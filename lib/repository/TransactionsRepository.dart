import 'dart:convert';
import 'dart:io';

import 'package:dio/dio.dart';
import 'package:krude_digital/config.dart';
import 'package:krude_digital/models/RequestModels/tranfers_to_subaccount.dart';
import 'package:krude_digital/repository/Interface/ITransactions.dart';

class TransactionsRepository implements ITransation {

  Dio _dio = new Dio();
  Config _config = new Config();

  TransactionsRepository() {
    _dio.onHttpClientCreate = (HttpClient client) {
      client.badCertificateCallback =
          (X509Certificate cert, String host, int port) {
        return true;
      };
    };
  }

  @override
  generateCoupons() {
    // TODO: implement generateCoupons
    return null;
  }

  @override
  getSaleDetails() {
    // TODO: implement getSaleDetails
    return null;
  }

  @override
  getTransaction() {
    // TODO: implement getTransaction
    return null;
  }

  @override
  purchaseFuel(model) async {
    try{
      FormData form = new FormData();
      // form.add("coupon", model.coupon);
      // form.add('accountId', model.accountId);

      await _dio.post(_config.baseUrl + "/Transactions/PurchaseFuel", data: form).then((response) => {
        print(response.data)
      }).catchError((err){
        print(err);
      });
    }catch (e) {
      print(e);
    }
  }

  @override
  redeem() {
    // TODO: implement redeem
    return null;
  }

  @override
  retractPrintCoupon() {
    // TODO: implement retractPrintCoupon
    return null;
  }

  @override
  sell() {
    // TODO: implement sell
    return null;
  }

  @override
  swapFuel() {
    // TODO: implement swapFuel
    return null;
  }

  @override
  swapFuelForInternational() {
    // TODO: implement swapFuelForInternational
    return null;
  }

  @override
  transaferFromAccounts(data) async {
    // TODO: implement transaferFromAccounts
    await _dio.post(_config.baseUrl + "/Transactions/TransferFromAccounts", data: json.encode({
      "coupon": data.coupon.toJson(),
      "clients": data.clients,
      "transactingUserID": data.transactingUserID
    })).then((response) =>
      print(response.data)
    ).catchError((err) {
        print(err);
    });
  }

  @override
  transferToAccounts(data) async {
    // TODO: implement transferToAccounts
    await _dio.post(_config.baseUrl + "/Transactions/TransferToAccounts", data: json.encode({
      "coupon": data.coupon.toJson(),
      "clients": data.clients,
      "transactingUserID": data.transactingUserID
    })).then((response) =>
      print(response.data)
    ).catchError((err) {
        print(err);
    });
  }

  @override
  transafer(form) async {
    // TODO: implement transafer
    await _dio.post(_config.baseUrl + '/Transaction/Trafser', data: form).then((response) => {
      print("Done")
    }).catchError((err) => {
      print(err)
    });
    return null;
  }

}