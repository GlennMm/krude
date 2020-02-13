import 'package:flutter/material.dart';

class PaymentConfirmation extends StatefulWidget {
  PaymentConfirmation({Key key}) : super(key: key);

  _PaymentConfirmationState createState() => _PaymentConfirmationState();
}

class _PaymentConfirmationState extends State<PaymentConfirmation> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
       body: Container(
         child: ListView(
           children: <Widget>[
             Card(
               color: Colors.green,
               child: Text('Demo'),
             )
           ],
         ),
       )
    );
  }
}