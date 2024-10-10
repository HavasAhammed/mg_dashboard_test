class PaidPatientModel {
  int? tokenCount;
  double? amount;
  int? doctorId;
  String? doctorName;
  String? departmentName;
  int? departmentId;

  PaidPatientModel({
    this.tokenCount,
    this.amount,
    this.doctorId,
    this.doctorName,
    this.departmentName,
    this.departmentId,
  });

  factory PaidPatientModel.fromJson(Map<String, dynamic> json) => PaidPatientModel(
        tokenCount: json['TokenCount'] as int?,
        amount: json['Amount'] as double?,
        doctorId: json['DoctorId'] as int?,
        doctorName: json['DoctorName'] as String?,
        departmentName: json['DepartmentName'] as String?,
        departmentId: json['DepartmentId'] as int?,
      );

  Map<String, dynamic> toJson() => {
        'TokenCount': tokenCount,
        'Amount': amount,
        'DoctorId': doctorId,
        'DoctorName': doctorName,
        'DepartmentName': departmentName,
        'DepartmentId': departmentId,
      };
}
