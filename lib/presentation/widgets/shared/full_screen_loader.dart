// Flutter
import 'package:flutter/material.dart';

// Third Party
import 'package:animate_do/animate_do.dart';

class FullScreenLoader extends StatelessWidget {
  const FullScreenLoader({super.key});

  static const List<String> _messages = [
    'Cargando peliculas',
    'Comprando palomitas de maiz',
    'Cargando Populares',
    'Llamando a mi novia',
    'Ya mero...',
    'Esto esta tardando mas de lo esperado :(',
  ];

  Stream<String> getLoadingMessages() {
    return Stream.periodic(const Duration(seconds: 2), (step) {
      return _messages[step];
    }).take(_messages.length);
  }

  @override
  Widget build(BuildContext context) {
    final textStyle = Theme.of(context).textTheme.titleMedium;

    return Center(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          const Text('Espere por favor...'),
          const SizedBox(height: 10),
          const CircularProgressIndicator(strokeWidth: 2),
          const SizedBox(height: 20),
          StreamBuilder(
            stream: getLoadingMessages(),
            builder: (context, snapshot) {
              if (!snapshot.hasData) {
                return Text('Cargando...', style: textStyle);
              }
              return FadeIn(
                key: Key(snapshot.data!),
                child: Text(snapshot.data!, style: textStyle),
              );
            },
          ),
        ],
      ),
    );
  }
}
