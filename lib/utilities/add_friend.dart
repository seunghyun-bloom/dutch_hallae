import 'package:flutter/material.dart';
import 'package:get/get.dart';

class AddFriendPopup {
  AddFriendPopup(BuildContext context) {
    showDialog(
      barrierDismissible: true,
      context: context,
      builder: (context) {
        return AlertDialog(
          insetPadding: EdgeInsets.zero,
          contentPadding: const EdgeInsets.only(left: 20),
          clipBehavior: Clip.antiAliasWithSaveLayer,
          content: Builder(
            builder: (context) {
              var height = Get.height;
              var width = Get.width;
              return SizedBox(
                height: height * 0.5,
                width: width * 0.7,
                child: Column(
                  children: [
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        const Flexible(
                          child: TextField(
                            decoration: InputDecoration(
                              hintText: '목록에서 검색',
                            ),
                          ),
                        ),
                        Padding(
                          padding: const EdgeInsets.only(top: 10),
                          child: TextButton(
                            child: const Icon(Icons.add),
                            onPressed: () {},
                          ),
                        ),
                      ],
                    ),
                    SizedBox(
                      height: height * 0.4,
                      child: SingleChildScrollView(
                        child: Column(
                          children: [
                            InkWell(
                              child: ListTile(
                                title: Text('아이린'),
                                subtitle: Text('010-2323-4545'),
                              ),
                              onTap: () {},
                            ),
                            InkWell(
                              child: ListTile(
                                title: Text('슬기'),
                                subtitle: Text('010-2323-4545'),
                              ),
                              onTap: () {},
                            ),
                            InkWell(
                              child: ListTile(
                                title: Text('웬디'),
                                subtitle: Text('010-2323-4545'),
                              ),
                              onTap: () {},
                            ),
                            InkWell(
                              child: ListTile(
                                title: Text('조이'),
                                subtitle: Text('010-2323-4545'),
                              ),
                              onTap: () {},
                            ),
                            InkWell(
                              child: ListTile(
                                title: Text('예리'),
                                subtitle: Text('010-2323-4545'),
                              ),
                              onTap: () {},
                            ),
                          ],
                        ),
                      ),
                    )
                  ],
                ),
              );
            },
          ),
        );
      },
    );
  }
}
