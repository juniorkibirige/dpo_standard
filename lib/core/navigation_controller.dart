import 'package:flutter_inappwebview/flutter_inappwebview.dart';
import 'package:dpo_standard/core/transaction_callback.dart';
import 'package:dpo_standard/view/dpo_webview.dart';
import 'package:dpo_standard/view/dpo_style.dart';
import 'package:http/http.dart';

class NavigationController {
  Client client;
  final DPOStyle? style;
  final TransactionCallBack _callBack;

  NavigationController(this.client, this.style, this._callBack);

  /// Initiates initial transaction to get web url
  startTransaction(final String paymentURL) async {
    try {
      openBrowser(paymentURL);
    } catch (error) {
      rethrow;
    }
  }

  /// Opens browser with URL returned from startTransaction()
  openBrowser(final String url, [final bool isTestMode = false]) async {
    final DPOInAppBrowser browser = DPOInAppBrowser(callBack: _callBack);

    var options = InAppBrowserClassOptions(
      crossPlatform: InAppBrowserOptions(hideUrlBar: true),
      inAppWebViewGroupOptions: InAppWebViewGroupOptions(
        crossPlatform: InAppWebViewOptions(javaScriptEnabled: true),
      ),
    );

    await browser.openUrlRequest(urlRequest: URLRequest(url: Uri.parse(url)), options: options);
  }
}
