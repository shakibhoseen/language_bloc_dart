import 'package:flutter/material.dart';

class PainScreen extends StatelessWidget {
  const PainScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        width: double.maxFinite,
        decoration: const BoxDecoration(

          image: DecorationImage(image: NetworkImage('https://img.freepik.com/free-photo/painting-mountain-lake-with-mountain-background_188544-9126.jpg'), fit: BoxFit.cover),
        ),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [

            Center(
              child: Container(
                clipBehavior: Clip.antiAlias,
                decoration: const BoxDecoration(
                  borderRadius: BorderRadius.only(
                      bottomRight: Radius.elliptical(50, 50)),
                ),
                child: Container(
                  decoration: const BoxDecoration(
                    color: Colors.white30,
                    border: Border(
                      top: BorderSide(color: Colors.red, width: 1.0),
                      // Top border
                      left: BorderSide(color: Colors.blue, width: 1.0),
                      // Left border
                      bottom: BorderSide(color: Colors.green, width: 1.0),
                      // Bottom border
                      right:
                      BorderSide(color: Colors.yellow, width: 1.0, ), // Right border
                    ),
                  ),
                  height: 200,
                  width: 200,
                ),
              ),
            )
          ],
        ),
      ),
    );
  }
}
