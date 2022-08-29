import 'package:flutter/material.dart';

class MainStat extends StatelessWidget {
  final String category;
  final String imagePath;
  final String level;
  final String stat;

  const MainStat({
    required this.category,
    required this.imagePath,
    required this.level,
    required this.stat,
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final textStyle = TextStyle(
      color: Colors.black,
    );
    return Column(
      children: [
        Text(
          category,
          style: textStyle,
        ),
        const SizedBox(height: 8.0,),
        Image.asset(
          imagePath,
          width: 50.0,
        ),
        const SizedBox(height: 8.0,),
        Text(
          level,
          style: textStyle,
        ),
        Text(
          stat,
          style: textStyle,
        ),
      ],
    );
  }
}
