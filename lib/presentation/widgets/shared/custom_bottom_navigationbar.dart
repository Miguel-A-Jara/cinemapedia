// Flutter
import 'package:flutter/material.dart';

// Third Party
import 'package:go_router/go_router.dart';

class CustomBottomNavigationBar extends StatelessWidget {
  final StatefulNavigationShell currentChild;
  const CustomBottomNavigationBar({required this.currentChild, super.key});

  Future<bool> handleOnWillPop() async {
    final location = currentChild.shellRouteContext.routerState.location;

    if (location != '/') {
      currentChild.goBranch(0);
      return false;
    }

    return true;
  }

  @override
  Widget build(BuildContext context) {
    return WillPopScope(
      onWillPop: handleOnWillPop,
      child: BottomNavigationBar(
        currentIndex: currentChild.currentIndex,
        onTap: (idx) => currentChild.goBranch(idx),
        elevation: 0,
        items: const [
          BottomNavigationBarItem(
            icon: Icon(Icons.home_max),
            label: 'Inicio',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.label_outline),
            label: 'Categorías',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.favorite_outline),
            label: 'Favoritos',
          ),
        ],
      ),
    );
  }
}
