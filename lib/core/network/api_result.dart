import 'package:dio/dio.dart';
import 'api_exception.dart';

/// Bungkus pemanggilan Dio supaya error selalu ke-unwrap
/// jadi ApiException yang sudah rapi (bukan DioException mentah).
Future<T> unwrapApiCall<T>(Future<T> Function() call) async {
  try {
    return await call();
  } on DioException catch (e) {
    if (e.error is ApiException) {
      throw e.error as ApiException;
    }
    // Error jaringan murni (timeout, no internet, dll — bukan dari _onError)
    throw ApiException(
      message: 'Tidak dapat terhubung ke server. Periksa koneksi internet.',
    );
  }
}