import 'package:flutter/material.dart';
import 'package:flutter_hive_database/hive_database/home_screen.dart';
import 'package:get/get.dart';

class WelcomePage extends StatefulWidget {
  const WelcomePage({super.key});

  @override
  State<WelcomePage> createState() => _WelcomePageState();
}

class _WelcomePageState extends State<WelcomePage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Welcome'),
      ),
      body: Align(
        alignment: Alignment.center,
        child: Padding(
          padding: const EdgeInsets.only(top: 20.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              const Text(
                "Welcome To My App",
                style: TextStyle(fontSize: 16.0, fontWeight: FontWeight.w600),
              ),
              const SizedBox(
                height: 20.0,
              ),
              ElevatedButton(
                  onPressed: () {
                    Get.to(() => const HomeScreen());
                  },
                  child: const Text('Hive Database')),
              ElevatedButton(
                  onPressed: () {
                   // Get.to(() => const HomeScreen());
                  },
                  child: const Text('SQFLite Database')),
            ],
          ),
        ),
      ),
    );
  }
}
