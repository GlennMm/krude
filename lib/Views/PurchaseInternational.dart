import 'dart:io';

import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:krude_digital/config.dart';
import 'package:krude_digital/models/Country.dart';
import 'package:krude_digital/models/Product.dart';
import 'package:krude_digital/models/ProductPrice.dart';
import 'package:krude_digital/repository/CountryRepository.dart';
import 'package:krude_digital/repository/LoggedUser.dart';
import 'package:krude_digital/repository/ProductPricesRepository.dart';
import 'package:krude_digital/repository/ProductsRepository.dart';
import 'package:states_rebuilder/states_rebuilder.dart';

class PurchaseInternational extends StatefulWidget {
  String username;

  PurchaseInternational() {}

  _PurchaseInternationalState createState() => _PurchaseInternationalState();
}

class _PurchaseInternationalState extends State<PurchaseInternational> {
  Product selectedFuel;
  Country selectedCountry;
  Product fuelTypeSelected;
  var config = new Config();
  var quantity = TextEditingController();

  _PurchaseInternationalState() { }

  @override
  Widget build(BuildContext context) {
    return StateBuilder(
      models: [
        Injector.getAsReactive<ProductsRepository>(),
        Injector.getAsReactive<ProductPricesRepository>(),
        Injector.getAsReactive<CountryRepository>(),
      ],
      builder: (_, model) {
        var countries = Injector.getAsReactive<CountryRepository>();
        var products = Injector.getAsReactive<ProductsRepository>();
        var user = Injector.getAsReactive<LoggedInUserRepository>();

        countries.setState((model) => {
          model.getActiveCountries()
        });

        return Scaffold(
          body: Container(
            child: ListView(
              children: <Widget>[
                Center(
                  child: Container(
                    padding: EdgeInsets.only(top: 25.0, bottom: 25.0),
                    child: Text(
                      'Purchase Fuel Internationally',
                      style: TextStyle(
                          fontWeight: FontWeight.bold,
                          color: Color(0xff213E4A),
                          fontSize: 20.0),
                    ),
                  ),
                ),
                Container(
                  padding: EdgeInsets.symmetric(vertical: 10, horizontal: 40),
                  child: Row(
                    children: <Widget>[
                      Container(
                        child: DropdownButton(
                          items:
                              countries.state.countries.map<DropdownMenuItem<Country>>((value) {
                            return DropdownMenuItem<Country>(
                              value: value,
                              child: Text(value.countryName),
                            );
                          }).toList(),
                          onChanged: (Country value) {
                            setState(() {
                              selectedCountry = value;
                            });
                          },
                          icon: Icon(Icons.arrow_drop_down),
                          hint: Text(selectedCountry.countryName ?? 'Select Country'),
                        ),
                      ),
                    ],
                  ),
                ),
                Container(
                  padding: EdgeInsets.symmetric(vertical: 10, horizontal: 40),
                  child: Row(
                    children: <Widget>[
                      Container(
                        // padding: EdgeInsets.only(left: 20.0, right: 20.0),
                        child: DropdownButton(
                          items: products.state.products.map<DropdownMenuItem<Product>>((value) {
                            return DropdownMenuItem<Product>(
                              value: value,
                              child: Text(value.productName),
                            );
                          }).toList(),
                          onChanged: (Product value) {
                            setState(() {
                              selectedFuel = value;
                            });
                          },
                          icon: Icon(Icons.arrow_drop_down),
                          hint: Text(selectedFuel ?? 'Select Fuel'),
                        ),
                      ),
                    ],
                  ),
                ),
                Container(
                  padding: EdgeInsets.symmetric(vertical: 10, horizontal: 40),
                  child: TextField(
                    controller: quantity,
                    decoration: InputDecoration(
                        labelText: 'Quantity',
                        labelStyle: TextStyle(
                            fontWeight: FontWeight.bold, color: Colors.grey),
                        focusedBorder: UnderlineInputBorder(
                            borderSide: BorderSide(color: Colors.green))),
                  ),
                ),
                Container(
                  margin: EdgeInsets.only(top: 20, left: 40, right: 40),
                  child: RaisedButton(
                    onPressed: () async {
                      purchaseConfirm(context);
                    },
                    color: Colors.green,
                    child: Text('Purchase',
                        style: TextStyle(
                            fontWeight: FontWeight.bold, color: Colors.black)),
                  ),
                )
              ],
            ),
          ),
        );
      },
    );
  }

  purchase(double price, Product currentProd) async {
    Dio dio = new Dio();
    dio.onHttpClientCreate = (HttpClient client) {
      client.badCertificateCallback =
          (X509Certificate cert, String host, int port) {
        return true;
      };
    };

    var form = new FormData();

    form.add('username', 'users');
    form.add('SelectedProductQuantity', int.parse(quantity.text));
    form.add('SelectedProductPrice', (price * int.parse(quantity.text)));
    form.add('SelectedProduct', currentProd.productID);
    // form.add('CountryID', currentProd.cid);
    try {
      await dio
          .post(config.baseUrl + "/MobileAppApi/PurchaseInternational",
              data: form)
          .then((resp) {
        if (resp.data['message'] ==
            "Your purchase was succesfully, Thank you.") {
          Navigator.pop(context);
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
            title: Text("Error Message"),
            content: Text(e.response.data["message"]),
          );
        },
      );
    }
  }

  purchaseConfirm(BuildContext context) {
    double price;
    Product p;

    // productPrices.forEach((pp){
    //   if(pp.product == selectedCountry.toString() ){
    //     if(pp.product.productName == selectedFuel.toString()){
    //       price = pp.price;
    //       p = pp.product;
    //     }
    //   }
    // });

    double tp = price * int.parse(quantity.text);

    var alertDialog = AlertDialog(
      title: Text('Payment Confirmation',
          style: TextStyle(fontWeight: FontWeight.w900, fontSize: 30)),
      content: Container(
        constraints: BoxConstraints(minWidth: 230.0, minHeight: 25.0),
        width: 300,
        height: 100,
        child: ListView(
          children: <Widget>[
            Text(
                "Quantity ${quantity.text} litres of $selectedFuel in $selectedCountry"),
            Text("Price    : RTGS \$ $tp"),
          ],
        ),
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
              'Cancel',
              style: TextStyle(color: Colors.white),
            ),
          ),
        ),
        RaisedButton.icon(
          icon: Icon(Icons.check, color: Colors.white),
          onPressed: () {
            purchase(tp, p);
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
