import 'dart:io';

import 'package:dio/dio.dart';
import 'package:flutter_testing_tutorial/services/dio/interceptors/dio_connectivity_request_retrier.dart';

class RetryOnConnectionChangeInterceptor extends Interceptor {
  final DioConnectivityRequestRetrier dioConnectivityRequestRetrier;

  RetryOnConnectionChangeInterceptor(this.dioConnectivityRequestRetrier);

  @override
  Future onError(DioError err, ErrorInterceptorHandler handler) async {
    // super.onError(err, handler);
    if (_shouldRetry(err)) {
      try {
        return dioConnectivityRequestRetrier.scheduledRequestRetry(err.requestOptions);
      } catch (e) {
        return e;
      }
    }

    return err;
  }

  bool _shouldRetry(DioError error) {
    return error.type == DioErrorType.other && error.error != null && error.error is SocketException;
  }
}
