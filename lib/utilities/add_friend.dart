import 'package:flutter/material.dart';
import 'package:get/get.dart';

//TODO: popup 형태로 친구추가 화면 생성
//TODO: 상단에 TextField로 이름 검색
//TODO: 하단에 주소록 목록 위치

//TODO: contacts_service package로 폰 주소록에 있는 목록 불러오기
//TODO: 처음부터 cloud firestore에 저장하지 않고,
//TODO: 선택해서 추가된 친구만 firestore에 추가

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
                        Flexible(
                          child: TextField(),
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
