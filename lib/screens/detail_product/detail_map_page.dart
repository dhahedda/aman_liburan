import 'dart:collection';

import 'package:flutter/material.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:aman_liburan/models/response/api_response.dart';
import 'package:aman_liburan/utilities/size_config.dart';
import 'package:aman_liburan/utilities/styles/custom_styles.dart';

class DetailMapPage extends StatefulWidget {
  final ItemResponse detailItem;

  DetailMapPage({Key key, this.detailItem}) : super(key: key);

  @override
  _DetailMapPageState createState() => _DetailMapPageState(detailItem);
}

class _DetailMapPageState extends State<DetailMapPage> {
  final ItemResponse detailItem;
  Set<Marker> _markers = HashSet<Marker>();

  _DetailMapPageState(this.detailItem);

  void _onMapCreated(GoogleMapController controller) {
    setState(() {
      _markers.add(
        Marker(
          markerId: MarkerId(detailItem.id),
          position: LatLng(
              detailItem.location.latitude, detailItem.location.longitude),
          infoWindow:
              InfoWindow(title: detailItem.name, snippet: detailItem.name),
        ),
      );
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child:
            Stack(fit: StackFit.expand, overflow: Overflow.visible, children: [
          Container(
            width: SizeConfig.getWidth(context),
            height: SizeConfig.getHeight(context),
            child: ClipRRect(
              borderRadius: BorderRadius.all(Radius.circular(15.0)),
              child: GoogleMap(
                mapType: MapType.terrain,
                onMapCreated: _onMapCreated,
                initialCameraPosition: CameraPosition(
                  target: LatLng(
                    detailItem.location.latitude,
                    detailItem.location.longitude,
                  ),
                  zoom: 13,
                  // bearing: 30,
                  // tilt: 20,
                ),
                zoomGesturesEnabled: true,
                markers: _markers,
              ),
            ),
          ),
          Positioned(
            top: 0.0,
            right: 10.0,
            child: SafeArea(
              child: Container(
                decoration: BoxDecoration(
                  color: Colors.white.withOpacity(0.7),
                  borderRadius: BorderRadius.all(const Radius.circular(30.0)),
                ),
                child: IconButton(
                  icon: Icon(Icons.close, color: colorDarkBackground),
                  onPressed: () => Navigator.of(context).pop(),
                ),
              ),
            ),
          ),
        ]),
      ),
    );
  }
}
