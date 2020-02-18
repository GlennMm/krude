import 'package:flutter/material.dart';
import 'package:krude_digital/Views/components/appbar.dart';
import 'package:krude_digital/Views/subAccounts/add-retrect-balance.dart';
import 'package:krude_digital/repository/ClientProductRepository.dart';
import 'package:krude_digital/repository/LoggedUser.dart';
import 'package:states_rebuilder/states_rebuilder.dart';
import 'package:krude_digital/models/SubAcccount.dart';
import 'package:intl/intl.dart';

class SubAccountDetails extends StatefulWidget {
  SubAccount subAccount;
  SubAccountDetails(this.subAccount, {Key key}) : super(key: key);

  @override
  _SubAccountDetailsState createState() => _SubAccountDetailsState(subAccount);
}

class _SubAccountDetailsState extends State<SubAccountDetails> {

  SubAccount subAccount;

  var user = Injector.getAsReactive<LoggedInUserRepository>();
  var clientProduct = Injector.getAsReactive<ClientProductRepository>();

  _SubAccountDetailsState(this.subAccount){
    clientProduct.setState((model) => {
      model.getSubAccountBalance()
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: appBar(),
      // drawer: drawer(context, user),
      body: Column(
        children: <Widget>[
          Container(
            padding: EdgeInsets.symmetric(vertical: 5),
            child: Center(
              child: Text(
                "Sub Account Details",
                style: TextStyle(
                    color: Color(0xff213E4A),
                    fontSize: 15,
                    fontWeight: FontWeight.bold),
              ),
            ),
          ),
          Container(
            margin: EdgeInsets.all(5.0),
            child: Card(
              child: Column(
                children: <Widget>[
                  Center(
                      child: Text(
                    "${subAccount.accountName}",
                    style: TextStyle(
                      fontSize: 20,
                      color: Color(0xff355664),
                    ),
                  )),
                  Divider(
                    endIndent: 100,
                    indent: 100,
                    color: Color(0xff355664),
                  ),
                  Container(
                    padding: EdgeInsets.all(15.0),
                    alignment: Alignment.centerLeft,
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: <Widget>[
                        Text(
                          "Station Name :                 ${subAccount.accountName}",
                          style: TextStyle(
                            color: Color(0xff355664),
                          ),
                        ),
                        Text(
                          "Account Number :           ${subAccount.accountID}",
                          style: TextStyle(
                            color: Color(0xff355664),
                          ),
                        ),
                        Text(
                          "Country:                            ${subAccount.countryName}",
                          style: TextStyle(
                            color: Color(0xff355664),
                          ),
                        ),
                        Text(
                          "Created:                            ${new DateFormat('yyyy-MM-dd').parse(subAccount.createdDate).day}-${new DateFormat('yyyy-MM-dd').parse(subAccount.createdDate).month}-${new DateFormat('yyyy-MM-dd').parse(subAccount.createdDate).year}",
                          style: TextStyle(
                            color: Color(0xff355664),
                          ),
                        ),
                      ],
                    ),
                  )
                ],
              ),
            ),
          ),
          Container(
            margin: EdgeInsets.all(5.0),
            child: Card(
              child: Table(
                children: [
                  TableRow(children: [
                    TableCell(
                      child: Container(
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
                    ),
                    TableCell(
                      child: Container(
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
                    ),
                    TableCell(
                      child: Container(
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
                    ),
                    TableCell(
                      child: Container(
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
                    ),
                  ]),
                  TableRow(
                    children: [
                      TableCell(
                        child: Container(
                          child: Padding(
                            padding: EdgeInsets.only(
                                top: 5.0, bottom: 5.0, left: 10.0, right: 10.0),
                            child: Text("value",
                                style: TextStyle(
                                    fontSize: 10,
                                    fontWeight: FontWeight.bold,
                                    color: Colors.white70)),
                          ),
                        ),
                      ),
                      TableCell(
                        child: Container(
                          child: Padding(
                            padding: EdgeInsets.only(
                                top: 5.0, bottom: 5.0, left: 10.0, right: 10.0),
                            child: Text("value",
                                style: TextStyle(
                                    fontSize: 10,
                                    fontWeight: FontWeight.bold,
                                    color: Colors.white70)),
                          ),
                        ),
                      ),
                      TableCell(
                        child: Container(
                          child: Padding(
                            padding: EdgeInsets.only(
                                top: 5.0, bottom: 5.0, left: 10.0, right: 10.0),
                            child: Text("value",
                                style: TextStyle(
                                    fontSize: 10,
                                    fontWeight: FontWeight.bold,
                                    color: Colors.white70)),
                          ),
                        ),
                      ),
                      TableCell(
                        child: Container(
                          child: Padding(
                            padding: EdgeInsets.only(
                                top: 5.0, bottom: 5.0, left: 10.0, right: 10.0),
                            child: Text("value",
                                style: TextStyle(
                                    fontSize: 10,
                                    fontWeight: FontWeight.bold,
                                    color: Colors.white70)),
                          ),
                        ),
                      ),

                    ]
                  )
                ],
              ),
            ),
          )
        ],
      ),
      floatingActionButton: Row(
        mainAxisAlignment: MainAxisAlignment.end,
        children: <Widget>[
        FlatButton.icon(
          onPressed: () {
             Navigator.push(context,
             MaterialPageRoute(builder: (context) => AddRetrctBalance(subAccount)));
          },
          icon: Icon(
            Icons.add,
            color: Color(0xff355664),
          ),
          label: Text(
            "Add/Retract",
            style: TextStyle(
              color: Color(0xff355664),
            ),
          ))
        ],
      ),
    );
  }
}
