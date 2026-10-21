import 'dart:async';

import 'package:flutter/material.dart';
import 'package:geolocator/geolocator.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';

class MapPage extends StatefulWidget {
  const MapPage({super.key});

  @override
  State<MapPage> createState() => _MapPageState();
}

class _MapPageState extends State<MapPage> {
  late GoogleMapController mapController;
  late StreamSubscription<Position> positionStreamSubscription;
  LocationPermission? permission;
  bool? locationServiceEnabled;
  bool permissionCheckComplete = false;

  void showMap() {
    setState(() {
      permissionCheckComplete = true;
    });
  }

  Future<void> isLocationTurnedOn() async {
    locationServiceEnabled = await Geolocator.isLocationServiceEnabled();
    setState(() {});
  }

  Future<void> checkPermission() async {
    permission = await Geolocator.checkPermission();
    setState(() {});
  }

  Future<void> requestPermission() async {
    permission = await Geolocator.requestPermission();
    setState(() {});
  }

  bool get hasPermission {
    return ![
      LocationPermission.denied,
      LocationPermission.deniedForever,
      LocationPermission.unableToDetermine,
    ].contains(permission);
  }

  void onMapCreated(GoogleMapController controller) async {
    mapController = controller;
    await checkPermission();
    if (!hasPermission) {
      await requestPermission();
      if (!hasPermission) {
        return;
      }
    }
    positionStreamSubscription =
        Geolocator.getPositionStream(
          locationSettings: LocationSettings(
            accuracy: LocationAccuracy.bestForNavigation,
            distanceFilter: 0,
          ),
        ).listen((Position position) {
          mapController.animateCamera(
            CameraUpdate.newLatLng(
              LatLng(position.latitude, position.longitude),
            ),
          );
        });
  }

  @override
  void dispose() {
    positionStreamSubscription.cancel();
    mapController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text("Google Maps Demo")),
      body: Center(
        child: permissionCheckComplete
            ? GoogleMap(
                onMapCreated: onMapCreated,
                myLocationButtonEnabled: true,
                myLocationEnabled: true,
                onCameraMove: (CameraPosition cameraPosition) {},
                onCameraIdle: () async {},
                initialCameraPosition: const CameraPosition(
                  target: LatLng(51, 0),
                  zoom: 9,
                ),
                markers: {},
              )
            : Column(
                mainAxisSize: MainAxisSize.min,
                children: [
                  FilledButton(
                    child: Text("Check if Location Enabled"),
                    onPressed: isLocationTurnedOn,
                  ),
                  Text(
                    "Location Turned on? ${locationServiceEnabled == null ? 'Unknown' : locationServiceEnabled!}",
                  ),
                  if (locationServiceEnabled != null &&
                      !locationServiceEnabled!)
                    Text(
                      "This means the GPS is completely turned off for the device.",
                    ),
                  SizedBox(height: 20),
                  FilledButton(
                    child: Text("Check Permission"),
                    onPressed: checkPermission,
                  ),
                  Text(
                    "Permission? ${permission == null ? 'Unknown' : permission!.name}",
                  ),
                  SizedBox(height: 20),
                  FilledButton(
                    child: Text("Request Permission"),
                    onPressed: requestPermission,
                  ),
                  SizedBox(height: 20),
                  FilledButton(child: Text("Show map"), onPressed: showMap),
                ],
              ),
      ),
    );
  }
}
