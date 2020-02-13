import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
// import 'package:qrcode_reader/qrcode_reader.dart';

enum ConfirmAction { CANCEL, ACCEPT }

Future<ConfirmAction> _CouponConfirmDialog(BuildContext context) async {
  return showDialog<ConfirmAction>(
      context: context,
      barrierDismissible: false,
      builder: (BuildContext context) {
        return AlertDialog(
          title: Text("Confirm Coupon"),
          content: const Text("Hello Man"),
          actions: <Widget>[
            FlatButton(
              child: const Text('Cancel'),
              onPressed: () {
                Navigator.of(context).pop(ConfirmAction.CANCEL);
              },
            ),
            FlatButton(
              child: const Text("Accept"),
              onPressed: () {
                Navigator.of(context).pop(ConfirmAction.ACCEPT);
              },
            )
          ],
        );
      });
}

Future<ConfirmAction> _AlertDialog(BuildContext context) async {
  return showDialog<ConfirmAction>(
      context: context,
      barrierDismissible: false,
      builder: (BuildContext context) {
        return AlertDialog(
          title: Text("Error"),
          content: const Text("You have not yet scaned the Qr Code."),
          actions: <Widget>[
            FlatButton(
              child: const Text('Cancel'),
              onPressed: () {
                Navigator.of(context).pop(ConfirmAction.CANCEL);
              },
            )
          ],
        );
      });
}

class MyApp extends StatefulWidget {
  @override
  _MyAppState createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  String _content;
  Future<String> _barcodeString;

  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: <Widget>[

            Center(
                child: new FutureBuilder<String>(
                    future: _barcodeString,
                    builder: (BuildContext context, AsyncSnapshot<String> snapshot) {
                      return new Text(snapshot.data != null ? snapshot.data : '');
                    })),




//            Card(
//                color: Colors.lightGreen[300],
//                child: Container(
//                  margin: EdgeInsets.all(20.0),
//                  child: Text(_content ?? "Scan a coupon"),
//                )),
//            Row(
//              children: <Widget>[
//                FlatButton(
//                  color: Colors.blue,
//                  onPressed: () {
//                    _scanQR();
//                  },
//                  child: Text(
//                    'Scan Coupon',
//                    style: TextStyle(color: Colors.white),
//                  ),
//                ),
//                FlatButton(
//                  color: Colors.deepOrangeAccent,
//                  onPressed: () {
//                    if (_content.isEmpty) {
//                      _AlertDialog(context);
//                    } else {
//                      var resp = GetCoupon(_content);
//                      if (resp != null) {
//                        _CouponConfirmDialog(context);
//                      }
//                    }
//                  },
//                  child: Text(
//                    'Proceed With Transaction',
//                    style: TextStyle(color: Colors.white),
//                  ),
//                ),
//              ],
//            )
          ],
        ),
      ),
        floatingActionButton: new FloatingActionButton(
          onPressed: () {
            setState(() {
              // _barcodeString = new QRCodeReader()
                  // .setAutoFocusIntervalInMs(200)
                  // .setForceAutoFocus(true)
                  // .setTorchEnabled(true)
                  // .setHandlePermissions(true)
                  // .setExecuteAfterPermissionGranted(true)
                  // .scan();
            });
          },
          tooltip: 'Reader the QRCode',
          child: new Icon(Icons.add_a_photo),
        )
    );
  }

  void _scanQR() async {
    // String result;

    setState(() async {
      try {
//        _content = await QrUtils.scanQR;
      } on PlatformException {
        _content = 'Process Failed!';
      }
    });
  }

  GetCoupon(String content) async {
   // http request

  }
}
