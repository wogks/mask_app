import 'package:flutter/material.dart';
import 'package:mask_app/const/colors.dart';

class MainAppBar extends StatelessWidget {
  const MainAppBar({super.key});

  @override
  Widget build(BuildContext context) {
    const ts = TextStyle(
      color: Colors.white,
      fontSize: 30,
    );
    return SliverAppBar(
      backgroundColor: primaryColor,
      expandedHeight: 500,
      flexibleSpace: FlexibleSpaceBar(
        background: SafeArea(
          //컨테이너를 넣어서 드로어를 앱바 크기만큼 띄워준다
          child: Container(
            //margin = safearea와의 간격을 둔다(컨테이너에 색을 넣으면 아래의 콜럼이 검은색) padding = column과의 간격을 둔다(컨테이너도 포함되서 검은색)
            margin: const EdgeInsets.only(top: kToolbarHeight),
            child: Column(
              children: [
                const Text(
                  '서울',
                  style: ts,
                ),
                Text(
                  DateTime.now().toString(),
                  style: ts.copyWith(
                    fontSize: 20,
                    fontWeight: FontWeight.w700,
                  ),
                ),
                const SizedBox(height: 20),
                Image.asset(
                  'asset/img/mediocre.png',
                  width: MediaQuery.of(context).size.width / 2,
                ),
                const SizedBox(height: 20),
                Text(
                  '보통',
                  style: ts.copyWith(
                    fontSize: 30,
                    fontWeight: FontWeight.w700,
                  ),
                ),
                const SizedBox(height: 20),
                Text(
                  '낫배도 하네요!',
                  style: ts.copyWith(
                    fontSize: 20,
                    fontWeight: FontWeight.w700,
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
