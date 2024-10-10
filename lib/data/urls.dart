class Urls {
  static dynamic getHeaders() {
    var ss = {
      'Content-Type': 'application/json',
      // 'Authorization': 'Bearer ' + HiveDb.getAuthToken(),
    };

    return ss;
  }

  static dynamic getBaseUrl() {
    // return HiveDb.getUrl() + "apis/api/";
    return 'https://app.gotoken.in/dashboard/api/';
  }

  static String getDashboardData = "${getBaseUrl()}dashboard/getDashBoardData";
  static String getTotalIncomeData =
      "${getBaseUrl()}dashboard/getTotalIncomeData";
  static String getTotalIncomeByDepartment =
      "${getBaseUrl()}dashboard/getTotalIncomeByDepartmant";
  static String getDoctorAppointments =
      "${getBaseUrl()}dashboard/income/department/details";
  static String getTotalCashHdr = "${getBaseUrl()}dashboard/getTotalCash";
  static String getTotalCashDtl =
      "${getBaseUrl()}dashboard/getTotalCashDetails";
  static String getTotalUpi = "${getBaseUrl()}dashboard/getTotalUpi";
  static String getTotalUpiDetails =
      "${getBaseUrl()}dashboard/getTotalUpiDetails";
  static String getTotalCard = "${getBaseUrl()}dashboard/getTotalCard";
  static String getTotalCardDetails =
      "${getBaseUrl()}dashboard/getTotalCardDetails";
  static String getTotalCredit = "${getBaseUrl()}dashboard/getTotalCredit";
  static String getTotalCreditDetails =
      "${getBaseUrl()}dashboard/getTotalCreditDetails";
  static String getTotalOp = "${getBaseUrl()}dashboard/getTotalOp";
  static String getTotalIncomeDetails =
      "${getBaseUrl()}dashboard/getTotalIncomeDetails";
  static String getTotalOpCount = "${getBaseUrl()}dashboard/getTotalOp";
  static String getTotalOpCountDetails =
      "${getBaseUrl()}dashboard/getTotalOpDetails";
  static String getPaidPatients= "${getBaseUrl()}dashboard/doctors/paid";
  static String getReviewedPatients= "${getBaseUrl()}dashboard/doctors/reviewed";
  static String getPharmacyPurchase= "${getBaseUrl()}dashboard/purchase";
  static String getExpiryMedicine= "${getBaseUrl()}dashboard/ExpiryList";
  static String getBornCount= "${getBaseUrl()}dashboard/GetBorn";
  static String getRoomList= "${getBaseUrl()}dashboard/RoomList";
  static String getDoctorList= "${getBaseUrl()}dashboard/DoctorList";
  static String getBooking= "${getBaseUrl()}dashboard/doctors";
  static String getCurrentIp= "${getBaseUrl()}dashboard/getTotalIP";
  static String getIpCount= "${getBaseUrl()}dashboard/getAllIP";
  static String getLeaveDoctors= "${getBaseUrl()}dashboard/doctors/leave";
  static String getAvailableDoctors= "${getBaseUrl()}dashboard/doctors/present";
  static String getAmount= "${getBaseUrl()}dashboard/getTotalIncomeDetails";


}
