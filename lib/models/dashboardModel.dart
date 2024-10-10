import 'dart:convert';

DashboardModel dashboardModelFromMap(String str) =>
    DashboardModel.fromJson(json.decode(str));

String dashboardModelToMap(DashboardModel data) => json.encode(data.toJson());

class DashboardModel {
  double? totalIncome;
  int? totalOp;
  int? todayIp;
  int? totalIp;
  double? totalLabAmt;
  double? totalPharmacyAmt;
  double? totalOpAmt;
  double? totalUpiAmt;
  double? totalCardAmt;
  double? totalCredit;
  double? totalCash;
  int? roomCount;
  int? bornCount;
  double? expiryAmount;
  double? purchaseAmount;
  double? opAmount;
  double? labAmount;
  double? phAmount;
  double? advanceAmount;
  int? opId;
  int? labId;
  int? phId;
  int? advanceId;
  int? doctorCount;
  int? totalPatients;
  int? totalPaidPatients;
  int? totalReviewedPatients;
  int? todayLeaveDoctors;
  int? todayPresentDoctors;

  DashboardModel(
      {this.totalIncome,
      this.totalOp,
      this.todayIp,
      this.totalIp,
      this.totalLabAmt,
      this.totalPharmacyAmt,
      this.totalOpAmt,
      this.totalUpiAmt,
      this.totalCardAmt,
      this.totalCredit,
      this.totalCash,
      this.roomCount,
      this.bornCount,
      this.expiryAmount,
      this.purchaseAmount,
      this.opAmount,
      this.labAmount,
      this.phAmount,
      this.advanceAmount,
      this.opId,
      this.labId,
      this.phId,
      this.advanceId,
      this.doctorCount,
      this.todayLeaveDoctors,
      this.todayPresentDoctors,
      this.totalPaidPatients,
      this.totalReviewedPatients,
      this.totalPatients});

  DashboardModel.fromJson(Map<String, dynamic> json) {
    totalIncome = json['totalIncome'];
    totalOp = json['totalOp'];
    todayIp = json['todayIp'];
    totalIp = json['totalIp'];
    totalLabAmt = json['totalLabAmt'];
    totalPharmacyAmt = json['totalPharmacyAmt'];
    totalOpAmt = json['totalOpAmt'];
    totalUpiAmt = json['totalUpiAmt'];
    totalCardAmt = json['totalCardAmt'];
    totalCredit = json['totalCredit'];
    totalCash = json['totalCash'];
    roomCount = json['RoomCount'];
    bornCount = json['bornCount'];
    expiryAmount = double.parse((json['expiryAmount'] ?? 0).toString());
    purchaseAmount = double.parse((json['purchaseAmount'] ?? 0).toString());
    labAmount = double.parse((json['labAmount'] ?? 0).toString());
    phAmount = double.parse((json['phAmount'] ?? 0).toString());
    advanceAmount = double.parse((json['advanceAmount'] ?? 0).toString());
    opId = json['opId'];
    labId = json['labId'];
    phId = json['phId'];
    advanceId = json['advanceId'];
    doctorCount = json['doctorCount'];
    totalPaidPatients = json['totalPaidPatients'];
    totalReviewedPatients = json['totalReviewedPatients'];
    todayLeaveDoctors = json['todayLeaveDoctors'];
    todayPresentDoctors = json['todayPresentDoctors'];
    totalPatients = json['totalPatients'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['totalIncome'] = this.totalIncome;
    data['totalOp'] = this.totalOp;
    data['todayIp'] = this.todayIp;
    data['totalIp'] = this.totalIp;
    data['totalLabAmt'] = this.totalLabAmt;
    data['totalPharmacyAmt'] = this.totalPharmacyAmt;
    data['totalOpAmt'] = this.totalOpAmt;
    data['totalUpiAmt'] = this.totalUpiAmt;
    data['totalCardAmt'] = this.totalCardAmt;
    data['totalCredit'] = this.totalCredit;
    data['totalCash'] = this.totalCash;
    data['RoomCount'] = this.roomCount;
    data['bornCount'] = this.bornCount;
    data['expiryAmount'] = this.expiryAmount;
    data['purchaseAmount'] = this.purchaseAmount;
    data['opAmount'] = this.opAmount;
    data['labAmount'] = this.labAmount;
    data['phAmount'] = this.phAmount;
    data['advanceAmount'] = this.advanceAmount;
    data['opId'] = this.opId;
    data['labId'] = this.labId;
    data['phId'] = this.phId;
    data['advanceId'] = this.advanceId;
    data['doctorCount'] = this.doctorCount;
    data['totalPaidPatients'] = this.totalPaidPatients;
    data['totalReviewedPatients'] = this.totalReviewedPatients;
    data['todayLeaveDoctors'] = this.todayLeaveDoctors;
    data['todayPresentDoctors'] = this.todayPresentDoctors;
    data['totalPatients'] = this.totalPatients;
    return data;
  }
}
