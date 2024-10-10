class BornCountModel {
  String? mrNo;
  int? ipNo;
  String? patName;
  String? gender;
  String? room;
  String? mobile;

  BornCountModel({
    this.mrNo,
    this.ipNo,
    this.patName,
    this.gender,
    this.room,
    this.mobile,
  });

  factory BornCountModel.fromJson(Map<String, dynamic> json) => BornCountModel(
        mrNo: json["MrNo"],
        ipNo: json["IpNo"],
        patName: json["PatName"],
        gender: json["Gender"],
        room: json["Room"],
        mobile: json["Mobile"],
      );

  Map<String, dynamic> toJson() => {
        "MrNo": mrNo,
        "IpNo": ipNo,
        "PatName": patName,
        "Gender": gender,
        "Room": room,
        "Mobile": mobile,
      };
}
