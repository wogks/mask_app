import 'package:flutter/material.dart';
import 'package:hive_flutter/hive_flutter.dart';
import 'package:mask_app/model/stat_model.dart';
import 'package:mask_app/screen/home_screen.dart';

const testBox = 'test';

void main() async {
  //플러터를 초화한다
  await Hive.initFlutter();

  //제너릭에 등록할 아답터의 클래스를 넣는다
  Hive.registerAdapter<StatModel>(StatModelAdapter());
  Hive.registerAdapter<ItemCode>(ItemCodeAdapter());

  for (ItemCode itemCode in ItemCode.values) {
    await Hive.openBox<StatModel>(itemCode.name);
  }

  //어떤박스를 열지 정한다.
  await Hive.openBox('test');
  runApp(
    MaterialApp(
      theme: ThemeData(fontFamily: 'sunflower'),
      home: const HomeScreen(),
    ),
  );
}
