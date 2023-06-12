import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:mask_app/component/category_card.dart';
import 'package:mask_app/component/hourly_card.dart';
import 'package:mask_app/component/main_appbar.dart';
import 'package:mask_app/component/main_drawer.dart';
import 'package:mask_app/const/colors.dart';
import 'package:mask_app/model/stat_model.dart';

import '../const/data.dart';

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
    final response = await Dio().get(
      'http://apis.data.go.kr/B552584/ArpltnStatsSvc/getCtprvnMesureLIst',
      queryParameters: {
        'serviceKey': serviceKey,
        'returnType': 'json',
        'numOfRows': 30,
        'pageNo': 1,
        'itemCode': 'PM10',
        'year': 2023,
        'dataGubun': 'HOUR',
        'searchCondition': 'WEEK',
      },
    );

    print(
      response.data['response']['body']['items'].map(
        (item) => StatModel.fromJson(json: item),
      ),
    );
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
