class LeaveDoctorsModel {
  int? id;
  String? name;
  DateTime? date;

  LeaveDoctorsModel({
    this.id,
    this.name,
    this.date,
  });

  factory LeaveDoctorsModel.fromJson(Map<String, dynamic> json) =>
      LeaveDoctorsModel(
        id: json["Id"],
        name: json["Name"],
        date: json["Date"] == null ? null : DateTime.parse(json["Date"]),
      );

  Map<String, dynamic> toJson() => {
        "Id": id,
        "Name": name,
        "Date": date?.toIso8601String(),
      };
}
