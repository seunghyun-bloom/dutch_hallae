import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:dutch_hallae/getx/controller/group_controller.dart';
import 'package:dutch_hallae/pages/main/groups/group_add_page.dart';
import 'package:dutch_hallae/pages/main/groups/group_info_page.dart';
import 'package:dutch_hallae/utilities/no_data.dart';
import 'package:dutch_hallae/utilities/styles.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';

class GroupStreamer extends GetView<GroupController> {
  const GroupStreamer({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return StreamBuilder<QuerySnapshot>(
      stream: controller.firestoreQuery,
      builder: (context, snapshot) {
        if (snapshot.connectionState == ConnectionState.waiting) {
          return const Center(child: CircularProgressIndicator());
        }

        if (snapshot.data?.docs.length == 0) {
          return NoDataSquare(
            titleString: '모임을 추가해보세요',
            contentString: '이런... 모임이 하나도 없으시네요',
            onTap: () => Get.to(() => GroupAddPage()),
          );
        } else {
          return ListView.builder(
            itemCount: snapshot.data?.docs.length,
            itemBuilder: (context, index) {
              return GroupBubble(
                image: snapshot.data?.docs[index]['image'],
                name: snapshot.data?.docs[index]['name'],
                colorValue: snapshot.data?.docs[index]['color'],
                members: snapshot.data?.docs[index]['members'],
                isFavorite: snapshot.data?.docs[index]['favorite'],
                createdDate: snapshot.data?.docs[index]['createdDate'],
                index: index,
              );
            },
          );
        }
      },
    );
  }
}

class GroupBubble extends GetView<GroupController> {
  String name;
  String image;
  double size;
  int colorValue;
  List members;
  bool isFavorite;
  Timestamp createdDate;
  int index;
  GroupBubble({
    Key? key,
    required this.image,
    required this.name,
    required this.colorValue,
    required this.members,
    required this.isFavorite,
    required this.createdDate,
    this.size = 0,
    this.index = 999,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    Get.put(GroupController());
    return InkWell(
      onTap: () {
        Get.to(
          () => GroupInfoPage(
            image: image,
            name: name,
            colorValue: colorValue,
            members: members,
            isFavorite: isFavorite,
            createdDate: createdDate,
            index: index,
          ),
        );
      },
      child: Padding(
        padding: const EdgeInsets.only(bottom: 15),
        child: Stack(
          children: [
            Container(
              width: size == 0 ? Get.width : size.w,
              height: size == 0 ? Get.width : size.w,
              foregroundDecoration: BoxDecoration(
                borderRadius: BorderRadius.circular(12),
                gradient: const LinearGradient(
                  begin: Alignment.topCenter,
                  end: Alignment.center,
                  colors: [
                    Color.fromARGB(123, 0, 0, 0),
                    Colors.transparent,
                  ],
                ),
              ),
              child: ClipRRect(
                borderRadius: BorderRadius.circular(12),
                child: Hero(
                  tag: 'groupHeroTag$index',
                  child: Image.network(image, fit: BoxFit.cover),
                ),
              ),
            ),
            Column(
              crossAxisAlignment: CrossAxisAlignment.end,
              children: [
                Padding(
                  padding: const EdgeInsets.all(12.0),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Row(
                        children: [
                          InkWell(
                            onTap: () => controller.setToFavorite(name),
                            child: Container(
                              padding: const EdgeInsets.all(3),
                              decoration: BoxDecoration(
                                  color: Colors.black.withOpacity(0.5),
                                  borderRadius: BorderRadius.circular(6)),
                              child: Icon(
                                Icons.star_rounded,
                                color: isFavorite
                                    ? Colors.white
                                    : Colors.white.withOpacity(0.2),
                              ),
                            ),
                          ),
                          Text(
                            ' $name',
                            style: TextStyle(
                              fontSize: 16.sp,
                              color: Colors.white,
                            ),
                          ),
                        ],
                      ),
                      Container(
                        padding: const EdgeInsets.all(3),
                        // height: 20.h,
                        decoration: BoxDecoration(
                          color: Colors.grey.withOpacity(0.5),
                          borderRadius: BorderRadius.circular(6),
                        ),
                        child: Row(
                          children: [
                            const Icon(
                              Icons.person,
                              color: Colors.white,
                            ),
                            Text(
                              members.length.toString(),
                              style: whiteText,
                            ),
                          ],
                        ),
                      )
                    ],
                  ),
                ),
                SizedBox(
                  height: 20,
                  child: ListView.builder(
                    shrinkWrap: true,
                    scrollDirection: Axis.horizontal,
                    itemCount: members.length,
                    itemBuilder: (context, index) {
                      return Text(
                        '${members[index]['name']}  ',
                        style: const TextStyle(color: Colors.white),
                        maxLines: 1,
                        overflow: TextOverflow.fade,
                        softWrap: false,
                      );
                    },
                  ),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
