import 'package:flutter/cupertino.dart';
import 'package:provider/provider.dart';

class Login extends ChangeNotifier {
  bool show = true;
  String? errorUsername;
  String? errorPass;
  validateUsername(String username) {
    return username.length > 6 && username.contains('@');
  }

  validatePass(String password) {
    return password.length > 2;
  }

  checkLogin(String username, String password) {
    if (username == "") {
      errorUsername = 'Nhập username';
      notifyListeners();
      return false;
    }
    if (!validateUsername(username)) {
      errorUsername = 'Email Không đúng định dạng!';
      notifyListeners();
      return false;
    }
    errorUsername = "";
    if (password == "") {
      errorPass = 'Nhập Mật Khẩu';
      notifyListeners();
      return false;
    }
    errorPass = "";
    if (!validatePass(password)) {
      errorPass = 'Sai Mật Khẩu';
      notifyListeners();
      return false;
    }
    notifyListeners();
    return true;
  }

  changeShow() {
    show = !show;
    notifyListeners();
  }
}
