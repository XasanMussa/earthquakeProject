import 'package:flutter/material.dart';
import 'package:flutter_map/flutter_map.dart';
import 'package:latlong2/latlong.dart';

class MapPage extends StatefulWidget {
  const MapPage({super.key});

  @override
  State<MapPage> createState() => _MapPageState();
}

class _MapPageState extends State<MapPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: FlutterMap(
            options: MapOptions(
              initialCenter: LatLng(2.036722350893286, 45.30067514030088),
              initialZoom: 17,
              interactionOptions: const InteractionOptions(
                  flags: ~InteractiveFlag.doubleTapZoom),
            ),
            children: [
          openStreetMapTileLater,
          MarkerLayer(markers: [
            Marker(
              point: LatLng(2.0367866832396975, 45.300943361192274),
              width: 60,
              height: 60,
              alignment: Alignment.centerLeft,
              child: Icon(
                Icons.location_pin,
                size: 60,
                color: Colors.red,
              ),
            ),
          ]),
        ]));
  }

  TileLayer get openStreetMapTileLater => TileLayer(
        urlTemplate: 'https://tile.openstreetmap.org/{z}/{x}/{y}.png',
        userAgentPackageName: 'dev.fleaflet.flutter_map.example',
      );
}
