import 'package:flutter/material.dart';


class ProductDistribution extends StatefulWidget {
  ProductDistribution({Key key}) : super(key: key);

  _ProductDistributionState createState() => _ProductDistributionState();
}

class _ProductDistributionState extends State<ProductDistribution> {
  Map<String, bool> values = {
    'True': true,
    'False': false,
  };

  var dropdownValue, dropdownValue1;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
//      drawer: mDrawer(),
      appBar: AppBar(
        title: Text('Product Distribution', style: TextStyle(fontSize: 25.0),),
        actions: <Widget>[
          FlatButton.icon(
            onPressed: () {},
            icon: Icon(Icons.account_balance_wallet),
            label: Text("Wallet"),
          ),
        ],
      ),
      body: Container(
          padding: EdgeInsets.all(10.0),
          child: ListView(children: <Widget>[
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: <Widget>[
                DropdownButton<String>(
                  value: dropdownValue1,
                  onChanged: (String newValue) {
                    setState(() {
                      dropdownValue1 = newValue;
                    });
                  },
                  items: <String>['Zimbabwe', 'SA', 'Zambia', 'Namibia']
                      .map<DropdownMenuItem<String>>((String value) {
                    return DropdownMenuItem<String>(
                      value: value,
                      child: Text(value),
                    );
                  }).toList(),
                ),

                DropdownButton<String>(
                  value: dropdownValue,
                  onChanged: (String newValue) {
                    setState(() {
                      dropdownValue = newValue;
                    });
                  },
                  items: <String>['Diesel', 'Petrol', 'Unlead Blend']
                      .map<DropdownMenuItem<String>>((String value) {
                    return DropdownMenuItem<String>(
                      value: value,
                      child: Text(value),
                    );
                  }).toList(),
                ),

                // ListItem(),
                Container(
                    padding: EdgeInsets.only(left: 30, right: 30),
                    child: Column(
                      children: <Widget>[
                        TextField(
                          keyboardType: TextInputType.number,
                          decoration: InputDecoration(
                            icon: Icon(Icons.local_gas_station),
                            labelText: "Quantity",
                          ),
                        ),
                        SizedBox(
                          height: 20.0,
                        ),
                        MaterialButton(
                          onPressed: () {
                            _showDialog();
                          },
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: <Widget>[Text("Apply")],
                          ),
                          color: Colors.grey,
                          height: 40,
                        )
                      ],
                    )),
              ],
            ),
          ])),
    );
  }

void _showDialog() {
    // flutter defined function
    showDialog(
      context: context,
      builder: (BuildContext context) {
        // return object of type Dialog
        return AlertDialog(
          title: new Text("Transaction Summary"),
          content: new Text("Successfully transafered fuel."),
          actions: <Widget>[
            // usually buttons at the bottom of the dialog
            new FlatButton(
              child: new Text("Close"),
              onPressed: () {
                Navigator.of(context).pop();
              },
            ),
          ],
        );
      },
    );
  }

}

