import 'package:flutter/material.dart';
import 'package:hive/hive.dart';
import 'package:mg_dashboard/ui/dashboard/dashboardScreen.dart';
import 'package:mg_dashboard/ui/widgets/customText.dart';
import 'package:mg_dashboard/utils/colorConst.dart';
import 'package:mg_dashboard/utils/fontConst.dart';

class UrlScreen extends StatefulWidget {
  const UrlScreen({super.key});

  @override
  State<UrlScreen> createState() => _UrlScreenState();
}

class _UrlScreenState extends State<UrlScreen> {
  final formKey = GlobalKey<FormState>();
  TextEditingController urlController = TextEditingController();
  final box = Hive.box('settingsBox');

  @override
  void initState() {
    super.initState();
    urlController.text = box.get('baseUrl', defaultValue: '');
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        title: CustomText(
          'URL',
          fontSize: appBarTextFont,
        ),
      ),
      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 24),
        child: Form(
          key: formKey,
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const Text('Enter URL :'),
              const SizedBox(
                height: 8,
              ),
              TextFormField(
                controller: urlController,
                validator: (value) {
                  if (value!.isEmpty || value == '') {
                    return 'Please enter a valid URL';
                  }
                  return null;
                },
                decoration: const InputDecoration(
                  hintText: 'Enter your URL here',
                  hintStyle: TextStyle(
                    fontSize: 14,
                    color: Colors.black45,
                  ),
                ),
              ),
              const SizedBox(
                height: 20,
              ),
              Center(
                child: GestureDetector(
                  onTap: () {
                    final form = formKey.currentState;
                    if (form!.validate()) {
                      box.put('baseUrl', urlController.text);
                      Navigator.pushReplacement(
                        context,
                        MaterialPageRoute(
                          builder: (context) => const Dashboardscreen(),
                        ),
                      );
                    }
                  },
                  child: Container(
                    height: 48,
                    width: MediaQuery.of(context).size.width / 3,
                    decoration: BoxDecoration(
                      color: ColorConst.primaryFont,
                      borderRadius: BorderRadius.circular(8),
                    ),
                    child: const Center(
                      child: Text(
                        'Continue',
                        style: TextStyle(
                          color: ColorConst.secondaryText,
                          fontWeight: FontWeight.w500,
                        ),
                      ),
                    ),
                  ),
                ),
              )
            ],
          ),
        ),
      ),
    );
  }
}
