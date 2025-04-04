import 'package:dpo_standard/core/transaction_status.dart';

class ChargeResponse {
  String? status;
  bool? success;
  String? transactionId;
  String? cCDApproval;
  String? pnrID;
  String? transactionToken;
  String? companyRef;

  ChargeResponse({
    this.status,
    this.success,
    this.transactionId,
    this.cCDApproval,
    this.pnrID,
    this.transactionToken,
    this.companyRef,
  });

  ChargeResponse.fromJson(Map<String, dynamic> json) {
    status = json['status'] ?? TransactionStatus.ERROR;
    success = json['success'] ?? false;
    transactionId = json['TransID'];
    cCDApproval = json['CCDapproval'];
    pnrID = json['PnrID'];
    transactionToken = json['TransactionToken'];
    companyRef = json['CompanyRef'];
  }

  /// Converts this instance to json
  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['status'] = status;
    data['success'] = success;
    data['TransID'] = transactionId;
    data['CCDapproval'] = cCDApproval;
    data['PnrID'] = pnrID;
    data['TransactionToken'] = transactionToken;
    data['CompanyRef'] = companyRef;
    return data;
  }
}
