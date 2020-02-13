import 'dart:io';

import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:krude_digital/models/Country.dart';
import './SwapFuel.dart';

class SwapFuelInternational extends StatefulWidget {
  SwapFuelInternational() {}

  _SwapFuelInternationalState createState() => _SwapFuelInternationalState();
}

showLoading(context) {
  showDialog(
    context: context,
    builder: (BuildContext context) {
      return AlertDialog(
        content: Row(
          children: <Widget>[
            CircularProgressIndicator(),
            SizedBox(
              width: 30,
            ),
            Text("Processing...")
          ],
        ),
      );
    },
  );
}

class _SwapFuelInternationalState extends State<SwapFuelInternational> {
  List countries = new List();
  List<Country> mCountries = new List<Country>();

  _SwapFuelInternationalState() {}

  getCountries() async {
    Dio dio = new Dio();
    dio.onHttpClientCreate = (HttpClient client) {
      client.badCertificateCallback =
          (X509Certificate cert, String host, int port) {
        return true;
      };
    };

    await dio
        .get(config.baseUrl + "/Countries/GetActiveCountries")
        .then((resp) {
      resp.data.forEach((e) {
        setState(() {
          var a = e["countryName"];
          var id = e["countryID"];
          var c = new Country();
          c.countryID = id;
          c.countryName = e["countryName"];
          print(c.countryName);
          c.isoCode = e["isoCode"];
          c.isActive = e["isActive"];
          countries.add(a);
          mCountries.add(c);
        });
      });
    });
  }

  var method;
  var FuelType;
  var targetCountry;
  var quantity = new TextEditingController();

  MessageBox(String data) {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          content: Row(
            children: <Widget>[Text(data)],
          ),
          actions: <Widget>[
            RaisedButton.icon(
              color: Colors.grey,
              icon: Icon(
                Icons.cancel,
                color: Colors.white,
              ),
              onPressed: () {
                Navigator.pop(context);
              },
              label: Container(
                alignment: Alignment.bottomRight,
                child: Text(
                  'Close',
                  style: TextStyle(color: Colors.white),
                ),
              ),
            ),
          ],
        );
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        child: ListView(
          children: <Widget>[
            Container(
              padding: EdgeInsets.only(top: 20.0),
              margin: EdgeInsets.all(20.0),
              child: Center(child: Text("SHOW TABLE SHOW AVAILABLE FUEL")),
            ),
            Container(
              child: Center(
                child: Text(
                  'Swap Fuel International'.toUpperCase(),
                  style: TextStyle(
                      fontWeight: FontWeight.bold,
                      color: Color(0xff213E4A),
                      fontSize: 18),
                ),
              ),
            ),
            SizedBox(
              height: 30,
            ),
            Container(
                padding: EdgeInsets.only(left: 20.0, right: 20.0),
                child: Row(
                  children: <Widget>[
                    Icon(Icons.cached, color: Color(0xff213E4A)),SizedBox(width: 10),
                    DropdownButton(
                      onChanged: (value) {
                        setState(() {
                          method = value;
                        });
                      },
                      items: ['To', 'From']
                          .map<DropdownMenuItem<String>>((String value) {
                        return DropdownMenuItem<String>(
                          value: value,
                          child: Text(value),
                        );
                      }).toList(),
                      hint: Text(
                        method ?? 'Select Method Type',
                        style: TextStyle(color: Color(0xff213E4A)),
                      ),
                    )
                  ],
                )),
            Container(
                padding: EdgeInsets.only(left: 20.0, right: 20.0),
                child: Row(
                  children: <Widget>[
                    Icon(Icons.map, color: Color(0xff213E4A),),SizedBox(width: 10),
                    DropdownButton(
                  onChanged: (value) {
                    setState(() {
                      targetCountry = value;
                    });
                  },
                  items: countries.map<DropdownMenuItem<String>>((value) {
                    return DropdownMenuItem(
                      child: Text(value),
                      value: value,
                    );
                  }).toList(),
                  hint: Text(
                    targetCountry ?? 'Select Target Country',
                    style: TextStyle(color: Color(0xff213E4A)),
                  ),
                )
                  ],
                ),
            ),
            Container(
                padding: EdgeInsets.only(left: 20.0, right: 20.0),
                child: Row(children: <Widget>[
                  // Icon(Icons.ev_station, color: Color(0xff213E4A)), SizedBox(width: 10),
                  DropdownButton(
                  onChanged: (value) {
                    setState(() {
                      FuelType = value;
                    });
                  },
                  items: ['Petrol', 'Diesel', 'Unlead Blend']
                      .map<DropdownMenuItem<String>>((value) {
                    return DropdownMenuItem(
                      child: Text(value),
                      value: value,
                    );
                  }).toList(),
                  hint: Text(
                    FuelType ?? 'Select fuel Type',
                    style: TextStyle(color: Color(0xff213E4A)),
                  ),
                )
                ],)
            ),
            Container(
              width: 50,
              padding: EdgeInsets.only(left: 20.0, right: 20.0),
              child: Row(children: <Widget>[
                Icon(Icons.polymer, color: Color(0xff213E4A)),
                SizedBox(width: 10,),
                TextField(

                controller: quantity,
                decoration: InputDecoration(
                    labelText: 'Quantity',
                    labelStyle: TextStyle(color: Color(0xff213E4A)),
                    focusedBorder: UnderlineInputBorder(
                        borderSide: BorderSide(color: Colors.green))),
              )
              ],)
            ),
            Container(
              margin: EdgeInsets.only(top: 20, left: 40, right: 40),
              child: RaisedButton(
                onPressed: () {
                  if (method == null || method == "") {
                    return MessageBox("choose the transfer method!");
                  } else if (FuelType == null || FuelType == "") {
                    return MessageBox("choose the fuel type!");
                  } else if (targetCountry == null || targetCountry == "") {
                    return MessageBox("choose the target country!");
                  } else if (quantity.text == null || quantity.text == "") {
                    return MessageBox("enter the quantity of fuel!");
                  }
                  return swapConf(
                      context, quantity.text, method, FuelType, targetCountry);
                },
                color: Colors.green,
                child: Text('Swap', style: TextStyle(color: Color(0xff213E4A))),
              ),
            )
          ],
        ),
      ),
    );
  }

  void swapConf(BuildContext context, String quantity, String method,
      String type, String target) {
    var alertDialog = AlertDialog(
      title: Text(
        'Fuel Swap Confirmation',
        style: TextStyle(
          fontWeight: FontWeight.bold,
          decoration: TextDecoration.underline,
        ),
      ),
      content: Text('Swapping $quantity Litres of  $type $method $target'),
      actions: <Widget>[
        RaisedButton.icon(
          color: Colors.grey,
          icon: Icon(
            Icons.cancel,
            color: Colors.white,
          ),
          onPressed: () {
            Navigator.pop(context);
          },
          label: Container(
            alignment: Alignment.bottomRight,
            child: Text(
              'Cancel',
              style: TextStyle(color: Colors.white),
            ),
          ),
        ),
        RaisedButton.icon(
          icon: Icon(Icons.check, color: Colors.white),
          onPressed: () {
            showLoading(context);
            swap(target);
          },
          color: Colors.green,
          label: Container(
            alignment: Alignment.bottomLeft,
            child: Text(
              'Confirm',
              style: TextStyle(color: Colors.white),
            ),
          ),
        ),
      ],
    );
    showDialog(
        context: context,
        builder: (BuildContext context) {
          return alertDialog;
        });
  }

  swap(String target) async {
    Dio dio = new Dio();
    dio.onHttpClientCreate = (HttpClient client) {
      client.badCertificateCallback =
          (X509Certificate cert, String host, int port) {
        return true;
      };
    };

    var form = new FormData();
    form.add('method', method);
    form.add('target', target);
    form.add('type', FuelType);
    form.add('quantity', int.parse(quantity.text));
    form.add('username', "username");
    form.add('countryName', target);
    try {
      await dio
          .post(config.baseUrl + "/MobileAppApi/SwapInternationally",
              data: form)
          .then((resp) {
        if (resp.statusCode == 200 &&
            resp.data['message'] == "Successfully transfered fuel") {
          Navigator.pop(context);
          Navigator.pop(context);
        }
      });
    } on DioError catch (e) {
      print(e.response.data);
      Navigator.pop(context);
      Navigator.pop(context);

      showDialog(
        context: context,
        builder: (BuildContext context) {
          return AlertDialog(
            title: Text("Error Message showing something happened"),
            content: Text(e.response.data["message"]),
          );
        },
      );
    }
  }
}
