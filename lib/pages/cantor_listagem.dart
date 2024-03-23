import 'package:aula04_statefull/dtos/cantor_dto.dart';
import 'package:aula04_statefull/repository/cantor_dao.dart';
import 'package:aula04_statefull/widget/itens_lista.dart';
import 'package:flutter/material.dart';

class CantorListagem extends StatelessWidget {
  const CantorListagem({super.key});

  @override
  Widget build(BuildContext context) {
    Future<List<CantorDTO>> listaCantoresDTO = listarCantores();

    List<ItensLista> listaItensLista = List.empty(growable: true);
    listaItensLista
        .add(const ItensLista("Alceu Valença e Zé Ramalho", "Coração Bobo"));

    listaCantoresDTO.then((cantores) {
      for (var cantor in cantores) {
        print(
            'ID: ${cantor.id}, Nome: ${cantor.nome}, Música: ${cantor.musica}');
        ItensLista newItem = ItensLista(cantor.nome, cantor.musica);
        listaItensLista.add(newItem);
      }
    }).catchError((error) {
      print('Error fetching cantores: $error');
    });

    return Scaffold(
      body: Column(
        children: [
          ListView.builder(
            shrinkWrap: true,
            itemCount: listaItensLista.length,
            itemBuilder: (BuildContext context, int index) {
              return listaItensLista[index];
            },
          ),
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
    List<CantorDTO> cantores = await dao.selectAll();
    return cantores;
  }
}
