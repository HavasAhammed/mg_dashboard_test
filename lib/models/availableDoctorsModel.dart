

class AvailableDoctorsModel {
    int? staffId;
    String? department;
    int? departmentId;
    int? id;
    String? name;
    DateTime? date;

    AvailableDoctorsModel({
        this.staffId,
        this.department,
        this.departmentId,
        this.id,
        this.name,
        this.date,
    });

    factory AvailableDoctorsModel.fromJson(Map<String, dynamic> json) => AvailableDoctorsModel(
        staffId: json["StaffId"],
        department: json["Department"],
        departmentId: json["DepartmentId"],
        id: json["Id"],
        name: json["Name"],
        date: json["Date"] == null ? null : DateTime.parse(json["Date"]),
    );

    Map<String, dynamic> toJson() => {
        "StaffId": staffId,
        "Department": department,
        "DepartmentId": departmentId,
        "Id": id,
        "Name": name,
        "Date": date?.toIso8601String(),
    };
}
