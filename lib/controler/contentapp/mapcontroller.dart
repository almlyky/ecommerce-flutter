import 'dart:math';
import 'dart:typed_data';

import 'package:geocoding/geocoding.dart';
import 'package:geolocator/geolocator.dart';
import 'package:get/get.dart';
import 'package:mapbox_maps_flutter/mapbox_maps_flutter.dart' as mapbox;

class Mapcontroller extends GetxController {
  mapbox.MapboxMap? mapboxMap;
  double? lat, long;
  // double lat1 = 13.9750500564672;
  // double long1 = 44.176088331355906;

  // double lat2 = 13.973684028135997;
  // double long2 = 44.17566630890177;

  late mapbox.PointAnnotationManager pointAnnotationManager;
  late Uint8List markerImage;
  List<Placemark> placemarks = [];

  //  late mapbox.PointAnnotationManager pointAnnotationManager;

  mapbox.Point? markerpoint;

  getcurrentlocation() async {
    bool serviceEnabled;
    LocationPermission permission;

    serviceEnabled = await Geolocator.isLocationServiceEnabled();
    if (!serviceEnabled) {
      print("the location is disable");
    }
    permission = await Geolocator.checkPermission();
    if (permission == LocationPermission.denied) {
      permission = await Geolocator.requestPermission();
      if (permission == LocationPermission.denied) {
        print("Location permissions are denied");
        return Future.error('Location permissions are denied');
      }
    }

    if (permission == LocationPermission.always) {
      Position position = await Geolocator.getCurrentPosition();
      lat = position.latitude;
      long = position.longitude;
      markerpoint= mapbox.Point(
      coordinates: mapbox.Position(long!,lat!));
      placemarks = await placemarkFromCoordinates(lat!, long!);
      update();

      // double distance = Geolocator.distanceBetween(lat1, long1, lat2, long2);

      // print("======================== $distance");
    }
  }

  saveLocation() {
    update();
    Get.back();
  }

  @override
  void onInit() async {
    getcurrentlocation();
    super.onInit();
  }
}
