import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:mg_dashboard/models/reviewedPatientModel.dart';
import 'package:mg_dashboard/provider/appProvider.dart';
import 'package:mg_dashboard/ui/dashboard/dashboardRepo/dashboardRepo.dart';
import 'package:mg_dashboard/ui/dashboard/filterWidget.dart';
import 'package:mg_dashboard/ui/widgets/customText.dart';
import 'package:mg_dashboard/ui/widgets/loadingCircle.dart';
import 'package:mg_dashboard/ui/widgets/sliverAppBarDeligate.dart';
import 'package:mg_dashboard/utils/colorConst.dart';
import 'package:mg_dashboard/utils/extensions.dart';
import 'package:mg_dashboard/utils/fontConst.dart';

class ReviewedPatientsScreen extends StatefulWidget {
  const ReviewedPatientsScreen({super.key});

  @override
  State<ReviewedPatientsScreen> createState() => _ReviewedPatientsScreenState();
}

class _ReviewedPatientsScreenState extends State<ReviewedPatientsScreen> {
  bool _isVisible = false;
  bool isLoading = false;
  List<ReviewedPatientsModel> dataList = [];

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    getData(context);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Row(
          children: [
            Expanded(
              child: CustomText(
                'Review Patients',
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
      body: SingleChildScrollView(
        child: Column(
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
              child: CustomScrollView(
                slivers: [
                  SliverPersistentHeader(
                    pinned: true,
                    delegate: SliverAppBarDelegate(
                      minHeight: 60.0,
                      maxHeight: 60.0,
                      child: Column(
                        children: [
                          Container(
                            margin: const EdgeInsets.symmetric(horizontal: 2),
                            padding: const EdgeInsets.all(8.0),
                            color: ColorConst.primaryColor,
                            child: const Row(
                              children: [
                                SizedBox(
                                  width: 45,
                                  child: CustomText(
                                    "Sl",
                                    textColor: ColorConst.primaryFont,
                                    fontWeight: FontWeight.bold,
                                  ),
                                ),
                                Expanded(
                                  flex: 2,
                                  child: CustomText(
                                    "Doctor Name",
                                    textColor: ColorConst.primaryFont,
                                    fontWeight: FontWeight.bold,
                                    textAlign: TextAlign.start,
                                  ),
                                ),
                                Expanded(
                                  child: CustomText(
                                    "Department",
                                    textColor: ColorConst.primaryFont,
                                    fontWeight: FontWeight.bold,
                                    textAlign: TextAlign.end,
                                  ),
                                ),
                                Expanded(
                                  child: CustomText(
                                    "Amount",
                                    textColor: ColorConst.primaryFont,
                                    fontWeight: FontWeight.bold,
                                    textAlign: TextAlign.end,
                                  ),
                                ),
                              ],
                            ),
                          ),
                          Container(
                            margin: const EdgeInsets.symmetric(horizontal: 2),
                            padding: const EdgeInsets.symmetric(
                                horizontal: 8.0, vertical: 4),
                            color: ColorConst.secondaryColor,
                            child: Row(
                              children: [
                                const SizedBox(
                                  width: 45,
                                  child: CustomText(
                                    "",
                                    textColor: ColorConst.primaryFont,
                                    fontWeight: FontWeight.bold,
                                  ),
                                ),
                                const Expanded(
                                  flex: 2,
                                  child: CustomText(
                                    "Total",
                                    fontWeight: FontWeight.bold,
                                  ),
                                ),
                                Expanded(
                                  child: CustomText(
                                    dataList
                                        .fold(
                                            0.0,
                                            (sum, doctor) =>
                                                sum + (doctor.amount ?? 0))
                                        .toStringAsFixed(0),
                                    fontWeight: FontWeight.bold,
                                    textAlign: TextAlign.end,
                                  ),
                                )
                              ],
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                  SliverList(
                    delegate: SliverChildBuilderDelegate(
                      childCount: 1,
                      (context, position) {
                        return isLoading
                            ? Container(
                                padding: const EdgeInsets.all(190),
                                child: Center(child: LoadingCircle()),
                              )
                            : dataList.isNotEmpty
                                ? ListView.builder(
                                    shrinkWrap: true,
                                    itemCount: dataList.length,
                                    physics:
                                        const NeverScrollableScrollPhysics(),
                                    itemBuilder: (context, index) {
                                      ReviewedPatientsModel model =
                                          dataList[index];

                                      return InkWell(
                                        child: Container(
                                          color: Colors.white,
                                          margin: const EdgeInsets.symmetric(
                                              horizontal: 5, vertical: 2),
                                          padding: const EdgeInsets.all(8),
                                          child: Row(
                                            children: [
                                              SizedBox(
                                                width: 45,
                                                child: CustomText(
                                                  "${index + 1}) ",
                                                ),
                                              ),
                                              Expanded(
                                                flex: 2,
                                                child: CustomText(
                                                  model.doctorName,
                                                  textAlign: TextAlign.start,
                                                ),
                                              ),
                                              Expanded(
                                                child: CustomText(
                                                  model.departmentName,
                                                  textAlign: TextAlign.end,
                                                ),
                                              ),
                                              Expanded(
                                                  child: CustomText(
                                                model.amount!
                                                    .toStringAsFixed(0),
                                                textAlign: TextAlign.end,
                                              )),
                                            ],
                                          ),
                                        ),
                                      );
                                    },
                                  )
                                : const Center(
                                    child: Padding(
                                      padding: EdgeInsets.only(top: 200),
                                      child: CustomText(
                                        'No data to show!',
                                        textColor: ColorConst.primaryText,
                                      ),
                                    ),
                                  );
                      },
                    ),
                  )
                ],
              ),
            )
          ],
        ),
      ),
    );
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

    var data = await DashboardRepo.getReviewedPatients(jsonData, context);
    if (!data.$1) {
      dataList = data.$2;
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
