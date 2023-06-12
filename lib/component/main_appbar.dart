import 'package:flutter/material.dart';
import 'package:mask_app/model/stat_model.dart';
import 'package:mask_app/model/status_model.dart';

class MainAppBar extends StatelessWidget {
  final StatusModel status;
  final StatModel stat;
  const MainAppBar({super.key, required this.status, required this.stat});

  @override
  Widget build(BuildContext context) {
    const ts = TextStyle(
      color: Colors.white,
      fontSize: 30,
    );
    return SliverAppBar(
      backgroundColor: status.primaryColor,
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
                  getTimeFromDateTime(dateTime: stat.dataTime),
                  style: ts.copyWith(
                    fontSize: 20,
                    fontWeight: FontWeight.w700,
                  ),
                ),
                const SizedBox(height: 20),
                Image.asset(
                  status.imagePath,
                  width: MediaQuery.of(context).size.width / 2,
                ),
                const SizedBox(height: 20),
                Text(
                  status.label,
                  style: ts.copyWith(
                    fontSize: 40,
                    fontWeight: FontWeight.w700,
                  ),
                ),
                const SizedBox(height: 20),
                Text(
                  status.comment,
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

  String getTimeFromDateTime({required DateTime dateTime}) {
    return '${dateTime.year}-${dateTime.month}-${dateTime.day} ${getTimeFormat(dateTime.hour)}:${getTimeFormat(dateTime.minute)}';
  }

  String getTimeFormat(int number) {
    return number.toString().padLeft(2, '0');
  }
}
