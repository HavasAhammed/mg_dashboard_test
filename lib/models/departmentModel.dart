import 'package:mg_dashboard/utils/extensions.dart';

class DepartmentModel {
  int? departmentId;
  String? departmentName;
  List<DoctorModel>? doctorList;
  bool? isExpanded;

  DepartmentModel(
      {this.departmentId,
      this.departmentName,
      this.doctorList,
      this.isExpanded});

  DepartmentModel.fromJson(Map<String, dynamic> json) {
    departmentId = json['DepartmentId'];
    departmentName = json['DepartmentName'];
    isExpanded = false;
    if (json['Doctors'] != null) {
      doctorList = <DoctorModel>[];
      json['Doctors'].forEach((v) {
        doctorList!.add(DoctorModel.fromJson(v));
      });
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['DepartmentId'] = departmentId;
    data['DepartmentName'] = departmentName;
    if (doctorList != null) {
      data['Doctors'] = doctorList!.map((v) => v.toJson()).toList();
    }
    return data;
  }
}

class DoctorModel {
  int? id;
  String? doctorName;
  double? amount;
  double? phAmount;
  double? opAmount;
  double? labAmount;
  double? genAmount;
  int? phId;
  int? opId;
  int? labId;
  int? advanceId;

  DoctorModel(
      {this.id,
      this.doctorName,
      this.amount,
      this.phAmount,
      this.opAmount,
      this.labAmount,
      this.genAmount,
      this.phId,
      this.opId,
      this.labId,
      this.advanceId});

  DoctorModel.fromJson(Map<String, dynamic> json) {
    id = json['Id'];
    doctorName = json['DoctorName'];
    amount = json['Amount'].toString().toDouble();
    phAmount = json['PhAmount'].toString().toDouble();
    opAmount = json['OpAmount'].toString().toDouble();
    labAmount = json['LabAmount'].toString().toDouble();
    genAmount = json['GenAmount'].toString().toDouble();
    phId = json['PhId'];
    opId = json['OpId'];
    labId = json['LabId'];
    advanceId = json['AdvanceId'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['Id'] = id;
    data['DoctorName'] = doctorName;
    data['Amount'] = amount;
    data['PhAmount'] = phAmount;
    data['OpAmount'] = opAmount;
    data['LabAmount'] = labAmount;
    data['GenAmount'] = genAmount;
    data['PhId'] = phId;
    data['OpId'] = opId;
    data['LabId'] = labId;
    data['AdvanceId'] = advanceId;
    return data;
  }
}
