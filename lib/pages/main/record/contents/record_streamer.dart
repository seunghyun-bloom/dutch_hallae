import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:dutch_hallae/getx/controller/record_controller.dart';
import 'package:dutch_hallae/pages/main/record/contents/record_more_info.dart';
import 'package:dutch_hallae/pages/main/record/record_create_page.dart';
import 'package:dutch_hallae/utilities/no_data.dart';
import 'package:dutch_hallae/utilities/styles.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class RecordStreamer extends GetView<RecordController> {
  const RecordStreamer({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return StreamBuilder<QuerySnapshot>(
      stream: controller.firestoreQuery,
      builder: (context, snapshot) {
        if (snapshot.connectionState == ConnectionState.waiting) {
          return const Center(child: CircularProgressIndicator());
        }

        if (!snapshot.hasData) {
          return NoDataSquare(
            titleString: '만남기록이 없어요',
            contentString: '기록을 추가해보세요!',
            onTap: () => Get.to(() => RecordCreatePage()),
          );
        } else {
          return GridView.builder(
            itemCount: snapshot.data?.docs.length,
            gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
              crossAxisCount: 2,
              mainAxisSpacing: 10,
              crossAxisSpacing: 10,
            ),
            itemBuilder: (context, index) {
              return RecordBubble(
                title: snapshot.data?.docs[index]['title'],
                group: snapshot.data?.docs[index]['group'],
                image: snapshot.data?.docs[index]['image'],
                members: snapshot.data?.docs[index]['members'],
                place: snapshot.data?.docs[index]['place'],
                date: snapshot.data?.docs[index]['timeStamp'],
                amount: snapshot.data?.docs[index]['amount'],
                index: index,
              );
            },
          );
        }
      },
    );
  }
}

class RecordBubble extends StatelessWidget {
  final String title;
  final String group;
  final String image;
  final List members;
  final Map<String, dynamic> place;
  final Timestamp date;
  final int amount;
  final int index;

  const RecordBubble({
    Key? key,
    required this.title,
    required this.group,
    required this.image,
    required this.members,
    required this.place,
    required this.date,
    required this.amount,
    required this.index,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    DateTime dateTime = date.toDate();
    final _getxRecord = Get.put(RecordController());

    return InkWell(
      onTap: () async {
        await _getxRecord.findGroupImage(group);
        await _getxRecord.findGroupMembers(group);
        Get.to(
          () => RecordMoreInfo(
            title: title,
            group: group,
            image: image,
            members: members,
            place: place,
            date: dateTime,
            amount: amount,
            index: index,
          ),
        );
      },
      child: Container(
        foregroundDecoration: BoxDecoration(
          borderRadius: BorderRadius.circular(8),
        ),
        child: Stack(
          alignment: AlignmentDirectional.bottomEnd,
          children: [
            Container(
              foregroundDecoration: BoxDecoration(
                borderRadius: BorderRadius.circular(8),
                gradient: const LinearGradient(
                  begin: Alignment.bottomCenter,
                  end: Alignment.center,
                  colors: [
                    Color.fromARGB(123, 0, 0, 0),
                    Colors.transparent,
                  ],
                ),
              ),
              child: ClipRRect(
                borderRadius: BorderRadius.circular(8),
                child: Hero(
                  tag: 'recordHeroTag$index',
                  child: Image.network(image),
                ),
              ),
            ),
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: Column(
                mainAxisSize: MainAxisSize.min,
                crossAxisAlignment: CrossAxisAlignment.end,
                children: [
                  Text(title, style: whiteText),
                  Text(group, style: white12Text),
                  Text(dateTime.toString().substring(0, 10),
                      style: white12Text),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
