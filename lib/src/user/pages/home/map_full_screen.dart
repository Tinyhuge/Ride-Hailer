// ignore_for_file: avoid_print

import 'package:flutter/material.dart';
import 'package:mapmyindia_gl/mapmyindia_gl.dart';
import 'package:ride_hailer/src/user/constants/api_key.dart';

class MapFullScreen extends StatefulWidget {
  MapFullScreen({Key? key}) : super(key: key);

  @override
  State<MapFullScreen> createState() => _MapFullScreenState();
}

class _MapFullScreenState extends State<MapFullScreen> {
  void initMapMyIndia() {
    MapmyIndiaAccountManager.setMapSDKKey(ApiKey.REST_API_KEY);
    MapmyIndiaAccountManager.setRestAPIKey(ApiKey.REST_API_KEY);
    MapmyIndiaAccountManager.setAtlasClientId(ApiKey.ATLAS_CLIENT_ID);
    MapmyIndiaAccountManager.setAtlasClientSecret(ApiKey.ATLAS_CLIENT_SECRET);
  }

  Future<void> initMapOperations() async {
    mapPlaceSearch().callPlaceDetail().then((value) {
      print("Place Details : ${value!.latitude}");
      print("Place Details : ${value!.city}");
      print("Place Details : ${value!.placeInfo}");
      print("Place Details : ${value!.placeName}");
      print("Place Details : ${value!.pincode}");
    }).onError((error, stackTrace) {
      print("Map Place Search Error occured...$error");
    });
  }

  @override
  void initState() {
    initMapMyIndia();
    initMapOperations();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: SafeArea(
            child: Container(
      child: Center(
        child: mapMyIndiaWidget(),
      ),
    )));
  }

  Text dummyText() {
    return const Text(
      "Map Full Screen..",
      style: TextStyle(fontSize: 18, fontWeight: FontWeight.w800),
    );
  }

  MapmyIndiaPlaceDetail mapPlaceSearch() {
    return MapmyIndiaPlaceDetail(eLoc: "delhi");
  }

  MapmyIndiaTextSearch mapMyIndiaPicker() {
    return MapmyIndiaTextSearch(query: "kashmir");
  }

  MapmyIndiaNearby mapNearBy() {
    return MapmyIndiaNearby(keyword: "gaya");
  }

  MapmyIndiaAutoSuggest mapMy() {
    return MapmyIndiaAutoSuggest(query: "delhi");
  }

  Widget mapMyIndiaWidget() {
    return MapmyIndiaMap(
      zoomGesturesEnabled: true,
      compassEnabled: true,
      myLocationEnabled: true,
      tiltGesturesEnabled: true,
      scrollGesturesEnabled: true,
      initialCameraPosition: const CameraPosition(
        target: LatLng(12.9587464, 77.5573456),
        zoom: 14.0,
      ),
      onMapCreated: (map) => {
        // mapController = map,
      },
      onMapClick: (point, coordinates) {
        print("onMapClick : $coordinates");
      },
      onMapLongClick: (point, coordinates) {
        print("onMapLongClick : $coordinates");
      },
      onMapError: (code, message) {
        print("onMapError : $message");
      },
    );
  }
}
