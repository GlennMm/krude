import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';

class RedeemFuel extends StatefulWidget {
  RedeemFuel({Key key}) : super(key: key);

  _RedeemFuelState createState() => _RedeemFuelState();
}

class _RedeemFuelState extends State<RedeemFuel> {
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
            Center(
              child: Text(
                  'Redeem Fuel Coupons',
                  style: TextStyle( fontSize: 18,
                      fontWeight: FontWeight.bold, color: Color(0xff355664)),
                ),
            ),
            Container(
                padding: EdgeInsets.only(left: 20.0, right: 20.0),
                child: new DropdownButton(
                  onChanged: (data){
                    
                  },
                  items: [],
                  hint: Text('Fuel Type', style: TextStyle(color: Color(0xff355664)),),
                )
              ),
            Container(
              padding: EdgeInsets.only(left: 20.0, right: 20.0),
              child: TextField(
                decoration: InputDecoration(
                    labelText: 'Price',
                    labelStyle: TextStyle( color: Color(0xff355664)),
                    focusedBorder: UnderlineInputBorder(
                        borderSide: BorderSide(color: Colors.green))),
              ),
            ),
            Container(
              padding: EdgeInsets.only(left: 20.0, right: 20.0),
              child: TextField(
                decoration: InputDecoration(
                    labelText: 'Quantity',
                    labelStyle: TextStyle( color: Color(0xff355664)),
                    focusedBorder: UnderlineInputBorder(
                        borderSide: BorderSide(color: Colors.green))),
              ),
            ),
            Container(
              margin: EdgeInsets.only(top: 20, left: 40, right: 40),
              child: RaisedButton(
                onPressed: () {
                  // swapConfirmation(context);
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
}
