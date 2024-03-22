import 'package:aula04_statefull/dtos/cantor_dto.dart';
import 'package:aula04_statefull/repository/cantor_dao.dart';
import 'package:flutter/material.dart';

import '../repository/conexao.dart';

// void main() => runApp(const MyApp());

void main() async {
  WidgetsFlutterBinding.ensureInitialized();

  await Conexao.instance.initDB();
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return const MaterialApp(
      title: 'SetList Marinke',
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
        title: const Text('SetList Marinke'),
      ),
      body: Form(
        key: _formKey,
        child: Column(
          children: [
            TextFormField(
              decoration: const InputDecoration(
                labelText: 'Cantor',
                labelStyle: TextStyle(
                    color: Colors.black87,
                    fontSize: 17,
                    fontFamily: 'AvenirLight'),
              ),
              controller: myControllerNr1,
              validator: (value) {
                if (value == null || value.isEmpty) {
                  return 'Campo obrigatório';
                }
                return null;
              },
            ),
            TextFormField(
              decoration: const InputDecoration(
                labelText: 'Principal sucesso',
                labelStyle: TextStyle(
                    color: Colors.black87,
                    fontSize: 17,
                    fontFamily: 'AvenirLight'),
              ),
              controller: myControllerNr2,
              validator: (value) {
                if (value == null || value.isEmpty) {
                  return 'Campo obrigatório';
                }
                return null;
              },
            ),
            ElevatedButton(
              onPressed: () async {
                CantorDAO dao = CantorDAO();
                Future<CantorDTO?> ultimoCantor = dao.obterUltimo();
                CantorDTO? cantor = await ultimoCantor;

                ScaffoldMessenger.of(context).showSnackBar(
                  SnackBar(content: Text(cantor.toString())),
                );
              },
              child: const Text("Último inserido"),
            ),
          ],
        ),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          if (_formKey.currentState!.validate()) {
            //criando objeto musica
            CantorDTO cantor = CantorDTO(
                nome: myControllerNr1.text, musica: myControllerNr2.text);

            _inserirCantor(cantor);

            myControllerNr2.clear();
            myControllerNr1.clear();

            ScaffoldMessenger.of(context).showSnackBar(
              const SnackBar(content: Text("Salvo em SQLite!")),
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
        tooltip: 'Adicionar música',
        child: const Icon(Icons.music_note_sharp),
      ),
    );
  }

  void _inserirCantor(CantorDTO cantor) {
    CantorDAO dao = CantorDAO();
    dao.insert(cantor);
  }
}
