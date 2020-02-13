import 'dart:io';

import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:krude_digital/config.dart';
import 'package:krude_digital/models/Country.dart';

class EditSubAccount extends StatefulWidget {
  String username;
  int countryId;
  int accountTId;
  int accountId;
  String userId;

  EditSubAccount(String name, int cId, int accTId, int accId, String uId) {
    username = name;
    countryId = cId;
    accountTId = accTId;
    accountId = accId;
    userId = uId;
  }

  _EditSubAccountState createState() =>
      _EditSubAccountState(username, countryId, accountTId, accountId, userId);
}

class _EditSubAccountState extends State<EditSubAccount> {
  String currentUser;
  int countryId;
  int accTId;
  int accountId;
  String userId;
  List<SubAccount> subAccounts = List<SubAccount>();
  List<Country> countries = new List<Country>();
  var config = new Config();

  _EditSubAccountState(
      String user, int cid, int accTId, int accountId, String uId) {
    currentUser = user;
    countryId = cid;
    accTId = accTId;
    accountId = accountId;
    userId = uId;
    GetSubAccounts(user, countryId, accountId);
    GetCountries();
  }

  GetSubAccounts(String user, int countryId, int accountId) async {
    Dio dio = new Dio();
    dio.onHttpClientCreate = (HttpClient client) {
      client.badCertificateCallback =
          (X509Certificate cert, String host, int port) {
        return true;
      };
    };
    try {
      await dio
          .get(config.baseUrl +
              "/Account/GetSubAccounts?accountId=$accountId&countryId=$countryId&userId=$userId")
          .then((resp) {
        for (var item in resp.data) {
          setState(() {
            SubAccount acc = SubAccount();
            acc.AccountId = item['accountID'];
            acc.AccountName = item['accountName'];
            acc.AccountNumber = item['accountNo'];
            acc.AcountTypeId = item['accountTypeID'];
            acc.CountryId = item['countryID'];
            acc.CountryName = item['countryName'];
            subAccounts.add(acc);
          });
        }
      });
    } on DioError catch (e) {
      print(e.message);
    }
  }

  GetCountries() async {
    Dio dio = new Dio();
    dio.onHttpClientCreate = (HttpClient client) {
      client.badCertificateCallback =
          (X509Certificate cert, String host, int port) {
        return true;
      };
    };
    try {
      await dio
          .get(config.baseUrl + "/Countries/GetActiveCountries")
          .then((resp) {
        for (var item in resp.data) {
          setState(() {
            Country con = Country();
            con.countryID = item['countryID'];
            con.countryName = item['countryName'];
            con.isoCode = item['isoCode'];
            con.isActive = item['isActive'];
            countries.add(con);
          });
        }
      });
    } on DioError catch (e) {
      print(e.message);
    }
  }

  ListTile _tile(
          SubAccount account, String title, String subtitle, IconData icon) =>
      ListTile(
        title: Text(title,
            style: TextStyle(
                fontWeight: FontWeight.w500,
                fontSize: 20,
                color: Color(0xff213E4A))),
        subtitle: Text(subtitle),
        leading: Icon(
          icon,
          color: Color(0xff213E4A),
        ),
        onTap: () {
          _showDialog(account);
        },
      );

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: Text('Krude Digital'),
          backgroundColor: Color(0xff213E4A),
        ),
        drawer: Drawer(
          child: ListView(
            children: <Widget>[
              UserAccountsDrawerHeader(
                decoration: BoxDecoration(
                  color: Color(0xff213E4A),
                ),
                accountName: Text('Tindiye  Trockper'),
                accountEmail: Text('tindosangoma@gmail.com'),
                currentAccountPicture: CircleAvatar(
                  backgroundColor: Colors.white,
                ),
              ),
              ListTile(
                leading: Icon(Icons.account_balance_wallet,
                    color: Color(0xff355664)),
                title: Text(
                  'My Wallet',
                  style: TextStyle(
                      fontWeight: FontWeight.bold, color: Color(0xff355664)),
                ),
                onTap: () {
                  Navigator.pushNamed(context, '/Views/MyWallet');
                },
              ),
              ExpansionTile(
                leading: Icon(Icons.shop, color: Color(0xff355664)),
                title: Text(
                  "Purchases",
                  style: TextStyle(
                      fontWeight: FontWeight.bold, color: Color(0xff355664)),
                ),
                children: <Widget>[
                  Container(
                      alignment: Alignment.bottomLeft,
                      color: Colors.transparent,
                      padding: EdgeInsets.only(left: 50.0, bottom: 10.0),
                      child: ListTile(
                        onTap: () {
                          Navigator.pushNamed(context, '/Views/PurchaseFuel');
                        },
                        leading:
                            Icon(Icons.location_on, color: Color(0xff355664)),
                        title: Text(
                          'Purchase Locally',
                          style: TextStyle(
                              fontWeight: FontWeight.bold,
                              color: Color(0xff355664)),
                        ),
                      )),
                  Container(
                      alignment: Alignment.bottomLeft,
                      color: Colors.transparent,
                      padding: EdgeInsets.only(left: 50.0, bottom: 10.0),
                      child: ListTile(
                        onTap: () {
                          Navigator.pushNamed(
                              context, '/Views/PurchaseInternational');
                        },
                        leading: Icon(
                          Icons.location_searching,
                          color: Color(0xff355664),
                        ),
                        title: Text(
                          'Purchase Regionally',
                          style: TextStyle(
                              fontWeight: FontWeight.bold,
                              color: Color(0xff355664)),
                        ),
                      )),
                ],
              ),
              ExpansionTile(
                leading: Icon(Icons.transfer_within_a_station,
                    color: Color(0xff355664)),
                title: Text(
                  "Transfers",
                  style: TextStyle(
                      fontWeight: FontWeight.bold, color: Color(0xff355664)),
                ),
                children: <Widget>[
                  Container(
                      alignment: Alignment.bottomLeft,
                      color: Colors.transparent,
                      padding: EdgeInsets.only(left: 50.0, bottom: 10.0),
                      child: ListTile(
                        onTap: () {
                          Navigator.pushNamed(context, '/Views/TransferFuel');
                        },
                        leading: Icon(Icons.transfer_within_a_station,
                            color: Color(0xff355664)),
                        title: Text(
                          'Transfer Fuel',
                          style: TextStyle(
                              fontWeight: FontWeight.bold,
                              color: Color(0xff355664)),
                        ),
                      )),
                  Container(
                      alignment: Alignment.bottomLeft,
                      color: Colors.transparent,
                      padding: EdgeInsets.only(left: 50.0, bottom: 10.0),
                      child: ListTile(
                        onTap: () {
                          Navigator.pushNamed(context, '/Views/SwapFuel');
                        },
                        leading: Icon(Icons.swap_horizontal_circle,
                            color: Color(0xff355664)),
                        title: Text(
                          'Swap Locally',
                          style: TextStyle(
                              fontWeight: FontWeight.bold,
                              color: Color(0xff355664)),
                        ),
                      )),
                  Container(
                      alignment: Alignment.bottomLeft,
                      color: Colors.transparent,
                      padding: EdgeInsets.only(left: 50.0, bottom: 10.0),
                      child: ListTile(
                        onTap: () {
                          Navigator.pushNamed(
                              context, '/Views/SwapFuelInternational');
                        },
                        leading: Icon(Icons.swap_horizontal_circle,
                            color: Color(0xff355664)),
                        title: Text(
                          'Swap Regionally',
                          style: TextStyle(
                              fontWeight: FontWeight.bold,
                              color: Color(0xff355664)),
                        ),
                      )),
                ],
              ),
              ExpansionTile(
                leading: Icon(Icons.table_chart, color: Color(0xff355664)),
                title: Text(
                  "Digital Coupons",
                  style: TextStyle(
                      fontWeight: FontWeight.bold, color: Color(0xff355664)),
                ),
                children: <Widget>[
                  Container(
                      alignment: Alignment.bottomLeft,
                      color: Colors.transparent,
                      padding: EdgeInsets.only(left: 50.0, bottom: 10.0),
                      child: ListTile(
                        onTap: () {
                          Navigator.pushNamed(context, '/Views/RedeemFuel');
                        },
                        leading: Icon(Icons.redeem, color: Color(0xff355664)),
                        title: Text(
                          'Redeem Fuel',
                          style: TextStyle(
                              fontWeight: FontWeight.bold,
                              color: Color(0xff355664)),
                        ),
                      )),
                  Container(
                      alignment: Alignment.bottomLeft,
                      color: Colors.transparent,
                      padding: EdgeInsets.only(left: 50.0, bottom: 10.0),
                      child: ListTile(
                        onTap: () {
                          Navigator.pushNamed(context, '/Views/MyWallet');
                        },
                        leading:
                            Icon(Icons.filter_list, color: Color(0xff355664)),
                        title: Text(
                          'Load to Cart',
                          style: TextStyle(
                              fontWeight: FontWeight.bold,
                              color: Color(0xff355664)),
                        ),
                      )),
                  Container(
                      alignment: Alignment.bottomLeft,
                      color: Colors.transparent,
                      padding: EdgeInsets.only(left: 50.0, bottom: 10.0),
                      child: ListTile(
                        onTap: () {
                          Navigator.pushNamed(context, '/Views/MyWallet');
                        },
                        leading: Icon(
                          Icons.print,
                          color: Color(0xff355664),
                        ),
                        title: Text(
                          'Print',
                          style: TextStyle(
                              fontWeight: FontWeight.bold,
                              color: Color(0xff355664)),
                        ),
                      )),
                ],
              ),
              ListTile(
                leading: Icon(Icons.access_alarm, color: Color(0xff355664)),
                title: Text(
                  'About Krude Digital',
                  style: TextStyle(
                      fontWeight: FontWeight.bold, color: Color(0xff355664)),
                ),
              ),
              ListTile(
                leading: Icon(Icons.info, color: Color(0xff355664)),
                title: Text(
                  'Help and feedback',
                  style: TextStyle(
                      fontWeight: FontWeight.bold, color: Color(0xff355664)),
                ),
              ),
              ListTile(
                leading: Icon(Icons.settings, color: Color(0xff355664)),
                title: Text(
                  'Setting and Configurations',
                  style: TextStyle(
                      fontWeight: FontWeight.bold, color: Color(0xff355664)),
                ),
              ),
            ],
          ),
        ),
        body: ListView.builder(
            itemCount: subAccounts.length,
            itemBuilder: (BuildContext ctxt, int index) {
              SubAccount account = subAccounts[index];
              var title = subAccounts[index].AccountName;
              var subTitle =
                  '${subAccounts[index].AccountNumber} (${subAccounts[index].CountryName})';

              return _tile(account, title, subTitle, Icons.person_outline);
            }));
  }

  _showDialog(SubAccount account) async {
    var newAccountName = new TextEditingController();
    var newCountry;
    var oldCountryName = account.CountryName;

    return showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
            shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(10.0)),
            actions: <Widget>[
              new Row(
                children: <Widget>[
                  ButtonBar(
                    children: <Widget>[
                      FlatButton(
                        color: Colors.redAccent,
                        child: Text(
                          "Cancel",
                          style: TextStyle(color: Colors.white),
                        ),
                        onPressed: () {
                          newAccountName = null;
                          newCountry = null;
                          Navigator.of(context).pop();
                        },
                        padding: EdgeInsets.all(10.0),
                      ),
                      SizedBox(
                        width: 100,
                      ),
                      FlatButton(
                        color: Color(0xff213E4A),
                        child: Text(
                          "Save",
                          style: TextStyle(color: Colors.white),
                        ),
                        onPressed: () {
                          SaveSubAccount(newAccountName, newCountry) {}
                          newAccountName = null;
                          newCountry = null;
                        },
                        padding: EdgeInsets.all(10.0),
                      ),
                    ],
                  )
                ],
              )
            ],
            content: Container(
                height: 200,
                width: 200,
                child: Padding(
                  padding: EdgeInsets.all(12.0),
                  child: new ListView(
                    children: <Widget>[
                      TextFormField(
                        controller: newAccountName,
                        decoration: InputDecoration(
                          labelText: '${account.AccountName}',
                          border: InputBorder.none,
                        ),
                      ),
                      DropdownButton(
                        items: countries
                            .map<DropdownMenuItem<Country>>((Country value) {
                          return DropdownMenuItem<Country>(
                            value: value,
                            child: Text(value.countryName),
                          );
                        }).toList(),
                        onChanged: (Country value) {
                          setState(() {
                            newCountry = value.countryName;
                          });
                        },
                        hint: Text(newCountry ?? oldCountryName),
                      ),
                    ],
                  ),
                )));
      },
    );
  }

  void SaveSubAccount(TextEditingController newAccountName, newCountry) {}
}

class SubAccount {
  String AccountName;
  String AccountNumber;
  int AccountId;
  int AcountTypeId;
  String CountryName;
  int CountryId;
  DateTime CreatedAt;
}
