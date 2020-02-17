import 'package:flutter/material.dart';
import 'package:krude_digital/Views/subAccounts/subaccountDeatils.dart';
import 'package:krude_digital/models/SubAcccount.dart';

subAccountsList(context, List<SubAccount> account) {
  return Container(
    height: 150.0,
    margin: EdgeInsets.all(5.0),
    child: Padding(
      padding: const EdgeInsets.all(1.0),
      child: ListView(
        scrollDirection: Axis.horizontal,
        children: <Widget>[
          for (var i = 0; i < account.length; i++)
            Container(
              width: 170.0,
              child: FlatButton(
                onPressed: () {
                  Navigator.push(
                      context,
                      MaterialPageRoute(
                          builder: (context) => SubAccountDetails(account[i])));
                },
                padding: EdgeInsets.all(5.0),
                child: Card(
                  elevation: 10,
                  child: Container(
                    width: 200,
                    height: 140,
                    padding: EdgeInsets.all(20),
                    child: Column(
                      children: <Widget>[
                        Icon(
                          Icons.contact_mail,
                          color: Color(0xff355664),
                          size: 40,
                        ),
                        SizedBox(
                          height: 10,
                        ),
                        Text(
                          "${account[i].accountName}",
                          style: TextStyle(color: Color(0xff213E4A)),
                        ),
                        SizedBox(
                          height: 5,
                        ),
                        Text("${account[i].accountNo}",
                            style: TextStyle(color: Color(0xff213E4A)))
                      ],
                    ),
                  ),
                ),
              ),
            ),
        ],
      ),
    ),
  );
}
