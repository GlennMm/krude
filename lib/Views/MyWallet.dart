import 'dart:io';
import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:flutter/painting.dart';
import 'package:krude_digital/Views/PurchaseInternational.dart';
import 'package:krude_digital/Views/SwapFuelInternational.dart';
import 'package:krude_digital/Views/TransferFuel.dart';
import 'package:krude_digital/config.dart';
import 'PurchaseFuel.dart';
import 'SwapFuel.dart';

class UserProduct{
  String accountName;
  String productName;
  double quantity;
  String country;
}

class Wallet extends StatefulWidget {
  var username;
  var cId;

  Wallet(String user, int cID){

    this.username = user;
    cId = cID;
    print(cId);
  }

  @override
  _WalletState createState() => _WalletState(username, cId);
}

class _WalletState extends State<Wallet> {

  final List<Object> items = new List<Object>();
  List<UserProduct> mProducts = new List<UserProduct>();
  List products;
  var name;
  double total = 0;
  var config = new Config();
  var CID;

  _WalletState(username, cId) {
      name = username;
      CID = cId;
  }

  @override
  void initState() {
    super.initState();
    getProducts(name);
  }

  getProducts(String username) async {
    setState(() {
      total = 0;
    });
    Dio dio = new Dio();
    dio.onHttpClientCreate = (HttpClient client) {
      client.badCertificateCallback = (X509Certificate cert, String host, int port) {
        return true;
      };
    };
    var data = new FormData();
    data.add("username", username );
    dio.post(config.baseUrl + "/MobileAppApi/Dashboard", data: data).then((resp){
      print(resp.statusCode);

      products = resp.data['productPrices'] as List;
      products.forEach((f){

        UserProduct p = new UserProduct();
        p.accountName = f["accountName"];
        p.productName = f["productName"];
        p.country = f["country"];
        p.quantity = f["quantity"];
        setState(() {
          mProducts.add(p);
          total = total + f["quantity"];
        });


      });
      print(total);
    });

  }

  @override
  Widget build(BuildContext context) {

    return Scaffold(
      drawer: Drawer(
        child: ListView(
          children: <Widget>[
            SizedBox(
              height: 30,
            ),
            // UserAccountsDrawerHeader(
            //   decoration: BoxDecoration(
            //     color: Color(0xff213E4A),
            //   ),
            //   accountName: Text('$name'),
            //   accountEmail: Text('$name@gmail.com'),
            //   currentAccountPicture: CircleAvatar(
            //     backgroundColor: Colors.white,
            //   ),
            // ),
            ListTile(
              leading:
              Icon(Icons.account_balance_wallet, color: Color(0xff355664)),
              title: Text(
                'My Wallet',
                style: TextStyle(
                    fontWeight: FontWeight.bold, color: Color(0xff355664)),
              ),
              onTap: () {
                return Navigator.push(context,MaterialPageRoute(builder: (context) => Wallet(name, CID)));
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
                        Navigator.push(context, MaterialPageRoute(builder: (context) => PurchaseFuelLocal()));
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
//                        Navigator.pushNamed(
//                            context, '/purchaseRegionally');
                        Navigator.push(context, MaterialPageRoute(builder: (context) => PurchaseInternational()));
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
                        Navigator.push(context, MaterialPageRoute(builder: (context) => TransferFuel()));
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
                        Navigator.push(context, MaterialPageRoute(builder: (context) => SwapFuel()));
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
                        Navigator.push(context, MaterialPageRoute(builder: (context) => SwapFuelInternational()));
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
                        Navigator.pushNamed(context, '/redeem');
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
      appBar: AppBar(
        backgroundColor: Color(0xff355664),
        title: Text("Krude Digital"),
        actions: <Widget>[
          FlatButton.icon(
              onPressed: null,
              icon: Icon(Icons.person_outline, color: Colors.white),
              label: Text(name, style: TextStyle(color: Colors.white),)
          ),

          // POPUP MENU
          PopupMenuButton(

            itemBuilder: (BuildContext context) {
              return ["Logout"].map((String opt) {
                return PopupMenuItem(

                  child: FlatButton(
                    onPressed: (){
                      Navigator.pushNamed(context, '/login');
                    } ,
                    child: Text(opt)
                  ),
                );
              }).toList();
            },
          )


        ],
      ),
      body: Container(
        padding: EdgeInsets.all(10.0),
        child: ListView(
          padding: EdgeInsets.all(5.0),
          children: <Widget>[
            Text("$name's Wallet", style: TextStyle(fontWeight: FontWeight.bold, fontSize: 25)),
            SizedBox(height: 10.0,),
            Column(
              children: <Widget>[],
            ),

          Table(
            border: TableBorder.all(
              width: .5,
              color: Colors.black38,
              style: BorderStyle.solid
            ),
            children: [
              TableRow(

                children: [

                Text("Product", style: TextStyle(fontWeight: FontWeight.bold)),
                Text("Country", style: TextStyle(fontWeight: FontWeight.bold)),
                Text("Balances", style: TextStyle(fontWeight: FontWeight.bold)),
                ]),
              for (var i = 0; i < mProducts.length; i++) TableRow(children: [

                Text(mProducts[i].productName),
                Text(mProducts[i].country),
                Text(mProducts[i].quantity.toStringAsFixed(3)),
              ]),
              TableRow(children: [Text(""),Text(""),Text("")] ),
              TableRow(children: [Text("Total", style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),),Text(""),Text(total.toStringAsFixed(3))] )
            ],
          ),
// TOMMORROWL CONTINE WITH THE DASHBOARD


        ],
      ),
    ),
    );
  }
}