class Country {
  int countryID;
  String countryName;
  String isoCode;
  String countryNameAbrev;
  bool isActive;

  Country(
      {this.countryID,
      this.countryName,
      this.isoCode,
      this.countryNameAbrev,
      this.isActive});

  Country.fromJson(Map<String, dynamic> json) {
    countryID = json['countryID'];
    countryName = json['countryName'];
    isoCode = json['isoCode'];
    countryNameAbrev = json['countryNameAbrev'];
    isActive = json['isActive'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['countryID'] = this.countryID;
    data['countryName'] = this.countryName;
    data['isoCode'] = this.isoCode;
    data['countryNameAbrev'] = this.countryNameAbrev;
    data['isActive'] = this.isActive;
    return data;
  }
}
