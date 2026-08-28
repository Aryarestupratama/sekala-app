import 'package:dio/dio.dart';
import '../../../core/network/api_result.dart';

class HomeApi {
  HomeApi(this._dio);
  final Dio _dio;

  Future<Map<String, dynamic>> getHomeSummary() {
    return unwrapApiCall(() async {
      final response = await _dio.get('/home');
      return response.data as Map<String, dynamic>;
    });
  }
}
