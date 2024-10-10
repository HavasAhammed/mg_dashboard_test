class DoctorsListModel {
  String? doctorCode;
  String? doctorName;
  String? department;
  String? designation;
  String? qualification;

  DoctorsListModel({
    this.doctorCode,
    this.doctorName,
    this.department,
    this.designation,
    this.qualification,
  });

  factory DoctorsListModel.fromJson(Map<String, dynamic> json) =>
      DoctorsListModel(
        doctorCode: json["DoctorCode"],
        doctorName: json["DoctorName"],
        department: json["Department"],
        designation: json["Designation"],
        qualification: json["Qualification"],
      );

  Map<String, dynamic> toJson() => {
        "DoctorCode": doctorCode,
        "DoctorName": doctorName,
        "Department": department,
        "Designation": designation,
        "Qualification": qualification,
      };
}
