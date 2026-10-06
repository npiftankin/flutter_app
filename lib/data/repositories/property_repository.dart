import 'package:dio/dio.dart';
import 'package:flutter_app/components/config.dart';
import 'package:flutter_app/data/dtos/properties_dto.dart';
import 'package:flutter_app/data/mappers/properties_mapper.dart';
import 'package:flutter_app/data/repositories/api_interface.dart';
import 'package:flutter_app/domain/models/home.dart';
import 'package:pretty_dio_logger/pretty_dio_logger.dart';

class PropertyRepository extends ApiInterface {
  static final Dio _dio = Dio(
    BaseOptions(
      connectTimeout: const Duration(seconds: 10),
      receiveTimeout: const Duration(seconds: 10),
    ),
  )..interceptors.add(PrettyDioLogger(requestHeader: true, requestBody: true));

  @override
  Future<HomeData?> loadData({OnErrorCallback? onError, String? type, int? maxPrice}) async {
    try {
      const String url = '$apiBaseUrl/properties';

      final Response<List<dynamic>> response = await _dio.get<List<dynamic>>(
        url,
        // Dio превращает null в пустой параметр (?type), а backend
        // воспринимает его как фильтр с пустым значением, поэтому
        // незаданные параметры в запрос не добавляем
        queryParameters: {'type': ?type, 'maxPrice': ?maxPrice},
      );

      final List<PropertyDto> dto = (response.data ?? [])
          .map((e) => PropertyDto.fromJson(e as Map<String, dynamic>))
          .toList();
      return dto.toDomain();
    } on DioException catch (e) {
      onError?.call(_errorMessage(e));
      return null;
    }
  }

  // Backend отвечает на ошибки телом {"status": ..., "message": ...}
  String? _errorMessage(DioException e) {
    final data = e.response?.data;
    if (data is Map<String, dynamic> && data['message'] is String) {
      return data['message'] as String;
    }
    return e.message ?? e.error?.toString();
  }
}
