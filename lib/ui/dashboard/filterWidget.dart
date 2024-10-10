// ignore_for_file: must_be_immutable

import 'package:flutter/material.dart';
import 'package:mg_dashboard/provider/appProvider.dart';
import 'package:mg_dashboard/ui/widgets/customText.dart';
import 'package:mg_dashboard/utils/colorConst.dart';
import 'package:mg_dashboard/utils/dateTimeUtils.dart';
import 'package:mg_dashboard/utils/extensions.dart';
import 'package:provider/provider.dart';

class FilterWidget extends StatelessWidget {
  FilterWidget({super.key, required this.isVisible, required this.onSelected});

  bool isVisible = false;
  void Function() onSelected;

  @override
  Widget build(BuildContext context) {
    return Consumer<AppProvider>(builder: (context, provider, child) {
      return AnimatedContainer(
        duration: const Duration(milliseconds: 500),
        curve: Curves.easeInOut,
        height: isVisible ? 80 : 0, // Animate the height
        color: ColorConst.secondaryColor,
        child: isVisible
            ? Card(
                color: ColorConst.secondaryColor,
                child: Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Wrap(
                    children: [
                      Row(
                        children: [
                          Expanded(
                            flex: 2,
                            child: InkWell(
                              onTap: () {
                                provider.setDate(
                                    DateTimeUtils.getFromDate(calenderTypeDay),
                                    DateTime.now(),
                                    calenderTypeDay);
                                onSelected();
                              },
                              child: Padding(
                                padding: const EdgeInsets.all(2.0),
                                child: Material(
                                  color:
                                      provider.calenderType == calenderTypeDay
                                          ? Colors.blue[900]
                                          : Colors.blue[100],
                                  shape: RoundedRectangleBorder(
                                      borderRadius: BorderRadius.circular(5)),
                                  child: Padding(
                                    padding: const EdgeInsets.all(2.0),
                                    child: Material(
                                      elevation: 0,
                                      color: Colors.blue[100],
                                      shape: RoundedRectangleBorder(
                                        borderRadius: BorderRadius.circular(5),
                                      ),
                                      child: Padding(
                                        padding: const EdgeInsets.all(8.0),
                                        child: Center(
                                          child: CustomText(
                                            "Today",
                                            textColor: Colors.blue[900],
                                          ),
                                        ),
                                      ),
                                    ),
                                  ),
                                ),
                              ),
                            ),
                          ),
                          Expanded(
                            flex: 3,
                            child: InkWell(
                              onTap: () {
                                provider.setDate(
                                    DateTimeUtils.getFromDate(calenderTypeWeek),
                                    DateTime.now(),
                                    calenderTypeWeek);
                                onSelected();
                              },
                              child: Padding(
                                padding: const EdgeInsets.all(2.0),
                                child: Material(
                                  color:
                                      provider.calenderType == calenderTypeWeek
                                          ? Colors.blue[900]
                                          : Colors.blue[100],
                                  shape: RoundedRectangleBorder(
                                      borderRadius: BorderRadius.circular(5)),
                                  child: Padding(
                                    padding: const EdgeInsets.all(2.0),
                                    child: Material(
                                      elevation: 0,
                                      color: Colors.blue[100],
                                      shape: RoundedRectangleBorder(
                                        borderRadius: BorderRadius.circular(5),
                                      ),
                                      child: Padding(
                                        padding: const EdgeInsets.all(8.0),
                                        child: Center(
                                          child: CustomText(
                                            "This Week",
                                            textColor: Colors.blue[900],
                                          ),
                                        ),
                                      ),
                                    ),
                                  ),
                                ),
                              ),
                            ),
                          ),
                          Expanded(
                            flex: 3,
                            child: InkWell(
                              onTap: () {
                                provider.setDate(
                                    DateTimeUtils.getFromDate(
                                        calenderTypeMonth),
                                    DateTime.now(),
                                    calenderTypeMonth);
                                onSelected();
                              },
                              child: Padding(
                                padding: const EdgeInsets.all(2.0),
                                child: Material(
                                  color:
                                      provider.calenderType == calenderTypeMonth
                                          ? Colors.blue[900]
                                          : Colors.blue[100],
                                  shape: RoundedRectangleBorder(
                                      borderRadius: BorderRadius.circular(4)),
                                  child: Padding(
                                    padding: const EdgeInsets.all(2.0),
                                    child: Material(
                                      elevation: 0,
                                      color: Colors.blue[100],
                                      shape: RoundedRectangleBorder(
                                        borderRadius: BorderRadius.circular(5),
                                      ),
                                      child: Padding(
                                        padding: const EdgeInsets.all(8.0),
                                        child: Center(
                                          child: CustomText(
                                            "This Month",
                                            textColor: Colors.blue[900],
                                          ),
                                        ),
                                      ),
                                    ),
                                  ),
                                ),
                              ),
                            ),
                          ),
                          Expanded(
                            flex: 2,
                            child: InkWell(
                              onTap: () async {
                                DateTime? fromDate =
                                    await DateTimeUtils.selectDate(
                                        context,
                                        provider.calenderType ==
                                                calenderTypeCustom
                                            ? provider.fromDate
                                            : DateTime.now(),
                                        helpText: "Select from date");
                                DateTime? toDate;
                                if (null != fromDate) {
                                  toDate = await DateTimeUtils.selectDate(
                                      context,
                                      provider.calenderType ==
                                              calenderTypeCustom
                                          ? provider.toDate
                                          : DateTime.now(),
                                      helpText: "Select to date");
                                }
                                if (null != fromDate && null != toDate) {
                                  // if(isDifferenceSixMonths(fromDate,toDate)) {
                                  provider.setDate(
                                      fromDate, toDate, calenderTypeCustom);
                                  onSelected();
                                  // }else{
                                  //   context.showSnackBar("Date must between 6 months");
                                  //
                                  // }
                                } else {}
                              },
                              child: Padding(
                                padding: const EdgeInsets.all(2.0),
                                child: Material(
                                  color: provider.calenderType ==
                                          calenderTypeCustom
                                      ? Colors.blue[900]
                                      : Colors.blue[100],
                                  shape: RoundedRectangleBorder(
                                      borderRadius: BorderRadius.circular(4)),
                                  child: Padding(
                                    padding: const EdgeInsets.all(2.0),
                                    child: Material(
                                      elevation: 0,
                                      color: Colors.blue[100],
                                      shape: RoundedRectangleBorder(
                                        borderRadius: BorderRadius.circular(5),
                                      ),
                                      child: Padding(
                                        padding: const EdgeInsets.all(8.0),
                                        child: Center(
                                          child: CustomText(
                                            "Custom",
                                            textColor: Colors.blue[900],
                                          ),
                                        ),
                                      ),
                                    ),
                                  ),
                                ),
                              ),
                            ),
                          ),
                        ],
                      ),
                      Center(
                          child: CustomText(
                        "${provider.fromDate.toString().toDateOnly()} - ${provider.toDate.toString().toDateOnly()}",
                        fontWeight: FontWeight.bold,
                        textColor: Colors.grey,
                      ))
                    ],
                  ),
                ),
              )
            : null,
      );
    });
  }
}
