import 'package:mg_dashboard/utils/extensions.dart';

class OpHdrModel {
  String? tDate;
  String? doctorName;
  int? opCount;
  double? amount;
  int? idDoctor;

  OpHdrModel(
      {this.tDate, this.doctorName, this.opCount, this.amount, this.idDoctor});

  OpHdrModel.fromJson(Map<String, dynamic> json) {
    tDate = json['tDate'];
    doctorName = json['doctorName'];
    opCount = json['opCount'];
    amount = json['amount'].toString().toDouble();
    idDoctor = json['idDoctor'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['tDate'] = tDate;
    data['doctorName'] = doctorName;
    data['opCount'] = opCount;
    data['amount'] = amount;
    data['idDoctor'] = idDoctor;
    return data;
  }
}
