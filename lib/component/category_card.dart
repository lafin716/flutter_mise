import 'package:flutter/material.dart';
import 'package:flutter_mise/component/card_title.dart';
import 'package:flutter_mise/component/main_card.dart';
import 'package:flutter_mise/component/main_stat.dart';
import 'package:flutter_mise/model/stat_and_status_model.dart';
import 'package:flutter_mise/utils/data_utils.dart';

class CategoryCard extends StatelessWidget {
  final String region;
  final Color darkColor;
  final Color lightColor;
  final List<StatAndStatusModel> models;

  const CategoryCard({
    required this.darkColor,
    required this.lightColor,
    required this.region,
    required this.models,
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: 160,
      child: MainCard(
        backgroundColor: lightColor,
        child: LayoutBuilder(builder: (context, constraint) {
          return Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              CardTitle(
                title: '종류별 통계',
                backgroundColor: darkColor,
              ),
              Expanded(
                child: ListView(
                  scrollDirection: Axis.horizontal,
                  physics: PageScrollPhysics(),
                  children: models
                      .map(
                        (model) => MainStat(
                          category: DataUtils.getItemCodeToKrString(
                              itemCode: model.itemCode),
                          imagePath: model.status.imagePath,
                          level: model.status.label,
                          stat:
                              '${model.stat.getLevelFromRegion(region)}${DataUtils.getUnitFromItemCode(itemCode: model.itemCode)}',
                          width: constraint.maxWidth / 3,
                        ),
                      )
                      .toList(),
                  // List.generate(
                  //   20,
                  //   (index) => MainStat(
                  //     category: '미세먼지 $index',
                  //     imagePath: 'asset/img/best.png',
                  //     level: '최고',
                  //     stat: '0㎍/m',
                  //     width: constraint.maxWidth / 3,
                  //   ),
                  // ),
                ),
              ),
            ],
          );
        }),
      ),
    );
  }
}
