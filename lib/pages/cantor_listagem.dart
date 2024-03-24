import 'package:aula04_statefull/dtos/cantor_dto.dart';
import 'package:aula04_statefull/repository/cantor_dao.dart';
import 'package:aula04_statefull/widget/itens_lista.dart';
import 'package:flutter/material.dart';

class CantorListagem extends StatefulWidget {
  const CantorListagem({super.key});

  @override
  State<StatefulWidget> createState() => _CantorListagemState();
}

class _CantorListagemState extends State<CantorListagem> {
  late Future<List<CantorDTO>> _listaCantoresDTO;

  @override
  void initState() {
    super.initState();
    _listaCantoresDTO = listarCantores();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("LineUp John Rock bb"),
        backgroundColor: Colors.greenAccent,
      ),
      body: FutureBuilder<List<CantorDTO>>(
        future: _listaCantoresDTO,
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return const Center(child: CircularProgressIndicator());
          } else if (snapshot.hasError) {
            return Center(child: Text('Error: ${snapshot.error}'));
          } else if (snapshot.hasData) {
            List<CantorDTO> cantores = snapshot.data!;
            List<ItensLista> listaItensLista = cantores.map((cantor) {
              return ItensLista(cantor.nome, cantor.musica);
            }).toList();

            return ListView.builder(
              itemCount: listaItensLista.length,
              itemBuilder: (BuildContext context, int index) {
                return listaItensLista[index];
              },
            );
          } else {
            return const Center(child: Text('Não há dados cadastrados.'));
          }
        },
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
