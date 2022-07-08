import 'dart:async';

import 'package:dutch_hallae/utilities/toast.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:naver_map_plugin/naver_map_plugin.dart';

class MiniMap extends StatefulWidget {
  double x;
  double y;
  MiniMap({Key? key, required this.x, required this.y}) : super(key: key);

  @override
  State<MiniMap> createState() => _MiniMapState();
}

class _MiniMapState extends State<MiniMap> {
  Completer<NaverMapController> naverMapController = Completer();

  @override
  Widget build(BuildContext context) {
    LatLng latLng = LatLng(widget.y, widget.x);
    moveCamera(latLng);

    showToast('rebuild: $latLng');

    return SizedBox(
      width: Get.mediaQuery.size.width,
      height: Get.mediaQuery.size.width * 0.5,
      child: NaverMap(
        onMapCreated: _onMapCreated,
        initialCameraPosition: CameraPosition(
          target: latLng,
        ),
        tiltGestureEnable: false,
        zoomGestureEnable: false,
        rotationGestureEnable: false,
        scrollGestureEnable: false,
        markers: [
          Marker(
            markerId: 'pickedPlace',
            position: latLng,
          ),
        ],
      ),
    );
  }

  _onMapCreated(NaverMapController controller) {
    if (naverMapController.isCompleted) naverMapController = Completer();
    naverMapController.complete(controller);
  }

  moveCamera(LatLng latLng) async {
    var controller = await naverMapController.future;
    controller.moveCamera(CameraUpdate.scrollTo(latLng));
    showToast('moveCamera called');
  }
}
