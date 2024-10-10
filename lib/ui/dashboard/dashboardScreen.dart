import 'dart:convert';

import 'package:carousel_slider/carousel_slider.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:mg_dashboard/models/DashboardModel.dart';
import 'package:mg_dashboard/provider/appProvider.dart';
import 'package:mg_dashboard/ui/booking/bookingScreen.dart';
import 'package:mg_dashboard/ui/born/bornCountScreen.dart';
import 'package:mg_dashboard/ui/card/cardHdrScreen.dart';
import 'package:mg_dashboard/ui/cash/cashHdrScreen.dart';
import 'package:mg_dashboard/ui/credit/creditHdrScreen.dart';
import 'package:mg_dashboard/ui/dashboard/DashboardRepo/DashboardRepo.dart';
import 'package:mg_dashboard/ui/dashboard/filterWidget.dart';
import 'package:mg_dashboard/ui/doctors/availableDoctorsScreen.dart';
import 'package:mg_dashboard/ui/doctors/doctorsListScreen.dart';
import 'package:mg_dashboard/ui/doctors/leaveDoctorsScreen.dart';
import 'package:mg_dashboard/ui/expiry/expiryMedicineScreen.dart';
import 'package:mg_dashboard/ui/incomeByDepartmentScreen.dart';
import 'package:mg_dashboard/ui/ip/currentIpScreen.dart';
import 'package:mg_dashboard/ui/ip/ipCountScreen.dart';
import 'package:mg_dashboard/ui/lab/labAmountScreen.dart';
import 'package:mg_dashboard/ui/op/opAmountScreen.dart';
import 'package:mg_dashboard/ui/op/opCountScreen.dart';
import 'package:mg_dashboard/ui/paid/paidPatientsScreen.dart';
import 'package:mg_dashboard/ui/purchase/pharmacyPurchaseScreen.dart';
import 'package:mg_dashboard/ui/reviewed/reviewedPatientsScreen.dart';
import 'package:mg_dashboard/ui/room/roomListScreen.dart';
import 'package:mg_dashboard/ui/upi/upiHdrScreen.dart';
import 'package:mg_dashboard/ui/widgets/customText.dart';
import 'package:mg_dashboard/utils/colorConst.dart';
import 'package:skeletonizer/skeletonizer.dart';

class Dashboardscreen extends StatefulWidget {
  const Dashboardscreen({super.key});

  @override
  State<Dashboardscreen> createState() => _DashboardscreenState();
}

class _DashboardscreenState extends State<Dashboardscreen> {
  DashboardModel dashboardModel = DashboardModel();
  int _current = 0;
  final CarouselSliderController sliderController = CarouselSliderController();
  bool isLoadingDashboardData = false;

  bool _isVisible = false;

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    getDashboardData(context);
  }

  void _toggleContainer() {
    setState(() {
      _isVisible = !_isVisible;
    });
  }

  @override
  void dispose() {
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Row(
          children: [
            const Icon(Icons.filter_alt_outlined),
            const Spacer(),
            InkWell(
                onTap: _toggleContainer,
                child: const Padding(
                  padding: EdgeInsets.all(8.0),
                  child: Icon(Icons.filter_alt_outlined),
                ))
          ],
        ),
      ),
      backgroundColor: ColorConst.secondaryColor,
      body: SafeArea(
          child: RefreshIndicator(
        onRefresh: () => getDashboardData(context),
        child: SingleChildScrollView(
          child: Column(
            children: [
              FilterWidget(
                isVisible: _isVisible,
                onSelected: () {
                  getDashboardData(context);
                },
              ),
              const Padding(
                padding: EdgeInsets.symmetric(horizontal: 8.0, vertical: 5),
                child: CustomText(
                  "Abc Hospital",
                  fontWeight: FontWeight.bold,
                  textColor: Colors.black,
                ),
              ),
              const Padding(
                padding: EdgeInsets.symmetric(horizontal: 8.0),
                child: CustomText(
                  "Orchid Changaramkulam, Thrissur 679574",
                  fontWeight: FontWeight.bold,
                  textColor: Colors.grey,
                ),
              ),
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: Skeletonizer(
                  enabled: isLoadingDashboardData,
                  child: CarouselSlider(
                    carouselController: sliderController,
                    options: CarouselOptions(
                        aspectRatio: 1.9,
                        viewportFraction: 1,
                        onPageChanged: (index, reason) {
                          setState(() {
                            _current = index;
                          });
                        }),
                    items: [
                      firstGrid(context),
                      secondGrid(),
                      thirdGrid(),
                      fourthGrid(),
                      fifthGrid(),
                      sixthGrid(),
                    ],
                  ),
                ),
              ),
              Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [1, 2, 3, 4, 5, 6].asMap().entries.map((entry) {
                    return GestureDetector(
                      onTap: () => sliderController.animateToPage(entry.key),
                      child: Container(
                        width: 10.0,
                        height: 10.0,
                        margin: const EdgeInsets.symmetric(
                            vertical: 8.0, horizontal: 4.0),
                        decoration: BoxDecoration(
                            shape: BoxShape.circle,
                            color:
                                (Theme.of(context).brightness == Brightness.dark
                                        ? Colors.white
                                        : Colors.black)
                                    .withOpacity(
                                        _current == entry.key ? 0.5 : 0.1)),
                      ),
                    );
                  }).toList()),
            ],
          ),
        ),
      )),
    );
  }

  Widget firstGrid(BuildContext context) {
    return Container(
      margin: const EdgeInsets.all(2),
      child: GridView.count(
        shrinkWrap: true,
        physics: const AlwaysScrollableScrollPhysics(),
        crossAxisCount: 2,
        childAspectRatio: 1.9,
        children: [
          gridCard(
              text: "Total Income",
              value: dashboardModel.totalIncome ?? 0,
              iconPath: "assets/icons/income.svg",
              iconColor: Colors.red,
              iconBgColor: Colors.red[100]!,
              onSelected: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(
                      builder: (context) => const IncomeByDepartmentScreen()),
                );
              }),
          gridCard(
              text: "Total Cash",
              value: dashboardModel.totalCash ?? 0,
              iconPath: "assets/icons/cash.svg",
              iconColor: Colors.blue,
              iconBgColor: Colors.blue[100]!,
              onSelected: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(
                      builder: (context) => const CashHdrScreen()),
                );
              }),
          gridCard(
              text: "Total Upi",
              value: dashboardModel.totalUpiAmt ?? 0,
              iconPath: "assets/icons/upi.svg",
              // iconColor: Colors.black,
              // iconBgColor: Colors.black12,
              onSelected: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(builder: (context) => const UpiHdrScreen()),
                );
              }),
          gridCard(
              text: "Total Card",
              value: dashboardModel.totalCardAmt ?? 0,
              iconPath: "assets/icons/card.svg",
              iconColor: Colors.green,
              iconBgColor: Colors.green[100]!,
              onSelected: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(
                      builder: (context) => const CardHdrScreen()),
                );
              }),
        ],
      ),
    );
  }

  Widget secondGrid() {
    return Container(
      margin: const EdgeInsets.all(2),
      child: GridView.count(
        shrinkWrap: true,
        physics: const AlwaysScrollableScrollPhysics(),
        crossAxisCount: 2,
        childAspectRatio: 1.9,
        children: [
          gridCard(
              text: "Total Credit",
              value: dashboardModel.totalCredit ?? 0,
              iconPath: "assets/icons/credit.svg",
              iconColor: Colors.red,
              iconBgColor: Colors.red[100]!,
              onSelected: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) => const CreditHdrScreen(),
                  ),
                );
              }),
          gridCard(
              text: "OP Amount",
              value: dashboardModel.totalOpAmt ?? 0,
              iconPath: "assets/icons/cash.svg",
              iconColor: Colors.blue,
              iconBgColor: Colors.blue[100]!,
              onSelected: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) => OpAmountScreen(
                      accountId: dashboardModel.opId ?? 0,
                    ),
                  ),
                );
              }),
          gridCard(
              text: "Lab Amount",
              value: dashboardModel.labAmount ?? 0,
              iconPath: "assets/icons/lab.svg",
              iconColor: Colors.yellow[900],
              iconBgColor: Colors.yellow[100],
              size: 18,
              onSelected: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) => LabAmountScreen(
                      accountId: dashboardModel.labId ?? 0,
                    ),
                  ),
                );
              }),
          gridCard(
              text: "Pharmacy Amount",
              value: dashboardModel.phAmount ?? 0,
              iconPath: "assets/icons/pharmacy.svg",
              iconColor: Colors.green,
              iconBgColor: Colors.green[100]!,
              onSelected: () {}),
        ],
      ),
    );
  }

  Widget thirdGrid() {
    return Container(
      margin: const EdgeInsets.all(2),
      child: GridView.count(
        shrinkWrap: true,
        physics: const AlwaysScrollableScrollPhysics(),
        crossAxisCount: 2,
        childAspectRatio: 1.9,
        children: [
          gridCard(
              text: "Advance Amount",
              value: dashboardModel.advanceAmount ?? 0,
              iconPath: "assets/icons/advanceAmt.svg",
              iconColor: Colors.red,
              iconBgColor: Colors.red[100]!,
              onSelected: () {}),
          gridCard(
              text: "OP Count",
              value: dashboardModel.totalOp ?? 0,
              iconPath: "assets/icons/opCount.svg",
              iconColor: Colors.blue,
              iconBgColor: Colors.blue[100]!,
              onSelected: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) => const OpCountScreen(),
                  ),
                );
              }),
          gridCard(
              text: "IP Count",
              value: dashboardModel.todayIp ?? 0,
              iconPath: "assets/icons/ipCount.svg",
              iconColor: Colors.yellow[900],
              iconBgColor: Colors.yellow[100],
              size: 18,
              onSelected: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) => const IpCountScreen(),
                  ),
                );
              }),
          gridCard(
              text: "Current IP",
              value: dashboardModel.totalIp ?? 0,
              iconPath: "assets/icons/inPatient.svg",
              iconColor: Colors.green,
              iconBgColor: Colors.green[100]!,
              onSelected: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) => const CurrentIpScreen(),
                  ),
                );
              }),
        ],
      ),
    );
  }

  Widget fourthGrid() {
    return Container(
      margin: const EdgeInsets.all(2),
      child: GridView.count(
        shrinkWrap: true,
        physics: const AlwaysScrollableScrollPhysics(),
        crossAxisCount: 2,
        childAspectRatio: 1.9,
        children: [
          gridCard(
              text: "Booking",
              value: dashboardModel.totalPatients ?? 0,
              iconPath: "assets/icons/booking.svg",
              iconColor: Colors.red,
              iconBgColor: Colors.red[100]!,
              onSelected: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) => const BookingScreen(),
                  ),
                );
              }),
          gridCard(
              text: "Paid Patients",
              value: dashboardModel.totalPaidPatients ?? 0,
              iconPath: "assets/icons/paid.svg",
              iconColor: Colors.blue,
              iconBgColor: Colors.blue[100]!,
              onSelected: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) => const PaidPatientsScreen(),
                  ),
                );
              }),
          gridCard(
              text: "Reviewed Patients",
              value: dashboardModel.totalReviewedPatients ?? 0,
              iconPath: "assets/icons/review.svg",
              iconColor: Colors.yellow[900],
              iconBgColor: Colors.yellow[100],
              size: 18,
              onSelected: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) => const ReviewedPatientsScreen(),
                  ),
                );
              }),
          gridCard(
              text: "Doctors Count",
              value: dashboardModel.doctorCount ?? 0,
              iconPath: "assets/icons/doctorCount.svg",
              iconColor: Colors.green,
              iconBgColor: Colors.green[100]!,
              onSelected: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) => const DoctorListScreen(),
                  ),
                );
              }),
        ],
      ),
    );
  }

  Widget fifthGrid() {
    return Container(
      margin: const EdgeInsets.all(2),
      child: GridView.count(
        shrinkWrap: true,
        physics: const AlwaysScrollableScrollPhysics(),
        crossAxisCount: 2,
        childAspectRatio: 1.9,
        children: [
          gridCard(
              text: "Leave Doctors",
              value: dashboardModel.todayLeaveDoctors ?? 0,
              iconPath: "assets/icons/doctorCount.svg",
              iconColor: Colors.red,
              iconBgColor: Colors.red[100]!,
              onSelected: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) => const LeaveDoctorsScreen(),
                  ),
                );
              }),
          gridCard(
              text: "Available Doctors",
              value: dashboardModel.todayPresentDoctors ?? 0,
              iconPath: "assets/icons/doctorCount.svg",
              iconColor: Colors.blue,
              iconBgColor: Colors.blue[100]!,
              onSelected: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) => const AvailableDoctorsScreen(),
                  ),
                );
              }),
          gridCard(
              text: "Born Count",
              value: dashboardModel.bornCount ?? 0,
              iconPath: "assets/icons/bornCount.svg",
              iconColor: Colors.yellow[900],
              iconBgColor: Colors.yellow[100],
              size: 18,
              onSelected: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) => const BornCountScreen(),
                  ),
                );
              }),
          gridCard(
              text: "Pharmacy Purchase",
              value: dashboardModel.purchaseAmount ?? 0,
              iconPath: "assets/icons/pharmacyPurchase.svg",
              iconColor: Colors.green,
              iconBgColor: Colors.green[100]!,
              onSelected: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) => const PharmacyPurchaseScreen(),
                  ),
                );
              }),
        ],
      ),
    );
  }

  Widget sixthGrid() {
    return Container(
      margin: const EdgeInsets.all(2),
      child: GridView.count(
        shrinkWrap: true,
        physics: const AlwaysScrollableScrollPhysics(),
        crossAxisCount: 2,
        childAspectRatio: 1.9,
        children: [
          gridCard(
              text: "Expiry Medicine",
              value: dashboardModel.expiryAmount ?? 0,
              iconPath: "assets/icons/expireMedicine.svg",
              iconColor: Colors.red,
              iconBgColor: Colors.red[100]!,
              onSelected: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) => const ExpiryMedicineScreen(),
                  ),
                );
              }),
          gridCard(
              text: "Available Rooms",
              value: dashboardModel.roomCount ?? 0,
              iconPath: "assets/icons/rooms.svg",
              iconColor: Colors.blue,
              iconBgColor: Colors.blue[100]!,
              onSelected: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) => const RoomListScreen(),
                  ),
                );
              }),
          // gridCard(
          //     text: "Born Count",
          //     value: dashboardModel.bornCount ?? 0,
          //     iconPath: "assets/icons/review.svg",
          //     iconColor: Colors.yellow[900],
          //     iconBgColor: Colors.yellow[100],
          //     size: 18,
          //     onSelected: () {}),
          // gridCard(
          //     text: "Pharmacy Purchase",
          //     value: dashboardModel.totalPharmacyAmt ?? 0,
          //     iconPath: "assets/icons/doctorCount.svg",
          //     iconColor: Colors.green,
          //     iconBgColor: Colors.green[100]!,
          //     onSelected: () {}),
        ],
      ),
    );
  }

  Widget gridCard(
      {required String text,
      required var value,
      required String iconPath,
      Color? iconColor,
      Color? iconBgColor,
      double? size,
      required void Function() onSelected}) {
    return InkWell(
      onTap: onSelected,
      child: Container(
        decoration: const BoxDecoration(
          borderRadius: BorderRadius.all(Radius.circular(12)),
          color: Colors.white,
        ),
        margin: const EdgeInsets.all(5),
        padding: const EdgeInsets.all(5),
        alignment: Alignment.center,
        child: Column(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Padding(
              padding: const EdgeInsets.all(4.0),
              child: Row(
                children: [
                  Expanded(
                      child: CustomText(
                    text,
                    textColor: Colors.grey,
                    fontWeight: FontWeight.bold,
                  )),
                  Material(
                      shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(5)),
                      color: iconBgColor,
                      child: Padding(
                        padding: const EdgeInsets.all(5.0),
                        child: SvgPicture.asset(
                          iconPath,
                          colorFilter: null != iconColor
                              ? ColorFilter.mode(iconColor, BlendMode.srcIn)
                              : null,
                          width: size ?? 15,
                          height: size ?? 15,
                        ),
                      ))
                ],
              ),
            ),
            Padding(
              padding: const EdgeInsets.all(4.0),
              child: CustomText(
                value.toStringAsFixed(0),
                fontWeight: FontWeight.bold,
                fontSize: 20,
              ),
            )
          ],
        ),
      ),
    );
  }

  getDashboardData(BuildContext context) async {
    isLoadingDashboardData = true;
    setState(() {});
    var jsonData = jsonEncode({
      "jsonData": {
        "dashModel": {
          "fromDate": AppProvider.of(context).fromDate.toIso8601String(),
          "toDate": AppProvider.of(context).toDate.toIso8601String(),
        }
      }
    });

    var data = await DashboardRepo.getDashboardData(jsonData, context);
    if (!data.$1) {
      dashboardModel = data.$2;
      AppProvider.of(context).dashboardModel = dashboardModel;
    }
    isLoadingDashboardData = false;
    setState(() {});
  }
}
