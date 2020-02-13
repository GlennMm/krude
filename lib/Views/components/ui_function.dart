import 'package:flutter/material.dart';
import 'package:krude_digital/models/ProductPrice.dart';

Widget productPricesTable(Map<dynamic, List<ProductPrice>> productsPrices) {
  return Table(
    border: TableBorder.all(
        width: .5, color: Color(0xffD5CBC9), style: BorderStyle.solid),
    children: [
      TableRow(children: [
        Container(
          color: Color(0xff355664),
          child: Padding(
            padding:
                EdgeInsets.only(top: 5.0, bottom: 5.0, left: 10.0, right: 10.0),
            child: Text("Country",
                style: TextStyle(
                    fontSize: 10,
                    fontWeight: FontWeight.bold,
                    color: Colors.white70)),
          ),
        ),
        Container(
          color: Color(0xff355664),
          child: Padding(
            padding:
                EdgeInsets.only(top: 5.0, bottom: 5.0, left: 10.0, right: 10.0),
            child: Text("Petrol",
                style: TextStyle(
                    fontSize: 10,
                    fontWeight: FontWeight.bold,
                    color: Colors.white70)),
          ),
        ),
        Container(
          color: Color(0xff355664),
          child: Padding(
            padding:
                EdgeInsets.only(top: 5.0, bottom: 5.0, left: 10.0, right: 10.0),
            child: Text("Diesel",
                style: TextStyle(
                    fontSize: 10,
                    fontWeight: FontWeight.bold,
                    color: Colors.white70)),
          ),
        ),
        Container(
          color: Color(0xff355664),
          child: Padding(
            padding:
                EdgeInsets.only(top: 5.0, bottom: 5.0, left: 10.0, right: 10.0),
            child: Text("Blend",
                style: TextStyle(
                    fontSize: 10,
                    fontWeight: FontWeight.bold,
                    color: Colors.white70)),
          ),
        ),
      ]),
      for (var key in productsPrices.keys)
        TableRow(children: [
          Container(
            color: Colors.black38,
            child: Padding(
              padding: EdgeInsets.only(
                  top: 5.0, bottom: 5.0, left: 10.0, right: 10.0),
              child: Text(key,
                  style: TextStyle(fontSize: 10, color: Colors.white)),
            ),
          ),
          Container(
            color: Colors.black38,
            child: Padding(
              padding: EdgeInsets.only(
                  top: 5.0, bottom: 5.0, left: 10.0, right: 10.0),
              child: Text(productsPrices[key][0].price.toStringAsFixed(2),
                  style: TextStyle(fontSize: 10, color: Colors.white)),
            ),
          ),
          Container(
            color: Colors.black38,
            child: Padding(
              padding: EdgeInsets.only(
                  top: 5.0, bottom: 5.0, left: 10.0, right: 10.0),
              child: Text(productsPrices[key][1].price.toStringAsFixed(2),
                  style: TextStyle(fontSize: 10, color: Colors.white)),
            ),
          ),
          Container(
            color: Colors.black38,
            child: Padding(
              padding: EdgeInsets.only(
                  top: 5.0, bottom: 5.0, left: 10.0, right: 10.0),
              child: Text(productsPrices[key][2].price.toStringAsFixed(2),
                  style: TextStyle(fontSize: 10, color: Colors.white)),
            ),
          ),
        ]),
    ],
  );
}