import 'dart:io';
import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:flutter/painting.dart';
import 'package:krude_digital/Views/PurchaseInternational.dart';
import 'package:krude_digital/Views/SwapFuelInternational.dart';
import 'package:krude_digital/Views/TransferFuel.dart';
import 'package:krude_digital/Views/subAccounts/editSubAccount.dart';
import 'package:krude_digital/Views/subAccounts/productDistribution.dart';
import 'package:krude_digital/config.dart';
import 'package:krude_digital/models/UserProduct.dart';
import 'package:krude_digital/repository/ProductsRepository.dart';
import 'package:states_rebuilder/states_rebuilder.dart';
import 'PurchaseFuel.dart';
import 'SwapFuel.dart';
import 'package:carousel_slider/carousel_slider.dart';
import 'package:flutter_circular_chart/flutter_circular_chart.dart';

@immutable
class Sales {
  const Sales(this.season, this.iceCream, this.chocolate, this.cookies);
  final String season;
  final int iceCream;
  final int chocolate;
  final int cookies;
}

class ProductCountry {
  String country;
  List<UserProduct> products;
}

class CWallet extends StatefulWidget {
  var username;
  var cId;
  var accTypeId;
  var accountId;
  String userId;

  CWallet(String user, int cID, accountTypeID, accId, uId) {
    this.username = user;
    cId = cID;
    accTypeId = accountTypeID;
    accountId = accId;
    userId = uId;
  }

  @override
  _WalletState createState() =>
      _WalletState(username, cId, accTypeId, accountId, userId);
}

class _WalletState extends State<CWallet> {
  List<Widget> carausal = [];
  List<Widget> tables = [];

  final List<Object> items = new List<Object>();
  List products;
  var name;
  double total = 0;
  var config = new Config();
  var CID;
  var accountTypeId;
  var accountId;
  String userId;

  List<ProductCountry> productsByCountry = new List<ProductCountry>();

  _WalletState(username, cId, accTypeId, accId, uId) {
    name = username;
    CID = cId;
    accountTypeId = accTypeId;
    accountId = accId;
    userId = uId;

    // CHART STUFF ENDS HERE
    tables.add(FutureBuilder(
      future: getFutureProducts(name),
      builder: (context, snapshot) {
        switch (snapshot.connectionState) {
          case ConnectionState.active:
            return Text("Loading...");
          case ConnectionState.done:
            return Table(
              border: TableBorder.all(
                  width: .5,
                  color: Color(0xffD5CBC9),
                  style: BorderStyle.solid),
              children: [
                TableRow(children: [
                  Container(
                    color: Color(0xff355664),
                    child: Padding(
                        padding: EdgeInsets.only(
                            top: 5.0, bottom: 5.0, left: 10.0, right: 10.0),
                        child: Text("Product",
                            style: TextStyle(
                                fontSize: 10,
                                fontWeight: FontWeight.bold,
                                color: Colors.white70))),
                  ),
                  Container(
                    color: Color(0xff355664),
                    child: Padding(
                      padding: EdgeInsets.only(
                          top: 5.0, bottom: 5.0, left: 10.0, right: 10.0),
                      child: Text("Country",
                          style: TextStyle(
                              fontSize: 10,
                              fontWeight: FontWeight.bold,
                              color: Colors.white70)),
                    ),
                  ),
                  Container(
                    color: Color(0xff355664),
                    child: Padding(
                      padding: EdgeInsets.only(
                          top: 5.0, bottom: 5.0, left: 10.0, right: 10.0),
                      child: Text("Balances",
                          style: TextStyle(
                              fontSize: 10,
                              fontWeight: FontWeight.bold,
                              color: Colors.white70)),
                    ),
                  ),
                ]),
                for (var i = 0; i < snapshot.data.length; i++)
                  TableRow(children: [
                    Container(
                      color: Color(0xFFEDF1FD),
                      child: Padding(
                        padding: EdgeInsets.only(
                            top: 5.0, bottom: 5.0, left: 10.0, right: 10.0),
                        child: Text(
                          snapshot.data[i].productName,
                          style:
                              TextStyle(fontSize: 8, color: Color(0xff213E4A)),
                        ),
                      ),
                    ),
                    Container(
                      color: Color(0xFFEDF1FD),
                      child: Padding(
                        padding: EdgeInsets.only(
                            top: 5.0, bottom: 5.0, left: 10.0, right: 10.0),
                        child: Text(
                          snapshot.data[i].country,
                          style:
                              TextStyle(fontSize: 8, color: Color(0xff213E4A)),
                        ),
                      ),
                    ),
                    Container(
                      color: Color(0xFFEDF1FD),
                      child: Padding(
                        padding: EdgeInsets.only(
                            top: 5.0, bottom: 5.0, left: 10.0, right: 10.0),
                        child: Text(
                          snapshot.data[i].quantity.toStringAsFixed(3),
                          style:
                              TextStyle(fontSize: 8, color: Color(0xff213E4A)),
                        ),
                      ),
                    ),
                  ]),
              ],
            );
          default:
            return Container(
              padding: EdgeInsets.all(10),
              child: Column(
                children: <Widget>[
                  Text("Something happened"),
                  MaterialButton(
                    child: Row(
                      children: <Widget>[
                        Icon(Icons.refresh),
                        Text(
                          "Refresh",
                          style: TextStyle(color: Colors.amber),
                        )
                      ],
                    ),
                    onPressed: () {
                      getFutureProducts(username);
                    },
                  )
                ],
              ),
            );
        }
      },
    ));
  }

  @override
  void initState() {
    super.initState();

    List<CircularStackEntry> data = <CircularStackEntry>[
      new CircularStackEntry(
        <CircularSegmentEntry>[
          new CircularSegmentEntry(5000.0, Colors.red[300], rankKey: 'Petrol'),
          new CircularSegmentEntry(1000.0, Colors.green[300],
              rankKey: 'Diesel'),
          new CircularSegmentEntry(2000.0, Colors.blue[300],
              rankKey: 'Blend Fuel'),
        ],
        rankKey: 'Summary',
      ),
    ];

    List<CircularStackEntry> data1 = <CircularStackEntry>[
      new CircularStackEntry(
        <CircularSegmentEntry>[
          new CircularSegmentEntry(
            2000.0,
            Colors.red[300],
            rankKey: 'Petrol',
          ),
          new CircularSegmentEntry(4000.0, Colors.green[300],
              rankKey: 'Diesel'),
          new CircularSegmentEntry(6000.0, Colors.blue[300],
              rankKey: 'Blend Fuel'),
        ],
        rankKey: 'Summary',
      ),
    ];

    carausal.add(new AnimatedCircularChart(
      size: const Size(300.0, 300.0),
      initialChartData: data,
      chartType: CircularChartType.Pie,
    ));

    carausal.add(
        new AnimatedCircularChart(
          size: const Size(300.0, 300.0),
          initialChartData: data1,
          chartType: CircularChartType.Pie,
        ));
  }

  Future<List<UserProduct>> getFutureProducts(String username) async {
    Dio dio = new Dio();
    dio.onHttpClientCreate = (HttpClient client) {
      client.badCertificateCallback =
          (X509Certificate cert, String host, int port) {
        return true;
      };
    };

    var data = new FormData();
    List<UserProduct> output = new List<UserProduct>();

    data.add("username", username);

    await dio
        .post(config.baseUrl + "/MobileAppApi/Dashboard", data: data)
        .then((resp) {
      var productsList = resp.data['productPrices'] as List;
      productsList.forEach((f) {
        UserProduct p = new UserProduct();
        p.accountName = f["accountName"];
        p.productName = f["productName"];
        p.country = f["country"];
        p.quantity = f["quantity"];
        setState(() {
          output.add(p);
          total = total + f["quantity"];
        });
      });
    });
    return output;
  }

  final productsState = Injector.getAsReactive<ProductsRepository>();
  final productsPricesState = Injector.getAsReactive<ProductsRepository>();
  final clientPricesState = Injector.getAsReactive<ProductsRepository>();

  @override
  Widget build(BuildContext context) {
    return StateBuilder(
        models: [productsState, productsPricesState, clientPricesState],
        builder: (_, model) {
          switch (model.connectionState) {
            case ConnectionState.done:
              return Scaffold(
                drawer: Drawer(
                  child: ListView(
                    children: <Widget>[
                      UserAccountsDrawerHeader(
                        decoration: BoxDecoration(
                          color: Color(0xff213E4A),
                        ),
                        accountName: Text('$name'),
                        accountEmail: Text(name + '@gmail.com'),
                        currentAccountPicture: CircleAvatar(
                          backgroundColor: Colors.white,
                        ),
                      ),
                      ListTile(
                        leading: Icon(Icons.account_balance_wallet,
                            color: Color(0xff355664)),
                        title: Text(
                          name + "'s Wallet",
                          style: TextStyle(
                              fontWeight: FontWeight.bold,
                              color: Color(0xff355664)),
                        ),
                        onTap: () {
                          return Navigator.push(
                              context,
                              MaterialPageRoute(
                                  builder: (context) => CWallet(name, CID,
                                      accountTypeId, accountId, userId)));
                        },
                      ),
                      ExpansionTile(
                        leading: Icon(Icons.shop, color: Color(0xff355664)),
                        title: Text(
                          "Purchases",
                          style: TextStyle(
                              fontWeight: FontWeight.bold,
                              color: Color(0xff355664)),
                        ),
                        children: <Widget>[
                          Container(
                              alignment: Alignment.bottomLeft,
                              color: Colors.transparent,
                              padding: EdgeInsets.only(left: 50.0, bottom: 10.0),
                              child: ListTile(
                                onTap: () {
                                  Navigator.push(
                                      context,
                                      MaterialPageRoute(
                                          builder: (context) =>
                                              PurchaseFuelLocal()));
                                },
                                leading: Icon(Icons.location_on,
                                    color: Color(0xff355664)),
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
    //                        Navigator.pushNamed(
    //                            context, '/purchaseRegionally');
                                  Navigator.push(
                                      context,
                                      MaterialPageRoute(
                                          builder: (context) =>
                                              PurchaseInternational()));
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
                              fontWeight: FontWeight.bold,
                              color: Color(0xff355664)),
                        ),
                        children: <Widget>[
                          Container(
                              alignment: Alignment.bottomLeft,
                              color: Colors.transparent,
                              padding: EdgeInsets.only(left: 50.0, bottom: 10.0),
                              child: ListTile(
                                onTap: () {
                                  Navigator.push(
                                      context,
                                      MaterialPageRoute(
                                          builder: (context) =>
                                              TransferFuel()));
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
                                  Navigator.push(
                                      context,
                                      MaterialPageRoute(
                                          builder: (context) => SwapFuel()));
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
                                  Navigator.push(
                                      context,
                                      MaterialPageRoute(
                                          builder: (context) =>
                                              SwapFuelInternational()));
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
                          "Sub Accounts",
                          style: TextStyle(
                              fontWeight: FontWeight.bold,
                              color: Color(0xff355664)),
                        ),
                        children: <Widget>[
                          Container(
                              alignment: Alignment.bottomLeft,
                              color: Colors.transparent,
                              padding: EdgeInsets.only(left: 50.0, bottom: 10.0),
                              child: ListTile(
                                onTap: () {
                                  Navigator.push(
                                      context,
                                      MaterialPageRoute(
                                          builder: (context) => EditSubAccount(
                                              name,
                                              CID,
                                              accountTypeId,
                                              accountId,
                                              userId)));
                                },
                                leading: Icon(Icons.edit_attributes,
                                    color: Color(0xff355664)),
                                title: Text(
                                  'Edit SubAccounts',
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
                                  Navigator.pop(
                                      context,
                                      MaterialPageRoute(
                                          builder: (context) =>
                                              ProductDistribution()));
                                },
                                leading: Icon(Icons.shop, color: Color(0xff355664)),
                                title: Text(
                                  'Product Distribution',
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
    //                        Navigator.push(context, MaterialPageRoute(builder: (context, SubAccountBalance() )));
                                },
                                leading: Icon(
                                  Icons.account_box,
                                  color: Color(0xff355664),
                                ),
                                title: Text(
                                  'Sub Accounts Balances',
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
                              fontWeight: FontWeight.bold,
                              color: Color(0xff355664)),
                        ),
                      ),
                      ListTile(
                        leading: Icon(Icons.info, color: Color(0xff355664)),
                        title: Text(
                          'Help and feedback',
                          style: TextStyle(
                              fontWeight: FontWeight.bold,
                              color: Color(0xff355664)),
                        ),
                      ),
                      ListTile(
                        leading: Icon(Icons.settings, color: Color(0xff355664)),
                        title: Text(
                          'Setting and Configurations',
                          style: TextStyle(
                              fontWeight: FontWeight.bold,
                              color: Color(0xff355664)),
                        ),
                      ),
                    ],
                  ),
                ),
                appBar: AppBar(
                  backgroundColor: Color(0xff355664),
                  title: Text("$name's Wallet"),
                  actions: <Widget>[
                    FlatButton.icon(
                        onPressed: null,
                        icon: Icon(Icons.person_outline, color: Colors.white),
                        label: Text(
                          name,
                          style: TextStyle(color: Colors.white),
                        )),

                    // POPUP MENU
                    PopupMenuButton(
                      itemBuilder: (BuildContext context) {
                        return ["Logout"].map((String opt) {
                          return PopupMenuItem(
                            child: FlatButton(
                                onPressed: () {
                                  Navigator.pushNamed(context, '/login');
                                },
                                child: Text(opt)),
                          );
                        }).toList();
                      },
                    )
                  ],
                ),
                body: Container(
                  child: ListView(
                    padding: EdgeInsets.all(5.0),
                    children: <Widget>[
    // TABLES CARAUSAL
                      CarouselSlider(
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
                        items: tables.map((i) {
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
                      ),

                      SizedBox(
                        height: 25,
                      ),

                      CarouselSlider(
                        aspectRatio: 16 / 9,
                        viewportFraction: 0.8,
                        initialPage: 0,
                        enableInfiniteScroll: true,
                        reverse: false,
                        autoPlay: true,
                        autoPlayInterval: Duration(seconds: 10),
                        autoPlayAnimationDuration: Duration(milliseconds: 1000),
                        pauseAutoPlayOnTouch: Duration(seconds: 20),
                        enlargeCenterPage: true,
                        scrollDirection: Axis.horizontal,
                        height: 400.0,
                        items: carausal.map((i) {
                          return Builder(
                            builder: (BuildContext context) {
                              return Container(
                                  width: MediaQuery.of(context).size.width,
                                  margin: EdgeInsets.symmetric(horizontal: 5.0),
                                  child: Card(
                                      elevation: 4,
                                      child: Column(
                                        children: <Widget>[
                                          Padding(
                                            padding:
                                                const EdgeInsets.only(top: 8.0),
                                            child: Text("Country Name Here"),
                                          ),
                                          i,
                                          Row(
                                            crossAxisAlignment:
                                                CrossAxisAlignment.center,
                                            children: <Widget>[
                                              Card(
                                                elevation: 0,
                                                child: Row(
                                                  children: <Widget>[
                                                    Container(
                                                      alignment: Alignment.center,
                                                      padding: EdgeInsets.symmetric(
                                                          horizontal: 5,
                                                          vertical: 5),
                                                      child: Container(
                                                        color: Colors.red[300],
                                                        child: Text(
                                                          "Heo",
                                                          style: TextStyle(
                                                              color:
                                                                  Colors.red[300]),
                                                        ),
                                                      ),
                                                    ),
                                                    Text("Blend")
                                                  ],
                                                ),
                                              ),
                                              Card(
                                                elevation: 0,
                                                child: Row(
                                                  children: <Widget>[
                                                    Container(
                                                      alignment: Alignment.center,
                                                      padding: EdgeInsets.symmetric(
                                                          horizontal: 5,
                                                          vertical: 5),
                                                      child: Container(
                                                        color: Colors.green[300],
                                                        child: Text(
                                                          "Heo",
                                                          style: TextStyle(
                                                              color: Colors
                                                                  .green[300]),
                                                        ),
                                                      ),
                                                    ),
                                                    Text("Petrol")
                                                  ],
                                                ),
                                              ),
                                              Card(
                                                elevation: 0,
                                                child: Row(
                                                  children: <Widget>[
                                                    Container(
                                                      alignment: Alignment.center,
                                                      padding: EdgeInsets.symmetric(
                                                          horizontal: 5,
                                                          vertical: 5),
                                                      child: Container(
                                                        color: Colors.blue,
                                                        child: Container(
                                                          color: Colors.blue[300],
                                                          child: Text(
                                                            "Heo",
                                                            style: TextStyle(
                                                                color: Colors
                                                                    .blue[300]),
                                                          ),
                                                        ),
                                                      ),
                                                    ),
                                                    Text("Diesel")
                                                  ],
                                                ),
                                              )
                                            ],
                                          )
                                        ],
                                      )));
                            },
                          );
                        }).toList(),
                      ),

                      Container(
                        margin: EdgeInsets.symmetric(vertical: 20.0),
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
                                              PurchaseFuelLocal()));
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
                                          builder: (context) =>
                                              TransferFuel()));
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
                                              name,
                                              CID,
                                              accountTypeId,
                                              accountId,
                                              userId)));
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
                      )


                    ],
                  ),
                ),
              );
            case ConnectionState.waiting:
              return Loading();
            case ConnectionState.active:
              return Loading();
            default:
              return Failed();
          }
        });
  }
}

Widget Loading() {
  return Scaffold(
    body: Center(
      child: ListView(
        children: <Widget>[
          CircularProgressIndicator(),
          Text('Loading..')
        ],
      ),
    ),
  );
}

Widget Failed() {
  return Scaffold(
    body: Center(
      child: ListView(
        children: <Widget>[
          Icon(Icons.warning, color: Colors.red,),
          Text('Failed To Load Page..')
        ],
      ),
    ),
  );
}
