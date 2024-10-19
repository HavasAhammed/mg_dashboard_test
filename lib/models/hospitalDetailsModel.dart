class HospitalDetailsModel {
  int? hospitalId;
  String? name;
  String? address;
  String? city;
  String? street;
  String? state;
  String? country;
  String? pin;
  String? website;

  HospitalDetailsModel({
    this.hospitalId,
    this.name,
    this.address,
    this.city,
    this.street,
    this.state,
    this.country,
    this.pin,
    this.website,
  });

  factory HospitalDetailsModel.fromJson(Map<String, dynamic> json) =>
      HospitalDetailsModel(
        hospitalId: json["HospitalId"],
        name: json["Name"],
        address: json["Address"],
        city: json["City"],
        street: json["Street"],
        state: json["State"],
        country: json["Country"],
        pin: json["Pin"],
        website: json["Website"],
      );

  Map<String, dynamic> toJson() => {
        "HospitalId": hospitalId,
        "Name": name,
        "Address": address,
        "City": city,
        "Street": street,
        "State": state,
        "Country": country,
        "Pin": pin,
        "Website": website,
      };
}
