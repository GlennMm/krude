class Coupon {
  int couponID;
  int accountID;
  int countryID;
  String countryName;
  String countryNameAbrev;
  int productID;
  String productName;
  String productMeasurement;
  String productDescription;
  String qrCode;
  int quantity;

  double price;
  int couponTypeID;

  Coupon(
    {
      this.couponID,
      this.accountID,
      this.countryID,
      this.countryName,
      this.countryNameAbrev,
      this.productID,
      this.productName,
      this.productMeasurement,
      this.productDescription,
      this.qrCode,
      this.quantity,
    // [this.price,  this.couponTypeID]
    });

  Coupon.fromJson(Map<String, dynamic> json) {
    couponID = json['couponID'];
    accountID = json['accountID'];
    countryID = json['countryID'];
    countryName = json['countryName'];
    countryNameAbrev = json['countryNameAbrev'];
    productID = json['productID'];
    productName = json['productName'];
    productMeasurement = json['productMeasurement'];
    productDescription = json['productDescription'];
    qrCode = json['qrCode'];
    quantity = json['quantity'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['couponID'] = this.couponID;
    data['accountID'] = this.accountID;
    data['countryID'] = this.countryID;
    data['countryName'] = this.countryName;
    data['countryNameAbrev'] = this.countryNameAbrev;
    data['productID'] = this.productID;
    data['productName'] = this.productName;
    data['productMeasurement'] = this.productMeasurement;
    data['productDescription'] = this.productDescription;
    data['qrCode'] = this.qrCode;
    data['quantity'] = this.quantity;
    return data;
  }
}