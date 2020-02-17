class SubAccount {
  int line;
  String accountName;
  String accountNo;
  int accountID;
  int accountTypeID;
  String countryName;
  int countryID;
  String createdDate;
  double credit;
  double debit;
  int parentID;
  int statusID;
  String updatedDate;
  // String beneficiary;

  SubAccount(
      {this.line,
      this.accountName,
      this.accountNo,
      this.accountID,
      this.accountTypeID,
      this.countryName,
      this.countryID,
      this.createdDate,
      this.credit,
      this.debit,
      this.parentID,
      this.statusID,
      this.updatedDate,
      // this.beneficiary
      });

  SubAccount.fromJson(Map<String, dynamic> json) {
    line = json['line'];
    accountName = json['accountName'];
    accountNo = json['accountNo'];
    accountID = json['accountID'];
    accountTypeID = json['accountTypeID'];
    countryName = json['countryName'];
    countryID = json['countryID'];
    createdDate = json['createdDate'];
    credit = json['credit'];
    debit = json['debit'];
    parentID = json['parentID'];
    statusID = json['statusID'];
    updatedDate = json['updatedDate'];
    // beneficiary = json['beneficiary'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['line'] = this.line;
    data['accountName'] = this.accountName;
    data['accountNo'] = this.accountNo;
    data['accountID'] = this.accountID;
    data['accountTypeID'] = this.accountTypeID;
    data['countryName'] = this.countryName;
    data['countryID'] = this.countryID;
    data['createdDate'] = this.createdDate;
    data['credit'] = this.credit;
    data['debit'] = this.debit;
    data['parentID'] = this.parentID;
    data['statusID'] = this.statusID;
    data['updatedDate'] = this.updatedDate;
    // data['beneficiary'] = this.beneficiary;
    return data;
  }
}