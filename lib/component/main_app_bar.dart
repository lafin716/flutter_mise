import 'package:flutter/material.dart';
import 'package:flutter_mise/const/colors.dart';

class MainAppBar extends StatelessWidget {
  const MainAppBar({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    const ts = TextStyle(
      color: Colors.white,
      fontSize: 30.0,
    );

    return SliverAppBar(
      backgroundColor: primaryColor,
      expandedHeight: 500,
      flexibleSpace: FlexibleSpaceBar(
        background: SafeArea(
          child: Container(
            margin: EdgeInsets.only(
              // material design 에서 툴바 높이를 변수로 받을 수 있다. kToolbarHeight
              top: kToolbarHeight,
            ),
            child: Column(
              children: [
                Text(
                  '서울',
                  style: ts,
                ),
                Text(
                  DateTime.now().toString(),
                  style: ts.copyWith(
                    fontSize: 18.0,
                  ),
                ),
                const SizedBox(
                  height: 20.0,
                ),
                Image.asset(
                  'asset/img/mediocre.png',
                  width: MediaQuery.of(context).size.width / 2,
                ),
                const SizedBox(
                  height: 20.0,
                ),
                Text(
                  '보통',
                  style: ts,
                ),
                const SizedBox(
                  height: 8.0,
                ),
                Text(
                  '나쁘지 않네요!',
                  style: ts.copyWith(
                    fontSize: 18.0,
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
