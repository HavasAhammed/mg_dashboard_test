// import 'package:flutter/material.dart';
// import 'package:get/get.dart';
//
// class Responsive extends StatelessWidget {
//   final Widget mobile;
//   final Widget tablet;
//   final Widget web;
//
//   const Responsive({
//     Key? key,
//     required this.mobile,
//     required this.tablet,
//     required this.web,
//   }) : super(key: key);
//
//   // This isMobile, isTablet, isDesktop help us later
//   static bool isMobile({bool isDevice = false}) => isDevice
//       ? (PlatF.isMobile)
//       : (GetPlatform.isMobile || getWidth() < 650);
//
//   static bool isTablet() => Get.width < 1100 && Get.width >= 650;
//
//   static bool isWeb({bool isKWeb = false}) {
//     bool web = (GetPlatform.isWindows || GetPlatform.isWeb || GetPlatform.isMacOS);
//     return isKWeb
//         ? web
//         : MediaQuery.of(Get.context!).size.width >= 1100 &&
//             (GetPlatform.isWindows || GetPlatform.isWeb || GetPlatform.isMacOS);
//   }
//   // checkTab ? (Get.width >= 1100 || Responsive.isTablet()) : Get.width >= 1100 ;
//   // Get.width >= 1100 ;
//
//   static double width() => Get.width;
//
//   static double height() => Get.height;
//
//   static double getDrawerWidth() => Responsive.isWeb(isKWeb: false)
//       ? Responsive.width() / 1.4
//       : Responsive.width() / 1.15;
//
//   // static bool isBigScreenPhone(BuildContext context) =>
//   //     MediaQuery.of(context).size.width >= 750;
//
//   @override
//   Widget build(BuildContext context) {
//     return LayoutBuilder(
//       // If our width is more than 1100 then we consider it a desktop
//       builder: (context, constraints) {
//         if (constraints.maxWidth >= 1100) {
//           return web;
//         }
//         // If width it less then 1100 and more then 650 we consider it as tablet
//         else if (constraints.maxWidth >= 650) {
//           return tablet;
//         }
//         // Or less then that we called it mobile
//         else {
//           return mobile;
//         }
//       },
//     );
//   }
// }
