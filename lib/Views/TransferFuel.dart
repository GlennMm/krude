import 'dart:io';

import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:krude_digital/Views/SwapFuel.dart';

import '../config.dart';

class Product {
  int productID;
  var productName;
  var description;
  var measurement;
  bool isActive;
}

class ProductPrice {
  Product product;
  double price;
}

class TransferFuel extends StatefulWidget {
  TransferFuel() {
  }

  String usern;

  _TransferFuelState createState() => _TransferFuelState();
}

var config = new Config();

class _TransferFuelState extends State<TransferFuel> {


  _TransferFuelState() {
  }

  var toName = new TextEditingController();
  var quantity = new TextEditingController();
  var type;
  List<ProductPrice> productPrice = new List<ProductPrice>();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        child: ListView(
          children: <Widget>[
            Container(
              padding: EdgeInsets.only(top: 20.0),
              margin: EdgeInsets.all(20.0),
              child: Image.asset('images/logo.png'),
            ),
            Container(
              padding: EdgeInsets.only(top: 25.0, bottom: 25.0, left: 130.0),
              child: Text(
                'Transfer Fuel',
                style: TextStyle(
                    fontWeight: FontWeight.bold, color: Color(0xff213E4A)),
              ),
            ),
            Container(
              padding: EdgeInsets.only(left: 20.0, right: 20.0),
              child: DropdownButton(
                items: ['Petrol', 'Diesel', 'Unlead Blend']
                    .map<DropdownMenuItem<String>>((String value) {
                  return DropdownMenuItem<String>(
                    value: value,
                    child: Text(value),
                  );
                }).toList(),
                onChanged: (String value) {
                  setState(() {
                    type = value;
                  });
                },
                icon: Icon(Icons.ev_station),
                hint: Text(
                  type ?? 'Select Fuel Type Here',
                  style: TextStyle(color: Color(0xff213E4A)),
                ),
              ),
            ),
            Container(
              padding: EdgeInsets.only(left: 20.0, right: 20.0),
              child: TextField(
                controller: toName,
                decoration: InputDecoration(
                    labelText: 'Username to transfer To',
                    labelStyle: TextStyle(color: Color(0xff213E4A)),
                    focusedBorder: UnderlineInputBorder(
                        borderSide: BorderSide(color: Colors.green))),
              ),
            ),
            Container(
              padding: EdgeInsets.only(left: 20.0, right: 20.0),
              child: TextField(
                controller: quantity,
                decoration: InputDecoration(
                    labelText: 'Quantity',
                    labelStyle: TextStyle(color: Color(0xff213E4A)),
                    focusedBorder: UnderlineInputBorder(
                        borderSide: BorderSide(color: Colors.green))),
              ),
            ),
            Container(
              margin: EdgeInsets.only(top: 20, left: 40, right: 40),
              child: RaisedButton(
                onPressed: () {
                  if (type == "" || type == null) {
                    return MessageBox(context, "Select the Fuel type");
                  } else if (toName.text == "" || toName == null) {
                    return MessageBox(
                        context, "Enter the username to transfer to!");
                  } else if (quantity.text == "" || quantity.text == null) {
                    return MessageBox(context, "Enter the quantity");
                  }
                  return transferConfirmation(
                      context, "username", quantity.text, toName.text, type);
                },
                color: Colors.green,
                child: Text('Transfer',
                    style: TextStyle(color: Color(0xff213E4A))),
              ),
            )
          ],
        ),
      ),
    );
  }

// FUEL TRANSFERING FUNCTION

  void Transfer(String name, String toname, int q, String typ) {
    Dio dio = new Dio();
    dio.onHttpClientCreate = (HttpClient client) {
      client.badCertificateCallback =
          (X509Certificate cert, String host, int port) {
        return true;
      };
    };

    var form = new FormData();
    form.add("username", name);
    form.add("toUsername", toname);
    form.add("Quantity", q);
    form.add("SelectedProduct", typ);

    try {
      dio.post(config.baseUrl + "/MobileAppApi/TransferFuel", data: form)
        .then((resp) {
          if (resp.data["message"] == "Your transaction was succesfully, Thank you.") {
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
            title: Text("Error Message"),
            content: Text(e.response.data["message"]),
          );
        },
      );
    }
  }

// FUEL TRANSFER CONFIRMATION

  void transferConfirmation(BuildContext context, String username,
      String quantity, String toName, String type) {
    var alertDialog = AlertDialog(
      title: Text(
        'Confirm Fuel Transfer To $toName',
        style: TextStyle(
            fontWeight: FontWeight.bold, decoration: TextDecoration.underline),
      ),
      content: Text('$quantity Litres of $type'),
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
            int q = int.parse(quantity);
            Transfer(username, toName, q, type);
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
}
