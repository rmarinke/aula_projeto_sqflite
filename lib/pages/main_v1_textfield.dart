import 'package:flutter/material.dart';

void main() => runApp(const MyApp());

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return const MaterialApp(
      title: 'Somador',
      home: FormularioValores(),
    );
  }
}

class FormularioValores extends StatefulWidget {
  const FormularioValores({super.key});

  @override
  State<FormularioValores> createState() => _FormularioValoresState();
}

class _FormularioValoresState extends State<FormularioValores> {
  final myControllerNr1 = TextEditingController();
  final myControllerNr2 = TextEditingController();

  @override
  void dispose() {
    myControllerNr1.dispose();
    myControllerNr2.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Somador'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16),
        child: Column(
          children: [
            TextField(
              controller: myControllerNr1,
            ),
            TextField(
              controller: myControllerNr2,
            ),
          ],
        ),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          showDialog(
            context: context,
            builder: (context) {
              String sum = (int.parse(myControllerNr1.text) +
                      int.parse(myControllerNr2.text))
                  .toString();

              return AlertDialog(
                content: Text(sum),
              );
            },
          );
        },
        tooltip: 'Exibir a soma!',
        child: const Icon(Icons.add),
      ),
    );
  }
}
