// ignore_for_file: use_build_context_synchronously, no_wildcard_variable_uses

import 'package:flutter/material.dart';
import 'package:mg_dashboard/Data/responseModel.dart';
import 'package:mg_dashboard/Data/urls.dart';
import 'package:mg_dashboard/data/api.dart';
import 'package:mg_dashboard/models/DashboardModel.dart';
import 'package:mg_dashboard/models/appointmentsModel.dart';
import 'package:mg_dashboard/models/availableDoctorsModel.dart';
import 'package:mg_dashboard/models/bookingModel.dart';
import 'package:mg_dashboard/models/bornCountModel.dart';
import 'package:mg_dashboard/models/cashDetailModel.dart';
import 'package:mg_dashboard/models/cashHdrModel.dart';
import 'package:mg_dashboard/models/currentIpModel.dart';
import 'package:mg_dashboard/models/departmentModel.dart';
import 'package:mg_dashboard/models/doctorsListModel.dart';
import 'package:mg_dashboard/models/expiryMedicineModel.dart';
import 'package:mg_dashboard/models/hospitalDetailsModel.dart';
import 'package:mg_dashboard/models/ipCountModel.dart';
import 'package:mg_dashboard/models/leaveDoctorsModel.dart';
import 'package:mg_dashboard/models/opAmountModel.dart';
import 'package:mg_dashboard/models/opCountDtlModel.dart';
import 'package:mg_dashboard/models/opCountHdrModel.dart';
import 'package:mg_dashboard/models/paidPatiantModel.dart';
import 'package:mg_dashboard/models/pharmacyPurchaseModel.dart';
import 'package:mg_dashboard/models/reviewedPatientModel.dart';
import 'package:mg_dashboard/models/roomListModel.dart';
import 'package:mg_dashboard/ui/widgets/Toast.dart';
import 'package:mg_dashboard/utils/extensions.dart';

class DashboardRepo {
  static Future<(bool isError, HospitalDetailsModel)> getHospitalDetails(
      BuildContext context) async {
    ResponseModel response = await getApiData(Urls.getHospitalDetails);

    HospitalDetailsModel hospitalDetails = HospitalDetailsModel();

    try {
      if (response.isError) {
        Toast.show(response.errorMessage ?? "", context, duration: 3);
        return (true, hospitalDetails);
      } else {
        hospitalDetails =
            HospitalDetailsModel.fromJson(response.responseObject['data']);
        return (false, hospitalDetails);
      }
    } catch (_) {
      Toast.show(_.toString(), context, duration: 3);
      return (true, hospitalDetails);
    }
  }

  static Future<(bool isError, DashboardModel)> getDashboardData(
      String json, BuildContext context) async {
    ResponseModel response = await postApiData(Urls.getDashboardData, json);
    DashboardModel dashboardModel = DashboardModel();
    try {
      if (response.isError) {
        Toast.show(response.errorMessage ?? "", context, duration: 3);
        return (true, dashboardModel);
      } else {
        dashboardModel =
            DashboardModel.fromJson(response.responseObject['data'][0]);
        return (false, dashboardModel);
      }
    } catch (_) {
      Toast.show(_.toString(), context, duration: 3);
      return (true, dashboardModel);
    }
  }

  static Future<(bool isError, List<DepartmentModel> list)>
      getTotalIncomeByDepartmant(String json, BuildContext context) async {
    ResponseModel response =
        await postApiData(Urls.getTotalIncomeByDepartment, json);
    List<DepartmentModel> list = [];
    try {
      if (response.isError) {
        Toast.show(response.errorMessage ?? "", context, duration: 3);
        return (true, list);
      } else {
        list = List<DepartmentModel>.from(response.responseObject['data']
            .map((x) => DepartmentModel.fromJson(x)));
        return (false, list);
      }
    } catch (_) {
      Toast.show(_.toString(), context, duration: 3);
      return (true, list);
    }
  }

  static Future<(bool isError, List<AppointmentsModel> list)>
      getDoctorAppointments(String json, BuildContext context) async {
    ResponseModel response =
        await postApiData(Urls.getDoctorAppointments, json);
    List<AppointmentsModel> list = [];
    try {
      if (response.isError) {
        Toast.show(response.errorMessage ?? "", context, duration: 3);
        return (true, list);
      } else {
        list = List<AppointmentsModel>.from(response.responseObject['data']
            .map((x) => AppointmentsModel.fromJson(x)));
        return (false, list);
      }
    } catch (_) {
      Toast.show(_.toString(), context, duration: 3);
      return (true, list);
    }
  }

  static Future<(bool isError, List<CashHdrModel> list)> getTotalCashHdr(
      String json, BuildContext context) async {
    ResponseModel response = await postApiData(Urls.getTotalCashHdr, json);
    List<CashHdrModel> list = [];
    try {
      if (response.isError) {
        Toast.show(response.errorMessage ?? "", context, duration: 3);
        return (true, list);
      } else {
        list = List<CashHdrModel>.from(response.responseObject['data']
            .map((x) => CashHdrModel.fromJson(x)));
        return (false, list);
      }
    } catch (_) {
      Toast.show(_.toString(), context, duration: 3);
      return (true, list);
    }
  }

  static Future<(bool isError, List<CashDetailModel> list)> getTotalCashDtl(
      String json, String url, BuildContext context) async {
    ResponseModel response = await postApiData(url, json);
    List<CashDetailModel> list = [];
    try {
      if (response.isError) {
        context.showSnackBar(response.errorMessage ?? "");
        return (true, list);
      } else {
        list = List<CashDetailModel>.from(response.responseObject['data']
            .map((x) => CashDetailModel.fromJson(x)));
        return (false, list);
      }
    } catch (_) {
      Toast.show(_.toString(), context, duration: 3);
      return (true, list);
    }
  }

  static Future<(bool isError, List<CashHdrModel> list)> getTotalUpi(
      String json, BuildContext context) async {
    ResponseModel response = await postApiData(Urls.getTotalUpi, json);
    List<CashHdrModel> list = [];
    try {
      if (response.isError) {
        Toast.show(response.errorMessage ?? "", context, duration: 3);
        return (true, list);
      } else {
        list = List<CashHdrModel>.from(response.responseObject['data']
            .map((x) => CashHdrModel.fromJson(x)));
        return (false, list);
      }
    } catch (_) {
      Toast.show(_.toString(), context, duration: 3);
      return (true, list);
    }
  }

  static Future<(bool isError, List<CashHdrModel> list)> getTotalUpiDtl(
      String json, BuildContext context) async {
    ResponseModel response = await postApiData(Urls.getTotalUpi, json);
    List<CashHdrModel> list = [];
    try {
      if (response.isError) {
        Toast.show(response.errorMessage ?? "", context, duration: 3);
        return (true, list);
      } else {
        list = List<CashHdrModel>.from(response.responseObject['data']
            .map((x) => CashHdrModel.fromJson(x)));
        return (false, list);
      }
    } catch (_) {
      Toast.show(_.toString(), context, duration: 3);
      return (true, list);
    }
  }

  static Future<(bool isError, List<CashHdrModel> list)> getTotalCardHdr(
      String json, BuildContext context) async {
    ResponseModel response = await postApiData(Urls.getTotalCard, json);
    List<CashHdrModel> list = [];
    try {
      if (response.isError) {
        Toast.show(response.errorMessage ?? "", context, duration: 3);
        return (true, list);
      } else {
        list = List<CashHdrModel>.from(response.responseObject['data']
            .map((x) => CashHdrModel.fromJson(x)));
        return (false, list);
      }
    } catch (_) {
      Toast.show(_.toString(), context, duration: 3);
      return (true, list);
    }
  }

  static Future<(bool isError, List<CashHdrModel> list)> getTotalCreditHdr(
      String json, BuildContext context) async {
    ResponseModel response = await postApiData(Urls.getTotalCredit, json);
    List<CashHdrModel> list = [];
    try {
      if (response.isError) {
        Toast.show(response.errorMessage ?? "", context, duration: 3);
        return (true, list);
      } else {
        list = List<CashHdrModel>.from(response.responseObject['data']
            .map((x) => CashHdrModel.fromJson(x)));
        return (false, list);
      }
    } catch (_) {
      Toast.show(_.toString(), context, duration: 3);
      return (true, list);
    }
  }

  static Future<(bool isError, List<OpCountHdrModel> list)> getTotalOpCountHdr(
      String json, BuildContext context) async {
    ResponseModel response = await postApiData(Urls.getTotalOpCount, json);
    List<OpCountHdrModel> list = [];
    try {
      if (response.isError) {
        Toast.show(response.errorMessage ?? "", context, duration: 3);
        return (true, list);
      } else {
        list = List<OpCountHdrModel>.from(response.responseObject['data']
            .map((x) => OpCountHdrModel.fromJson(x)));
        return (false, list);
      }
    } catch (_) {
      Toast.show(_.toString(), context, duration: 3);
      return (true, list);
    }
  }

  static Future<(bool isError, List<OpCountDtlModel> list)>
      getTotalOpCountDetails(
          String json, String url, BuildContext context) async {
    ResponseModel response = await postApiData(url, json);
    List<OpCountDtlModel> list = [];
    try {
      if (response.isError) {
        context.showSnackBar(response.errorMessage ?? "");
        return (true, list);
      } else {
        list = List<OpCountDtlModel>.from(response.responseObject['data']
            .map((x) => OpCountDtlModel.fromJson(x)));
        return (false, list);
      }
    } catch (_) {
      Toast.show(_.toString(), context, duration: 3);
      return (true, list);
    }
  }

  static Future<(bool isError, List<PaidPatientModel> list)> getPaidPatients(
      String json, BuildContext context) async {
    ResponseModel response = await postApiData(Urls.getPaidPatients, json);
    List<PaidPatientModel> list = [];
    try {
      if (response.isError) {
        Toast.show(response.errorMessage ?? "", context, duration: 3);
        return (true, list);
      } else {
        list = List<PaidPatientModel>.from(response.responseObject['data']
            .map((x) => PaidPatientModel.fromJson(x)));
        return (false, list);
      }
    } catch (_) {
      Toast.show(_.toString(), context, duration: 3);
      return (true, list);
    }
  }

  static Future<(bool isError, List<ReviewedPatientsModel> list)>
      getReviewedPatients(String json, BuildContext context) async {
    ResponseModel response = await postApiData(Urls.getReviewedPatients, json);
    List<ReviewedPatientsModel> list = [];
    try {
      if (response.isError) {
        Toast.show(response.errorMessage ?? "", context, duration: 3);
        return (true, list);
      } else {
        list = List<ReviewedPatientsModel>.from(response.responseObject['data']
            .map((x) => ReviewedPatientsModel.fromJson(x)));
        return (false, list);
      }
    } catch (_) {
      Toast.show(_.toString(), context, duration: 3);
      return (true, list);
    }
  }

  static Future<(bool isError, List<PharmacyPurchaseModel> list)>
      getPharmacyPurchase(String json, BuildContext context) async {
    ResponseModel response = await postApiData(Urls.getPharmacyPurchase, json);
    List<PharmacyPurchaseModel> list = [];
    try {
      if (response.isError) {
        Toast.show(response.errorMessage ?? "", context, duration: 3);
        return (true, list);
      } else {
        list = List<PharmacyPurchaseModel>.from(response.responseObject['data']
            .map((x) => PharmacyPurchaseModel.fromJson(x)));
        return (false, list);
      }
    } catch (_) {
      Toast.show(_.toString(), context, duration: 3);
      return (true, list);
    }
  }

  static Future<(bool isError, List<ExpiryMedicineModel> list)>
      getExpiryMedicine(String json, BuildContext context) async {
    ResponseModel response = await postApiData(Urls.getExpiryMedicine, json);
    List<ExpiryMedicineModel> list = [];
    try {
      if (response.isError) {
        Toast.show(response.errorMessage ?? "", context, duration: 3);
        return (true, list);
      } else {
        list = List<ExpiryMedicineModel>.from(response.responseObject['data']
            .map((x) => ExpiryMedicineModel.fromJson(x)));
        return (false, list);
      }
    } catch (_) {
      Toast.show(_.toString(), context, duration: 3);
      return (true, list);
    }
  }

  static Future<(bool isError, List<BornCountModel> list)> getBornCount(
      String json, BuildContext context) async {
    ResponseModel response = await postApiData(Urls.getBornCount, json);
    List<BornCountModel> list = [];
    try {
      if (response.isError) {
        Toast.show(response.errorMessage ?? "", context, duration: 3);
        return (true, list);
      } else {
        list = List<BornCountModel>.from(response.responseObject['data']
            .map((x) => BornCountModel.fromJson(x)));
        return (false, list);
      }
    } catch (_) {
      Toast.show(_.toString(), context, duration: 3);
      return (true, list);
    }
  }

  static Future<(bool isError, List<RoomListModel> list)> getRoomList(
      BuildContext context) async {
    ResponseModel response = await getApiData(
      Urls.getRoomList,
    );
    List<RoomListModel> list = [];
    try {
      if (response.isError) {
        Toast.show(response.errorMessage ?? "", context, duration: 3);
        return (true, list);
      } else {
        list = List<RoomListModel>.from(response.responseObject['data']
            .map((x) => RoomListModel.fromJson(x)));
        return (false, list);
      }
    } catch (_) {
      Toast.show(_.toString(), context, duration: 3);
      return (true, list);
    }
  }

  static Future<(bool isError, List<DoctorsListModel> list)> getDoctorList(
      BuildContext context) async {
    ResponseModel response = await getApiData(
      Urls.getDoctorList,
    );
    List<DoctorsListModel> list = [];
    try {
      if (response.isError) {
        Toast.show(response.errorMessage ?? "", context, duration: 3);
        return (true, list);
      } else {
        list = List<DoctorsListModel>.from(response.responseObject['data']
            .map((x) => DoctorsListModel.fromJson(x)));
        return (false, list);
      }
    } catch (_) {
      Toast.show(_.toString(), context, duration: 3);
      return (true, list);
    }
  }

  static Future<(bool isError, List<BookingModel> list)> getBooking(
      String json, BuildContext context) async {
    ResponseModel response = await postApiData(Urls.getBooking, json);
    List<BookingModel> list = [];
    try {
      if (response.isError) {
        Toast.show(response.errorMessage ?? "", context, duration: 3);
        return (true, list);
      } else {
        list = List<BookingModel>.from(response.responseObject['data']
            .map((x) => BookingModel.fromJson(x)));
        return (false, list);
      }
    } catch (_) {
      Toast.show(_.toString(), context, duration: 3);
      return (true, list);
    }
  }

  static Future<(bool isError, List<CurrentIpModel> list)> getCurrentIp(
      BuildContext context) async {
    ResponseModel response = await getApiData(
      Urls.getCurrentIp,
    );
    List<CurrentIpModel> list = [];
    try {
      if (response.isError) {
        Toast.show(response.errorMessage ?? "", context, duration: 3);
        return (true, list);
      } else {
        list = List<CurrentIpModel>.from(response.responseObject['data']
            .map((x) => CurrentIpModel.fromJson(x)));
        return (false, list);
      }
    } catch (_) {
      Toast.show(_.toString(), context, duration: 3);
      return (true, list);
    }
  }

  static Future<(bool isError, List<IpCountModel> list)> getIpCount(
      String json, BuildContext context) async {
    ResponseModel response = await postApiData(Urls.getIpCount, json);
    List<IpCountModel> list = [];
    try {
      if (response.isError) {
        Toast.show(response.errorMessage ?? "", context, duration: 3);
        return (true, list);
      } else {
        list = List<IpCountModel>.from(response.responseObject['data']
            .map((x) => IpCountModel.fromJson(x)));
        return (false, list);
      }
    } catch (_) {
      Toast.show(_.toString(), context, duration: 3);
      return (true, list);
    }
  }

  static Future<(bool isError, List<LeaveDoctorsModel> list)> getLeaveDoctors(
      String json, BuildContext context) async {
    ResponseModel response = await postApiData(Urls.getLeaveDoctors, json);
    List<LeaveDoctorsModel> list = [];
    try {
      if (response.isError) {
        Toast.show(response.errorMessage ?? "", context, duration: 3);
        return (true, list);
      } else {
        list = List<LeaveDoctorsModel>.from(response.responseObject['data']
            .map((x) => LeaveDoctorsModel.fromJson(x)));
        return (false, list);
      }
    } catch (_) {
      Toast.show(_.toString(), context, duration: 3);
      return (true, list);
    }
  }

  static Future<(bool isError, List<AvailableDoctorsModel> list)>
      getAvailableDoctors(String json, BuildContext context) async {
    ResponseModel response = await postApiData(Urls.getAvailableDoctors, json);
    List<AvailableDoctorsModel> list = [];
    try {
      if (response.isError) {
        Toast.show(response.errorMessage ?? "", context, duration: 3);
        return (true, list);
      } else {
        list = List<AvailableDoctorsModel>.from(response.responseObject['data']
            .map((x) => AvailableDoctorsModel.fromJson(x)));
        return (false, list);
      }
    } catch (_) {
      Toast.show(_.toString(), context, duration: 3);
      return (true, list);
    }
  }

  static Future<(bool isError, List<AmountModel> list)> getAmount(
      String json, BuildContext context) async {
    ResponseModel response = await postApiData(Urls.getAmount, json);
    List<AmountModel> list = [];
    try {
      if (response.isError) {
        Toast.show(response.errorMessage ?? "", context, duration: 3);
        return (true, list);
      } else {
        list = List<AmountModel>.from(response.responseObject['data']
            .map((x) => AmountModel.fromJson(x)));
        return (false, list);
      }
    } catch (_) {
      Toast.show(_.toString(), context, duration: 3);
      return (true, list);
    }
  }
}
