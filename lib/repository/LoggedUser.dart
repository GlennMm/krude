import 'dart:io';

import 'package:dio/dio.dart';
import 'package:krude_digital/config.dart';
import 'package:krude_digital/models/UserModel.dart';
import 'package:krude_digital/repository/Interface/ILoggedUSer.dart';

class LoggedInUserRepository implements ILoggedUser {
  Dio _dio = new Dio();
  Config _config = new Config();

  LoggedInUserRepository() {
    _dio.onHttpClientCreate = (HttpClient client) {
      client.badCertificateCallback =
          (X509Certificate cert, String host, int port) {
        return true;
      };
    };
  }

  @override
  UserModel loggedInUser;

  @override
  Future<bool> login(String username, String password) async {
    bool success;
    // await this
    //     ._dio
    //     .post(_config.baseUrl + '/MobileAppApi/Login?username=${username.toLowerCase().trim()}&password=${password.toLowerCase().trim()}')
    //     .then((result) {
    //   loggedInUser = new UserModel.fromJson(result.data);
    //   success = true;
    // }).catchError((error) {
    //   print(error);
    //   success = false;
    // }).timeout(Duration(seconds: 30));
    loggedInUser = new UserModel(
        accountID: 1,
        username: "Glenn",
        accountTypeID: 1,
        countryId: 250,
        email: 'vamdara@gmail.com',
        message: 'success');
    return success = true;
  }

  @override
  signUpCompany(FormData form) async {
    // implement signup
    await this
        ._dio
        .post(_config.baseUrl + '/MobileAppAPi/SignUpIndividual', data: form)
        .then((result) {
      print(result.data);
      return result.data;
    }).catchError((error) {
      print(error);
    }).timeout(Duration(seconds: 30));
  }

  @override
  signUpIndividual(FormData form) async {
    // implemention signup
    await this
        ._dio
        .post(_config.baseUrl + '/MobileAppAPi/SignUpIndividual', data: form)
        .then((result) {
      print(result.data);
      return result.data;
    }).catchError((error) {
      return error;
    }).timeout(Duration(seconds: 30));
  }

  @override
  signUpVendor(FormData form) async {
    // implemention signup
    await _dio
        .post(_config.baseUrl + '/MobileAppAPi/SignUpIndividual', data: form)
        .then((result) {
      print(result.data);
      return result.data;
    }).catchError((error) {
      print(error);
    }).timeout(Duration(seconds: 30));
    return null;
  }
}
