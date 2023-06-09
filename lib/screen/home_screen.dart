import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:hive_flutter/hive_flutter.dart';
import 'package:mask_app/component/category_card.dart';
import 'package:mask_app/component/hourly_card.dart';
import 'package:mask_app/component/main_appbar.dart';
import 'package:mask_app/component/main_drawer.dart';
import 'package:mask_app/const/regions.dart';
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

  Future<void> fetchData() async {
    try {
      final now = DateTime.now();
      final fetchTime = DateTime(
        now.year,
        now.month,
        now.day,
        now.hour,
      );
      final box = Hive.box<StatModel>(ItemCode.PM10.name);

      if (box.values.isNotEmpty &&
          (box.values.last).dataTime.isAtSameMomentAs(fetchTime)) {
        print('이미 최핀');
        return;
      }
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

        final box = Hive.box<StatModel>(key.name);

        for (StatModel stat in value) {
          box.put(stat.dataTime.toString(), stat);
        }

        final allKeys = box.keys.toList();

        if (allKeys.length > 24) {
          //start = 시작 인덱스 end = 끝 인덱스
          final deleteKeys = allKeys.sublist(0, allKeys.length - 24);

          box.deleteAll(deleteKeys);
        }
      }
    } on DioError catch (e) {
      ScaffoldMessenger.of(context)
          .showSnackBar(SnackBar(content: Text('인터넷 연결이 원활하지 않습니다.$e')));
    }
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
    return ValueListenableBuilder<Box>(
      valueListenable: Hive.box<StatModel>(ItemCode.PM10.name).listenable(),
      builder: (context, box, child) {
        if (box.values.isEmpty) {
          return const Center(
            child: CircularProgressIndicator(),
          );
        }
        final stat = (box.values.toList().last as StatModel);
        final status = DataUtils.getCurrentStatusFromStat(
          itemCode: ItemCode.PM10,
          value: stat.getLevelFromRegion(region),
        );

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
              child: RefreshIndicator(
                onRefresh: () async {
                  await fetchData();
                },
                child: CustomScrollView(
                  controller: scrollController,
                  slivers: [
                    MainAppBar(
                      isExpanded: isExpanded,
                      region: region,
                      status: status,
                      stat: stat,
                      dateTime: stat.dataTime,
                    ),
                    SliverToBoxAdapter(
                      child: Column(
                        children: [
                          CategoryCard(
                            region: region,
                            darkColor: status.darkColor,
                            lightColor: status.lightColor,
                          ),
                          const SizedBox(height: 16),
                          ...ItemCode.values.map((itemCode) {
                            return Padding(
                              padding: const EdgeInsets.only(bottom: 8.0),
                              child: HourlyCard(
                                itemCode: itemCode,
                                region: region,
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
              ),
            ));
      },
    );
  }
}
