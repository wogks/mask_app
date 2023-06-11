import 'package:flutter/material.dart';
import 'package:mask_app/component/card_title.dart';
import 'package:mask_app/component/category_card.dart';
import 'package:mask_app/component/main_appbar.dart';
import 'package:mask_app/component/main_card.dart';
import 'package:mask_app/component/main_drawer.dart';
import 'package:mask_app/const/colors.dart';

class HomeScreen extends StatelessWidget {
  const HomeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: primaryColor,
      drawer: const MainDrawer(),
      body: CustomScrollView(
        slivers: [
          const MainAppBar(),
          SliverToBoxAdapter(
            child: Column(
              children: [
                const CategoryCard(),
                const SizedBox(height: 16),
                MainCard(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.stretch,
                    children: [
                      const CardTitle(
                        title: '시간별 미세먼지',
                      ),
                      Column(
                        children: List.generate(24, (index) {
                          final now = DateTime.now();
                          final hour = now.hour;
                          int currentHour = hour - index;
                          if (currentHour < 0) {
                            currentHour += 24;
                          }
                          return Padding(
                            padding: const EdgeInsets.symmetric(
                                horizontal: 8.0, vertical: 4),
                            child: Row(
                              children: [
                                Expanded(child: Text('$currentHour시')),
                                Expanded(
                                    child: Image.asset('asset/img/good.png',
                                        height: 20)),
                                const Expanded(
                                    child: Text(
                                  '좋음',
                                  textAlign: TextAlign.right,
                                )),
                              ],
                            ),
                          );
                        }).toList(),
                      )
                    ],
                  ),
                ),
              ],
            ),
          )
        ],
      ),
    );
  }
}
