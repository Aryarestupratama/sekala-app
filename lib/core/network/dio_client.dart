import 'package:dio/dio.dart';
import 'package:pretty_dio_logger/pretty_dio_logger.dart';
import '../constants/api_constants.dart';
import '../storage/secure_storage_service.dart';
import 'api_exception.dart';

/// Callback dipanggil saat token invalid/expired (401),
/// supaya router bisa redirect ke halaman login.
/// Di-set dari core/router saat inisialisasi app.
typedef OnUnauthenticated = void Function();

class DioClient {
  DioClient._internal() {
    _dio = Dio(
      BaseOptions(
        baseUrl: ApiConstants.baseUrl,
        connectTimeout: ApiConstants.connectTimeout,
        receiveTimeout: ApiConstants.receiveTimeout,
        headers: {
          'Accept': 'application/json',
          'Content-Type': 'application/json',
        },
      ),
    );

    _dio.interceptors.add(
      InterceptorsWrapper(
        onRequest: _onRequest,
        onError: _onError,
      ),
    );

    // Logger cuma aktif saat debug — jangan lupa nanti disable/guard
    // pakai kDebugMode kalau mau build release.
    _dio.interceptors.add(
      PrettyDioLogger(
        requestHeader: true,
        requestBody: true,
        responseBody: true,
        compact: true,
      ),
    );
  }

  static final DioClient instance = DioClient._internal();
  late final Dio _dio;

  OnUnauthenticated? onUnauthenticated;

  Dio get dio => _dio;

  Future<void> _onRequest(
    RequestOptions options,
    RequestInterceptorHandler handler,
  ) async {
    final token = await SecureStorageService.instance.getToken();
    if (token != null && token.isNotEmpty) {
      options.headers['Authorization'] = 'Bearer $token';
    }
    handler.next(options);
  }

  Future<void> _onError(
    DioException error,
    ErrorInterceptorHandler handler,
  ) async {
    final response = error.response;
    final data = response?.data;

    String message = 'Terjadi kesalahan. Silakan coba lagi.';
    String? errorCode;
    Map<String, List<String>>? validationErrors;

    if (data is Map<String, dynamic>) {
      message = data['message'] as String? ?? message;
      errorCode = data['error_code'] as String?;

      // Laravel validation error format: { errors: { field: [msg, ...] } }
      if (data['errors'] is Map) {
        validationErrors = (data['errors'] as Map).map(
          (key, value) => MapEntry(
            key.toString(),
            List<String>.from(value as List),
          ),
        );
      }
    }

    // 401 → token invalid/expired/tidak ada — TAPI backend juga memakai
    // 401 + error_code EMAIL_NOT_VERIFIED untuk endpoint yang dijaga
    // middleware `verified` (R-AUTH-03). Dua kasus ini beda total: yang
    // kedua tokennya MASIH VALID, cuma emailnya belum terverifikasi, jadi
    // TIDAK boleh ikut memicu logout paksa di sini — kalau ikut terhapus,
    // begitu user selesai verifikasi email & balik ke app, token sudah
    // hilang duluan dan dia harus login ulang untuk dapat token baru
    // (persis bug "koleksi vaksin/badge harus refresh/login ulang dulu").
    final isEmailNotVerified = errorCode == 'EMAIL_NOT_VERIFIED';
    if (response?.statusCode == 401 && !isEmailNotVerified) {
      await SecureStorageService.instance.clear();
      onUnauthenticated?.call();
    }

    handler.reject(
      DioException(
        requestOptions: error.requestOptions,
        response: error.response,
        type: error.type,
        error: ApiException(
          message: message,
          errorCode: errorCode,
          statusCode: response?.statusCode,
          validationErrors: validationErrors,
        ),
      ),
    );
  }
}