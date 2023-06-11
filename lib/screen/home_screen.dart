import 'package:flutter/material.dart';
import 'package:mask_app/component/main_appbar.dart';
import 'package:mask_app/component/main_drawer.dart';
import 'package:mask_app/component/main_stat.dart';
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
                Card(
                  margin: const EdgeInsets.symmetric(horizontal: 8),
                  shape: const RoundedRectangleBorder(
                      borderRadius: BorderRadius.all(Radius.circular(16))),
                  color: lightColor,
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.stretch,
                    children: [
                      Container(
                        decoration: const BoxDecoration(
                          borderRadius: BorderRadius.only(
                            topLeft: Radius.circular(16),
                            topRight: Radius.circular(16),
                          ),
                          color: darkColor,
                        ),
                        child: const Padding(
                          padding: EdgeInsets.all(4.0),
                          child: Text(
                            '종류별 통계',
                            textAlign: TextAlign.center,
                            style: TextStyle(
                                color: Colors.white,
                                fontWeight: FontWeight.bold),
                          ),
                        ),
                      ),
                      const Row(
                        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                        children: [
                          MainStat(
                            category: '미세먼지',
                            imgPath: 'asset/img/best.png',
                            level: '최고',
                            stat: '0㎛/m',
                          ),
                          MainStat(
                            category: '미세먼지',
                            imgPath: 'asset/img/best.png',
                            level: '최고',
                            stat: '0㎛/m',
                          ),
                          MainStat(
                            category: '미세먼지',
                            imgPath: 'asset/img/best.png',
                            level: '최고',
                            stat: '0㎛/m',
                          )
                        ],
                      )
                    ],
                  ),
                )
              ],
            ),
          )
        ],
      ),
    );
  }
}
