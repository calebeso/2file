import 'package:flutter/material.dart';

import '../pages/newCategoriaPage.dart';

class CardAddCategoria extends StatelessWidget {
  const CardAddCategoria({this.atualizarListaCategorias});

  final atualizarListaCategorias;

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        Navigator.push(
            context,
            MaterialPageRoute(
                builder: (BuildContext context) => NewCategoriaPage(
                    atualizarListaCategorias: atualizarListaCategorias)));
      },
      child: Container(
        height: 100.0,
        width: 100.0,
        padding: const EdgeInsets.all(8),
        // color: const Color(0xffEAEBD9),
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(8.0),
          boxShadow: const <BoxShadow>[
            BoxShadow(
              color: Colors.black38,
              blurRadius: 5.0,
              offset: Offset(0.0, 0.80),
            ),
          ],
        ),
        child: const IconButton(
            onPressed: null,
            icon: Icon(
              Icons.add,
              color: Color(0xffFE7C3F),
              size: 40,
            )),
      ),
    );
  }
}
