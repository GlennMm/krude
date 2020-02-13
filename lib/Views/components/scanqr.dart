import 'package:barcode_scan/barcode_scan.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:krude_digital/Views/components/appbar.dart';
import 'package:krude_digital/Views/components/ui_function.dart';
import 'package:krude_digital/repository/LoggedUser.dart';
import 'package:krude_digital/repository/ProductPricesRepository.dart';
import 'package:states_rebuilder/states_rebuilder.dart';


class ScanScreen extends StatefulWidget {
  ScanScreen({Key key}) : super(key: key);

  @override
  _ScanScreenState createState() => _ScanScreenState();
}

class _ScanScreenState extends State<ScanScreen> {

  var user = Injector.getAsReactive<LoggedInUserRepository>();
  var prodPrices = Injector.getAsReactive<ProductPricesRepository>();

  String barcode = "";

  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
       appBar: appBar(),
       drawer: drawer(context, user),
       body: new Center(
          child: Column(
            // mainAxisAlignment: MainAxisAlignment.center,
            // crossAxisAlignment: CrossAxisAlignment.stretch,
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
              Padding(
                padding: EdgeInsets.symmetric(horizontal: 16.0, vertical: 8.0),
                child: Container(
                  height: 60,
                  child: RaisedButton(
                    color: Color(0xff355664),
                    textColor: Colors.white,
                    splashColor: Colors.blueGrey,
                    child: const Text("Scan Qr Code", style: TextStyle(fontSize: 15, fontWeight: FontWeight.w800),),
                    onPressed: scan,
                  ),
                ),
                ),
                Container(
                    padding: EdgeInsets.symmetric(vertical: 5),
                    child: Center(
                      child: Text(
                        "Transaction History",
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
                    elevation: 3,
                    child: transactionHistory(prodPrices.state.groupedCountry) ?? Text("Information not found"),
                  ),
            ],
          )
       ),
    );
  }

  Future scan() async {
    try{
      String barcode = await BarcodeScanner.scan();
      setState(()=> this.barcode = barcode);
    } on PlatformException catch (e) {
      if(e.code == BarcodeScanner.CameraAccessDenied){
        setState(() => this.barcode = "User did not grant the camera permission");
      }else{
        setState(()=> this.barcode = "Unknown error: $e");
      }
    } on FormatException{
      setState(() => this.barcode = 'Did not get result from last scan');
    } catch (e) {
      setState(() => this.barcode = 'Unknown error: $e');
    }
  }
}

Widget transactionHistory(productsPrices){
  return Table(
    border: TableBorder.all(
        width: .5, color: Color(0xffD5CBC9), style: BorderStyle.solid),
    children: [
      TableRow(children: [
        Container(
          color: Color(0xff355664),
          child: Padding(
            padding:
                EdgeInsets.only(top: 5.0, bottom: 5.0, left: 10.0, right: 10.0),
            child: Text("#",
                style: TextStyle(
                    fontSize: 10,
                    fontWeight: FontWeight.bold,
                    color: Colors.white70)),
          ),
        ),
        Container(
          color: Color(0xff355664),
          child: Padding(
            padding:
                EdgeInsets.only(top: 5.0, bottom: 5.0, left: 10.0, right: 10.0),
            child: Text("Type",
                style: TextStyle(
                    fontSize: 10,
                    fontWeight: FontWeight.bold,
                    color: Colors.white70)),
          ),
        ),
        Container(
          color: Color(0xff355664),
          child: Padding(
            padding:
                EdgeInsets.only(top: 5.0, bottom: 5.0, left: 10.0, right: 10.0),
            child: Text("Quantity",
                style: TextStyle(
                    fontSize: 10,
                    fontWeight: FontWeight.bold,
                    color: Colors.white70)),
          ),
        ),
        Container(
          color: Color(0xff355664),
          child: Padding(
            padding:
                EdgeInsets.only(top: 5.0, bottom: 5.0, left: 10.0, right: 10.0),
            child: Text("Price",
                style: TextStyle(
                    fontSize: 10,
                    fontWeight: FontWeight.bold,
                    color: Colors.white70)),
          ),
        ),
      ]),
      for (var key in productsPrices.keys)
        TableRow(children: [
          Container(
            color: Colors.black38,
            child: Padding(
              padding: EdgeInsets.only(
                  top: 5.0, bottom: 5.0, left: 10.0, right: 10.0),
              child: Text(key,
                  style: TextStyle(fontSize: 10, color: Colors.white)),
            ),
          ),
          Container(
            color: Colors.black38,
            child: Padding(
              padding: EdgeInsets.only(
                  top: 5.0, bottom: 5.0, left: 10.0, right: 10.0),
              child: Text(productsPrices[key][0].price.toStringAsFixed(2),
                  style: TextStyle(fontSize: 10, color: Colors.white)),
            ),
          ),
          Container(
            color: Colors.black38,
            child: Padding(
              padding: EdgeInsets.only(
                  top: 5.0, bottom: 5.0, left: 10.0, right: 10.0),
              child: Text(productsPrices[key][1].price.toStringAsFixed(2),
                  style: TextStyle(fontSize: 10, color: Colors.white)),
            ),
          ),
          Container(
            color: Colors.black38,
            child: Padding(
              padding: EdgeInsets.only(
                  top: 5.0, bottom: 5.0, left: 10.0, right: 10.0),
              child: Text(productsPrices[key][2].price.toStringAsFixed(2),
                  style: TextStyle(fontSize: 10, color: Colors.white)),
            ),
          ),
        ]),
    ],
  );
}