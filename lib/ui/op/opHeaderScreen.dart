import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:mg_dashboard/data/urls.dart';
import 'package:mg_dashboard/models/opHdrModel.dart';
import 'package:mg_dashboard/provider/appProvider.dart';
import 'package:mg_dashboard/ui/cash/cashDtlScreen.dart';
import 'package:mg_dashboard/ui/dashboard/DashboardRepo/DashboardRepo.dart';
import 'package:mg_dashboard/ui/dashboard/filterWidget.dart';
import 'package:mg_dashboard/ui/widgets/customText.dart';
import 'package:mg_dashboard/ui/widgets/loadingCircle.dart';
import 'package:mg_dashboard/ui/widgets/sliverAppBarDeligate.dart';
import 'package:mg_dashboard/utils/colorConst.dart';
import 'package:mg_dashboard/utils/extensions.dart';
import 'package:mg_dashboard/utils/fontConst.dart';

class OpHdrScreen extends StatefulWidget {
  const OpHdrScreen({super.key});

  @override
  State<OpHdrScreen> createState() => _OpHdrScreenState();
}

class _OpHdrScreenState extends State<OpHdrScreen> {
  bool _isVisible = false;
  bool isLoading = false;
  List<OpHdrModel> dataList = [];

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
              "Op Header",
              fontSize: appBarTextFont,
            )),
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
          child: SingleChildScrollView(
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
              // width: screenWidth,
              child: CustomScrollView(
                slivers: [
                  SliverMainAxisGroup(
                    slivers: [
                      SliverPersistentHeader(
                        pinned: true, // Keeps the header pinned at the top
                        delegate: SliverAppBarDelegate(
                          minHeight: 60.0,
                          maxHeight: 60.0,
                          child: Column(
                            children: [
                              Container(
                                margin:
                                    const EdgeInsets.symmetric(horizontal: 2),
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
                                        )),
                                    Expanded(
                                        flex: 2,
                                        child: CustomText(
                                          "Doctor Name",
                                          textColor: ColorConst.primaryFont,
                                          fontWeight: FontWeight.bold,
                                          textAlign: TextAlign.start,
                                        )),
                                    Expanded(
                                        child: CustomText(
                                      "Op Count",
                                      textColor: ColorConst.primaryFont,
                                      fontWeight: FontWeight.bold,
                                      textAlign: TextAlign.end,
                                    )),
                                    Expanded(
                                        child: CustomText(
                                      "Amount",
                                      textColor: ColorConst.primaryFont,
                                      fontWeight: FontWeight.bold,
                                      textAlign: TextAlign.end,
                                    )),
                                  ],
                                ),
                              ),
                              Container(
                                margin:
                                    const EdgeInsets.symmetric(horizontal: 2),
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
                                        )),
                                    const Expanded(
                                        flex: 2,
                                        child: CustomText(
                                          "Total",
                                          fontWeight: FontWeight.bold,
                                        )),
                                    Expanded(
                                      child: CustomText(
                                        dataList
                                            .fold(
                                                0.0,
                                                (sum, doctor) =>
                                                    sum + (doctor.opCount ?? 0))
                                            .toStringAsFixed(0),
                                        fontWeight: FontWeight.bold,
                                        textAlign: TextAlign.end,
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
                              )
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
                                : ListView.builder(
                                    shrinkWrap: true,
                                    itemCount: dataList.length,
                                    physics:
                                        const NeverScrollableScrollPhysics(),
                                    itemBuilder: (context, index) {
                                      OpHdrModel model = dataList[index];

                                      return InkWell(
                                        onTap: () {
                                          Navigator.push(
                                              context,
                                              MaterialPageRoute(
                                                  builder: (context) =>
                                                      CashDtlScreen(
                                                          model.idDoctor!,
                                                          model.doctorName!,
                                                          Urls.getTotalIncomeDetails)));
                                        },
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
                                                  model.opCount.toString(),
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
                                  );
                          },
                        ),
                      )
                    ],
                  ),
                ],
              ),
            )
          ],
        ),
      )),
    );
  }

  getData(BuildContext context) async {
    isLoading = true;
    setState(() {});
    var jsonData = jsonEncode({
      "jsonData": {
        "dashDetailModel": {
          "fromDate": AppProvider.of(context).fromDate.toIso8601String(),
          "toDate": AppProvider.of(context).toDate.toIso8601String(),
          "idAccount": AppProvider.of(context).dashboardModel.opId
        }
      }
    });

    var data = await DashboardRepo.getTotalOpHdr(jsonData, context);
    if (!data.$1) {
      dataList = data.$2;
      Map<int, OpHdrModel> uniqueProductsMap = dataList
          .fold(<int, OpHdrModel>{}, (Map<int, OpHdrModel> map, product) {
        if (map.containsKey(product.idDoctor)) {
          // Increment opCount directly
          map[product.idDoctor]!.opCount =
              (map[product.idDoctor]!.opCount ?? 0) + (product.opCount ?? 0);
          map[product.idDoctor]!.amount =
              (map[product.idDoctor]!.amount ?? 0) + (product.amount ?? 0);
        } else {
          map[product.idDoctor!] = product;
        }
        return map;
      });

      // Convert the map to a list if you need a list output
      dataList = uniqueProductsMap.values.toList();
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
