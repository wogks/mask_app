import 'package:flutter/material.dart';
import 'package:hive_flutter/hive_flutter.dart';
import 'package:mask_app/component/card_title.dart';
import 'package:mask_app/component/main_card.dart';
import 'package:mask_app/model/stat_model.dart';
import 'package:mask_app/utils/data_utils.dart';

class HourlyCard extends StatelessWidget {
  final Color darkColor;
  final Color lightColor;
  final String region;
  final ItemCode itemCode;
  const HourlyCard({
    super.key,
    required this.darkColor,
    required this.lightColor,
    required this.region,
    required this.itemCode,
  });

  @override
  Widget build(BuildContext context) {
    return MainCard(
      backgroundcolor: lightColor,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          CardTitle(
              backgroundColor: darkColor,
              title: '시간별 ${DataUtils.itemCodeKrString(itemCode: itemCode)}'),
          ValueListenableBuilder<Box>(
            valueListenable: Hive.box<StatModel>(itemCode.name).listenable(),
            builder: (context, box, child) => Column(
                children: box.values.map((stat) {
              return renderRow(stat: stat);
            }).toList()),
          ),
        ],
      ),
    );
  }

  Widget renderRow({required StatModel stat}) {
    final status = DataUtils.getCurrentStatusFromStat(
        value: stat.getLevelFromRegion(region), itemCode: stat.itemCode);
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 8.0, vertical: 4),
      child: Row(
        children: [
          Expanded(child: Text('${stat.dataTime.hour}시')),
          Expanded(child: Image.asset(status.imagePath, height: 20)),
          Expanded(
              child: Text(
            status.label,
            textAlign: TextAlign.right,
          )),
        ],
      ),
    );
  }
}
