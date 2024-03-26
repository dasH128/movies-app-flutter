import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:movies_app/src/presentation/providers/providers.dart';

class ConfigurationView extends ConsumerWidget {
  const ConfigurationView({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final bool darkMode = ref.watch(darkModeProvider);
    final colorsThemeApp = ref.watch(colorsThemeProvider);
    final int colorSelected = ref.watch(colorSelectedProvider);

    final MaterialStateProperty<Icon?> thumbIcon =
        MaterialStateProperty.resolveWith<Icon?>((states) {
      if (states.contains(MaterialState.selected)) {
        return const Icon(Icons.check);
      }
      return const Icon(Icons.close);
    });

    return Scaffold(
      appBar: AppBar(
        title: const Text('Configuraciones'),
      ),
      body: ListView(
        children: [
          ListTile(
            title: const Text('Idioma'),
            trailing: IconButton(
              onPressed: () {},
              icon: const Icon(Icons.back_hand_sharp),
            ),
          ),
          ListTile(
            title: const Text('Color del tema'),
            trailing: IconButton.filledTonal(
              icon: const Icon(Icons.palette),
              onPressed: () async {
                await showDialog(
                  context: context,
                  builder: (context) {
                    return AlertDialog(
                      title: const Text('Colores'),
                      actions: [
                        TextButton(onPressed: () {}, child: Text('Ok'))
                      ],
                      content: Container(
                        width: double.minPositive,
                        height: 140,
                        child: GridView.builder(
                          physics: const NeverScrollableScrollPhysics(),
                          itemCount: colorsThemeApp.length,
                          gridDelegate:
                              const SliverGridDelegateWithFixedCrossAxisCount(
                            crossAxisCount: 5,
                            childAspectRatio: 1.0,
                            mainAxisSpacing: 8,
                            crossAxisSpacing: 8,
                          ),
                          itemBuilder: (BuildContext context, int index) {
                            var itemColor = colorsThemeApp[index];
                            return IconButton(
                              style: IconButton.styleFrom(
                                backgroundColor: itemColor.color,
                              ),
                              isSelected: colorSelected == index,
                              onPressed: () {
                                ref
                                    .read(colorSelectedProvider.notifier)
                                    .update((state) => index);
                              },
                              selectedIcon: const Icon(
                                Icons.check,
                                color: Colors.black87,
                              ),
                              icon: const SizedBox(),
                            );
                          },
                        ),
                      ),
                    );
                  },
                );
              },
            ),
          ),
          SwitchListTile(
            thumbIcon: thumbIcon,
            value: darkMode,
            onChanged: (value) {
              ref.read(darkModeProvider.notifier).update((state) => !state);
            },
            title: const Text('Modo Oscuro'),
          )
        ],
      ),
    );
  }
}
