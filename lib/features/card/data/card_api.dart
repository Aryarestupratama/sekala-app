import 'package:dio/dio.dart';
import '../../../core/network/api_result.dart';

class CardApi {
  CardApi(this._dio);
  final Dio _dio;

  Future<Map<String, dynamic>> getCards() {
    return unwrapApiCall(() async {
      final response = await _dio.get('/cards');
      return response.data as Map<String, dynamic>;
    });
  }

  Future<dynamic> getFigureDetail(int figureId) {
    return unwrapApiCall(() async {
      final response = await _dio.get('/cards/$figureId');
      return response.data;
    });
  }
}
