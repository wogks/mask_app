import 'package:flutter/material.dart';
import 'package:mask_app/component/category_card.dart';
import 'package:mask_app/component/hourly_card.dart';
import 'package:mask_app/component/main_appbar.dart';
import 'package:mask_app/component/main_drawer.dart';
import 'package:mask_app/const/colors.dart';
import 'package:mask_app/repository/stat_repository.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  @override
  void initState() {
    fetchData();
    super.initState();
  }

  fetchData() async {
    final statModels = await StatRepository.fetchData();
    print(statModels);
  }

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
