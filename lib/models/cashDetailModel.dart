import 'package:mg_dashboard/utils/extensions.dart';

class CashDetailModel {
  String? tDate;
  String? counter;
  int? tno;
  String? mrno;
  String? patName;
  double? amount;
  bool? isExpanded;

  CashDetailModel(
      {this.tDate,
      this.counter,
      this.tno,
      this.mrno,
      this.patName,
      this.amount,
      this.isExpanded});

  CashDetailModel.fromJson(Map<String, dynamic> json) {
    tDate = json['tDate'];
    counter = json['counter'];
    tno = json.containsKey("tno")
        ? json['tno']
        : json.containsKey('tNo')
            ? json['tNo']
            : 0;
    mrno = json['mrno'];
    patName = json['patName'];
    amount = json['amount'].toString().toDouble();
    isExpanded = false;
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['tDate'] = tDate;
    data['counter'] = counter;
    data['tno'] = tno;
    data['mrno'] = mrno;
    data['patName'] = patName;
    data['amount'] = amount;
    return data;
  }
}
