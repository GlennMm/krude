import 'package:carousel_slider/carousel_slider.dart';
import 'package:flutter/material.dart';
import 'package:krude_digital/Views/Graphs/siglechart.dart';
import 'package:krude_digital/Views/components/appbar.dart';
import 'package:krude_digital/Views/components/ui_function.dart';
import 'package:krude_digital/Views/subAccounts/subaccountDeatils.dart';
import 'package:krude_digital/models/Summary.dart';
import 'package:krude_digital/repository/AccountRepository.dart';
import 'package:states_rebuilder/states_rebuilder.dart';

import 'package:krude_digital/Views/subAccounts/editSubAccount.dart';
import 'package:krude_digital/repository/ClientProductRepository.dart';
import 'package:krude_digital/repository/LoggedUser.dart';
import '../repository/ProductPricesRepository.dart';
import '../models/ProductPrice.dart';
import 'PurchaseFuel.dart' as PF;
import 'TransferFuel.dart' as TF;
import "package:collection/collection.dart";

import 'subAccounts/components/sub-account-list.dart';

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
  var accountRepo = Injector.getAsReactive<AccountRepository>();
  var chartData;

  getClientProducts() async {
    await clieProdRepo.setState((model) async {
      return await model.getBalance(user.state.loggedInUser.accountID,
        user.state.loggedInUser.countryId, 1);
    });
    prodPrices.setState((model) async {
      return await model.getAll();
    });
    chartData = groupBy(
        clieProdRepo.state.summaryList, (Summary item) => item.countryName);
    print(chartData);
  }

  _DashboardState() {
    getClientProducts();
    accountRepo.setState((model) async {
      return await model.getSubAccounts(user.state.loggedInUser.accountID, user.state.loggedInUser.countryId, user.state.loggedInUser.userId);
    });
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
                child: Center(
                  child: Column(
                    children: <Widget>[
                      Icon(Icons.error_outline, size: 50, color: Colors.red,),
                      Text("Something Wrong Happened! Try again your last action", style: TextStyle(color: Colors.red)),
                    ],
                  )
                ),
              ));
            break;
          case ConnectionState.waiting:
            return Scaffold(
              body: Center(

                child: CircularProgressIndicator(),
              ),
            );
            break;
          case ConnectionState.done:
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
                  Divider(
                    indent: 100,
                    endIndent: 100,
                    color: Color(0xff213E4A),
                  ),
                  if (prodPrices.state.groupedCountry == null)
                    Text("Failed to fetch product price list"),
                  if (prodPrices.state.groupedCountry != null)
                    Card(
                        margin:
                            EdgeInsets.symmetric(vertical: 5, horizontal: 8),
                        elevation: 3,
                        child: productPricesTable(prodPrices
                            .state.groupedCountry)), // QUICK NAVIFGATION BAR
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
                  subAccountsList(context, accountRepo.state.subAccounts),

                    SizedBox(height: 30,)
                ],
              )),
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
