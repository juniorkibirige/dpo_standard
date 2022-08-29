import 'package:dpo_standard/core/transaction_status.dart';
import 'package:dpo_standard/models/responses/charge_response.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:dpo_standard/core/transaction_callback.dart';
import 'package:dpo_standard/core/navigation_controller.dart';
import 'package:dpo_standard/view/view_utils.dart';
import 'package:http/http.dart';

import 'dpo_style.dart';

class PaymentWidget extends StatefulWidget {
  final DPOStyle style;
  final String requestUrl;
  final BuildContext mainContext;

  PaymentWidget({
    required this.requestUrl,
    required this.style,
    required this.mainContext,
  });

  @override
  State<StatefulWidget> createState() => _PaymentState();
}

class _PaymentState extends State<PaymentWidget>
    implements TransactionCallBack {
  final _navigatorKey = GlobalKey<NavigatorState>();
  bool _isDisabled = false;
  late NavigationController controller;

  @override
  void initState() {
    _isDisabled = false;
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    controller = NavigationController(Client(), widget.style, this);
    return MaterialApp(
      navigatorKey: _navigatorKey,
      debugShowCheckedModeBanner: kDebugMode,
      home: Scaffold(
        backgroundColor: widget.style.getMainBackgroundColor(),
        appBar: FlutterwaveViewUtils.appBar(
          context,
          widget.style.getAppBarText(),
          widget.style.getAppBarTextStyle(),
          widget.style.getAppBarIcon(),
          widget.style.getAppBarColor(),
        ),
        body: SafeArea(
          child: Container(
            width: double.infinity,
            height: 50,
            margin: EdgeInsets.fromLTRB(20, 50, 20, 0),
            child: ElevatedButton(
              autofocus: true,
              onPressed: _handleButtonClicked,
              style: ElevatedButton.styleFrom(
                  backgroundColor: widget.style.getButtonColor(),
                  textStyle: widget.style.getButtonTextStyle()),
              child: Text(
                widget.style.getButtonText(),
                style: widget.style.getButtonTextStyle(),
              ),
            ),
          ),
        ),
      ),
    );
  }

  void _handleButtonClicked() {
    if (_isDisabled) return;
    _showConfirmDialog();
  }

  void _handlePayment() async {
    try {
      _toggleButtonActive(false);
      controller.startTransaction(widget.requestUrl);
      _toggleButtonActive(true);
    } catch (error) {
      _toggleButtonActive(true);
      _showErrorAndClose(error.toString());
    }
  }

  void _toggleButtonActive(final bool shouldEnable) {
    setState(() {
      _isDisabled = !shouldEnable;
    });
  }

  void _showErrorAndClose(final String errorMessage) {
    FlutterwaveViewUtils.showToast(widget.mainContext, errorMessage);
    Navigator.pop(widget.mainContext); // return response to user
  }

  void _showConfirmDialog() {
    _handlePayment();
  }

  @override
  onTransactionError() {
    _showErrorAndClose("transaction error");
  }

  @override
  onCancelled() {
    FlutterwaveViewUtils.showToast(widget.mainContext, "Transaction Cancelled");
    Navigator.pop(widget.mainContext);
  }

  @override
  onTransactionSuccess(
    String id, {
    String? cCDApproval,
    String? pnrID,
    String? transactionToken,
    String? companyRef,
  }) {
    final ChargeResponse chargeResponse = ChargeResponse(
      status: TransactionStatus.SUCCESSFUL,
      success: true,
      transactionId: id,
      cCDApproval: cCDApproval,
      pnrID: pnrID,
      transactionToken: transactionToken,
      companyRef: companyRef,
    );
    Navigator.pop(widget.mainContext, chargeResponse);
  }
}
