import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:dutch_hallae/getx/controller/record_controller.dart';
import 'package:dutch_hallae/pages/main/record/contents/record_more_info.dart';
import 'package:dutch_hallae/utilities/styles.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';

class MainRecordComponent extends GetView<RecordController> {
  const MainRecordComponent({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: 300.h,
      child: StreamBuilder<QuerySnapshot>(
        stream: controller.firestoreQuery2,
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return const Center(child: CircularProgressIndicator());
          } else if (snapshot.data?.docs.length == 0) {
            return const Center(child: Text('만남 기록이 없어요'));
          }
          return ListView.builder(
            physics: const ClampingScrollPhysics(),
            shrinkWrap: true,
            scrollDirection: Axis.horizontal,
            itemCount:
                snapshot.data!.docs.length < 6 ? snapshot.data!.docs.length : 6,
            itemBuilder: (context, index) {
              return MainRecordBubble(
                title: snapshot.data?.docs[index]['title'],
                group: snapshot.data?.docs[index]['group'],
                image: snapshot.data?.docs[index]['image'],
                members: snapshot.data?.docs[index]['members'],
                dateTime: snapshot.data?.docs[index]['timeStamp'],
                amount: snapshot.data?.docs[index]['amount'],
                place: snapshot.data?.docs[index]['place'],
                index: index,
              );
            },
          );
        },
      ),
    );
  }
}

class MainRecordBubble extends GetView<RecordController> {
  String title;
  String group;
  String image;
  List members;
  Timestamp dateTime;
  int amount;
  Map<String, dynamic> place;
  int index;
  MainRecordBubble({
    Key? key,
    required this.title,
    required this.group,
    required this.image,
    required this.members,
    required this.dateTime,
    required this.amount,
    required this.place,
    required this.index,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final dateFormat = DateFormat('yyyy/MM/dd');
    // final numFormat = NumberFormat('###,###,###,###');
    List _members = [];
    for (var member in members) {
      _members.add(member['name']);
    }
    DateTime date = dateTime.toDate();

    String placeTitle = place['title'];

    return InkWell(
      onTap: () async {
        await controller.findGroupImage(group);
        await controller.findGroupMembers(group);
        Get.to(
          () => RecordMoreInfo(
            title: title,
            group: group,
            image: image,
            members: members,
            place: place,
            date: date,
            amount: amount,
            index: index,
          ),
        );
      },
      child: Container(
        width: 200.h,
        margin: const EdgeInsets.only(right: 12),
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(12),
          color: Colors.grey.shade300,
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
                  child: ClipRRect(
                    borderRadius: const BorderRadius.only(
                      topLeft: Radius.circular(12),
                      topRight: Radius.circular(12),
                    ),
                    child: Hero(
                      tag: 'recordHeroTag$index',
                      child: Image.network(
                        image,
                        fit: BoxFit.cover,
                      ),
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
                              _members.length.toString(),
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
                              itemCount: _members.length,
                              itemBuilder: (context, index) {
                                return Text(
                                  '${_members[index]}  ',
                                  style: whiteText,
                                  maxLines: 1,
                                  overflow: TextOverflow.fade,
                                  softWrap: false,
                                );
                              },
                            ),
                          ),
                          Text(
                            dateFormat.format(date),
                            style: TextStyle(
                              color: Colors.white,
                              fontSize: 12.sp,
                            ),
                          ),
                        ],
                      ),
                    ],
                  ),
                ),
              ],
            ),
            SizedBox(
              height: 50.h,
              child: Center(
                child: Text(
                  title,
                  style: TextStyle(
                    fontSize: 18.sp,
                  ),
                ),
              ),
            ),
            Padding(
              padding: EdgeInsets.symmetric(horizontal: 10.w),
              child: Divider(
                height: 0,
                color: Colors.grey.shade700,
              ),
            ),
            SizedBox(
              height: 50.h,
              child: Center(
                child: Text(
                  // '총 ${numFormat.format(totalAmount)}원',
                  placeTitle,
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
