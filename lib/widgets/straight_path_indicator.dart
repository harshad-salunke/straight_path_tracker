import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:straight_path_tracker/providers/location_provider.dart';
class StraightPathIndicator extends StatelessWidget {
  const StraightPathIndicator({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return  Consumer<LocationProvider>(builder:(_,locationProvider,__){

      return locationProvider.isTrackingStart?
      Positioned(
          left: 0,
          top: 50,
          right: 0,
          child: Container(
            margin: EdgeInsets.all(10),
            decoration: BoxDecoration(
                color: locationProvider.isOnRoute?Colors.green:Colors.red,
                borderRadius: BorderRadius.circular(10)),
            child: Column(
              children: [
                SizedBox(
                  height: 10,
                ),
                Row(
                  mainAxisAlignment:
                  MainAxisAlignment.spaceEvenly,
                  children: [
                    Text(
                      'LB - ${locationProvider.lowerThreshold.round()}',
                      style: TextStyle(
                          fontSize: 16,

                          fontWeight: FontWeight.bold,
                          color: Colors.white),
                    ),
                    Text(
                      '${locationProvider.currentLocation.heading?.round()}',
                      style: TextStyle(
                          fontWeight: FontWeight.w900,
                          fontSize: 16,
                          color: Colors.white),
                    ),
                    Text(
                      'UB - ${locationProvider.upperThreshold.round()}',
                      style: TextStyle(
                          fontWeight: FontWeight.bold,
                          fontSize: 16,
                          color: Colors.white),
                    ),
                  ],
                ),
                SizedBox(
                  height: 7,
                ),
                Text(locationProvider.isOnRoute?'Your are on straigth line':'Your are not on straigth line',
                style: TextStyle(
                  color: Colors.white
                ),),
                SizedBox(
                  height: 5,
                ),
              ],
            ),
          )):Container();
    });
  }
}
