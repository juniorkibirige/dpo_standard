abstract class TransactionCallBack {
  onTransactionSuccess(
    String id, {
    String? cCDApproval,
    String? pnrID,
    String? transactionToken,
    String? companyRef,
  });
  onTransactionError();
  onCancelled();
}
