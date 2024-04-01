import 'package:flutter/material.dart';

class CustomScroll extends StatefulWidget {

  CustomScroll({super.key});
  final  pages = [
    page(color: Colors.red),
    page(color: Colors.green),
    page(color: Colors.orange),
  ];
  @override
  State<CustomScroll> createState() => _CustomScrollState();
}

class _CustomScrollState extends State<CustomScroll> {
  late PageController _pageController;
  int _currentPage = 0;
  double _dragStartX = 0.0;

  @override
  void initState() {
    super.initState();
    _pageController = PageController();
  }

  @override
  void dispose() {
    _pageController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(
        children: [
          PageView.builder(
            controller: _pageController,
            itemCount: widget.pages.length,
            itemBuilder: (context, index) {
              return Center(
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Text(
                      'Page ${index + 1}',
                      style: TextStyle(fontSize: 24),
                    ),
                    SizedBox(height: 20),
                    // Example clickable child widget
                    ElevatedButton(
                      onPressed: () {
                        // Handle button click
                        print('Button on Page ${index + 1} clicked!');
                      },
                      child: Text('Click Me'),
                    ),
                  ],
                ),
              );
            },
            onPageChanged: (index) {
              setState(() {
                _currentPage = index;
              });
            },
          ),
          Positioned(
            left: 0,
            right: 0,
            bottom: 0,
            top: 0,
            child: GestureDetector(
              // Detect horizontal swipes for page navigation
              onHorizontalDragStart: (details) {
                _dragStartX = details.globalPosition.dx;
              },
              onHorizontalDragUpdate: (details) {
                // Calculate drag distance
                final dragDistance = details.globalPosition.dx - _dragStartX;
                final viewportWidth = MediaQuery.of(context).size.width;
                // Calculate percentage of viewport width to decide how much to change the page
                final dragPercentage = dragDistance / viewportWidth;

                // Update page controller position without animation
                _pageController.position.jumpTo(_pageController.position.pixels - dragPercentage * viewportWidth);
              },
              onHorizontalDragEnd: (details) {
                // Update current page based on page controller position
                setState(() {
                  _currentPage = _pageController.page!.round();
                });
              },
              child: Container(
                color: Colors.white10,
              ),
            ),
          ),
        ],
      ),
    );
  }
}


Widget page({required Color color}){
  return Container(
    color: color,
  );
}