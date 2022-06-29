import 'package:dutch_hallae/utilities/styles.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';

class MainRecordComponent extends StatelessWidget {
  const MainRecordComponent({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: 300.h,
      child: ListView.builder(
        physics: const ClampingScrollPhysics(),
        shrinkWrap: true,
        scrollDirection: Axis.horizontal,
        itemCount: 6,
        itemBuilder: (context, index) {
          return MainRecordBubble(
            name: '${index + 1}번째 모임',
            image:
                'https://cdn.trendbiz.co.kr/news/photo/202205/7113_14296_5118.png',
            members: ['김채원', '사쿠라', '홍은채', '카즈하', '허윤진'],
            date: '2022/06/0${index + 1}',
            totalAmount: 130000,
          );
        },
      ),
    );
  }
}

class MainRecordBubble extends StatelessWidget {
  String name;
  String image;
  List members;
  String date;
  int totalAmount;
  MainRecordBubble({
    Key? key,
    required this.name,
    required this.image,
    required this.members,
    required this.date,
    required this.totalAmount,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
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
                            itemCount: members.length,
                            itemBuilder: (context, index) {
                              return Text(
                                '${members[index]}  ',
                                style: whiteText,
                                maxLines: 1,
                                overflow: TextOverflow.fade,
                                softWrap: false,
                              );
                            },
                          ),
                        ),
                        Text(
                          date,
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
                name,
                style: TextStyle(
                  fontSize: 18.sp,
                ),
              ),
            ),
          ),
          Padding(
            padding: EdgeInsets.symmetric(horizontal: 10.w),
            child: const Divider(
              height: 0,
              color: Colors.grey,
            ),
          ),
          SizedBox(
            height: 50.h,
            child: Center(
              child: Text('총 $totalAmount원'),
            ),
          ),
        ],
      ),
    );
  }
}
