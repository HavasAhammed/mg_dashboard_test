// To parse this JSON data, do
//
//     final incomeHdrModel = incomeHdrModelFromJson(jsonString);

import 'dart:convert';

IncomeHdrModel incomeHdrModelFromJson(String str) =>
    IncomeHdrModel.fromJson(json.decode(str));

String incomeHdrModelToJson(IncomeHdrModel data) => json.encode(data.toJson());

class IncomeHdrModel {
  int? idAccount;
  String? accountName;
  double? totalIncome;

  IncomeHdrModel({
    this.idAccount,
    this.accountName,
    this.totalIncome,
  });

  factory IncomeHdrModel.fromJson(Map<String, dynamic> json) => IncomeHdrModel(
        idAccount: json["id_account"],
        accountName: json["account_name"],
        totalIncome: double.parse(json["totalIncome"].toString()),
      );

  Map<String, dynamic> toJson() => {
        "id_account": idAccount,
        "account_name": accountName,
        "totalIncome": totalIncome,
      };
}
