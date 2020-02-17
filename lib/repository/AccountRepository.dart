import 'dart:io';

import 'package:dio/dio.dart';
import 'package:krude_digital/config.dart';
import 'package:krude_digital/models/SubAcccount.dart';
import 'package:krude_digital/repository/Interface/IAccount.dart';

class AccountRepository implements IAccount {
  Dio _dio = new Dio();
  Config _config = new Config();
  List<SubAccount> subAccounts = [];

  AccountRepository(){
    _dio.onHttpClientCreate = (HttpClient client) {
      client.badCertificateCallback =
          (X509Certificate cert, String host, int port) {
        return true;
      };
    };
  }

  @override
  assignBeneficiary() async {
    // TODO: implement assignBeneficiary
    return null;
  }

  @override
  createMasterAccount() {
    // TODO: implement createMasterAccount
    return null;
  }

  @override
  getAccountById() {
    // TODO: implement getAccountById
    return null;
  }

  @override
  getAccountsInfo() {
    // TODO: implement getAccountsInfo
    return null;
  }

  @override
  getAccountsSummary() {
    // TODO: implement getAccountsSummary
    return null;
  }

  @override
  getCompanyAccountsInfo() {
    // TODO: implement getCompanyAccountsInfo
    return null;
  }

  @override
  getCountryAccountsSummary() {
    // TODO: implement getCountryAccountsSummary
    return null;
  }

  @override
  getIndividualAccountsInfo() {
    // TODO: implement getIndividualAccountsInfo
    return null;
  }

  @override
  getSubAccounts(int accountId, int countryId, String userId) async {
    // TODO: implement getSubAccounts
    _dio.get(_config.baseUrl + '/Account/GetSubAccounts?accountId=$accountId&countryId=0&user=$userId').then((response){
      // print(response.data);
      List msubAccounts = response.data as List;
      this.subAccounts = [];
      msubAccounts.forEach((element) {
        this.subAccounts.add(new SubAccount.fromJson(element));
      });
      return;
    }).catchError((err){
      return print(err);
    });
  }

  @override
  getSubAccountsInfo() {
    // TODO: implement getSubAccountsInfo
    return null;
  }

  @override
  getVendorAccountsInfo() {
    // TODO: implement getVendorAccountsInfo
    return null;
  }

  @override
  saveAccount() {
    // TODO: implement saveAccount
    return null;
  }

  @override
  searchAccounts() {
    // TODO: implement searchAccounts
    return null;
  }

  @override
  searchForAccount() {
    // TODO: implement searchForAccount
    return null;
  }

}