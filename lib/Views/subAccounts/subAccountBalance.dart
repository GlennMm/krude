import 'package:flutter/material.dart';

class SubAccountBalance extends StatelessWidget {

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.white,
      ),
      body: Container(
        child: Column(
          children: <Widget>[
            for (int i = 0; i < 3; i++)
              ListTile(
                leading: Icon(Icons.person_outline),
                title: Text("Sub Account"),
                onTap: () {
                  Navigator.pushNamed(
                    context, '/home/SubAccountBalances/Detail');
                },
              )
          ],
        ),
      ),
    );
  }
}
