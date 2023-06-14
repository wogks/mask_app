import 'package:flutter/material.dart';
import 'package:mask_app/component/category_card.dart';
import 'package:mask_app/component/hourly_card.dart';
import 'package:mask_app/component/main_appbar.dart';
import 'package:mask_app/component/main_drawer.dart';
import 'package:mask_app/const/regions.dart';
import 'package:mask_app/model/stat_and_status_model.dart';
import 'package:mask_app/model/stat_model.dart';
import 'package:mask_app/repository/stat_repository.dart';
import 'package:mask_app/utils/data_utils.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  String region = regions[0];
  bool isExpanded = true;
  ScrollController scrollController = ScrollController();

  Future<Map<ItemCode, List<StatModel>>> fetchData() async {
    Map<ItemCode, List<StatModel>> stats = {};
    List<Future> futures = [];
    for (ItemCode itemCode in ItemCode.values) {
      //await를 걸지 않는다
      futures.add(StatRepository.fetchData(
        itemCode: itemCode,
      ));
    }
    //리스트 안에 future를 모아서 한번에 기다린다, 리스트안에 값을 넣은 순서대로 값을 받을수 있다
    final results = await Future.wait(futures);

    //결과값 받는법
    for (var i = 0; i < results.length; i++) {
      final key = ItemCode.values[i];
      final value = results[i];
      stats.addAll({key: value});
    }

    return stats;
  }

  scrollListener() {
    bool isExpanded = scrollController.offset < 500 - kToolbarHeight;

    if (isExpanded != this.isExpanded) {
      setState(() {
        this.isExpanded = isExpanded;
      });
    }
  }

  @override
  void initState() {
    scrollController.addListener(scrollListener);
    super.initState();
  }

  @override
  void dispose() {
    scrollController.removeListener(scrollListener);
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return FutureBuilder<Map<ItemCode, List<StatModel>>>(
        future: fetchData(),
        builder: (context, snapshot) {
          if (snapshot.hasError) {
            return const Scaffold(
              body: Center(
                child: Text('에러가 있습니다'),
              ),
            );
          }
          if (!snapshot.hasData) {
            return const Scaffold(
              body: Center(
                child: CircularProgressIndicator(),
              ),
            );
          }

          Map<ItemCode, List<StatModel>> stats = snapshot.data!;
          StatModel pm10RecentStat = stats[ItemCode.PM10]![0];
          final status = DataUtils.getCurrentStatusFromStat(
            itemCode: ItemCode.PM10,
            value: pm10RecentStat.seoul,
          );
          final ssModel = stats.keys.map((key) {
            final value = stats[key]!;
            final stat = value[0];
            return StatAndStatusModel(
              itemCode: key,
              status: DataUtils.getCurrentStatusFromStat(
                value: stat.getLevelFromRegion(region),
                itemCode: key,
              ),
              stat: stat,
            );
          }).toList();
          return Scaffold(
              drawer: MainDrawer(
                darkColor: status.darkColor,
                lightColor: status.lightColor,
                selectedRegion: region,
                onRegionTap: (region) {
                  setState(() {
                    this.region = region;
                    Navigator.of(context).pop();
                  });
                },
              ),
              body: Container(
                color: status.primaryColor,
                child: CustomScrollView(
                  controller: scrollController,
                  slivers: [
                    MainAppBar(
                      isExpanded: isExpanded,
                      region: region,
                      status: status,
                      stat: pm10RecentStat,
                      dateTime: pm10RecentStat.dataTime,
                    ),
                    SliverToBoxAdapter(
                      child: Column(
                        children: [
                          CategoryCard(
                            models: ssModel,
                            region: region,
                            darkColor: status.darkColor,
                            lightColor: status.lightColor,
                          ),
                          const SizedBox(height: 16),
                          ...stats.keys.map((itemCode) {
                            final stat = stats[itemCode];
                            return Padding(
                              padding: const EdgeInsets.only(bottom: 8.0),
                              child: HourlyCard(
                                region: region,
                                stats: stat!,
                                category: DataUtils.itemCodeKrString(
                                    itemCode: itemCode),
                                darkColor: status.darkColor,
                                lightColor: status.lightColor,
                              ),
                            );
                          }).toList(),
                          const SizedBox(height: 32),
                        ],
                      ),
                    )
                  ],
                ),
              ));
        });
  }
}
