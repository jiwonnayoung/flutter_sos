import 'package:flutter/material.dart';
import 'dart:async';
import 'dart:convert';

import 'package:geolocator/geolocator.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:flutter_sos/messenger.dart';
import 'package:geocoding/geocoding.dart';
import 'package:cloud_firestore/cloud_firestore.dart';



class MapSampleLocation extends StatefulWidget {
  const MapSampleLocation({super.key});

  @override
  State<MapSampleLocation> createState() => MapSampleState();
}

class MapSampleState extends State<MapSampleLocation> {
  final Set<Marker> _markers = {};
  final Completer<GoogleMapController> _controller = Completer();
  LatLng? _currentPosition;
  String address = '';
  String result1 = "";

  static const CameraPosition _konyang = CameraPosition(
    target: LatLng(36.30489, 127.3439),
    zoom: 15,
  );

  @override
  void initState() {
    super.initState();
    _getCurrentLocation();
  }

  bool extended =false;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: GoogleMap(
        markers: _markers,
        mapType: MapType.normal,
        initialCameraPosition: _currentPosition != null
            ? CameraPosition(target: _currentPosition!, zoom: 17)
            : _konyang,
        onMapCreated: (GoogleMapController controller) {
          _controller.complete(controller);
        },
        onTap: _onMapTapped,
      ),
      bottomNavigationBar: BottomAppBar(
        child: Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            const SizedBox(height: 10),
            FloatingActionButton.extended(
              label: const Text("재난위치 설정하기"),
              onPressed: () async{
                String address = await _getCurrentLocationAddress();
                // 얻어온 주소를 Firestore에 저장
                await saveAddressToFirestore(address);

                // 화면을 새로 고침하여 저장된 마커를 표시
                setState(() {});

                Navigator.push(
                  context,
                  MaterialPageRoute(builder: (context) => Messenger()), // 변경 필요
                );
              },
              backgroundColor: Colors.black,
            ),
            const SizedBox(width: 20), // 간격 조절
            FloatingActionButton.extended(
              label: const Text("닫기"),
              onPressed: () {
                Navigator.pop(context);
                // 두 번째 버튼의 기능
              },
              backgroundColor: Colors.blue,
            ),
          ],
        ),
      ),
    );
  }

  void _onMapTapped(LatLng latLng) {
    _addMarker(latLng);
    _getAddressFromLatLng(latLng);
  }

  void _addMarker(LatLng latLng) {
    setState(() {
      _markers.clear();
      _markers.add(Marker(
        markerId: MarkerId('Tapped Location'),
        position: latLng,
      ));
    });
  }

  void _getAddressFromLatLng(LatLng latLng) async {
    List<Placemark> placemarks =
    await placemarkFromCoordinates(latLng.latitude, latLng.longitude);
    Placemark placemark = placemarks.first;
    address = '${placemark.street}, ${placemark.locality}, ${placemark.administrativeArea}';
    print('${placemark.street}, ${placemark.locality}, ${placemark.administrativeArea}');
  }

  String _getFormattedAddress(LatLng latLng) {
    String address1 = address;

    return address1;
  }


  Future<void> _getCurrentLocation() async {
    try {
      Position position = await getCurrentLocation();
      setState(() {
        _currentPosition = LatLng(position.latitude, position.longitude);
      });
    } catch (e) {
      print('현재 위치를 가져오는 중 오류 발생: $e');
      // 에러를 처리하거나 사용자에게 친숙한 메시지를 표시하거나 권한을 다시 요청합니다.
    }

  }

  String getAddress() {
    if (_currentPosition != null) {
      return _getFormattedAddress(_currentPosition!);
    } else {
      return '주소를 확인할 수 없습니다.';
    }
  }

  Future<Position> getCurrentLocation() async {
    LocationPermission permission = await Geolocator.requestPermission();
    Position position = await Geolocator.getCurrentPosition(
      desiredAccuracy: LocationAccuracy.high,
    );
    double latitude = position.latitude;
    double longitude = position.longitude;

    print('현재 위치의 위도: $latitude, 경도: $longitude');

    return position;
  }

  // 현재 위치로 이동하는 함수


  Future<String> _getCurrentLocationAddress() async {
    if (_currentPosition != null) {
      return _getFormattedAddress(_currentPosition!);
    } else {
      return '주소를 확인할 수 없습니다.';
    }
  }

  Future<void> saveAddressToFirestore(String address) async {
    try {
      // Firestore 컬렉션 및 도큐먼트에 주소 정보 추가
      await FirebaseFirestore.instance.collection('addresses').doc('location').set({
        'address': address,
      });
      var result = await FirebaseFirestore.instance.collection('addresses').doc('location').get();

      print('주소가 Firestore에 저장되었습니다.');
      print(result.data());

    } catch (e) {
      print('주소를 Firestore에 저장하는 도중 오류가 발생했습니다: $e');
    }
  }


}