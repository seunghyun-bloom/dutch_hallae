import 'package:dutch_hallae/pages/main/record/contents/record_streamer.dart';
import 'package:dutch_hallae/pages/main/record/record_create_page.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class RecordPage extends StatelessWidget {
  const RecordPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('만남 기록'),
        actions: [
          TextButton(
            onPressed: () => Get.to(() => RecordCreatePage()),
            child: const Text('추가'),
          ),
        ],
      ),
      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 15),
        child: RecordStreamer(),
      ),
    );
  }
}
