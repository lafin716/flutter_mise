import 'package:flutter/material.dart';
import 'package:flutter_mise/component/card_title.dart';
import 'package:flutter_mise/component/main_card.dart';
import 'package:flutter_mise/component/main_stat.dart';
import 'package:flutter_mise/model/stat_and_status_model.dart';
import 'package:flutter_mise/model/stat_model.dart';
import 'package:flutter_mise/utils/data_utils.dart';
import 'package:hive_flutter/hive_flutter.dart';

class CategoryCard extends StatelessWidget {
  final String region;
  final Color darkColor;
  final Color lightColor;

  const CategoryCard({
    required this.darkColor,
    required this.lightColor,
    required this.region,
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
                  children: ItemCode.values
                      .map(
                        (ItemCode itemCode) => ValueListenableBuilder<Box>(
                            valueListenable:
                                Hive.box<StatModel>(itemCode.name).listenable(),
                            builder: (context, box, widget) {
                              final stat = box.values.last as StatModel;
                              final status =
                                  DataUtils.getStatusFromItemCodeAndValue(
                                value: stat.getLevelFromRegion(region),
                                itemCode: itemCode,
                              );

                              return MainStat(
                                category: DataUtils.getItemCodeToKrString(
                                    itemCode: itemCode),
                                imagePath: status.imagePath,
                                level: status.label,
                                stat:
                                    '${stat.getLevelFromRegion(region)}${DataUtils.getUnitFromItemCode(itemCode: itemCode)}',
                                width: constraint.maxWidth / 3,
                              );
                            }),
                      )
                      .toList(),
                ),
              ),
            ],
          );
        }),
      ),
    );
  }
}
