import 'package:flutter/material.dart';
import 'package:flutter_sos/views_screen.dart';

class MapScreen extends StatefulWidget {
  const MapScreen({super.key});

  @override
  State<MapScreen> createState() => _MapScreenState();
}

class _MapScreenState extends State<MapScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.white,
        iconTheme: IconThemeData(color: Colors.black), // 뒤로가기 버튼 색상
        elevation: 0, // 그림자 없애기
      ),

      body: Container(
        color: Colors.white, // 흰 바탕 색상
        child: const Center(
          child: Text(
            'Map Screen',
            style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
          ),
        ),
      ),

    );
  }
}
