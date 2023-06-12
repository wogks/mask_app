import 'package:flutter/material.dart';
import 'package:mask_app/const/colors.dart';
import 'package:mask_app/const/regions.dart';

typedef OnRegionTap = void Function(String region);

class MainDrawer extends StatelessWidget {
  final OnRegionTap onRegionTap;
  final String selectedRegion;
  const MainDrawer({
    super.key,
    required this.onRegionTap,
    required this.selectedRegion,
  });

  @override
  Widget build(BuildContext context) {
    return Drawer(
      backgroundColor: darkColor,
      child: ListView(
        children: [
          //타이틀 부분
          const DrawerHeader(
            child: Text(
              '지역 선택',
              style: TextStyle(color: Colors.white, fontSize: 20),
            ),
          ),
          ...regions
              .map(
                (e) => ListTile(
                  tileColor: Colors.white,
                  //배경
                  selectedTileColor: lightColor,
                  //선택됐을때 글자색
                  selectedColor: Colors.black,
                  //셀렉티드에 입력한 값들이 트루를 하면 반영이 된다
                  selected: e == selectedRegion,
                  onTap: () {
                    onRegionTap(e);
                  },
                  title: Text(e),
                ),
              )
              .toList(),
        ],
      ),
    );
  }
}
