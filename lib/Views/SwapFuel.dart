import 'dart:io';

import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';

import '../config.dart';
var config = new Config();

class SwapFuel extends StatefulWidget {
  SwapFuel(){ }

  var name;

  _SwapFuelState createState() => _SwapFuelState();
}

showLoading(context){
  showDialog(
    context: context,
    builder: (BuildContext context) {
      return  AlertDialog(
        content: Row(children: <Widget>[ CircularProgressIndicator(),SizedBox(width: 30,),Text("Processing...")],),
      );
    },
  );
}

MessageBox(context, String data){
  showDialog(
    context: context,
    builder: (BuildContext context) {
      return  AlertDialog(
        content: Text(data),
        actions: <Widget>[
          RaisedButton.icon(
            color: Colors.grey,
            icon: Icon(Icons.cancel, color: Colors.white,),
            onPressed: () {
              Navigator.pop(context);
            },
            label: Container(
              alignment: Alignment.bottomRight,
              child: Text('Close', style: TextStyle(color: Colors.white),),
            ),
          ),
        ],
      );
    },
  );
}

class _SwapFuelState extends State<SwapFuel> {

  _SwapFuelState(){
  }



  var FuelTypeTo;
  var FuelTypeFrom;
  var quantity = new TextEditingController();

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
              padding: EdgeInsets.only(top: 25.0, bottom: 25.0, left: 100.0),
              child: Text(
                'Swap Fuel Coupons',
                style: TextStyle(
                    fontWeight: FontWeight.bold, color: Color(0xff213E4A)),
              ),
            ),
            Container(
                padding: EdgeInsets.only(left: 20.0, right: 20.0),
                child: new DropdownButton(
                  items: ['Petrol', 'Diesel', 'Unlead Blend'].map<DropdownMenuItem<String>>((String value) {
                    return DropdownMenuItem<String>(
                      value: value,
                      child: Text(value),
                    );
                  }).toList(),
                  onChanged: (value){
                    setState(() {
                      FuelTypeFrom = value;
                    });
                  },
                  hint: Text(
                    FuelTypeFrom ?? 'Select Fuel Type at hand',
                    style: TextStyle(color: Color(0xff213E4A)),
                  ),
                )),
            Container(
                padding: EdgeInsets.only(left: 20.0, right: 20.0),
                child: new DropdownButton(
                  items: ['Petrol', 'Diesel', 'Unlead Blend'].map<DropdownMenuItem<String>>((String value) {
                    return DropdownMenuItem<String>(
                      value: value,
                      child: Text(value),
                    );
                  }).toList(),
                  onChanged: (value){
                    setState(() {
                      FuelTypeTo = value;
                    });
                  },
                  hint: Text(
                    FuelTypeTo ??'Select Desired fuel Type',
                    style: TextStyle(color: Color(0xff213E4A)),
                  ),
                )),
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

                  if(FuelTypeFrom == "" || FuelTypeFrom == null){
                    return MessageBox(context, "Select the type of fuel at hand.");
                  }else if(FuelTypeTo == "" || FuelTypeTo == null){
                    return MessageBox(context, "Select the type of fuel  you desire.");
                  }else if(quantity.text == "" || quantity.text == null){
                    return MessageBox(context, "Quantity cant be empty.");
                  }
                  swapConfirmation(context, quantity.text, FuelTypeFrom, FuelTypeTo, "username");
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

void swapConfirmation(BuildContext context,String quantity, String TypeFrom, String TypeTo, String name) {
  var alertDialog = AlertDialog(
    title: Text(
      'Fuel Swap Succesfull',
      style: TextStyle(
        fontWeight: FontWeight.bold,
        decoration: TextDecoration.underline,
      ),
    ),
    content: Text('Swapping $quantity Litres of $TypeFrom to $TypeTo'),
    actions: <Widget>[
      RaisedButton.icon(
        color: Colors.grey,
        icon: Icon(Icons.cancel, color: Colors.white,),
        onPressed: () {
          Navigator.pop(context);
        },
        label: Container(
          alignment: Alignment.bottomRight,
          child: Text('Cancel', style: TextStyle(color: Colors.white),),
        ),
      ),
      RaisedButton.icon(
        icon: Icon(Icons.check, color: Colors.white),
        onPressed: () {
          showLoading(context);
          int q = int.parse(quantity);
          Swap(context, q, TypeFrom, TypeTo, name);
        },
        color: Colors.green,
        label: Container(
          alignment: Alignment.bottomLeft,
          child: Text('Confirm',  style: TextStyle(color: Colors.white),),
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

void Swap(context, int quantity, String from, String to, String username){

  Dio dio = new Dio();
  dio.onHttpClientCreate = (HttpClient client) {
    client.badCertificateCallback = (X509Certificate cert, String host, int port) {
      return true;
    };
  };

  try {

    var form = new FormData();
    form.add('to', to);
    form.add('from', from);
    form.add('quantity', quantity);
    form.add('username', username);
    print(form);
    dio.post(config.baseUrl + "/MobileAppApi/SwapFuel", data: form).then((resp){
      print(resp.data['message']);
      if(resp.data["message"] == 'Successfully swapped fuel'){
        Navigator.pop(context);
        Navigator.pop(context);
        Navigator.pop(context);
        MessageBox(context, resp.data['message']);
      }
    });

  } on DioError catch(e){
    print(e.response.data);
    Navigator.pop(context);
    Navigator.pop(context);
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return  AlertDialog(

          title: Text("Error Message"),
          content: Text(e.response.data["message"]),
        );
      },
    );
  }

}