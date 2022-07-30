import 'package:dutch_hallae/getx/controller/group_controller.dart';
import 'package:dutch_hallae/getx/controller/record_controller.dart';
import 'package:dutch_hallae/pages/main/groups/group_info_page.dart';
import 'package:dutch_hallae/pages/main/record/contents/mini_map.dart';
import 'package:dutch_hallae/utilities/mini_calendar.dart';
import 'package:dutch_hallae/utilities/mini_profile.dart';
import 'package:dutch_hallae/utilities/styles.dart';
import 'package:dutch_hallae/utilities/title.dart';
import 'package:dutch_hallae/utilities/toast.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';

class RecordMoreInfo extends StatefulWidget {
  final String title;
  final String group;
  final String image;
  final List members;
  final Map<String, dynamic> place;
  final DateTime date;
  final int amount;
  final int index;

  RecordMoreInfo({
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
  State<RecordMoreInfo> createState() => _RecordMoreInfoState();
}

class _RecordMoreInfoState extends State<RecordMoreInfo> {
  final formatter = NumberFormat('###,###,###,###');
  final _getxRecord = Get.find<RecordController>();

  @override
  void initState() {
    Get.put(RecordController());
    _getxRecord.getGroupByRecord(widget.group);
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text(widget.title)),
      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 8.0),
        child: ListView(
          children: [
            Hero(
              tag: 'recordHeroTag${widget.index}',
              child: ClipRRect(
                borderRadius: BorderRadius.circular(12),
                child: Image.network(
                  widget.image,
                  fit: BoxFit.cover,
                ),
              ),
            ),
            TitleText(title: '모임'),
            Obx(
              () => ListTile(
                leading: Hero(
                  tag: 'groupHeroTag888',
                  child: ClipRRect(
                    borderRadius: BorderRadius.circular(8),
                    child: Image.network(
                      _getxRecord.groupImage.value,
                    ),
                  ),
                ),
                title: Text(widget.group),
                subtitle: Text(_getxRecord.groupMembers.value),
                trailing: const Icon(
                  Icons.arrow_forward_ios_rounded,
                  color: Palette.basicBlue,
                ),
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(8),
                ),
                onTap: () {
                  Get.to(
                    () => GroupInfoPage(
                      image: _getxRecord.recordGroup['image'],
                      name: _getxRecord.recordGroup['name'],
                      colorValue: _getxRecord.recordGroup['color'],
                      members: _getxRecord.recordGroup['members'],
                      isFavorite: _getxRecord.recordGroup['favorite'],
                      createdDate: _getxRecord.recordGroup['createdDate'],
                      index: 888,
                    ),
                  );
                },
              ),
            ),
            TitleText(title: '함께한 친구들'),
            MiniProfiles(people: widget.members),
            TitleText(title: '장소'),
            Padding(
              padding: const EdgeInsets.only(bottom: 5),
              child: Center(
                child: TextButton(
                  child: Text(
                    widget.place['title'],
                    style: const TextStyle(
                      fontSize: 18,
                      color: Palette.basicBlue,
                    ),
                  ),
                  onPressed: () => showToast(widget.place['address']),
                ),
              ),
            ),
            ClipRRect(
              borderRadius: BorderRadius.circular(8),
              child: MiniMap(x: widget.place['x'], y: widget.place['y']),
            ),
            TitleText(title: '날짜'),
            MiniCalendar(dateTime: widget.date),
            TitleText(title: '총 금액'),
            Center(
              child: Text(
                formatter.format(widget.amount),
                style: bold20,
              ),
            ),
            const SizedBox(height: 20),
          ],
        ),
      ),
    );
  }
}
