import 'dart:async';

import 'package:connectivity/connectivity.dart';
import 'package:dio/dio.dart';

class DioConnectivityRequestRetrier {
  final Dio dio;
  final Connectivity connectivity;

  DioConnectivityRequestRetrier({
    required this.dio,
    required this.connectivity,
  });

  Future<Response> scheduledRequestRetry(RequestOptions requestOptions) async {
    late StreamSubscription<ConnectivityResult> connectivitySubscription;
    final responseCompleter = Completer<Response>();
    connectivitySubscription = connectivity.onConnectivityChanged.listen((connectivityResult) {
      //* if connection is available, retry the request
      if (connectivityResult != ConnectivityResult.none) {
        connectivitySubscription.cancel();

        responseCompleter.complete(dio.request(
          requestOptions.path,
          cancelToken: requestOptions.cancelToken,
          data: requestOptions.data,
          onReceiveProgress: requestOptions.onReceiveProgress,
          onSendProgress: requestOptions.onSendProgress,
          queryParameters: requestOptions.queryParameters,
        ));
      }
    });
    return responseCompleter.future;
  }
}
