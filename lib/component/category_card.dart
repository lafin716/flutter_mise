import 'package:flutter/material.dart';
import 'package:flutter_mise/component/main_stat.dart';
import 'package:flutter_mise/const/colors.dart';

class CategoryCard extends StatelessWidget {
  const CategoryCard({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Card(
      margin: EdgeInsets.symmetric(horizontal: 8.0),
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.all(
          Radius.circular(16.0),
        ),
      ),
      color: lightColor,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          Container(
            decoration: BoxDecoration(
              color: darkColor,
              borderRadius: BorderRadius.only(
                topLeft: Radius.circular(16.0),
                topRight: Radius.circular(16.0),
              ),
            ),
            child: Padding(
              padding: EdgeInsets.all(4.0),
              child: Text(
                '종류별 통계',
                style: TextStyle(
                  color: Colors.white,
                  fontWeight: FontWeight.w700,
                ),
                textAlign: TextAlign.center,
              ),
            ),
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: [
              MainStat(
                category: '미세먼지',
                imagePath: 'asset/img/best.png',
                level: '최고',
                stat: '0㎍/m',
              ),
              MainStat(
                category: '미세먼지',
                imagePath: 'asset/img/best.png',
                level: '최고',
                stat: '0㎍/m',
              ),
              MainStat(
                category: '미세먼지',
                imagePath: 'asset/img/best.png',
                level: '최고',
                stat: '0㎍/m',
              ),
            ],
          ),
        ],
      ),
    );
  }
}
