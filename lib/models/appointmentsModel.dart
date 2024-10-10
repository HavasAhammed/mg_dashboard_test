import 'package:mg_dashboard/utils/extensions.dart';

class AppointmentsModel {
  String? tDate;
  String? tNo;
  int? idDoctor;
  String? doctorName;
  String? mrNo;
  String? patName;
  String? serviceName;
  double? amount;
  bool? isExpanded;

  AppointmentsModel(
      {this.tDate,
      this.tNo,
      this.idDoctor,
      this.doctorName,
      this.mrNo,
      this.patName,
      this.serviceName,
      this.amount,
      this.isExpanded});

  AppointmentsModel.fromJson(Map<String, dynamic> json) {
    tDate = json['TDate'];
    tNo = json['TNo'];
    idDoctor = json['IdDoctor'];
    doctorName = json['DoctorName'];
    mrNo = json['MrNo'];
    patName = json['PatName'];
    serviceName = json['ServiceName'];
    amount = json['Amount'].toString().toDouble();
    isExpanded = false;
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['TDate'] = tDate;
    data['TNo'] = tNo;
    data['IdDoctor'] = idDoctor;
    data['DoctorName'] = doctorName;
    data['MrNo'] = mrNo;
    data['PatName'] = patName;
    data['ServiceName'] = serviceName;
    data['Amount'] = amount;
    return data;
  }
}
