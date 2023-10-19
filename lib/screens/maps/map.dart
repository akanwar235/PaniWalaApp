import 'package:flutter/material.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:geolocator/geolocator.dart';
// import 'package:example/services/location_service.dart';
import 'package:open_street_map_search_and_pick/open_street_map_search_and_pick.dart';
import 'package:water_order/screens/bottomnav/bottomnav.dart';
import 'package:water_order/utils/colors.dart';
import 'package:water_order/utils/global.dart';

import 'package:water_order/widget/snakbar.dart';

class Maps extends StatefulWidget {
  const Maps({super.key});

  @override
  State<Maps> createState() => _MapsState();
}

class _MapsState extends State<Maps> {
  late double currLatitude;
  late double currLongitude;
  FlutterSecureStorage storage = const FlutterSecureStorage();

  Future<Position> _determinePosition() async {
    bool serviceEnabled;
    LocationPermission permission;

    serviceEnabled = await Geolocator.isLocationServiceEnabled();

    permission = await Geolocator.checkPermission();
    if (permission == LocationPermission.denied) {
      permission = await Geolocator.requestPermission();
      if (permission == LocationPermission.denied) {
        return Future.error('Location permissions are denied');
      }
    }

    if (!serviceEnabled) {
      // return Future.error('Location services are disabled.');
      showCustomSnackBar("Location services are disabled.");
    }
    if (permission == LocationPermission.deniedForever) {
      return Future.error(
          'Location permissions are permanently denied, we cannot request permissions.');
    }
    return await Geolocator.getCurrentPosition();
  }

  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: FutureBuilder(
      future: _determinePosition(),
      builder: (context, snapshot) {
        if (snapshot.hasData) {
          currLatitude = snapshot.data!.latitude;
          currLongitude = snapshot.data!.longitude;

          VarGlobal.currlati = currLatitude;
          VarGlobal.currlongi = currLongitude;

          storage.write(key: "LATI", value: currLatitude.toString());
          storage.write(key: "LONG", value: currLatitude.toString());

          return OpenStreetMapSearchAndPick(
            center: LatLong(currLatitude, currLongitude),
            buttonColor: appColor,
            buttonText: 'Set Current Location',
            onPicked: (pickedData) {
              print(pickedData.address);

              currLatitude = pickedData.latLong.latitude;
              currLongitude = pickedData.latLong.longitude;

              VarGlobal.currlati = currLatitude;
              VarGlobal.currlongi = currLongitude;

              storage.write(key: "LATI", value: currLatitude.toString());
              storage.write(key: "LONG", value: currLongitude.toString());

              Navigator.pushAndRemoveUntil(
                  context,
                  MaterialPageRoute(builder: (context) => const BottomNav()),
                  (route) => false);
            },
          );
        }

        return WillPopScope(
          onWillPop: () async {
            return false;
          },
          child: Center(
              child: Text(
            "Getting your current location...",
            style: getstyle(fontsize: 20),
          )),
        );
      },
    ));
  }
}
