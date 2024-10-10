class OpAmountModel {
  DateTime? tDate;
  int? tNo;
  String? doctorName;
  String? mrno;
  String? patName;
  String? serviceName;
  double? amount;

  OpAmountModel({
    this.tDate,
    this.tNo,
    this.doctorName,
    this.mrno,
    this.patName,
    this.serviceName,
    this.amount,
  });

  factory OpAmountModel.fromJson(Map<String, dynamic> json) => OpAmountModel(
        tDate: json["tDate"] == null ? null : DateTime.parse(json["tDate"]),
        tNo: json["tNo"],
        doctorName: json["doctorName"],
        mrno: json["mrno"],
        patName: json["patName"],
        serviceName: json["serviceName"],
        amount: json["amount"],
      );

  Map<String, dynamic> toJson() => {
        "tDate": tDate?.toIso8601String(),
        "tNo": tNo,
        "doctorName": doctorName,
        "mrno": mrno,
        "patName": patName,
        "serviceName": serviceName,
        "amount": amount,
      };
}
