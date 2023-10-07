import 'package:flutter/material.dart';
import 'package:flutter_sos/home_screen.dart';
import 'package:flutter_vector_icons/flutter_vector_icons.dart';

class Views extends StatelessWidget {
  const Views({super.key});

  @override
  Widget build(BuildContext context) {
    return  Scaffold(
      body: SafeArea (
        child: Stack(
          children: [
            PageView(
              children: [
                HomeScreen(),
              ],
            ),
            Positioned(
              bottom: 0,
              child: Container(
                height: 90,
                width: MediaQuery.of(context).size.width,
                decoration: BoxDecoration(
                  color: Color.fromRGBO(31, 40, 71, 1),
                  borderRadius: BorderRadius.only(
                    topLeft: Radius.circular(45),
                    topRight: Radius.circular(45),
                  )
                ),
                child: Padding(
                  padding: EdgeInsets.symmetric(horizontal: 40),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Icon(MaterialCommunityIcons.map_marker,
                      color: Colors.white,
                      ),
                      Icon(
                        Octicons.report,
                        color: Colors.white,
                      ),
                      Icon(
                        Feather.settings,
                        color: Colors.white,
                      ),
                    ],
                  ),
                ),
              ),
            )
          ],
        ),
      ),
    );
  }

}
