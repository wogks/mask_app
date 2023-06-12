import 'package:flutter/material.dart';
import 'package:mask_app/component/category_card.dart';
import 'package:mask_app/component/hourly_card.dart';
import 'package:mask_app/component/main_appbar.dart';
import 'package:mask_app/component/main_drawer.dart';
import 'package:mask_app/const/colors.dart';
import 'package:mask_app/const/status_level.dart';
import 'package:mask_app/model/stat_model.dart';
import 'package:mask_app/repository/stat_repository.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  Future<List<StatModel>> fetchData() async {
    final statModels = await StatRepository.fetchData();
    return statModels;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: primaryColor,
      drawer: const MainDrawer(),
      body: FutureBuilder<List<StatModel>>(
          future: fetchData(),
          builder: (context, snapshot) {
            if (snapshot.hasError) {
              return const Center(
                child: Text('에러가 있습니다'),
              );
            }
            if (!snapshot.hasData) {
              return const Center(
                child: CircularProgressIndicator(),
              );
            }

            List<StatModel> stats = snapshot.data!;
            StatModel recentStat = stats[0];
            final status = statusLevel
                .where((element) => element.minFineDust < recentStat.seoul)
                .last;
            print(recentStat.seoul);
            return CustomScrollView(
              slivers: [
                MainAppBar(
                  status: status,
                  stat: recentStat,
                ),
                const SliverToBoxAdapter(
                  child: Column(
                    children: [
                      CategoryCard(),
                      SizedBox(height: 16),
                      HourlyCard(),
                    ],
                  ),
                )
              ],
            );
          }),
    );
  }
}
