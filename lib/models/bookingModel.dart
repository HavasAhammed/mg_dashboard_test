class BookingModel {
  int? doctorId;
  String? doctorName;
  String? departmentName;
  int? departmentId;
  int? tokenCount;
  int? datumNew;
  int? review;
  int? revisit;

  BookingModel({
    this.doctorId,
    this.doctorName,
    this.departmentName,
    this.departmentId,
    this.tokenCount,
    this.datumNew,
    this.review,
    this.revisit,
  });

  factory BookingModel.fromJson(Map<String, dynamic> json) => BookingModel(
        doctorId: json["DoctorId"],
        doctorName: json["DoctorName"],
        departmentName: json["DepartmentName"],
        departmentId: json["DepartmentId"],
        tokenCount: json["TokenCount"],
        datumNew: json["New"],
        review: json["Review"],
        revisit: json["Revisit"],
      );

  Map<String, dynamic> toJson() => {
        "DoctorId": doctorId,
        "DoctorName": doctorName,
        "DepartmentName": departmentName,
        "DepartmentId": departmentId,
        "TokenCount": tokenCount,
        "New": datumNew,
        "Review": review,
        "Revisit": revisit,
      };
}
