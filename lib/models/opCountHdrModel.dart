class OpCountHdrModel {
  String? tDate;
  String? doctorName;
  int? opCount;
  double? amount;
  int? idDoctor;

  OpCountHdrModel({
    this.tDate,
    this.doctorName,
    this.opCount,
    this.amount,
    this.idDoctor,
  });

  factory OpCountHdrModel.fromJson(Map<String, dynamic> json) =>
      OpCountHdrModel(
        tDate: json['tDate'] as String?,
        doctorName: json['doctorName'] as String?,
        opCount: json['opCount'] as int?,
        amount: json['amount'] as double?,
        idDoctor: json['idDoctor'] as int?,
      );

  Map<String, dynamic> toJson() => {
        'tDate': tDate,
        'doctorName': doctorName,
        'opCount': opCount,
        'amount': amount,
        'idDoctor': idDoctor,
      };
}
