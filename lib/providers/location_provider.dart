
import 'package:flutter/cupertino.dart';
import 'package:location/location.dart';
import 'package:straight_path_tracker/models/my_location_model.dart';

class LocationProvider extends ChangeNotifier {

  Location location = new Location();
  bool isLocationEnable=false;
  late LocationData currentLocation;

  bool isTrackingStart = false;
  bool isOnRoute = false;

  bool isPloyLineEnable=false;

  List<MyLocationModel> coordinatesList = [];


  double lowerThreshold=0;
  double startHeadingDirection=0;
  double upperThreshold=0;


  Future<bool> checkLocationPermission(BuildContext context) async {
    bool _serviceEnabled;
    PermissionStatus _permissionGranted;

    _permissionGranted = await location.hasPermission();
    if (_permissionGranted == PermissionStatus.denied) {
      _permissionGranted = await location.requestPermission();
      if (_permissionGranted != PermissionStatus.granted) {
        return false;
      }
    }

    _serviceEnabled = await location.serviceEnabled();
    if (!_serviceEnabled) {
      _serviceEnabled = await location.requestService();
      if (!_serviceEnabled) {
        return false;
      }
    }

    isLocationEnable=true;
    notifyListeners();
    getLiveLocation();

    return true;
  }

  Future<void> getLiveLocation() async {

    location.changeSettings(
        accuracy: LocationAccuracy.high,
        distanceFilter: 10);


    location.onLocationChanged.listen((LocationData location) {
      currentLocation = location;

      MyLocationModel myLocationModel = MyLocationModel(
          latitude: location.latitude!,
          longitude: location.longitude!,
          heading: location.heading!);

     if(isTrackingStart && isStraightPath(myLocationModel)){
       coordinatesList.add(myLocationModel);
     }

      notifyListeners();

    });
  }

  void startLocationTracking(){
    if(!isTrackingStart){

      isTrackingStart=true;
      startHeadingDirection=currentLocation.heading!;
      lowerThreshold=startHeadingDirection-10;
      upperThreshold=startHeadingDirection+10;

      print('Started heading point ${startHeadingDirection}');
    }else{
      isTrackingStart=false;
      coordinatesList.clear();
    }

    notifyListeners();

  }

void enablePolyline(){
    isPloyLineEnable=!isPloyLineEnable;
    notifyListeners();
}
  bool isStraightPath(MyLocationModel mylocationModel){

   if(mylocationModel.heading>lowerThreshold && mylocationModel.heading<upperThreshold){
     isOnRoute=true;
     return true;
   }

    isOnRoute=false;
    return false;
  }



}
