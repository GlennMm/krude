import 'package:flutter/material.dart';


class NavDrawer extends StatefulWidget {
  NavDrawer({Key key}) : super(key: key);

  _NavDrawerState createState() => _NavDrawerState();
}

class _NavDrawerState extends State<NavDrawer> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Krude Digital'),
        backgroundColor: Colors.greenAccent,
      ),
      drawer: Drawer(
        child: ListView(
          children: <Widget>[
          DrawerHeader(
            decoration: BoxDecoration(

            ),
            child: Text('Krude Digital'),
          
          ),
          ListTile(
            title: Text('Purchases'),
          ),
            ListTile(
            title: Text('Transfers'),
          ),
            ListTile(
            title: Text('Digital Coupons'),
          ),
          ],
        ),
      ),
    );
  }
}