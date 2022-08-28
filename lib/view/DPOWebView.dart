import 'package:dpo_standard/core/transaction_status.dart';
import 'package:flutter_inappwebview/flutter_inappwebview.dart';
import 'package:dpo_standard/core/TransactionCallBack.dart';

class DPOInAppBrowser extends InAppBrowser {
  final TransactionCallBack callBack;

  var hasCompletedProcessing = false;
  var haveCallBacksBeenCalled = false;

  DPOInAppBrowser({required this.callBack});

  @override
  Future onBrowserCreated() async {}

  @override
  Future onLoadStart(url) async {
    final id = url?.queryParameters["TransID"];
    final ccd = url?.queryParameters["CCDapproval"];
    final pnr = url?.queryParameters["PnrID"];
    final transToken = url?.queryParameters["TransactionToken"];
    final compRef = url?.queryParameters["CompanyRef"];
    final hasRedirected = url?.host != "secure.3gdirectpay.com";
    if (hasRedirected && url != null) {
      hasCompletedProcessing = hasRedirected;
      if (url.host.contains("asanty.africa"))
        _processResponse(
          url,
          TransactionStatus.SUCCESSFUL,
          id,
          ccd,
          pnr,
          transToken,
          compRef,
        );
      else {
        _processResponse(
          url,
          TransactionStatus.CANCELLED,
          id,
          ccd,
          pnr,
          transToken,
          compRef,
        );
      }
    }
  }

  _processResponse(
    Uri url,
    String? status,
    String? id,
    String? ccd,
    String? pnr,
    String? transToken,
    String? compRef,
  ) {
    if ("successful" == status) {
      callBack.onTransactionSuccess(
        id!,
        cCDApproval: ccd,
        pnrID: pnr,
        transactionToken: transToken,
        companyRef: compRef,
      );
    } else {
      callBack.onCancelled();
    }
    haveCallBacksBeenCalled = true;
    close();
  }

  @override
  Future onLoadStop(url) async {}

  @override
  void onLoadError(url, code, message) {
    callBack.onTransactionError();
  }

  @override
  void onProgressChanged(progress) {}

  @override
  void onExit() {
    if (!haveCallBacksBeenCalled) {
      callBack.onCancelled();
    }
  }
}
