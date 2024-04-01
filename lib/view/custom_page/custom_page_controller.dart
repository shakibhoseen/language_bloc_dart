import 'package:flutter/material.dart';

class CustomPageViewController extends ChangeNotifier {
  late PageController _pageController;
  late int _currentPage;
  double _dragStartX = 0.0;

  CustomPageViewController(int initialPage) {
    _pageController = PageController(initialPage: initialPage);
    _currentPage = initialPage;

    _pageController.addListener(() {
      if (!_pageController.position.isScrollingNotifier.value) {
        _currentPage = _pageController.page!.round();
        notifyListeners();
      }
    });
  }

  PageController get pageController => _pageController;

  int get currentPage => _currentPage;

  void handleDragStart(DragStartDetails details) {
    _dragStartX = details.globalPosition.dx;
  }

  void handleDragUpdate(DragUpdateDetails details, BuildContext context) {
    final dragDistance = details.globalPosition.dx - _dragStartX;
    final viewportWidth = MediaQuery.of(context).size.width;
    final dragPercentage = dragDistance / viewportWidth;
    final newPage = (_currentPage - dragPercentage).clamp(0.0, 2.0);
    _pageController.jumpToPage(newPage.toInt());
  }

  void handleDragEnd(DragEndDetails details) {
    final nearestPage = (_currentPage + 0.5).toInt();
    _pageController.animateToPage(
      nearestPage,
      duration: Duration(milliseconds: 300),
      curve: Curves.ease,
    );
  }
}
