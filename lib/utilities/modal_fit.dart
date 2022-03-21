import 'package:flutter/material.dart';
import 'package:get/get.dart';

class ModalFit extends StatelessWidget {
  ModalFit({Key? key, required this.friend, required this.number})
      : super(key: key);
  String friend;
  String number;

  @override
  Widget build(BuildContext context) {
    return Material(
      child: SafeArea(
        top: false,
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            Padding(
              padding: const EdgeInsets.symmetric(vertical: 20.0),
              child: CircleAvatar(
                child: const Text('Image'),
                radius: 50,
              ),
            ),
            Text(
              '$friend 님의\n프로필을 완성해 보세요',
              textAlign: TextAlign.center,
              style: TextStyle(fontWeight: FontWeight.w700, fontSize: 20),
            ),
            Padding(
              padding: const EdgeInsets.all(20),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceAround,
                children: [
                  CircleAvatar(),
                  CircleAvatar(),
                  CircleAvatar(),
                  CircleAvatar(),
                  CircleAvatar(),
                ],
              ),
            ),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 20),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceAround,
                children: [
                  CircleAvatar(),
                  CircleAvatar(),
                  CircleAvatar(),
                  CircleAvatar(),
                  CircleAvatar(),
                ],
              ),
            ),
            Padding(
              padding: const EdgeInsets.symmetric(
                horizontal: 20,
                vertical: 30,
              ),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceAround,
                children: [
                  SizedBox(
                    width: Get.width * 0.4,
                    height: 45,
                    child: ElevatedButton(
                      child: const Text(
                        '지우기',
                        textAlign: TextAlign.center,
                        style: TextStyle(color: Colors.black),
                      ),
                      style: ButtonStyle(
                        backgroundColor:
                            MaterialStateProperty.all(Colors.grey.shade300),
                      ),
                      onPressed: () {},
                    ),
                  ),
                  SizedBox(
                    width: Get.width * 0.4,
                    height: 45,
                    child: ElevatedButton(
                      child: const Text(
                        '완료',
                        textAlign: TextAlign.center,
                      ),
                      onPressed: () {
                        print(number);
                      },
                    ),
                  ),
                ],
              ),
            )
          ],
        ),
      ),
    );
  }
}
