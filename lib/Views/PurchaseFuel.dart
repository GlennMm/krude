import 'dart:io';
import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:krude_digital/Views/components/appbar.dart';
import 'package:krude_digital/Views/components/ui_function.dart';
import 'package:krude_digital/config.dart';
import 'package:krude_digital/models/Coupon.dart';
import 'package:krude_digital/models/Product.dart';
import 'package:krude_digital/models/ProductPrice.dart';
import 'package:krude_digital/models/RequestModels/PurchaseFuel.dart';
import 'package:krude_digital/models/UserModel.dart';
import 'package:krude_digital/repository/LoggedUser.dart';
import 'package:krude_digital/repository/ProductPricesRepository.dart';
import 'package:krude_digital/repository/ProductsRepository.dart';
import 'package:krude_digital/repository/TransactionsRepository.dart';
import 'package:states_rebuilder/states_rebuilder.dart';

class PurchaseFuelLocal extends StatefulWidget {


  _PurchaseFuelLocalState createState() => _PurchaseFuelLocalState();
}

class _PurchaseFuelLocalState extends State<PurchaseFuelLocal> {
  String selectedFuel;
  List<String> fuelTypes = [];
  var config = new Config();
  double price;
  var quantity = new TextEditingController();
  var username;
  List<ProductPrice> productPrice = new List<ProductPrice>();
  var selectId;
  var cId;


  @override
  Widget build(BuildContext context) {
    return StateBuilder(
      models: [
        Injector.getAsReactive<TransactionsRepository>(),
        Injector.getAsReactive<ProductPricesRepository>(),
        Injector.getAsReactive<ProductsRepository>(),
        Injector.getAsReactive<LoggedInUserRepository>()
      ],
      builder: (_, model) {
        var transactionRepo = Injector.getAsReactive<TransactionsRepository>();
        var productPrices = Injector.getAsReactive<ProductPricesRepository>();
        var products = Injector.getAsReactive<ProductsRepository>();

        var user = Injector.getAsReactive<LoggedInUserRepository>();

        if (products.isWaiting) {
          Future.delayed(Duration(seconds: 5));
          print("waitng 5 sec");
        }

        return Scaffold(
          appBar: appBar(),
          drawer: drawer(context, user),
          body: Container(
            child: ListView(
              children: <Widget>[
                Container(
                  padding: EdgeInsets.all(5),
                  child: Center(
                    child: Text(
                      "Products Prices In Active Countries",
                      style: TextStyle(
                          color: Color(0xff213E4A),
                          fontWeight: FontWeight.w600,
                          fontSize: 18),
                    ),
                  ),
                ),
                Container(
                    margin: EdgeInsets.all(8),
                    child: Center(
                        child: productPricesTable(
                            productPrices.state.groupedCountry))),
                Container(
                  child: Column(
                    children: <Widget>[
                      SizedBox(
                        height: 10,
                      ),
                      Text(
                        'Purchasing Fuel Locally',
                        style: TextStyle(
                            fontWeight: FontWeight.w600,
                            color: Color(0xff213E4A),
                            fontSize: 25),
                      ),
                      SizedBox(
                        height: 20,
                      ),
                      Container(
                        margin: EdgeInsets.symmetric(horizontal: 20),
                        child: FutureBuilder(
                            future: products.state.getActiveProducts(),
                            builder: (_, product) {
                              return DropdownButton(
                                items: products.state.products
                                    .map<DropdownMenuItem<Product>>(
                                        (Product value) {
                                  return DropdownMenuItem<Product>(
                                    value: value,
                                    child: Text(value.productName),
                                  );
                                }).toList(),
                                onChanged: (Product value) {
                                  setState(() {
                                    selectedFuel = value.productName;
                                  });
                                },
                                icon: Icon(Icons.ev_station),
                                // value: selectedFuel,
                                hint: Text(selectedFuel ??
                                    'Select Fuel Type         '),
                              );
                            }),
                      ),
                      SizedBox(
                        height: 10,
                      ),
                      Container(
                        padding: EdgeInsets.only(left: 80, right: 80),
                        child: TextField(
                          controller: quantity,
                          decoration: InputDecoration(
                              // icon: Icon(Icons.qu),
                              labelText: 'Quantity',
                              labelStyle: TextStyle(
                                  fontWeight: FontWeight.bold,
                                  color: Colors.grey),
                              focusedBorder: UnderlineInputBorder(
                                  borderSide: BorderSide(color: Colors.green))),
                          keyboardType: TextInputType.number,
                        ),
                      ),
                      SizedBox(
                        height: 20,
                      ),
                      Container(
                        width: 200,
                        margin: EdgeInsets.only(top: 20),
                        child: RaisedButton(
                          onPressed: () {
                            var p = calculatePrice(
                              quantity.text,
                              productPrices.state.productPrices,
                              user.state.loggedInUser,
                              selectedFuel
                            );

                            return purchaseConfirmation(
                              context                          ,
                              quantity.text                    ,
                              p                                ,
                              selectedFuel                     ,
                              user.state.loggedInUser          ,
                              productPrices.state.productPrices,
                            );
                          },
                          color: Color(0xff213E4A),
                          child: Text('Purchase',
                            style: TextStyle(
                              fontWeight: FontWeight.bold,
                              color: Color(0xff213E4A),
                            )
                          ),
                        ),
                      ),
                    ],
                  ),
                )
              ],
            ),
          ),
        );
      },
    );
  }

  purchaseConfirmedFuel(Coupon coupon) async {

    var transactionRepo = Injector.getAsReactive<TransactionsRepository>();

    PurchaseFuelRequestModel model = new PurchaseFuelRequestModel();
    model.coupon = coupon;
    model.accountId = coupon.accountID;

   try {
      transactionRepo.state.purchaseFuel(model);
      return print("Done");
   } catch (err) {
     return print(err);
   }
  }

  double calculatePrice(String quantity, List<ProductPrice> products, UserModel user, selected) {
    double price = 0;
    try{
      ProductPrice p = products.firstWhere((e) => e.country.countryID == user.countryId && e.product.productName == selected);
      price = p.price * int.parse(quantity);
    }catch (e) {
      print(e.message);
    }
    return price;
  }

  void purchaseConfirmation(BuildContext context, String quantity, double price, String selected, UserModel user, List<ProductPrice> productPrices) {
    var alertDialog = AlertDialog(
      title: Text('Payment Confirmation', style: TextStyle(fontWeight: FontWeight.w900, fontSize: 30)),
      content: Container(
        constraints: BoxConstraints(minWidth: 230.0, minHeight: 25.0),
        width: 300,
        height: 50,
        child: ListView(
          children: <Widget>[
            Text("Quantity $quantity litres of $selected"),
            Text("Price    : RTGS \$ ${price.toStringAsFixed(2)}"),
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
          color: Colors.green,
          label: Container(
            alignment: Alignment.bottomLeft,
            child: Text(
              'Confirm',
              style: TextStyle(color: Colors.white),
            ),
          ),
          onPressed: () {

              Coupon coupon = new Coupon();
            setState(() {
              coupon.accountID = user.accountID;
              coupon.countryID = user.countryId;
              coupon.quantity = int.parse(quantity);
              coupon.price = price;
              coupon.productID = productPrices.firstWhere((e) => e.product.productName == selected && e.countryID == user.countryId ).productID;
              coupon.couponTypeID = 1;
            });
            return purchaseConfirmedFuel(coupon);
          },
        ),
      ],
    );
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return alertDialog;
      }
    );
  }
}
