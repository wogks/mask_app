import 'package:flutter/material.dart';
import 'package:hive_flutter/hive_flutter.dart';
import 'package:mask_app/main.dart';

class TestScreen extends StatefulWidget {
  const TestScreen({super.key});

  @override
  State<TestScreen> createState() => _TestScreenState();
}

class _TestScreenState extends State<TestScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          const Text(
            'test',
            textAlign: TextAlign.center,
          ),
          ElevatedButton(
            onPressed: () {
              final box = Hive.box(testBox);
              print('keys = ${box.keys.toList()}');
              print('values = ${box.values.toList()}');
            },
            child: const Text('박스 프린트하기'),
          ),
          ElevatedButton(
              onPressed: () {
                final box = Hive.box(testBox);
                // box.add('테스트1');
                //put:데이터를 생성하거나 업데이트할때
                box.put(0, '테스트3');
              },
              child: const Text('데이터 넣기!')),
          ElevatedButton(
              onPressed: () {
                final box = Hive.box(testBox);

                print(box.get(100));
              },
              child: const Text('특정값 가져오기')),
        ],
      ),
    );
  }
}
