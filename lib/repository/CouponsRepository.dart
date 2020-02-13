import 'dart:io';

import 'package:dio/dio.dart';
import 'package:krude_digital/config.dart';
import 'package:krude_digital/repository/Interface/ICoupons.dart';

class CouponsRepository implements ICoupons {

  Dio _dio = new Dio();
  Config _config = new Config();

  CouponsRepository() {
     _dio.onHttpClientCreate = (HttpClient client) {
       client.badCertificateCallback =
           (X509Certificate cert, String host, int port) {
         return true;
       };
     };
  }


  @override
  archivePrintCoupon() {
    // TODO: implement archivePrintCoupon
    return null;
  }

  @override
  createCoupons() {
    // TODO: implement createCoupons
    return null;
  }

  @override
  deleteCoupons() {
    // TODO: implement deleteCoupons
    return null;
  }

  @override
  getArchivedCoupons() {
    // TODO: implement getArchivedCoupons
    return null;
  }

  @override
  getMasterCoupons() {
    // TODO: implement getMasterCoupons
    return null;
  }

  @override
  getPrintCoupons() {
    // TODO: implement getPrintCoupons
    return null;
  }

  @override
  getUsedCoupons() {
    // TODO: implement getUsedCoupons
    return null;
  }

}