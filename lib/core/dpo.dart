import 'package:flutter/material.dart';
import 'package:dpo_standard/models/responses/charge_response.dart';
import 'package:dpo_standard/view/dpo_style.dart';
import 'package:dpo_standard/view/payment_widget.dart';

class DPO {
  BuildContext context;
  bool isTestMode;
  String paymentUrl;
  DPOStyle? style;

  DPO({
    required this.context,
    required this.paymentUrl,
    required this.isTestMode,
    this.style,
  });

  /// Starts Standard Transaction
  Future<ChargeResponse> charge() async {
    return await Navigator.push(
      context,
      MaterialPageRoute(
        builder: (context) => PaymentWidget(
          requestUrl: paymentUrl,
          style: style ?? DPOStyle(),
          mainContext: context,
        ),
      ),
    );
  }
}
