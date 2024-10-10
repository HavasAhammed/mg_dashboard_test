import 'package:flutter/material.dart';
import 'package:mg_dashboard/models/DashboardModel.dart';
import 'package:mg_dashboard/utils/dateTimeUtils.dart';
import 'package:provider/provider.dart';

class AppProvider extends ChangeNotifier {
  DateTime _fromDate = DateTime.now();
  DateTime _toDate = DateTime.now();
  int calenderType = calenderTypeDay;
  DashboardModel _dashboardModel = DashboardModel();

  DashboardModel get dashboardModel => _dashboardModel;

  set dashboardModel(DashboardModel value) {
    _dashboardModel = value;
  }

  DateTime get toDate => _toDate;

  set toDate(DateTime value) {
    _toDate = value;
  }

  DateTime get fromDate => _fromDate;

  set fromDate(DateTime value) {
    _fromDate = value;
  }

  static AppProvider of(BuildContext context) {
    return Provider.of<AppProvider>(context, listen: false);
  }

  setDate(DateTime fromDate, DateTime toDate, int calenderTypeMonth) {
    this.fromDate = fromDate;
    this.toDate = toDate;
    calenderType = calenderTypeMonth;
    notifyListeners();
  }
}
