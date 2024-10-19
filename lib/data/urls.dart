import 'package:hive/hive.dart';

class Urls {
  static final box = Hive.box('settingsBox');

  static dynamic getHeaders() {
    var ss = {
      'Content-Type': 'application/json',
      // 'Authorization': 'Bearer ' + HiveDb.getAuthToken(),
    };

    return ss;
  }

  static dynamic getBaseUrl() {
    // return 'https://app.gotoken.in/dashboard';
    // return 'https://app.gotoken.in/dashboardhnckpba';
    return box.get('baseUrl', defaultValue: 'https://app.gotoken.in/dashboard');
  }


static String getHospitalDetails = "${getBaseUrl()}/api/dashboard/hospital/details";
  static String getDashboardData =
      "${getBaseUrl()}/api/dashboard/getDashBoardData";
  static String getTotalIncomeData =
      "${getBaseUrl()}/api/dashboard/getTotalIncomeData";
  static String getTotalIncomeByDepartment =
      "${getBaseUrl()}/api/dashboard/getTotalIncomeByDepartmant";
  static String getDoctorAppointments =
      "${getBaseUrl()}/api/dashboard/income/department/details";
  static String getTotalCashHdr = "${getBaseUrl()}/api/dashboard/getTotalCash";
  static String getTotalCashDtl =
      "${getBaseUrl()}/api/dashboard/getTotalCashDetails";
  static String getTotalUpi = "${getBaseUrl()}/api/dashboard/getTotalUpi";
  static String getTotalUpiDetails =
      "${getBaseUrl()}/api/dashboard/getTotalUpiDetails";
  static String getTotalCard = "${getBaseUrl()}/api/dashboard/getTotalCard";
  static String getTotalCardDetails =
      "${getBaseUrl()}/api/dashboard/getTotalCardDetails";
  static String getTotalCredit = "${getBaseUrl()}/api/dashboard/getTotalCredit";
  static String getTotalCreditDetails =
      "${getBaseUrl()}/api/dashboard/getTotalCreditDetails";
  static String getTotalOp = "${getBaseUrl()}/api/dashboard/getTotalOp";
  static String getTotalIncomeDetails =
      "${getBaseUrl()}/api/dashboard/getTotalIncomeDetails";
  static String getTotalOpCount = "${getBaseUrl()}/api/dashboard/getTotalOp";
  static String getTotalOpCountDetails =
      "${getBaseUrl()}/api/dashboard/getTotalOpDetails";
  static String getPaidPatients = "${getBaseUrl()}/api/dashboard/doctors/paid";
  static String getReviewedPatients =
      "${getBaseUrl()}/api/dashboard/doctors/reviewed";
  static String getPharmacyPurchase = "${getBaseUrl()}/api/dashboard/purchase";
  static String getExpiryMedicine = "${getBaseUrl()}/api/dashboard/ExpiryList";
  static String getBornCount = "${getBaseUrl()}/api/dashboard/GetBorn";
  static String getRoomList = "${getBaseUrl()}/api/dashboard/RoomList";
  static String getDoctorList = "${getBaseUrl()}/api/dashboard/DoctorList";
  static String getBooking = "${getBaseUrl()}/api/dashboard/doctors";
  static String getCurrentIp = "${getBaseUrl()}/api/dashboard/getTotalIP";
  static String getIpCount = "${getBaseUrl()}/api/dashboard/getAllIP";
  static String getLeaveDoctors = "${getBaseUrl()}/api/dashboard/doctors/leave";
  static String getAvailableDoctors =
      "${getBaseUrl()}/api/dashboard/doctors/present";
  static String getAmount =
      "${getBaseUrl()}/api/dashboard/getTotalIncomeDetails";
}
