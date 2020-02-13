import 'package:carousel_slider/carousel_slider.dart';
import 'package:flutter/material.dart';
import 'package:krude_digital/Views/Graphs/siglechart.dart';
import 'package:krude_digital/Views/components/appbar.dart';
import 'package:krude_digital/Views/components/ui_function.dart';
import 'package:krude_digital/Views/subAccounts/subaccountDeatils.dart';
import 'package:krude_digital/models/Summary.dart';
import 'package:states_rebuilder/states_rebuilder.dart';

import 'package:krude_digital/Views/subAccounts/editSubAccount.dart';
import 'package:krude_digital/repository/ClientProductRepository.dart';
import 'package:krude_digital/repository/LoggedUser.dart';
import '../repository/ProductPricesRepository.dart';
import '../models/ProductPrice.dart';
import 'PurchaseFuel.dart' as PF;
import 'TransferFuel.dart' as TF;
import "package:collection/collection.dart";
import 'package:charts_flutter/flutter.dart' as charts;

class Dashboard extends StatefulWidget {
  Dashboard({Key key}) : super(key: key);

  _DashboardState createState() => _DashboardState();
}

class CardItem {
  String header;
  double petrol;
  double diesel;
  double blend;

  CardItem(this.header, this.petrol, this.diesel, this.blend);
}

class ChartBarGroup {
  final String country;
  final double amount;

  ChartBarGroup(this.country, this.amount);
}

class _DashboardState extends State<Dashboard> {
  List<ProductPrice> pPrices = new List<ProductPrice>();
  var prodPrices = Injector.getAsReactive<ProductPricesRepository>();
  var clieProdRepo = Injector.getAsReactive<ClientProductRepository>();
  var user = Injector.getAsReactive<LoggedInUserRepository>();
  var chartData;

  getClientProducts() async {
    await clieProdRepo.setState((model) async {
      return await model.getBalance(user.state.loggedInUser.accountID,
          user.state.loggedInUser.countryId, 1);
    });
    chartData = groupBy(
        clieProdRepo.state.summaryList, (Summary item) => item.countryName);
    print(chartData);
  }

  _DashboardState() {
    getClientProducts();
  }

  @override
  Widget build(BuildContext context) {
    return StateBuilder(
      models: [
        Injector.getAsReactive<ProductPricesRepository>(),
        Injector.getAsReactive<ClientProductRepository>(),
        Injector.getAsReactive<LoggedInUserRepository>(),
      ],
      builder: (_, model) {
        switch (model.connectionState) {
          case ConnectionState.active:
            return Scaffold(
              body: Text("active"),
            );
            break;
          case ConnectionState.none:
            return Scaffold(
              appBar: appBar(),
              drawer: drawer(context, user),
              body: Container(
                  child: ListView(
                children: <Widget>[
                  Container(
                    padding: EdgeInsets.symmetric(vertical: 5),
                    child: Center(
                      child: Text(
                        "Welcome to your dashboard",
                        style: TextStyle(color: Color(0xff213E4A)),
                      ),
                    ),
                  ),
                  Divider(
                    indent: 100,
                    endIndent: 100,
                    color: Color(0xff213E4A),
                  ),
                  Card(
                    margin: EdgeInsets.symmetric(vertical: 5, horizontal: 8),
                    child: Container(
                      // color: Color(0xff213E4A),
                      height: 200.0,
                      child: Padding(
                          padding: const EdgeInsets.all(5.0),
                          child: ChartExample.withSampleData(chartData)),
                    ),
                  ),
                  // MaterialButton(
                  //     child: Container(
                  //       color: Color(0xff213E4A),
                  //       child: Padding(
                  //         padding: const EdgeInsets.all(10.0),
                  //         child: Text(
                  //           "Refresh Data",
                  //           style: TextStyle(color: Colors.white),
                  //         ),
                  //       ),
                  //     ),
                  //     onPressed: () async {
                  //       print("refreshing");
                  //       getClientProducts();
                  //       print("done");
                  //     }),
                  // RaisedButton(
                  //     child: Text("OPEN SCANNER"),
                  //     onPressed: () {
                  //       Navigator.pushNamed(context, '/qr_scan');
                  //     }),
                  Divider(
                    indent: 100,
                    endIndent: 100,
                    color: Color(0xff213E4A),
                  ),

                  Card(
                    margin: EdgeInsets.symmetric(vertical: 5, horizontal: 8),
                    elevation: 3,
                    child:
                        productPricesTable(prodPrices.state.groupedCountry) ??
                            Text("Information not found"),
                  ),
                  // subAccountsContainer(context, []),
                  // QUICK NAVIFGATION BAR
                  Container(
                    margin: EdgeInsets.symmetric(vertical: 5, horizontal: 5),
                    height: 200.0,
                    child: ListView(
                      scrollDirection: Axis.horizontal,
                      children: <Widget>[
                        Container(
                          width: 160.0,
                          child: FlatButton(
                            onPressed: () {
                              Navigator.push(
                                  context,
                                  MaterialPageRoute(
                                      builder: (context) =>
                                          PF.PurchaseFuelLocal()));
                            },
                            padding: EdgeInsets.all(5.0),
                            child: Card(
                              elevation: 5,
                              child: Container(
                                width: 130,
                                height: 130,
                                padding: EdgeInsets.all(20),
                                child: Column(
                                  children: <Widget>[
                                    Icon(
                                      Icons.shop,
                                      color: Color(0xff355664),
                                      size: 70,
                                    ),
                                    Text(
                                      "Purchase Fuel",
                                      style:
                                          TextStyle(color: Color(0xff213E4A)),
                                    )
                                  ],
                                ),
                              ),
                            ),
                          ),
                        ),
                        Container(
                          width: 160.0,
                          child: FlatButton(
                            onPressed: () {
                              Navigator.push(
                                  context,
                                  MaterialPageRoute(
                                      builder: (context) => TF.TransferFuel()));
                            },
                            padding: EdgeInsets.all(5.0),
                            child: Card(
                              elevation: 5,
                              child: Container(
                                width: 130,
                                height: 130,
                                padding: EdgeInsets.all(20),
                                child: Column(
                                  children: <Widget>[
                                    Icon(
                                      Icons.swap_horiz,
                                      color: Color(0xff355664),
                                      size: 70,
                                    ),
                                    Text(
                                      "Transfer",
                                      style:
                                          TextStyle(color: Color(0xff213E4A)),
                                    )
                                  ],
                                ),
                              ),
                            ),
                          ),
                        ),
                        Container(
                          width: 160.0,
                          child: FlatButton(
                            onPressed: () {
                              Navigator.push(
                                  context,
                                  MaterialPageRoute(
                                      builder: (context) => EditSubAccount(
                                            user.state.loggedInUser.username,
                                            user.state.loggedInUser.countryId,
                                            user.state.loggedInUser
                                                .accountTypeID,
                                            user.state.loggedInUser.accountID,
                                            'user id',
                                          )));
                            },
                            padding: EdgeInsets.all(5.0),
                            child: Card(
                              elevation: 5,
                              child: Container(
                                width: 130,
                                height: 130,
                                padding: EdgeInsets.all(20),
                                child: Column(
                                  children: <Widget>[
                                    Icon(
                                      Icons.supervised_user_circle,
                                      color: Color(0xff355664),
                                      size: 70,
                                    ),
                                    Text(
                                      "Sub Accounts",
                                      style:
                                          TextStyle(color: Color(0xff213E4A)),
                                    )
                                  ],
                                ),
                              ),
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),


                  Container(
                    // margin: EdgeInsets.all(5.0),
                    height: 200.0,
                    child: Padding(
                        padding: const EdgeInsets.all(1.0),
                        child: ListView(
                          scrollDirection: Axis.horizontal,
                          children: <Widget>[

                            for (var i = 0; i < 5; i++) Container(
                                    width: 160.0,
                                    child: FlatButton(
                                      onPressed: () {
                                        Navigator.push(
                                          context,
                                          MaterialPageRoute(
                                            builder: (context) => SubAccountDetails()
                                          )
                                        );
                                      },
                                      padding: EdgeInsets.all(5.0),
                                      child: Card(
                                        // elevation: 5,
                                        child: Container(
                                          width: 130,
                                          height: 130,
                                          padding: EdgeInsets.all(20),
                                          child: Column(
                                            children: <Widget>[
                                              Row(
                                                children: <Widget>[
                                                  Icon(
                                                    Icons.contact_mail,
                                                    color: Color(0xff355664),
                                                    size: 40,
                                                  ),
                                                ],
                                              ),
                                              SizedBox(height: 10,),
                                              Text(
                                                "Sub Accounts ${i+1}",
                                                style:
                                                  TextStyle(color: Color(0xff213E4A)),
                                              ),
                                              SizedBox(height: 5,),
                                              Text("000 000 00${i+1}",
                                                style:
                                                  TextStyle(color: Color(0xff213E4A)))


                                            ],
                                          ),
                                        ),
                                      ),
                                    ),
                                  ),






                          ],
                        ),
                    ),
                  )
                ],
              )),
            );
            break;
          case ConnectionState.waiting:
            return Scaffold(
              body: Text("waiting"),
            );
            break;
          case ConnectionState.done:
            return Scaffold(
              body: Text("done"),
            );
            break;
          default:
            return Scaffold(
              body: Text("Big error happened"),
            );
        }
      },
    );
  }
}

// PRICLIST TABLE IS GENERATED HERE

// SUBACCOUNTS SECTION GENERATION
Widget subAccountsContainer(BuildContext context, data) {
  return CarouselSlider(
    aspectRatio: 16 / 9,
    viewportFraction: 0.8,
    initialPage: 0,
    enableInfiniteScroll: true,
    reverse: true,
    autoPlayAnimationDuration: Duration(milliseconds: 800),
    pauseAutoPlayOnTouch: Duration(seconds: 10),
    enlargeCenterPage: true,
    scrollDirection: Axis.horizontal,
    height: 85.0,
    items: [].map((i) {
      return Builder(
        builder: (BuildContext context) {
          return Container(
            width: MediaQuery.of(context).size.width,
            margin: EdgeInsets.symmetric(horizontal: 5.0),
            child: Card(elevation: 5, child: i),
          );
        },
      );
    }).toList(),
  );
}
