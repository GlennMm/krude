import 'package:krude_digital/models/Country.dart';
import 'package:krude_digital/models/SubAcccount.dart';
import 'package:krude_digital/models/Transaction.dart';

class Account {
  Null parent;
  List<SubAccount> subAccounts;
  List<Transaction> transactions;
  Country country;
  int accountID;
  Null parentID;
  String accountName;
  int createdBy;
  String createdDate;
  Null updatedBy;
  int statusID;
  Null updatedDate;
  String accountNo;
  int accountTypeID;
  int credit;
  int debit;
  int countryID;

  Account(
      {this.parent,
      this.subAccounts,
      this.transactions,
      this.country,
      this.accountID,
      this.parentID,
      this.accountName,
      this.createdBy,
      this.createdDate,
      this.updatedBy,
      this.statusID,
      this.updatedDate,
      this.accountNo,
      this.accountTypeID,
      this.credit,
      this.debit,
      this.countryID});

  Account.fromJson(Map<String, dynamic> json) {
    parent = json['parent'];
    if (json['subAccounts'] != null) {
      subAccounts = new List<Null>();
      json['subAccounts'].forEach((v) {
        subAccounts.add(new SubAccount.fromJson(v));
      });
    }
    if (json['transactions'] != null) {
      transactions = new List<Transaction>();
      json['transactions'].forEach((v) {
        transactions.add(new Transaction.fromJson(v));
      });
    }
    country =
        json['country'] != null ? new Country.fromJson(json['country']) : null;
    accountID = json['accountID'];
    parentID = json['parentID'];
    accountName = json['accountName'];
    createdBy = json['createdBy'];
    createdDate = json['createdDate'];
    updatedBy = json['updatedBy'];
    statusID = json['statusID'];
    updatedDate = json['updatedDate'];
    accountNo = json['accountNo'];
    accountTypeID = json['accountTypeID'];
    credit = json['credit'];
    debit = json['debit'];
    countryID = json['countryID'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['parent'] = this.parent;
    if (this.subAccounts != null) {
      data['subAccounts'] = this.subAccounts.map((v) => v.toJson()).toList();
    }
    if (this.transactions != null) {
      data['transactions'] = this.transactions.map((v) => v.toJson()).toList();
    }
    if (this.country != null) {
      data['country'] = this.country.toJson();
    }
    data['accountID'] = this.accountID;
    data['parentID'] = this.parentID;
    data['accountName'] = this.accountName;
    data['createdBy'] = this.createdBy;
    data['createdDate'] = this.createdDate;
    data['updatedBy'] = this.updatedBy;
    data['statusID'] = this.statusID;
    data['updatedDate'] = this.updatedDate;
    data['accountNo'] = this.accountNo;
    data['accountTypeID'] = this.accountTypeID;
    data['credit'] = this.credit;
    data['debit'] = this.debit;
    data['countryID'] = this.countryID;
    return data;
  }
}
