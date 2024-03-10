import 'package:flutter/material.dart';

class CustomFullscreenLoaderWidget extends StatelessWidget {
  const CustomFullscreenLoaderWidget({super.key});

  Stream<String> getLoadingMessages() {
    const List<String> messages = [
      'Cargando populares',
      'Cargando palomitas',
      'Llamando al administrador',
      'ya mero',
      'esta tardando más de lo esperado'
    ];

    return Stream.periodic(const Duration(milliseconds: 900), (step) {
      return messages[step];
    }).take(messages.length);
  }

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          const Text('Espere porfavor'),
          const SizedBox(height: 10),
          const CircularProgressIndicator(strokeWidth: 2),
          const SizedBox(height: 10),
          StreamBuilder(
              stream: getLoadingMessages(),
              builder: (_, snapshot) {
                if (!snapshot.hasData) return const Text('Cargando..');
                return Text(snapshot.data ?? '');
              })
        ],
      ),
    );
  }
}
