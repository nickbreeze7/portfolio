import 'package:flutter/Material.dart';
import '../../sign_in.dart';

class HomeHeader extends  StatelessWidget {
  const HomeHeader({super.key});

  @override
  Widget build(BuildContext context) {
      return Padding(
        padding: const EdgeInsets.only(left: 10, right: 30, top: 30),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              '$name님 안녕하세여',
              style: TextStyle(color: Colors.blue[900], fontSize: 20),
            ),
            Text(
              '근처에 있는 바버샾을 ',
              style: TextStyle(color: Colors.blue[900], fontSize: 20),
            ),
            Text(
              '추천해 드리겠습니다.',
              style: TextStyle(color: Colors.blue[900], fontSize: 20),
            ),
          ],
        ),
      );
  }

}