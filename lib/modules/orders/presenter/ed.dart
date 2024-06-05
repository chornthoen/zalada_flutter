import 'package:flutter/material.dart';
import 'package:geolocator/geolocator.dart';
import 'package:zalada_flutter/modules/orders/service/location_service.dart';


class EdScreen extends StatefulWidget {
  @override
  _EdScreenState createState() => _EdScreenState();
}

class _EdScreenState extends State<EdScreen> {
  String _locationMessage = "";
  String _addressMessage = "";

  void _getLocation() async {
    LocationService locationService = LocationService();
    Position position = await locationService.getCurrentLocation();
    setState(() {
      _locationMessage = "Latitude: ${position.latitude}, Longitude: ${position.longitude}";
    });

    String address = await locationService.getAddressFromLatLng(position);
    setState(() {
      _addressMessage = address;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Flutter Location Example'),
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            Text(_locationMessage),
            Text(_addressMessage),
            ElevatedButton(
              onPressed: _getLocation,
              child: Text('Get Location'),
            ),
          ],
        ),
      ),
    );
  }
}