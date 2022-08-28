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
    status = json['status'] == null ? TransactionStatus.ERROR : json['status'];
    success = json['success'] == null ? false : json['success'];
    transactionId = json['TransID'];
    cCDApproval = json['CCDapproval'];
    pnrID = json['PnrID'];
    transactionToken = json['TransactionToken'];
    companyRef = json['CompanyRef'];
  }

  /// Converts this instance to json
  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['status'] = this.status;
    data['success'] = this.success;
    data['TransID'] = this.transactionId;
    data['CCDapproval'] = this.cCDApproval;
    data['PnrID'] = this.pnrID;
    data['TransactionToken'] = this.transactionToken;
    data['CompanyRef'] = this.companyRef;
    return data;
  }
}
