import 'dart:async';

import 'package:dpo_standard/models/responses/charge_response.dart';
import 'package:flutter/material.dart';
import 'package:dpo_standard/dpo.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'DPO Standard Demo',
      home: MyHomePage('DPO Standard'),
    );
  }
}

class MyHomePage extends StatefulWidget {
  MyHomePage(this.title);

  final String title;

  @override
  _MyHomePageState createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  final formKey = GlobalKey<FormState>();
  final urlController = TextEditingController();

  final url =
      "https://secure.3gdirectpay.com/payv3.php?ID=E7045C50-E58C-492E-BB08-2A765C97F913";

  @override
  Widget build(BuildContext context) {
    this.urlController.text = this.url;

    return Scaffold(
      appBar: AppBar(
        title: Text(widget.title),
      ),
      body: Container(
        width: double.infinity,
        margin: EdgeInsets.fromLTRB(20, 10, 20, 10),
        child: Form(
          key: this.formKey,
          child: ListView(
            children: <Widget>[
              Container(
                margin: EdgeInsets.fromLTRB(0, 20, 0, 10),
                child: TextFormField(
                  controller: this.urlController,
                  textInputAction: TextInputAction.next,
                  keyboardType: TextInputType.text,
                  style: TextStyle(color: Colors.black),
                  decoration: InputDecoration(hintText: "DPO URL"),
                  validator: (value) =>
                      value.isNotEmpty ? null : "DPO Url is required",
                ),
              ),
              Container(
                width: double.infinity,
                height: 50,
                margin: EdgeInsets.fromLTRB(0, 20, 0, 10),
                child: ElevatedButton(
                  onPressed: this._onPressed,
                  style: ButtonStyle(
                    foregroundColor: MaterialStateColor.resolveWith(
                      (states) => Colors.blue,
                    ),
                  ),
                  child: Text(
                    "Make Payment",
                    style: TextStyle(color: Colors.white),
                  ),
                ),
              )
            ],
          ),
        ),
      ), // This trailing comma makes auto-formatting nicer for build methods.
    );
  }

  _onPressed() {
    if (this.formKey.currentState.validate()) {
      this._handlePaymentInitialization();
    }
  }

  _handlePaymentInitialization() async {
    final style = DPOStyle(
      appBarText: "My Standard Blue",
      buttonColor: Color(0xffd0ebff),
      buttonTextStyle: TextStyle(
        color: Colors.deepOrangeAccent,
        fontSize: 16,
      ),
      appBarColor: Color(0xff8fa33b),
      dialogCancelTextStyle: TextStyle(
        color: Colors.brown,
        fontSize: 18,
      ),
      dialogContinueTextStyle: TextStyle(
        color: Colors.purpleAccent,
        fontSize: 18,
      ),
      mainBackgroundColor: Colors.indigo,
      mainTextStyle:
          TextStyle(color: Colors.indigo, fontSize: 19, letterSpacing: 2),
      dialogBackgroundColor: Colors.greenAccent,
      appBarIcon: Icon(Icons.message, color: Colors.purple),
      buttonText: "Proceed",
      appBarTitleTextStyle: TextStyle(
        color: Colors.purpleAccent,
        fontSize: 18,
      ),
    );

    final DPO flutterwave = DPO(
      context: context,
      style: style,
      isTestMode: false,
      paymentUrl: this.urlController.text,
    );

    final ChargeResponse response = await flutterwave.charge();
    if (response != null) {
      this.showLoading(response.status);
      print("${response.toJson()}");
    } else {
      print("${response.toJson()}");
      this.showLoading("No Response!");
      Timer(const Duration(seconds: 5), () {
        Navigator.of(this.context).pop();
      });
    }
  }

  Future<void> showLoading(String message) {
    return showDialog(
      context: this.context,
      barrierDismissible: false,
      builder: (BuildContext context) {
        return AlertDialog(
          content: Container(
            margin: EdgeInsets.fromLTRB(30, 20, 30, 20),
            width: double.infinity,
            height: 50,
            child: Text(message),
          ),
        );
      },
    );
  }
}
