class UserModel {
  String message;
  int accountTypeID;
  int accountID;
  String username;
  int countryId;
  String email;

  UserModel(
      {this.message,
      this.accountTypeID,
      this.accountID,
      this.username,
      this.countryId,
      this.email});

  UserModel.fromJson(Map<String, dynamic> json) {
    message = json['message'];
    accountTypeID = json['accountTypeID'];
    accountID = json['accountID'];
    username = json['username'];
    countryId = json['countryId'];
    email = json['email'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['message'] = this.message;
    data['accountTypeID'] = this.accountTypeID;
    data['accountID'] = this.accountID;
    data['username'] = this.username;
    data['countryId'] = this.countryId;
    data['email'] = this.email;
    return data;
  }
}
