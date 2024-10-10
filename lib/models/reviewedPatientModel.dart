class ReviewedPatientsModel {
  int? doctorId;
  String? doctorName;
  String? departmentName;
  int? departmentId;
  int? tokenCount;
  double? amount;

  ReviewedPatientsModel({
    this.doctorId,
    this.doctorName,
    this.departmentName,
    this.departmentId,
    this.tokenCount,
    this.amount,
  });

  factory ReviewedPatientsModel.fromJson(Map<String, dynamic> json) =>
      ReviewedPatientsModel(
        doctorId: json["DoctorId"],
        doctorName: json["DoctorName"],
        departmentName: json["DepartmentName"],
        departmentId: json["DepartmentId"],
        tokenCount: json["TokenCount"],
        amount: json["Amount"],
      );

  Map<String, dynamic> toJson() => {
        "DoctorId": doctorId,
        "DoctorName": doctorName,
        "DepartmentName": departmentName,
        "DepartmentId": departmentId,
        "TokenCount": tokenCount,
        "Amount": amount,
      };
}
