import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:dutch_hallae/getx/controller/group_controller.dart';
import 'package:dutch_hallae/pages/main/components/main_record.dart';
import 'package:dutch_hallae/utilities/mini_calendar.dart';
import 'package:dutch_hallae/utilities/mini_profile.dart';
import 'package:dutch_hallae/utilities/styles.dart';
import 'package:dutch_hallae/utilities/title.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:get/get.dart';
import 'package:get/get_state_manager/get_state_manager.dart';
import 'package:intl/intl.dart';

class GroupInfoPage extends StatefulWidget {
  String name;
  String image;
  int colorValue;
  List members;
  bool isFavorite;
  Timestamp createdDate;
  int index;
  GroupInfoPage({
    Key? key,
    required this.image,
    required this.name,
    required this.colorValue,
    required this.members,
    required this.isFavorite,
    required this.createdDate,
    this.index = 999,
  }) : super(key: key);

  @override
  State<GroupInfoPage> createState() => _GroupInfoPageState();
}

class _GroupInfoPageState extends State<GroupInfoPage> {
  final _getxGroup = Get.put(GroupController());
  @override
  void initState() {
    _getxGroup.getRecordByGroup(widget.name);
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    DateTime _createdDate = widget.createdDate.toDate();
    DateFormat dateFormat = DateFormat('yyyy년 MM월 dd일');
    Get.put(GroupController());
    return Scaffold(
      appBar: AppBar(
        title: Text(widget.name),
        actions: [
          TextButton(
            child: const Text('편집'),
            onPressed: () {},
          )
        ],
      ),
      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 8.0),
        child: ListView(
          children: [
            ClipRRect(
              borderRadius: BorderRadius.circular(8),
              child: Hero(
                tag: 'groupHeroTag${widget.index}',
                child: Image.network(widget.image),
              ),
            ),
            TitleText(title: '멤버들'),
            MiniProfiles(people: widget.members),
            TitleText(title: '그룹 대표 색'),
            Center(
              child: FaIcon(
                FontAwesomeIcons.moon,
                size: 36,
                color: Color(widget.colorValue).withOpacity(1),
              ),
            ),
            TitleText(title: '모임 생성일'),
            MiniCalendar(dateTime: _createdDate),
            TitleText(title: '최근 만남'),
            Obx(
              () => SizedBox(
                height: 300.h,
                child: ListView.builder(
                  physics: const ClampingScrollPhysics(),
                  scrollDirection: Axis.horizontal,
                  shrinkWrap: true,
                  itemCount: _getxGroup.groupRecord.length,
                  itemBuilder: (context, index) {
                    var _groupRecord = _getxGroup.groupRecord.reversed.toList();
                    return MainRecordBubble(
                      title: _groupRecord[index]['title'],
                      group: _groupRecord[index]['group'],
                      image: _groupRecord[index]['image'],
                      members: _groupRecord[index]['members'],
                      dateTime: _groupRecord[index]['timeStamp'],
                      amount: _groupRecord[index]['amount'],
                      place: _groupRecord[index]['place'],
                      index: index,
                    );
                  },
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
