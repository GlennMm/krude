class Transaction {
  String referenceNo;
  String transactionDate;
  String tansactionType;
  int quantity;
  String productName;
  String relativeAccount;

  Transaction(
      {this.referenceNo,
      this.transactionDate,
      this.tansactionType,
      this.quantity,
      this.productName,
      this.relativeAccount});

  Transaction.fromJson(Map<String, dynamic> json) {
    referenceNo = json['referenceNo'];
    transactionDate = json['transactionDate'];
    tansactionType = json['tansactionType'];
    quantity = json['quantity'];
    productName = json['productName'];
    relativeAccount = json['relativeAccount'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['referenceNo'] = this.referenceNo;
    data['transactionDate'] = this.transactionDate;
    data['tansactionType'] = this.tansactionType;
    data['quantity'] = this.quantity;
    data['productName'] = this.productName;
    data['relativeAccount'] = this.relativeAccount;
    return data;
  }
}