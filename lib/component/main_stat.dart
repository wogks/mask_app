import 'package:flutter/material.dart';

class MainStat extends StatelessWidget {
  final String category;
  final String imgPath;
  final String level;
  final String stat;
  final double width;
  const MainStat({
    super.key,
    required this.category,
    required this.imgPath,
    required this.level,
    required this.stat,
    required this.width,
  });

  @override
  Widget build(BuildContext context) {
    const ts = TextStyle(color: Colors.black);
    //리스트뷰에 세개만 넣는법
    return SizedBox(
      width: width,
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Text(
            category,
            style: ts,
          ),
          const SizedBox(height: 8),
          Image.asset(
            imgPath,
            width: 50,
          ),
          const SizedBox(height: 8),
          Text(
            level,
            style: ts,
          ),
          Text(
            stat,
            style: ts,
          ),
        ],
      ),
    );
  }
}
