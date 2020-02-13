import 'package:flutter/material.dart';

// this is a multi-purpose dialog e.g Showing message to user

dialog(BuildContext context, String message) {
  return showDialog(
      context: context,
      builder: (context) {
        return Dialog(
          child: Container(
              height: 50,
              width: 100,
              child: Padding(
                padding:
                    EdgeInsets.only(top: 10, bottom: 10, left: 20, right: 20),
                child: Text(message),
              )),
        );
      });
}

loggingIn(BuildContext context) {
  return showDialog(
    context: context,
    builder: (BuildContext context) {
      return AlertDialog(
        content: Row(
          children: <Widget>[
            CircularProgressIndicator(),
            SizedBox(
              width: 30,
            ),
            Text("Logging in...")
          ],
        ),
      );
    },
  );
}

loading(BuildContext context) {
  return showDialog(
    context: context,
    builder: (BuildContext context) {
      return AlertDialog(
        content: Row(
          children: <Widget>[
            CircularProgressIndicator(),
            SizedBox(
              width: 30,
            ),
            Text("Loading...")
          ],
        ),
      );
    },
  );
}

criticalError() {
  return Container(
    child: Column(
      children: <Widget>[
        SizedBox(
          height: 30,
        ),
        Icon(
          Icons.warning,
          color: Colors.red,
          size: 150,
        ),
        Text(
          "Something bad happened. Restart the application",
          style: TextStyle(color: Colors.red, fontSize: 16),
        ),
        SizedBox(
          height: 30,
        ),
      ],
    ),
  );
}
