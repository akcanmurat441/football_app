import 'package:dartz/dartz.dart';
import 'package:dio/dio.dart';

enum LoginFailure { invalidCredentials, error, exception }

class BaseService {
  BaseService({
    required this.dio,
  });

  Dio dio;

  getAll(String endpoint) async {
    try {
      final response = await dio.get(endpoint);
      return response.data["response"];
    } catch (e) {
      return const Left(LoginFailure.exception);
    }
  }
}
