import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:mg_dashboard/models/departmentModel.dart';
import 'package:mg_dashboard/provider/appProvider.dart';
import 'package:mg_dashboard/ui/dashboard/DashboardRepo/DashboardRepo.dart';
import 'package:mg_dashboard/ui/dashboard/filterWidget.dart';
import 'package:mg_dashboard/ui/doctorAppointmentListScreen.dart';
import 'package:mg_dashboard/ui/widgets/sliverAppBarDeligate.dart';
import 'package:mg_dashboard/ui/widgets/customText.dart';
import 'package:mg_dashboard/ui/widgets/loadingCircle.dart';
import 'package:mg_dashboard/utils/colorConst.dart';
import 'package:mg_dashboard/utils/extensions.dart';
import 'package:mg_dashboard/utils/fontConst.dart';
import 'package:skeletonizer/skeletonizer.dart';

class IncomeByDepartmentScreen extends StatefulWidget {
  const IncomeByDepartmentScreen({super.key});

  @override
  State<IncomeByDepartmentScreen> createState() =>
      _IncomeByDepartmentScreenState();
}

class _IncomeByDepartmentScreenState extends State<IncomeByDepartmentScreen> {
  TextStyle textStyle = const TextStyle(color: Colors.white);
  bool _isVisible = false;
  bool isLoading = false;
  List<DepartmentModel> dataList = [];
  int selectedIndex = -1;
  double screenWidth = 0;
  double totalAmt = 0;

  @override
  void initState() {
    super.initState();

    getData(context);
  }

  @override
  Widget build(BuildContext context) {
    screenWidth = context.getWidth() + 300;

    return Scaffold(
      appBar: AppBar(
        title: Row(
          children: [
            Expanded(
              child: CustomText(
                "Income By Department",
                fontSize: appBarTextFont,
              ),
            ),
            InkWell(
              onTap: _toggleContainer,
              child: const Padding(
                padding: EdgeInsets.all(8.0),
                child: Icon(Icons.filter_alt_outlined),
              ),
            ),
          ],
        ),
      ),
      backgroundColor: ColorConst.secondaryColor,
      body: SafeArea(
        child: SingleChildScrollView(
          scrollDirection: Axis.horizontal,
          child: SingleChildScrollView(
            scrollDirection: Axis.vertical,
            child: isLoading
                ? Container(
                    padding: const EdgeInsets.all(190),
                    child: Center(child: LoadingCircle()),
                  )
                : Column(
                    mainAxisAlignment: MainAxisAlignment.start,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      SizedBox(
                        width: context.getWidth(),
                        child: FilterWidget(
                          isVisible: _isVisible,
                          onSelected: () {
                            getData(context);
                          },
                        ),
                      ),
                      SizedBox(
                        height: MediaQuery.of(context).size.height - 130,
                        width: screenWidth,
                        child: CustomScrollView(
                          slivers: [
                            SliverMainAxisGroup(
                              slivers: [
                                SliverPersistentHeader(
                                  pinned:
                                      true, // Keeps the header pinned at the top
                                  delegate: SliverAppBarDelegate(
                                    minHeight: 55.0,
                                    maxHeight: 55.0,
                                    child: Column(
                                      children: [
                                        Container(
                                          margin: const EdgeInsets.symmetric(
                                              horizontal: 2),
                                          padding: const EdgeInsets.all(8.0),
                                          color: ColorConst.primaryColor,
                                          child: Row(
                                            children: [
                                              SizedBox(
                                                width: screenWidth / 2.9,
                                                child: const Row(
                                                  children: [
                                                    SizedBox(
                                                      width: 20,
                                                      child: CustomText(
                                                        "Sl",
                                                        textColor: ColorConst
                                                            .primaryFont,
                                                        fontWeight:
                                                            FontWeight.bold,
                                                      ),
                                                    ),
                                                    Expanded(
                                                      child: CustomText(
                                                        "Service",
                                                        textColor: ColorConst
                                                            .primaryFont,
                                                        fontWeight:
                                                            FontWeight.bold,
                                                      ),
                                                    ),
                                                  ],
                                                ),
                                              ),
                                              SizedBox(
                                                width: screenWidth / 10,
                                                child: const CustomText(
                                                  "Total",
                                                  textColor:
                                                      ColorConst.primaryFont,
                                                  fontWeight: FontWeight.bold,
                                                  textAlign: TextAlign.end,
                                                ),
                                              ),
                                              SizedBox(
                                                width: screenWidth / 10,
                                                child: const CustomText(
                                                  "Percent",
                                                  textColor:
                                                      ColorConst.primaryFont,
                                                  fontWeight: FontWeight.bold,
                                                  textAlign: TextAlign.end,
                                                ),
                                              ),
                                              SizedBox(
                                                width: screenWidth / 10,
                                                child: const CustomText(
                                                  "General",
                                                  textColor:
                                                      ColorConst.primaryFont,
                                                  fontWeight: FontWeight.bold,
                                                  textAlign: TextAlign.end,
                                                ),
                                              ),
                                              SizedBox(
                                                width: screenWidth / 10,
                                                child: const CustomText(
                                                  "Pharmacy",
                                                  textColor:
                                                      ColorConst.primaryFont,
                                                  fontWeight: FontWeight.bold,
                                                  textAlign: TextAlign.end,
                                                ),
                                              ),
                                              SizedBox(
                                                width: screenWidth / 10,
                                                child: const CustomText(
                                                  "Lab",
                                                  textColor:
                                                      ColorConst.primaryFont,
                                                  fontWeight: FontWeight.bold,
                                                  textAlign: TextAlign.end,
                                                ),
                                              ),
                                              SizedBox(
                                                width: screenWidth / 10,
                                                child: const CustomText(
                                                  "Op",
                                                  textColor:
                                                      ColorConst.primaryFont,
                                                  fontWeight: FontWeight.bold,
                                                  textAlign: TextAlign.end,
                                                ),
                                              ),
                                            ],
                                          ),
                                        ),
                                        Container(
                                          height: 20,
                                          color: ColorConst.secondaryColor,
                                          margin: const EdgeInsets.symmetric(
                                              horizontal: 5),
                                          padding: const EdgeInsets.symmetric(
                                              vertical: 0.0, horizontal: 4),
                                          child: Row(
                                            children: [
                                              SizedBox(
                                                width: screenWidth / 2.9,
                                                child: const Row(
                                                  children: [
                                                    SizedBox(
                                                      width: 20,
                                                      child: CustomText(""),
                                                    ),
                                                    Expanded(
                                                      child: CustomText(
                                                        "Total",
                                                        fontWeight:
                                                            FontWeight.bold,
                                                      ),
                                                    ),
                                                  ],
                                                ),
                                              ),
                                              SizedBox(
                                                width: screenWidth / 10,
                                                child: CustomText(
                                                  totalAmt.toStringAsFixed(0),
                                                  textAlign: TextAlign.end,
                                                  fontWeight: FontWeight.bold,
                                                ),
                                              ),
                                              SizedBox(
                                                width: screenWidth / 10,
                                                child: const CustomText(
                                                  "",
                                                  textAlign: TextAlign.end,
                                                  fontWeight: FontWeight.bold,
                                                ),
                                              ),
                                              SizedBox(
                                                width: screenWidth / 10,
                                                child: CustomText(
                                                  dataList
                                                      .map((e) => e.doctorList!
                                                          .fold(
                                                              0.0,
                                                              (sum, doctor) =>
                                                                  sum +
                                                                  (doctor.genAmount ??
                                                                      0)))
                                                      .toList()
                                                      .fold(
                                                          0.0,
                                                          (sum, amt) =>
                                                              sum + amt)
                                                      .toStringAsFixed(0),
                                                  textAlign: TextAlign.end,
                                                  fontWeight: FontWeight.bold,
                                                ),
                                              ),
                                              SizedBox(
                                                width: screenWidth / 10,
                                                child: CustomText(
                                                  dataList
                                                      .map((e) => e.doctorList!
                                                          .fold(
                                                              0.0,
                                                              (sum, doctor) =>
                                                                  sum +
                                                                  (doctor.phAmount ??
                                                                      0)))
                                                      .toList()
                                                      .fold(
                                                          0.0,
                                                          (sum, amt) =>
                                                              sum + amt)
                                                      .toStringAsFixed(0),
                                                  textAlign: TextAlign.end,
                                                  fontWeight: FontWeight.bold,
                                                ),
                                              ),
                                              SizedBox(
                                                width: screenWidth / 10,
                                                child: CustomText(
                                                  dataList
                                                      .map((e) => e.doctorList!
                                                          .fold(
                                                              0.0,
                                                              (sum, doctor) =>
                                                                  sum +
                                                                  (doctor.labAmount ??
                                                                      0)))
                                                      .toList()
                                                      .fold(
                                                          0.0,
                                                          (sum, amt) =>
                                                              sum + amt)
                                                      .toStringAsFixed(0),
                                                  textAlign: TextAlign.end,
                                                  fontWeight: FontWeight.bold,
                                                ),
                                              ),
                                              SizedBox(
                                                width: screenWidth / 10,
                                                child: CustomText(
                                                  dataList
                                                      .map(
                                                        (e) =>
                                                            e.doctorList!.fold(
                                                          0.0,
                                                          (sum, doctor) =>
                                                              sum +
                                                              (doctor.opAmount ??
                                                                  0),
                                                        ),
                                                      )
                                                      .toList()
                                                      .fold(
                                                          0.0,
                                                          (sum, amt) =>
                                                              sum + amt)
                                                      .toStringAsFixed(0),
                                                  textAlign: TextAlign.end,
                                                  fontWeight: FontWeight.bold,
                                                ),
                                              ),
                                            ],
                                          ),
                                        ),
                                      ],
                                    ),
                                  ),
                                ),
                                // isLoading?
                                // SliverToBoxAdapter(
                                //   child: Padding(
                                //     padding: const EdgeInsets.all(8.0),
                                //     child: Container(
                                //         child: LoadingCircle()),
                                //   ),
                                // ):
                                SliverList(
                                  delegate: SliverChildBuilderDelegate(
                                    childCount: 1,
                                    (context, position) {
                                      return Padding(
                                        padding: const EdgeInsets.symmetric(
                                            horizontal: 0.0, vertical: 0),
                                        child: ListView.builder(
                                          shrinkWrap: true,
                                          itemCount: dataList.length,
                                          physics:
                                              const NeverScrollableScrollPhysics(),
                                          itemBuilder: (context, index) {
                                            DepartmentModel model =
                                                dataList[index];

                                            return InkWell(
                                              onTap: () {
                                                dataList[index].isExpanded =
                                                    !dataList[index]
                                                        .isExpanded!;
                                                setState(() {});
                                              },
                                              child: Column(
                                                children: [
                                                  Container(
                                                    margin: const EdgeInsets.all(2),
                                                    color: model.isExpanded!
                                                        ? Colors.grey[400]
                                                        : Colors.white,
                                                    padding: const EdgeInsets
                                                        .symmetric(
                                                        horizontal: 7.0,
                                                        vertical: 7),
                                                    child: Row(
                                                      children: [
                                                        SizedBox(
                                                          width:
                                                              screenWidth / 2.9,
                                                          child: Row(
                                                            children: [
                                                              SizedBox(
                                                                width: 20,
                                                                child:
                                                                    CustomText(
                                                                  (index + 1)
                                                                      .toString(),
                                                                ),
                                                              ),
                                                              Expanded(
                                                                child:
                                                                    CustomText(
                                                                  model
                                                                      .departmentName,
                                                                  fontWeight: model
                                                                          .isExpanded!
                                                                      ? FontWeight
                                                                          .bold
                                                                      : FontWeight
                                                                          .normal,
                                                                ),
                                                              ),
                                                            ],
                                                          ),
                                                        ),
                                                        SizedBox(
                                                          width:
                                                              screenWidth / 10,
                                                          child: CustomText(
                                                            (model.doctorList!
                                                                .fold(
                                                                  0.0,
                                                                  (sum, doctor) =>
                                                                      (sum +
                                                                          doctor
                                                                              .amount!),
                                                                )
                                                                .toStringAsFixed(
                                                                    0)),
                                                            textAlign:
                                                                TextAlign.end,
                                                            fontWeight: model
                                                                    .isExpanded!
                                                                ? FontWeight
                                                                    .bold
                                                                : FontWeight
                                                                    .normal,
                                                          ),
                                                        ),
                                                        SizedBox(
                                                          width:
                                                              screenWidth / 10,
                                                          child: CustomText(
                                                            "${((model.doctorList!.fold(0.0, (sum, doctor) => (sum + doctor.amount!)) /
                                                                            totalAmt) *
                                                                        100)
                                                                    .toStringAsFixed(
                                                                        2)}%",
                                                            textAlign:
                                                                TextAlign.end,
                                                            fontWeight: model
                                                                    .isExpanded!
                                                                ? FontWeight
                                                                    .bold
                                                                : FontWeight
                                                                    .normal,
                                                          ),
                                                        ),
                                                        SizedBox(
                                                          width:
                                                              screenWidth / 10,
                                                          child: CustomText(
                                                            (model.doctorList!
                                                                .fold(
                                                                  0.0,
                                                                  (sum, doctor) =>
                                                                      (sum +
                                                                          doctor
                                                                              .genAmount!),
                                                                )
                                                                .toStringAsFixed(
                                                                    0)),
                                                            textAlign:
                                                                TextAlign.end,
                                                            fontWeight: model
                                                                    .isExpanded!
                                                                ? FontWeight
                                                                    .bold
                                                                : FontWeight
                                                                    .normal,
                                                          ),
                                                        ),
                                                        SizedBox(
                                                          width:
                                                              screenWidth / 10,
                                                          child: CustomText(
                                                            (model.doctorList!
                                                                .fold(
                                                                    0.0,
                                                                    (sum, doctor) =>
                                                                        (sum +
                                                                            doctor
                                                                                .phAmount!))
                                                                .toStringAsFixed(
                                                                    0)),
                                                            textAlign:
                                                                TextAlign.end,
                                                            fontWeight: model
                                                                    .isExpanded!
                                                                ? FontWeight
                                                                    .bold
                                                                : FontWeight
                                                                    .normal,
                                                          ),
                                                        ),
                                                        SizedBox(
                                                          width:
                                                              screenWidth / 10,
                                                          child: CustomText(
                                                            (model.doctorList!
                                                                .fold(
                                                                    0.0,
                                                                    (sum, doctor) =>
                                                                        (sum +
                                                                            doctor
                                                                                .labAmount!))
                                                                .toStringAsFixed(
                                                                    0)),
                                                            textAlign:
                                                                TextAlign.end,
                                                            fontWeight: model
                                                                    .isExpanded!
                                                                ? FontWeight
                                                                    .bold
                                                                : FontWeight
                                                                    .normal,
                                                          ),
                                                        ),
                                                        SizedBox(
                                                          width:
                                                              screenWidth / 10,
                                                          child: CustomText(
                                                            (model.doctorList!
                                                                .fold(
                                                                    0.0,
                                                                    (sum, doctor) =>
                                                                        (sum +
                                                                            doctor
                                                                                .opAmount!))
                                                                .toStringAsFixed(
                                                                    0)),
                                                            textAlign:
                                                                TextAlign.end,
                                                            fontWeight: model
                                                                    .isExpanded!
                                                                ? FontWeight
                                                                    .bold
                                                                : FontWeight
                                                                    .normal,
                                                          ),
                                                        ),
                                                      ],
                                                    ),
                                                  ),
                                                  if (model.isExpanded!)
                                                    ListView.builder(
                                                      shrinkWrap: true,
                                                      itemCount: model
                                                          .doctorList?.length,
                                                      physics:
                                                          const AlwaysScrollableScrollPhysics(),
                                                      itemBuilder:
                                                          (context, index) {
                                                        DoctorModel e = model
                                                            .doctorList![index];
                                                        return InkWell(
                                                          onTap: () {
                                                            Navigator.push(
                                                              context,
                                                              MaterialPageRoute(
                                                                builder:
                                                                    (context) =>
                                                                        DoctorAppointmentListScreen(
                                                                  e.doctorName!,
                                                                  e.id!,
                                                                ),
                                                              ),
                                                            );
                                                          },
                                                          child: Padding(
                                                            padding:
                                                                const EdgeInsets
                                                                    .all(2.0),
                                                            child: Flex(
                                                              direction: Axis
                                                                  .horizontal,
                                                              children: [
                                                                Container(
                                                                  width:
                                                                      screenWidth /
                                                                          2.8,
                                                                  padding: const EdgeInsets
                                                                      .symmetric(
                                                                      horizontal:
                                                                          7.0,
                                                                      vertical:
                                                                          2),
                                                                  child: Row(
                                                                    children: [
                                                                      Container(
                                                                          width:
                                                                              20),
                                                                      SizedBox(
                                                                        width:
                                                                            15,
                                                                        child:
                                                                            CustomText(
                                                                          (index + 1)
                                                                              .toString(),
                                                                        ),
                                                                      ),
                                                                      Expanded(
                                                                        child:
                                                                            CustomText(
                                                                          e.doctorName,
                                                                        ),
                                                                      ),
                                                                    ],
                                                                  ),
                                                                ),
                                                                SizedBox(
                                                                  width:
                                                                      screenWidth /
                                                                          10,
                                                                  child:
                                                                      CustomText(
                                                                    e.amount
                                                                        .toString(),
                                                                    textAlign:
                                                                        TextAlign
                                                                            .right,
                                                                  ),
                                                                ),
                                                                SizedBox(
                                                                  width:
                                                                      screenWidth /
                                                                          10,
                                                                  child:
                                                                      CustomText(
                                                                    "${(((e.amount! / totalAmt) *
                                                                                100))
                                                                            .toStringAsFixed(2)}%",
                                                                    textAlign:
                                                                        TextAlign
                                                                            .right,
                                                                  ),
                                                                ),
                                                                SizedBox(
                                                                  width:
                                                                      screenWidth /
                                                                          10,
                                                                  child:
                                                                      CustomText(
                                                                    e.genAmount!
                                                                        .toStringAsFixed(
                                                                            2),
                                                                    textAlign:
                                                                        TextAlign
                                                                            .right,
                                                                  ),
                                                                ),
                                                                SizedBox(
                                                                  width:
                                                                      screenWidth /
                                                                          10,
                                                                  child:
                                                                      CustomText(
                                                                    e.phAmount!
                                                                        .toStringAsFixed(
                                                                            2),
                                                                    textAlign:
                                                                        TextAlign
                                                                            .right,
                                                                  ),
                                                                ),
                                                                SizedBox(
                                                                  width:
                                                                      screenWidth /
                                                                          10,
                                                                  child:
                                                                      CustomText(
                                                                    e.labAmount!
                                                                        .toStringAsFixed(
                                                                            2),
                                                                    textAlign:
                                                                        TextAlign
                                                                            .right,
                                                                  ),
                                                                ),
                                                                SizedBox(
                                                                  width:
                                                                      screenWidth /
                                                                          10,
                                                                  child:
                                                                      CustomText(
                                                                    e.opAmount!
                                                                        .toStringAsFixed(
                                                                            2),
                                                                    textAlign:
                                                                        TextAlign
                                                                            .right,
                                                                  ),
                                                                ),
                                                              ],
                                                            ),
                                                          ),
                                                        );
                                                      },
                                                    ),
                                                ],
                                              ),
                                            );
                                          },
                                        ),
                                      );
                                    },
                                  ),
                                ),
                              ],
                            ),
                          ],
                        ),
                      ),
                    ],
                  ),
          ),
        ),
      ),
    );
  }

  doctorListView(DepartmentModel model) {
    return ListView.builder(
        shrinkWrap: true,
        scrollDirection: Axis.horizontal,
        itemCount: model.doctorList?.length,
        // physics: AlwaysScrollableScrollPhysics(),
        itemBuilder: (context, index) {
          DoctorModel doctorModel = model.doctorList![index];
          return CustomText(doctorModel.doctorName);
        });
  }

  getData(BuildContext context) async {
    isLoading = true;
    setState(() {});
    var jsonData = jsonEncode({
      "jsonData": {
        "dashModel": {
          "fromDate": AppProvider.of(context).fromDate.toIso8601String(),
          "toDate": AppProvider.of(context).toDate.toIso8601String(),
        }
      }
    });

    var data =
        await DashboardRepo.getTotalIncomeByDepartmant(jsonData, context);
    if (!data.$1) {
      dataList = data.$2;
      totalAmt = dataList
          .map((e) => e.doctorList!
              .fold(0.0, (sum, doctor) => sum + (doctor.amount ?? 0)))
          .toList()
          .fold(0.0, (sum, amt) => sum + amt);
    }
    isLoading = false;
    setState(() {});
  }

  void _toggleContainer() {
    setState(() {
      _isVisible = !_isVisible;
    });
  }
}
