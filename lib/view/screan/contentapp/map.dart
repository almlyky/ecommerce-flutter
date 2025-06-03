import 'package:eccommerce_new/controler/contentapp/mapcontroller.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:geocoding/geocoding.dart';
import 'package:get/get.dart';
import 'package:mapbox_maps_flutter/mapbox_maps_flutter.dart';

class Mapbox extends StatelessWidget {
  const Mapbox({super.key});

  @override
  Widget build(BuildContext context) {
    Mapcontroller mapcontroller = Get.put(Mapcontroller());
    return Scaffold(
      appBar: AppBar(title: Text("Map")),
      body: Column(
        children: [
          Expanded(
            child: MapWidget(
              // styleUri: "mapbox://styles/mapbox/streets-v1
              onMapCreated: (MapboxMap mapboxMap) async {
                mapcontroller.mapboxMap = mapboxMap;
                final ByteData bytes =
                    await rootBundle.load('assets/image/marks.png');
                mapcontroller.markerImage = bytes.buffer.asUint8List();
                mapcontroller.pointAnnotationManager =
                    await mapboxMap.annotations.createPointAnnotationManager();
                await mapcontroller.pointAnnotationManager.create(
                  PointAnnotationOptions(
                    geometry: mapcontroller.markerpoint!,
                    image: mapcontroller.markerImage,
                    iconSize: 0.1,
                  ),
                );
              },
            
              onTapListener: (MapContentGestureContext context) async {
                final lng = context.point.coordinates.lng;
                final lat = context.point.coordinates.lat;
                Point markerpoint = Point(coordinates: Position(lng, lat));
                mapcontroller.placemarks = await placemarkFromCoordinates(
                    lat.toDouble(), lng.toDouble());
                // احذف الماركرات القديمة إن أردت
                await mapcontroller.pointAnnotationManager.deleteAll();
            
                // أضف ماركر جديد
                await mapcontroller.pointAnnotationManager.create(
                  PointAnnotationOptions(
                    geometry: markerpoint,
                    image: mapcontroller.markerImage, // الذي حمّلته مسبقاً
                    iconSize: 0.1,
                  ),
                );
              },
            
              cameraOptions: CameraOptions(
                  center: Point(
                      coordinates:
                          Position(mapcontroller.long!, mapcontroller.lat!)),
                  anchor: ScreenCoordinate(x: 0, y: 0),
                  zoom: 16,
                  bearing: 0,
                  pitch: 0),
            ),
          ),
          ElevatedButton(
            onPressed: mapcontroller.saveLocation,
            child: Text("Save Location"),
          ),
        ],
      ),
    );
  }
}
