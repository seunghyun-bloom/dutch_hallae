import 'dart:async';

import 'package:flutter/material.dart';
import 'package:naver_map_plugin/naver_map_plugin.dart';

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
        mapType: MapType.Basic,
        locationButtonEnable: true,
      ),
    );
  }

  onMapCreated(NaverMapController controller) {
    if (_controller.isCompleted) _controller = Completer();
    _controller.complete(controller);
  }
}
