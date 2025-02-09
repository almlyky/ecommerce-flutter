import 'package:flutter/material.dart';
import 'package:flutter_map/flutter_map.dart';
import 'package:latlong2/latlong.dart';

class MyMapPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text("خريطة مجانية")),
      body: FlutterMap(

        options: MapOptions(  
          initialCenter: LatLng(24.7136, 46.6753),
           // الرياض
            initialZoom: 10,
          // zoom: 10,
        ),
        children: [
          TileLayer(
            urlTemplate: "https://{s}.tile.openstreetmap.org/{z}/{x}/{y}.png",
            subdomains: ['a', 'b', 'c'],
          ),
          MarkerLayer(
            markers: [
              // Marker(point: point, child: child)
              Marker(
                point: LatLng(24.7136, 46.6753),
                width: 80,
                height: 80,
               child: Icon(Icons.location_pin, color: Colors.red, size: 40),
              ),
            ],
          ),
        ],
      ),
    );
  }
}
