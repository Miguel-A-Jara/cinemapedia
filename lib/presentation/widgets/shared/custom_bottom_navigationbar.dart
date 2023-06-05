// Flutter
import 'package:flutter/material.dart';

// Third Party
import 'package:go_router/go_router.dart';

class CustomBottomNavigationBar extends StatelessWidget {
  final StatefulNavigationShell navigationShell;
  const CustomBottomNavigationBar({required this.navigationShell, super.key});

  Future<bool> handleOnWillPop(BuildContext context) async {
    final location = navigationShell.shellRouteContext.routerState.location;

    if (location != '/') {
      navigationShell.goBranch(0);
      return false;
    }

    late bool isUserExit;

    await showDialog(
      context: context,
      builder: (context) {
        return AlertDialog(
          title: const Text('¿Quieres Salir?'),
          content: const Text('Estás a punto de salir de la Aplicación.'),
          actions: [
            FilledButton.tonal(
              child: const Text('Cancelar'),
              onPressed: () {
                isUserExit = false;
                context.pop();
              },
            ),
            FilledButton(
              child: const Text('Salir'),
              onPressed: () {
                isUserExit = true;
                context.pop();
              },
            ),
          ],
        );
      },
    );
    return isUserExit;
  }

  @override
  Widget build(BuildContext context) {
    final colors = Theme.of(context).colorScheme;

    return WillPopScope(
      onWillPop: () => handleOnWillPop(context),
      child: BottomNavigationBar(
        type: BottomNavigationBarType.shifting,
        selectedItemColor: colors.primary,
        unselectedItemColor: colors.primary.withOpacity(0.25),
        currentIndex: navigationShell.currentIndex,
        onTap: (idx) => navigationShell.goBranch(idx),
        elevation: 0,
        items: const [
          BottomNavigationBarItem(
            icon: Icon(Icons.home_max),
            label: 'Inicio',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.thumbs_up_down_outlined),
            label: 'Populares',
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
