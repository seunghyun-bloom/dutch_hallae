import 'package:dutch_hallae/getx/controller/place_controller.dart';
import 'package:dutch_hallae/utilities/styles.dart';
import 'package:flutter/material.dart';
import 'package:flutter_animated_dialog/flutter_animated_dialog.dart';
import 'package:get/get.dart';

class PlaceSearcher {
  BuildContext context;
  PlaceSearcher({required this.context}) {
    showAnimatedDialog(
        context: context,
        barrierDismissible: true,
        animationType: DialogTransitionType.scale,
        duration: const Duration(milliseconds: 300),
        builder: (BuildContext context) {
          return PlaceSearcherContents();
        });
  }
}

class PlaceSearcherContents extends GetView<PlaceController> {
  const PlaceSearcherContents({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: AlertDialog(
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
        title: TextField(
          autofocus: true,
          onChanged: (value) {
            controller.searchQuery(value);
          },
        ),
        content: SizedBox(
          width: Get.mediaQuery.size.width,
          height: Get.mediaQuery.size.height * 0.5,
          child: SingleChildScrollView(
            child: Obx(
              () => ListView.builder(
                physics: const ScrollPhysics(),
                shrinkWrap: true,
                itemCount: controller.searchedPlaces.length,
                itemBuilder: (context, index) {
                  if (controller.searchedPlaces.isEmpty) {
                    return const Text('no data');
                  }
                  return InkWell(
                    onTap: () {
                      controller.pickPlace(
                        controller.searchedPlaces[index]['title']!,
                        controller.searchedPlaces[index]['address']!,
                        controller.searchedPlaces[index]['category']!,
                        controller.searchedPlaces[index]['mapx']!,
                        controller.searchedPlaces[index]['mapy']!,
                      );
                      Get.back();
                    },
                    child: ListTile(
                      title: Text(controller.searchedPlaces[index]['title']!),
                      subtitle: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            controller.searchedPlaces[index]['category']!,
                            style: const TextStyle(
                                fontSize: 12, color: Palette.basicBlue),
                          ),
                          Text(
                            controller.searchedPlaces[index]['address']!,
                            style: const TextStyle(fontSize: 14),
                          ),
                        ],
                      ),
                      isThreeLine: true,
                    ),
                  );
                },
              ),
            ),
          ),
        ),
      ),
    );
  }
}
