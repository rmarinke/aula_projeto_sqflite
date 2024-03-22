import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

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
  final _formKey = GlobalKey<FormState>();

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
      body: Form(
        key: _formKey,
        child: Column(
          children: [
            TextFormField(
              keyboardType: TextInputType.number,
              inputFormatters: <TextInputFormatter>[
                FilteringTextInputFormatter.digitsOnly
              ],
              controller: myControllerNr1,
              validator: (value) {
                if (value == null || value.isEmpty) {
                  return 'Digite um número válido';
                }
                return null;
              },
            ),
            TextFormField(
              controller: myControllerNr2,
              validator: (value) {
                if (value == null || value.isEmpty) {
                  return 'Digite um número válido';
                }
                return null;
              },
            ),
          ],
        ),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          if (_formKey.currentState!.validate()) {
            String sum = (int.parse(myControllerNr1.text) +
                    int.parse(myControllerNr2.text))
                .toString();
            ScaffoldMessenger.of(context).showSnackBar(
              SnackBar(content: Text("Soma é: $sum")),
            );
          } else {
            showDialog(
              context: context,
              builder: (context) {
                return const AlertDialog(
                  content: Text("Erro! Preencha todos os campos!"),
                );
              },
            );
          }
        },
        tooltip: 'Exibir a soma!',
        child: const Icon(Icons.add),
      ),
    );
  }
}
