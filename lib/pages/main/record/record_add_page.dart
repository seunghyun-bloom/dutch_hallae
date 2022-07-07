import 'package:dutch_hallae/getx/controller/record_controller.dart';
import 'package:dutch_hallae/pages/main/components/main_account.dart';
import 'package:dutch_hallae/pages/main/record/contents/record_group_picker.dart';
import 'package:dutch_hallae/utilities/insert_info_frame.dart';
import 'package:dutch_hallae/utilities/textfield_formatter.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';

class RecordAddPage extends StatelessWidget {
  RecordAddPage({Key? key}) : super(key: key);

  final TextEditingController _titleTextController = TextEditingController();
  final TextEditingController _totalAmountTextController =
      TextEditingController();
  final TextEditingController _specialDCTextController =
      TextEditingController();
  List members = ['김채원', '사쿠라', '홍은채', '카즈하', '허윤진'];
  final _getxRecord = Get.put(RecordController());
  var numberFormat = NumberFormat('###,###,###,###');

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('정산하기'),
        actions: [
          TextButton(
            child: Text('print'),
            onPressed: () {
              // print(_getxRecord.title.value);
              // print(_getxRecord.totalAmount.value);
            },
          ),
        ],
      ),
      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 15),
        child: SingleChildScrollView(
          physics: const ScrollPhysics(),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                '1차 정산',
                style: TextStyle(
                  fontSize: 20.sp,
                  fontWeight: FontWeight.w800,
                ),
              ),
              const SizedBox(height: 10),
              InsertInfoFrame(
                title: '제목',
                fontSize: 18,
                height: 40,
                content: TextField(
                  controller: _titleTextController,
                  onChanged: (value) {
                    _getxRecord.title.value = value;
                  },
                  maxLength: 8,
                  decoration: const InputDecoration(
                    hintText: 'ex) 1차 치맥',
                    border: InputBorder.none,
                    counterText: "",
                  ),
                ),
              ),
              const SizedBox(height: 5),
              MainAccountComponent(
                onTap: () {},
              ),
              const SizedBox(height: 5),
              InsertInfoFrame(
                title: '총 금액',
                fontSize: 18,
                height: 40,
                content: TextFormField(
                  controller: _totalAmountTextController,
                  onChanged: (value) {
                    var removeChars = value.replaceAll(",", "");
                    var intValue = int.tryParse(removeChars) ?? 0;
                    _getxRecord.totalAmount.value = intValue;
                  },
                  maxLength: 15,
                  keyboardType: TextInputType.number,
                  inputFormatters: [thousandSeparateFormat],
                  decoration: const InputDecoration(
                    hintText: 'ex) 15,000',
                    border: InputBorder.none,
                    counterText: "",
                  ),
                ),
              ),
              InsertInfoFrame(
                title: '1/N 금액',
                fontSize: 18,
                content: const Text(
                  '5,000원',
                  style: TextStyle(fontWeight: FontWeight.w800, fontSize: 19),
                ),
                alignment: MainAxisAlignment.start,
                showBorder: false,
              ),
              const SizedBox(height: 5),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Flexible(
                    flex: 2,
                    child: InsertInfoFrame(
                      title: '특별공제',
                      isOptional: true,
                      content: TextField(
                        controller: _specialDCTextController,
                      ),
                    ),
                  ),
                  Flexible(
                    flex: 1,
                    child: Container(
                      margin: const EdgeInsets.only(left: 8),
                      width: 90,
                      height: 45.h,
                      child: ElevatedButton(
                        onPressed: () {},
                        child: Text('멤버선택'),
                      ),
                    ),
                  ),
                ],
              ),
              Row(
                children: [
                  Flexible(
                    flex: 4,
                    child: InsertInfoFrame(
                      title: '공제멤버',
                      fontSize: 18,
                      showBorder: false,
                      height: 45,
                      content: ListView.builder(
                        shrinkWrap: true,
                        scrollDirection: Axis.horizontal,
                        itemCount: members.length,
                        itemBuilder: (context, index) {
                          return Center(
                            child: Text(
                              '${members[index]}, ',
                              style: const TextStyle(
                                fontSize: 19,
                                fontWeight: FontWeight.w800,
                              ),
                              maxLines: 1,
                              overflow: TextOverflow.fade,
                              softWrap: false,
                            ),
                          );
                        },
                      ),
                    ),
                  ),
                  Flexible(
                    flex: 1,
                    child: Center(
                      child: TextButton(
                        child: const Text(
                          '더보기',
                          style: TextStyle(color: Colors.grey),
                        ),
                        onPressed: () {},
                      ),
                    ),
                  )
                ],
              ),
              const Text('정산 모임 선택하기'),
              RecordGroupPicker(),
            ],
          ),
        ),
      ),
    );
  }
}
