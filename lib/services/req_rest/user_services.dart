import 'package:dio/dio.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter_testing_tutorial/models/user_model.dart';
import 'package:flutter_testing_tutorial/services/dio/api_client/dio_api_client.dart';

class UserServices {
  DioApiClient dioApiClient;
  UserServices({required this.dioApiClient});

  // get user method
  Future<UserModel?> getUser({required String id}) async {
    UserModel? userModel;
    try {
      Response userDataResponse = await dioApiClient.getData('/api/users/' + id);
      debugPrint('User data : ${userDataResponse.data}');

      userModel = UserModel.fromJson(userDataResponse.data);
      return userModel;
    } on DioError catch (e) {
      if (e.response != null) {
        debugPrint('Dio error!');
        debugPrint('STATUS: ${e.response?.statusCode}');
        debugPrint('DATA: ${e.response?.data}');
        debugPrint('HEADERS: ${e.response?.headers}');
      } else {
        // Error due to setting up or sending the request
        debugPrint('Error sending request!');
        debugPrint(e.message);
      }
    }
    return userModel;
  }
}
