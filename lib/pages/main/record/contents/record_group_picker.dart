import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:dutch_hallae/getx/controller/group_controller.dart';
import 'package:dutch_hallae/getx/controller/record_controller.dart';
import 'package:dutch_hallae/pages/main/groups/group_add_page.dart';
import 'package:dutch_hallae/utilities/no_data.dart';
import 'package:dutch_hallae/utilities/styles.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

final _getxGroup = Get.find<GroupController>();
final _getxRecord = Get.find<RecordController>();

class RecordGroupPicker extends StatelessWidget {
  RecordGroupPicker({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    Get.put(GroupController());
    return SizedBox(
      width: Get.width,
      height: 240.h,
      child: StreamBuilder<QuerySnapshot>(
        stream: _getxGroup.firestoreQuery,
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
              shrinkWrap: true,
              scrollDirection: Axis.horizontal,
              itemCount: snapshot.data?.docs.length,
              itemBuilder: (context, index) {
                return Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 4),
                  child: RecordGroupPickerBubble(
                    image: snapshot.data?.docs[index]['image'],
                    name: snapshot.data?.docs[index]['name'],
                    members: snapshot.data?.docs[index]['members'],
                    isPicked: snapshot.data?.docs[index]['picked'],
                  ),
                );
              },
            );
          }
        },
      ),
    );
  }
}

class RecordGroupPickerBubble extends StatelessWidget {
  String name;
  String image;
  List members;
  bool isPicked;
  RecordGroupPickerBubble({
    Key? key,
    required this.name,
    required this.image,
    required this.members,
    required this.isPicked,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    Get.put(GroupController());
    Get.put(RecordController());
    return InkWell(
      onTap: () {
        _getxGroup.pickForRecord(name);
        _getxRecord.group(name);
      },
      child: Container(
        width: 200.h,
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(12),
          color: isPicked ? Palette.basicBlue : Colors.grey.shade300,
        ),
        foregroundDecoration:
            BoxDecoration(borderRadius: BorderRadius.circular(12)),
        child: Column(
          children: [
            Stack(
              children: [
                Container(
                  height: 200.h,
                  width: 200.h,
                  decoration: BoxDecoration(
                    borderRadius: const BorderRadius.only(
                      topLeft: Radius.circular(12),
                      topRight: Radius.circular(12),
                    ),
                    image: DecorationImage(
                      fit: BoxFit.cover,
                      image: NetworkImage(image),
                    ),
                  ),
                  foregroundDecoration: const BoxDecoration(
                    borderRadius: BorderRadius.only(
                      topLeft: Radius.circular(12),
                      topRight: Radius.circular(12),
                    ),
                    gradient: LinearGradient(
                      begin: Alignment.bottomCenter,
                      end: Alignment.center,
                      colors: [
                        Color.fromARGB(123, 0, 0, 0),
                        Colors.transparent,
                      ],
                    ),
                  ),
                ),
                Positioned(
                  top: 120.h,
                  right: 10.w,
                  width: 200.w * 0.9,
                  height: 75.h,
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.end,
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Container(
                        width: 40.w,
                        padding: const EdgeInsets.all(3),
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
                      ),
                      Column(
                        crossAxisAlignment: CrossAxisAlignment.end,
                        children: [
                          SizedBox(
                            width: 200.w,
                            height: 20.h,
                            child: ListView.builder(
                              shrinkWrap: true,
                              scrollDirection: Axis.horizontal,
                              reverse: true,
                              itemCount: members.length,
                              itemBuilder: (context, index) {
                                return Text(
                                  '${members[members.length - 1 - index]['name']}  ',
                                  style: const TextStyle(
                                    color: Colors.white,
                                    fontSize: 13,
                                  ),
                                  maxLines: 1,
                                  overflow: TextOverflow.fade,
                                  softWrap: false,
                                );
                              },
                            ),
                          ),
                          Text(
                            name,
                            style: const TextStyle(
                              color: Colors.white,
                              fontSize: 15,
                              fontWeight: FontWeight.w800,
                            ),
                          ),
                        ],
                      ),
                    ],
                  ),
                ),
              ],
            ),
            Expanded(
              child: Center(
                child: Text(
                  isPicked ? '선택완료' : '선택',
                  style: TextStyle(
                    color: isPicked ? Colors.white : Colors.black,
                    fontSize: 16.sp,
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
