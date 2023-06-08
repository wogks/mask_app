import 'package:flutter/material.dart';
import 'package:mask_app/component/main_appbar.dart';
import 'package:mask_app/const/colors.dart';

class HomeScreen extends StatelessWidget {
  const HomeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return const Scaffold(
      backgroundColor: primaryColor,
      body: CustomScrollView(
        slivers: [
          MainAppBar(),
        ],
      ),
    );
  }
}
