import 'package:flutter/material.dart';
import 'package:mg_dashboard/models/currentIpModel.dart';
import 'package:mg_dashboard/ui/dashboard/dashboardRepo/dashboardRepo.dart';
import 'package:mg_dashboard/ui/dashboard/filterWidget.dart';
import 'package:mg_dashboard/ui/widgets/customText.dart';
import 'package:mg_dashboard/ui/widgets/loadingCircle.dart';
import 'package:mg_dashboard/ui/widgets/sliverAppBarDeligate.dart';
import 'package:mg_dashboard/utils/colorConst.dart';
import 'package:mg_dashboard/utils/extensions.dart';
import 'package:mg_dashboard/utils/fontConst.dart';

class CurrentIpScreen extends StatefulWidget {
  const CurrentIpScreen({super.key});

  @override
  State<CurrentIpScreen> createState() => _CurrentIpScreenState();
}

class _CurrentIpScreenState extends State<CurrentIpScreen> {
  bool _isVisible = false;
  bool isLoading = false;
  List<CurrentIpModel> dataList = [];

  @override
  void initState() {
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
                'Current IP',
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
                      minHeight: 36.0,
                      maxHeight: 36.0,
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
                                  flex: 4,
                                  child: CustomText(
                                    "Doctor Name",
                                    textColor: ColorConst.primaryFont,
                                    fontWeight: FontWeight.bold,
                                    textAlign: TextAlign.start,
                                  ),
                                ),
                                Expanded(
                                  flex: 2,
                                  child: CustomText(
                                    "Patient Name",
                                    textColor: ColorConst.primaryFont,
                                    fontWeight: FontWeight.bold,
                                    textAlign: TextAlign.start,
                                  ),
                                ),
                                Expanded(
                                  child: CustomText(
                                    "Room",
                                    textColor: ColorConst.primaryFont,
                                    fontWeight: FontWeight.bold,
                                    textAlign: TextAlign.start,
                                  ),
                                ),
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
                                      CurrentIpModel model = dataList[index];

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
                                                flex: 4,
                                                child: CustomText(
                                                  model.doctorName,
                                                  textAlign: TextAlign.start,
                                                ),
                                              ),
                                              Expanded(
                                                flex: 2,
                                                child: CustomText(
                                                  model.patName,
                                                  textAlign: TextAlign.start,
                                                ),
                                              ),
                                              Expanded(
                                                child: CustomText(
                                                  model.roomNo,
                                                  textAlign: TextAlign.start,
                                                ),
                                              ),
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

    var data = await DashboardRepo.getCurrentIp(context);
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
