import 'package:flutter/cupertino.dart';
import 'package:provider/provider.dart';

class Register extends ChangeNotifier {
  bool show = true;
  bool show2 = true;
  String? errorUsername;
  String? errorPass;
  String? errorFullname;
  String? errorConfirmpass;
  String? errorPhone;
  String? errorAdress;
  validateUsername(String username) {
    return username.length > 6 && username.contains('@');
  }

  validatePass(String password) {
    return password.length > 2;
  }

  validateFullname(String fullname) {
    return fullname != "";
  }

  validateConfirmPass(String cfpassword, String password) {
    return cfpassword == password;
  }

  validatePhone(String phone) {
    return phone != "";
  }

  validateAddress(String address) {
    return address != "";
  }

  checkLogin(String username, String password, String fullname,
      String confirmpass, String phone, String address) {
    if (!validateFullname(fullname)) {
      errorFullname = "Vui Lòng Nhập Họ Tên Của Bạn!";
      notifyListeners();
      return false;
    }
    errorFullname = "";
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

    if (phone == "") {
      errorPhone = 'Nhập Số điện thoại';
      notifyListeners();
      return false;
    }

    if (address == "") {
      errorAdress = 'Nhập địa chỉ';
      notifyListeners();
      return false;
    }

    if (password == "") {
      errorPass = 'Nhập Mật Khẩu';
      notifyListeners();
      return false;
    }
    if (!validatePass(password)) {
      errorPass = 'Sai Mật Khẩu';
      notifyListeners();
      return false;
    }
    errorPass = "";
    if (!validateConfirmPass(confirmpass, password)) {
      errorConfirmpass = "Vui Lòng Nhập Lại Đúng Mật Khẩu!";
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

  changeShow2() {
    show2 = !show2;
    notifyListeners();
  }
}
