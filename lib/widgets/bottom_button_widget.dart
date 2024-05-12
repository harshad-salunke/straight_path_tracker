import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:straight_path_tracker/providers/location_provider.dart';

import 'my_button.dart';
class BottomButtonWidget extends StatelessWidget {
  const BottomButtonWidget({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return  Consumer<LocationProvider>(builder: (_,locationProvider,__){
      return Positioned(
          left: 0,
          bottom: 5,
          right: 0,
          child: Container(
            margin: EdgeInsets.all(10),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                Expanded(
                    child: MyElevatedButton(
                        title:locationProvider.isTrackingStart? 'Stop':'Start',
                        height: 10,
                        width: 100,
                        fontsize: 16,
                        radius: 10,
                        bg_color:locationProvider.isTrackingStart? Colors.red:Colors.green,
                        text_color: Colors.white,
                        fontWeight: FontWeight.bold,
                        onPressed: () {
                          locationProvider.startLocationTracking();
                        })),
                SizedBox(
                  width: 10,
                ),
                Expanded(
                  child: MyElevatedButton(
                      title:locationProvider.isPloyLineEnable?'Clear':'Polyline',
                      height: 10,
                      width: 100,
                      fontsize: 12,
                      radius: 10,
                      bg_color: Colors.white,
                      text_color: Colors.black,

                      fontWeight: FontWeight.bold,
                      onPressed: () {
                        locationProvider.enablePolyline();
                      }),
                )
              ],
            ),
          ));
    });
  }
}
