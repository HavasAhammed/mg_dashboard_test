import 'package:mg_dashboard/utils/extensions.dart';

class CashHdrModel {
  int? idAccount;
  String? account;
  double? amount;

  CashHdrModel({this.idAccount, this.account, this.amount});

  CashHdrModel.fromJson(Map<String, dynamic> json) {
    idAccount = json['idAccount'] is String
        ? int.parse(json['idAccount'])
        : json['idAccount'];
    account = json['account'];
    amount = json['amount'].toString().toDouble();
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['idAccount'] = idAccount;
    data['account'] = account;
    data['amount'] = amount;
    return data;
  }
}
