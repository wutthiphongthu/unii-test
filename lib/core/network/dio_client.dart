import 'dart:developer' as developer;

import 'package:dio/dio.dart';
import 'package:injectable/injectable.dart';
import 'package:unii_test/core/constants/app_constants.dart';

@lazySingleton
class DioClient {
  DioClient()
      : dio = Dio(
          BaseOptions(
            baseUrl: AppConstants.baseUrl,
            connectTimeout: AppConstants.requestTimeout,
            receiveTimeout: AppConstants.requestTimeout,
            headers: <String, dynamic>{
              if (AppConstants.apiKey.isNotEmpty)
                'x-access-token': AppConstants.apiKey,
            },
          ),
        )
      ..interceptors.add(_CurlLogInterceptor())
      ..interceptors.add(
        LogInterceptor(
          requestBody: false,
          responseBody: false,
        ),
      );

  final Dio dio;
}

class _CurlLogInterceptor extends Interceptor {
  static const String _ansiReset = '\x1B[0m';
  static const String _ansiCyan = '\x1B[36m';
  static const String _ansiYellow = '\x1B[33m';

  @override
  void onRequest(
    RequestOptions options,
    RequestInterceptorHandler handler,
  ) {
    final command = _buildCurlCommand(options);
    developer.log(
      '$_ansiCyan[CURL]$_ansiReset $_ansiYellow$command$_ansiReset',
      name: 'DioClient',
    );
    handler.next(options);
  }

  String _buildCurlCommand(RequestOptions options) {
    final parts = <String>[
      'curl -X ${options.method.toUpperCase()}',
      "'${options.uri}'",
    ];

    options.headers.forEach((key, value) {
      if (value != null) {
        parts.add("-H '$key: $value'");
      }
    });

    if (options.data != null) {
      final data = options.data.toString().replaceAll("'", r"'\''");
      parts.add("--data-raw '$data'");
    }

    return parts.join(' ');
  }
}
