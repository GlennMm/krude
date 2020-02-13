import 'package:flutter/material.dart';

Widget appBar() {
  return AppBar(
    title: Text('Krude Digital'),
    backgroundColor: Color(0xff213E4A),
  );
}

Widget drawer(BuildContext context, user) {
  return Drawer(
    child: ListView(
      children: <Widget>[
        UserAccountsDrawerHeader(
          decoration: BoxDecoration(
            color: Color(0xff213E4A),
          ),
          accountName:
              Text('${user.state.loggedInUser.username.toUpperCase()}'),
          accountEmail: Text('${user.state.loggedInUser.email.toLowerCase()}'),
          currentAccountPicture: CircleAvatar(
            backgroundColor: Colors.white,
          ),
        ),
        ListTile(
          leading: Icon(Icons.account_balance_wallet, color: Color(0xff355664)),
          title: Text(
            'Wallet',
            style: TextStyle(
                fontWeight: FontWeight.bold, color: Color(0xff355664)),
          ),
          onTap: () {
            Navigator.pushNamed(context, '/wallet');
          },
        ),
        ExpansionTile(
          leading: Icon(Icons.shop, color: Color(0xff355664)),
          title: Text(
            "Purchases",
            style: TextStyle(
                fontWeight: FontWeight.bold, color: Color(0xff355664)),
          ),
          children: <Widget>[
            Container(
                alignment: Alignment.bottomLeft,
                color: Colors.transparent,
                padding: EdgeInsets.only(left: 50.0, bottom: 10.0),
                child: ListTile(
                  onTap: () {
                    Navigator.pushNamed(context, '/purchaseLocally');
                  },
                  leading: Icon(Icons.location_on, color: Color(0xff355664)),
                  title: Text(
                    'Purchase Locally',
                    style: TextStyle(
                        fontWeight: FontWeight.bold, color: Color(0xff355664)),
                  ),
                )),
            Container(
                alignment: Alignment.bottomLeft,
                color: Colors.transparent,
                padding: EdgeInsets.only(left: 50.0, bottom: 10.0),
                child: ListTile(
                  onTap: () {
                    Navigator.pushNamed(
                        context, '/purchaseRegionally');
                  },
                  leading: Icon(
                    Icons.location_searching,
                    color: Color(0xff355664),
                  ),
                  title: Text(
                    'Purchase Regionally',
                    style: TextStyle(
                        fontWeight: FontWeight.bold, color: Color(0xff355664)),
                  ),
                )),
          ],
        ),
        ExpansionTile(
          leading:
              Icon(Icons.transfer_within_a_station, color: Color(0xff355664)),
          title: Text(
            "Transfers",
            style: TextStyle(
                fontWeight: FontWeight.bold, color: Color(0xff355664)),
          ),
          children: <Widget>[
            Container(
                alignment: Alignment.bottomLeft,
                color: Colors.transparent,
                padding: EdgeInsets.only(left: 50.0, bottom: 10.0),
                child: ListTile(
                  onTap: () {
                    Navigator.pushNamed(context, '/transferFuel');
                  },
                  leading: Icon(Icons.transfer_within_a_station,
                      color: Color(0xff355664)),
                  title: Text(
                    'Transfer Fuel',
                    style: TextStyle(
                        fontWeight: FontWeight.bold, color: Color(0xff355664)),
                  ),
                )),
            Container(
                alignment: Alignment.bottomLeft,
                color: Colors.transparent,
                padding: EdgeInsets.only(left: 50.0, bottom: 10.0),
                child: ListTile(
                  onTap: () {
                    Navigator.pushNamed(context, '/swapfuel');
                  },
                  leading: Icon(Icons.swap_horizontal_circle,
                      color: Color(0xff355664)),
                  title: Text(
                    'Swap Locally',
                    style: TextStyle(
                        fontWeight: FontWeight.bold, color: Color(0xff355664)),
                  ),
                )),
            Container(
                alignment: Alignment.bottomLeft,
                color: Colors.transparent,
                padding: EdgeInsets.only(left: 50.0, bottom: 10.0),
                child: ListTile(
                  onTap: () {
                    Navigator.pushNamed(
                        context, '/swapinternational');
                  },
                  leading: Icon(Icons.swap_horizontal_circle,
                      color: Color(0xff355664)),
                  title: Text(
                    'Swap Regionally',
                    style: TextStyle(
                        fontWeight: FontWeight.bold, color: Color(0xff355664)),
                  ),
                )),
          ],
        ),
        ExpansionTile(
          leading: Icon(Icons.table_chart, color: Color(0xff355664)),
          title: Text(
            "Digital Coupons",
            style: TextStyle(
                fontWeight: FontWeight.bold, color: Color(0xff355664)),
          ),
          children: <Widget>[
            Container(
                alignment: Alignment.bottomLeft,
                color: Colors.transparent,
                padding: EdgeInsets.only(left: 50.0, bottom: 10.0),
                child: ListTile(
                  onTap: () {
                    Navigator.pushNamed(context, '/redeemfuel');
                  },
                  leading: Icon(Icons.redeem, color: Color(0xff355664)),
                  title: Text(
                    'Redeem Fuel',
                    style: TextStyle(
                        fontWeight: FontWeight.bold, color: Color(0xff355664)),
                  ),
                )),
            Container(
                alignment: Alignment.bottomLeft,
                color: Colors.transparent,
                padding: EdgeInsets.only(left: 50.0, bottom: 10.0),
                child: ListTile(
                  onTap: () {
                    Navigator.pushNamed(context, '/wallet');
                  },
                  leading: Icon(Icons.filter_list, color: Color(0xff355664)),
                  title: Text(
                    'Load to Cart',
                    style: TextStyle(
                        fontWeight: FontWeight.bold, color: Color(0xff355664)),
                  ),
                )),
            Container(
                alignment: Alignment.bottomLeft,
                color: Colors.transparent,
                padding: EdgeInsets.only(left: 50.0, bottom: 10.0),
                child: ListTile(
                  onTap: () {
                    Navigator.pushNamed(context, '/Views/MyWallet');
                  },
                  leading: Icon(
                    Icons.print,
                    color: Color(0xff355664),
                  ),
                  title: Text(
                    'Print',
                    style: TextStyle(
                        fontWeight: FontWeight.bold, color: Color(0xff355664)),
                  ),
                )),
          ],
        ),
        ListTile(
          leading: Icon(Icons.access_alarm, color: Color(0xff355664)),
          title: Text(
            'About Krude Digital',
            style: TextStyle(
                fontWeight: FontWeight.bold, color: Color(0xff355664)),
          ),
        ),
        ListTile(
          leading: Icon(Icons.info, color: Color(0xff355664)),
          title: Text(
            'Help and feedback',
            style: TextStyle(
                fontWeight: FontWeight.bold, color: Color(0xff355664)),
          ),
        ),
        ListTile(
          leading: Icon(Icons.settings, color: Color(0xff355664)),
          title: Text(
            'Setting and Configurations',
            style: TextStyle(
                fontWeight: FontWeight.bold, color: Color(0xff355664)),
          ),
        ),
      ],
    ),
  );
}
