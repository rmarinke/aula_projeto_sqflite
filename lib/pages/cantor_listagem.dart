import 'package:aula04_statefull/dtos/cantor_dto.dart';
import 'package:aula04_statefull/repository/cantor_dao.dart';
import 'package:aula04_statefull/widget/itens_lista.dart';
import 'package:flutter/material.dart';

class CantorListagem extends StatelessWidget {
  const CantorListagem({super.key});

  @override
  Widget build(BuildContext context) {
    Future<List<CantorDTO>> lista = listarCantores();

    // List<ItensLista> listaTeste = [
    //   [const ItensLista('CPM22', 'Canta: outra música')],
    //   [
    //     const ItensLista('CPM22', 'Canta: outra música'),
    //   ],
    //   [const ItensLista('Pitty e Emicida', 'Cantam: Hoje Cedo')]
    // ];

    lista.then((cantores) {
      for (var cantor in cantores) {
        print(
            'ID: ${cantor.id}, Nome: ${cantor.nome}, Música: ${cantor.musica}');
      }
    }).catchError((error) {
      // Handle any errors that occur during the retrieval process
      print('Error fetching cantores: $error');
    });

    print(lista);
    return Scaffold(
      body: const Column(
        children: [
          // ListView.builder(
          //   shrinkWrap: true,
          //   itemCount: listaTeste.length,
          //   itemBuilder: (BuildContext context, int index) {
          //     return listaTeste[index];
          //   },
          // ),
          ItensLista('Alceu Valença e Zé Ramalho', 'Cantam: Coração Bobo'),
          ItensLista('CPM22', 'Canta: outra música'),
          ItensLista('Pitty e Emicida', 'Cantam: Hoje Cedo'),
        ],
      ),
      appBar: AppBar(
        title: const Text("LineUp John Rock bb"),
        backgroundColor: Colors.greenAccent,
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () => (),
        child: const Icon(Icons.add),
      ),
    );
  }

  Future<List<CantorDTO>> listarCantores() async {
    CantorDAO dao = CantorDAO();
    Future<List<CantorDTO>> cantores = dao.selectAll();
    return await cantores;
  }
}
