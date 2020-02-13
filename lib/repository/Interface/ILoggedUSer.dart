import 'package:dio/dio.dart';
import 'package:krude_digital/models/UserModel.dart';

abstract class ILoggedUser {

  UserModel loggedInUser;

  login(String username, String password);
  signUpIndividual(FormData form);
  signUpCompany(FormData form);
  signUpVendor(FormData form);
}