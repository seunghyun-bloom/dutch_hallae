import 'dart:async';

import 'package:flutter/material.dart';
import 'package:naver_map_plugin/naver_map_plugin.dart';

import '../../utilities/toast.dart';

class MapPage extends StatefulWidget {
  const MapPage({Key? key}) : super(key: key);

  @override
  State<MapPage> createState() => _MapPageState();
}

class _MapPageState extends State<MapPage> {
  Completer<NaverMapController> _controller = Completer();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: NaverMap(
        onMapCreated: onMapCreated,
        locationButtonEnable: true,
        indoorEnable: true,
        markers: [
          Marker(
            markerId: 'temp',
            position: const LatLng(37.47784109625723, 126.96112696391705),
            captionColor: Colors.red,
            infoWindow: '제훈이 취업 기념 모임',
            captionText: '고딩 동창들',
          ),
        ],
      ),
      floatingActionButton: FloatingActionButton(
        heroTag: 'map page',
        child: const Icon(Icons.add),
        onPressed: () => showToast('맵 정산 시작'),
      ),
    );
  }

  onMapCreated(NaverMapController controller) {
    if (_controller.isCompleted) _controller = Completer();
    _controller.complete(controller);
  }
}
