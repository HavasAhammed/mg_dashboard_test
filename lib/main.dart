import 'package:flutter/material.dart';
import 'package:mg_dashboard/provider/appProvider.dart';
import 'package:mg_dashboard/ui/dashboard/dashboardScreen.dart';
import 'package:provider/provider.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [
        ChangeNotifierProvider(create: (context) => AppProvider()),
      ],
      child: MaterialApp(
        debugShowCheckedModeBanner: false,
        title: 'Dashboard',
        theme: ThemeData(
          appBarTheme: AppBarTheme.of(context).copyWith(color: Colors.white),
          cardTheme: CardTheme.of(context).copyWith(color: Colors.white),
          buttonTheme: ButtonTheme.of(context).copyWith(
            buttonColor: Colors.white,
            focusColor: Colors.white,
          ),
          colorScheme: ColorScheme.fromSeed(seedColor: Colors.deepPurple),
          useMaterial3: true,
        ),
        home: const Dashboardscreen(),
      ),
    );
  }
}
