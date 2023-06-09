import 'package:flutter/material.dart';
import 'package:hive_flutter/hive_flutter.dart';
import 'package:mask_app/component/card_title.dart';
import 'package:mask_app/component/main_card.dart';
import 'package:mask_app/component/main_stat.dart';
import 'package:mask_app/model/stat_model.dart';
import 'package:mask_app/utils/data_utils.dart';

class CategoryCard extends StatelessWidget {
  final String region;
  final Color darkColor;
  final Color lightColor;
  const CategoryCard(
      {super.key,
      required this.region,
      required this.darkColor,
      required this.lightColor});

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: 160,
      child: MainCard(
        backgroundcolor: lightColor,
        //리스트뷰에 3개씩만 나오게 하는법
        //너비의 크기를 알고싶은 위젯을 레이아웃 빌더에 감싼다
        child: LayoutBuilder(builder: (context, constraint) {
          //constraint:레이아웃 빌더가 차지하고 있는 공간의 최대최소높이너비
          return Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              CardTitle(
                title: '종류별 통계',
                backgroundColor: darkColor,
              ),
              Expanded(
                child: ListView(
                  //리스트뷰에서 한페이지식 넘어가게 하는 법
                  physics: const PageScrollPhysics(),
                  scrollDirection: Axis.horizontal,
                  children: ItemCode.values
                      .map((ItemCode itemCode) => ValueListenableBuilder<Box>(
                            valueListenable:
                                Hive.box<StatModel>(itemCode.name).listenable(),
                            builder: (context, box, child) {
                              final stat = box.values.last;
                              final status = DataUtils.getCurrentStatusFromStat(
                                  itemCode: itemCode,
                                  value: stat.getLevelFromRegion(region));
                              return MainStat(
                                category: DataUtils.itemCodeKrString(
                                    itemCode: itemCode),
                                imgPath: status.imagePath,
                                level: status.label,
                                stat:
                                    '${stat.getLevelFromRegion(region)}${DataUtils.getUnitFromItemCode(itemCode: itemCode)}',
                                width: constraint.maxWidth / 3,
                              );
                            },
                          ))
                      .toList(),
                  // children: List.generate(
                  //   20,
                  //   (index) => MainStat(
                  //     width: constraint.maxWidth / 3,
                  //     category: '미세먼지',
                  //     imgPath: 'asset/img/best.png',
                  //     level: '최고',
                  //     stat: '0㎛/m',
                  //   ),
                  // ),
                ),
              )
            ],
          );
        }),
      ),
    );
  }
}
