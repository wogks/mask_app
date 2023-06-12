import 'package:flutter/material.dart';
import 'package:mask_app/component/card_title.dart';
import 'package:mask_app/component/main_card.dart';
import 'package:mask_app/component/main_stat.dart';

class CategoryCard extends StatelessWidget {
  const CategoryCard({super.key});

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: 160,
      child: MainCard(
        //리스트뷰에 3개씩만 나오게 하는법
        //너비의 크기를 알고싶은 위젯을 레이아웃 빌더에 감싼다
        child: LayoutBuilder(builder: (context, constraint) {
          //constraint:레이아웃 빌더가 차지하고 있는 공간의 최대최소높이너비
          return Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              const CardTitle(
                title: '종류별 통계',
              ),
              Expanded(
                child: ListView(
                  //리스트뷰에서 한페이지식 넘어가게 하는 법
                  physics: const PageScrollPhysics(),
                  scrollDirection: Axis.horizontal,
                  children: List.generate(
                    20,
                    (index) => MainStat(
                      width: constraint.maxWidth / 3,
                      category: '미세먼지',
                      imgPath: 'asset/img/best.png',
                      level: '최고',
                      stat: '0㎛/m',
                    ),
                  ),
                ),
              )
            ],
          );
        }),
      ),
    );
  }
}