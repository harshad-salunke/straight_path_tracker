import 'dart:async';

import 'package:flutter/material.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:location/location.dart';
import 'package:provider/provider.dart';
import 'package:straight_path_tracker/models/my_location_model.dart';
import 'package:straight_path_tracker/widgets/my_button.dart';

import '../providers/location_provider.dart';
import '../widgets/bottom_button_widget.dart';
import '../widgets/straight_path_indicator.dart';

class StraightPathMapScreen extends StatefulWidget {
  const StraightPathMapScreen({Key? key}) : super(key: key);

  @override
  State<StraightPathMapScreen> createState() => _StraightPathMapScreenState();
}

class _StraightPathMapScreenState extends State<StraightPathMapScreen> {
  final Completer<GoogleMapController> _controller =
      Completer<GoogleMapController>();

  late GoogleMapController myLocatoinCamera;

  static const CameraPosition _kGooglePlex = CameraPosition(
    target: LatLng(18.43655463412377, 73.89477824953909),
    zoom: 10.0,
  );

  @override
  void initState() {
    super.initState();
    Provider.of<LocationProvider>(context, listen: false)
        .checkLocationPermission(context);
  }
  final Set<Polyline> _polylines = {};

  Set<Marker> coordinateMarkers = {};
  bool isFirstime = true;
  bool isMapCreated=false;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        child: Consumer<LocationProvider>(builder: (_, locationProvider, __) {
          if(isMapCreated){
            getCurrentLocation(locationProvider);
          }

          return Container(
            child: Column(
              children: [
                Expanded(
                  child: Stack(
                    children: [
                      Container(
                        child: GoogleMap(
                          mapType: MapType.hybrid,
                          initialCameraPosition: _kGooglePlex,
                          myLocationEnabled: locationProvider.isLocationEnable,
                          myLocationButtonEnabled: locationProvider.isLocationEnable,
                          markers: coordinateMarkers,
                          polylines: _polylines,
                          padding: EdgeInsets.fromLTRB(0, 110, 0, 50),
                          onMapCreated: (GoogleMapController controller) {
                            _controller.complete(controller);
                            isMapCreated=true;
                          },
                        ),
                      ),
                      StraightPathIndicator(),
                      BottomButtonWidget(),
                    ],
                  ),
                ),
              ],
            ),
          );
        }),
      ),
    );
  }

  void getCurrentLocation(LocationProvider locationProvider) async {
    LatLng currentLatlng = LatLng(locationProvider.currentLocation.latitude!,
        locationProvider.currentLocation.longitude!);

    myLocatoinCamera = await _controller.future;

    if (isFirstime) {
      myLocatoinCamera.animateCamera(CameraUpdate.newCameraPosition(
          CameraPosition(zoom: 18.0, target: currentLatlng)));
      isFirstime = false;
    }

    coordinateMarkers.clear();
    _polylines.clear();

    locationProvider.coordinatesList.forEach((cordinate) {
      Marker marker = getMarker(cordinate);
      coordinateMarkers.add(marker);
    });

    if(locationProvider.isPloyLineEnable){
      genratePolyLine(locationProvider);
    }

    setState(() {});

  }

  Marker getMarker(MyLocationModel mylocation) {
    LatLng currentLatlng = LatLng(mylocation.latitude, mylocation.longitude);

    Marker locationMarker = Marker(
        markerId:
            MarkerId('${currentLatlng.latitude}-${currentLatlng.longitude}'),
        position: currentLatlng,
        infoWindow: InfoWindow(title: 'Location', onTap: () {}));
    return locationMarker;
  }

  void genratePolyLine(LocationProvider locationProvider) {
    List<LatLng> coordinates = [];
    locationProvider.coordinatesList.forEach((coordinate){
      LatLng latLng=LatLng(coordinate.latitude, coordinate.longitude);
      coordinates.add(latLng);
    });
    Polyline polyline = Polyline(
      polylineId: PolylineId('Straight Path'),
      color: Colors.blue, // Polyline color
      points: coordinates,
      width: 3, // Polyline width
    );
    _polylines.add(polyline);

  }


}
