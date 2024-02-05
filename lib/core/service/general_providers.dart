import 'package:dio/dio.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

final dioProvider = Provider<Dio>((ref) {
  BaseOptions bo = BaseOptions(
    baseUrl: "https://v3.football.api-sports.io",
    headers: {
      'x-apisports-key': '95fbefa9539acf466bd4e2cde35aedc0',
    },
  );
  return Dio(bo);
});
