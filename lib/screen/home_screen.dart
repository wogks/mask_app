import 'package:flutter/material.dart';
import 'package:mask_app/component/category_card.dart';
import 'package:mask_app/component/hourly_card.dart';
import 'package:mask_app/component/main_appbar.dart';
import 'package:mask_app/component/main_drawer.dart';
import 'package:mask_app/const/colors.dart';

class HomeScreen extends StatelessWidget {
  const HomeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return const Scaffold(
      backgroundColor: primaryColor,
      drawer: MainDrawer(),
      body: CustomScrollView(
        slivers: [
          MainAppBar(),
          SliverToBoxAdapter(
            child: Column(
              children: [
                CategoryCard(),
                SizedBox(height: 16),
                HourlyCard(),
              ],
            ),
          )
        ],
      ),
    );
  }
}
