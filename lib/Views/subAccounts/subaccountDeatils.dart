import 'package:flutter/material.dart';
import 'package:krude_digital/Views/components/appbar.dart';
import 'package:krude_digital/repository/LoggedUser.dart';
import 'package:states_rebuilder/states_rebuilder.dart';

class SubAccountDetails extends StatefulWidget {
  SubAccountDetails({Key key}) : super(key: key);

  @override
  _SubAccountDetailsState createState() => _SubAccountDetailsState();
}

class _SubAccountDetailsState extends State<SubAccountDetails> {
  var user = Injector.getAsReactive<LoggedInUserRepository>();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: appBar(),
      drawer: drawer(context, user),
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
                    "Sub Account Name",
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
                          "Parent Account :             Total",
                          style: TextStyle(
                            color: Color(0xff355664),
                          ),
                        ),
                        Text(
                          "Station Name :                Total Seven Mile Station",
                          style: TextStyle(
                            color: Color(0xff355664),
                          ),
                        ),
                        Text(
                          "Account Number :           000 000 001",
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
      floatingActionButton: FlatButton.icon(
          onPressed: () {},
          icon: Icon(
            Icons.add,
            color: Color(0xff355664),
          ),
          label: Text(
            "Add",
            style: TextStyle(
              color: Color(0xff355664),
            ),
          )),
    );
  }
}
