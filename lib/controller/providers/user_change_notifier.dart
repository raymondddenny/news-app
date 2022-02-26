import 'package:flutter/foundation.dart';
import 'package:flutter_testing_tutorial/models/user_model.dart';
import 'package:flutter_testing_tutorial/services/req_rest/user_services.dart';

class UserChangeNotifier extends ChangeNotifier {
  final UserServices _userServices;

  UserChangeNotifier(this._userServices);

  UserModel? _userModel;
  bool _isLoading = true;

  UserModel? get userModel => _userModel;
  bool get isLoading => _isLoading;

  Future<void> getUser(String userId) async {
    _isLoading = true;
    notifyListeners();

    _userModel = await _userServices.getUser(id: userId);

    _isLoading = false;
    notifyListeners();
  }
}
