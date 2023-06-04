// Flutter
import 'package:flutter/material.dart';

// Third Party
import 'package:go_router/go_router.dart';

// Project
import 'package:cinemapedia/presentation/widgets/widgets.dart';

class HomeScreen extends StatelessWidget {
  static const name = 'home-screen';
  final StatefulNavigationShell currentChild;

  const HomeScreen({super.key, required this.currentChild});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: currentChild,
      bottomNavigationBar:
          CustomBottomNavigationBar(currentChild: currentChild),
    );
  }
}
