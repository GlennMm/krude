import 'package:flutter/material.dart';
import 'package:krude_digital/Views/components/appbar.dart';
import 'package:krude_digital/models/Coupon.dart';
import 'package:krude_digital/models/Product.dart';
import 'package:krude_digital/models/RequestModels/tranfers_to_subaccount.dart';
import 'package:krude_digital/models/SubAcccount.dart';
import 'package:krude_digital/repository/LoggedUser.dart';
import 'package:krude_digital/repository/ProductsRepository.dart';
import 'package:krude_digital/repository/TransactionsRepository.dart';
import 'package:states_rebuilder/states_rebuilder.dart';

class AddRetrctBalance extends StatefulWidget {

  SubAccount subaccount;

  AddRetrctBalance(this.subaccount){}

  @override
  _AddRetrctBalanceState createState() => _AddRetrctBalanceState(subaccount);
}

class _AddRetrctBalanceState extends State<AddRetrctBalance> {

  String action;
  Product type;
  String selected;
  TextEditingController amount = new TextEditingController();
  SubAccount subAccount;
  var productRepo = Injector.getAsReactive<ProductsRepository>();

  _AddRetrctBalanceState(this.subAccount){}

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: appBar(),
      body: ListView(
        padding: EdgeInsets.all(5),
        children: <Widget>[
          Center(
            child: Text(
              "Add or Retract Balance to/from ${subAccount.accountName}",
              style: TextStyle(
                  color: Color(0xff213E4A),
                  fontSize: 15,
                  fontWeight: FontWeight.bold),
            ),
          ),
          Divider(
            indent: 100,
            endIndent: 100,
            color: Color(0xff213E4A),
          ),
          Container(
            width: 40,
            height: 220,
            child: Card(
              margin: EdgeInsets.all(10),
              elevation: 5,
              child: ListView(
                padding: EdgeInsets.all(10),
                children: <Widget>[
                  Text(
                    "Fill the form",
                    style: TextStyle(color: Color(0xff213E4A), fontSize: 15),
                  ),
                  Container(
                    child: Row(
                      children: <Widget>[
                        SizedBox(width: 40,),
                        DropdownButton(
                          onChanged: (data){
                            setState(() {
                              action = data.toString();
                            });
                          },
                          hint: Text( action ?? "Action"),
                          items: ["Add", "Retract"].map((item) => DropdownMenuItem(child: Text(item),value: item,)).toList(),
                        ),
                        SizedBox(width: 80,),
                        DropdownButton(
                          onChanged: (data){
                            setState(() {
                              type = data;
                              selected = type.productName;
                            });
                          },
                          hint: Text(selected ?? "Fuel Type"),
                          items: productRepo.state.products.map((item) => DropdownMenuItem(child: Text(item.productName),value: item,)).toList(),
                        ),
                      ],
                    )
                  ),
                  Container(
                    child: TextField(
                      controller: amount,
                      decoration: InputDecoration(
                        labelText: 'Amount',
                        labelStyle: TextStyle(
                            fontWeight: FontWeight.bold, color: Colors.grey),
                        focusedBorder: UnderlineInputBorder(
                            borderSide: BorderSide(color: Colors.green)),
                        icon: Icon(Icons.ev_station),
                      ),
                    ),
                  ),
                  SizedBox(height: 10,),
                  RaisedButton(
                    color: Color(0xff213E4A),
                    onPressed: (){
                      var transaction = Injector.getAsReactive<TransactionsRepository>();
                      var user = Injector.getAsReactive<LoggedInUserRepository>();

                      print('tranfering ${amount.text} litres of ${selected} ${action} ${subAccount.accountName}');
                      TransaferRequestModel model = new TransaferRequestModel();
                      model.coupon = new Coupon();
                      model.coupon.accountID = subAccount.accountID;
                      model.coupon.countryID = subAccount.countryID;
                      model.coupon.countryName = subAccount.countryName;
                      model.coupon.productID = type.productID;
                      model.coupon.productMeasurement = type.measurement;
                      model.coupon.productName = type.productName;
                      model.coupon.quantity = int.parse(amount.text);
                      model.clients = [subAccount.accountID];
                      model.transactingUserID = user.state.loggedInUser.accountID;

                      var obj = {
                        "coupon": model.coupon.toJson(),
                        "clients": [model.clients],
                        'transactingUserID': model.transactingUserID
                      };

                      if(action == "Add"){
                        transaction.state.transferToAccounts(model);
                      }else if(action == "Retract"){
                        transaction.state.transaferFromAccounts(model);
                      }else{
                        print("action not found");
                      }
                      print("Done");
                    },
                    child: Text("Effect", style: TextStyle(color: Colors.white),),
                  )
                ],
              ),
            ),
          )
        ],
      ),
    );
  }
}
