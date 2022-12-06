import 'package:flutter/material.dart';

import '../models/categoria.dart';
import '../pages/categoriaPage.dart';

class CardCategoria extends StatelessWidget {

  final Categoria categoria;

  CardCategoria ({
    required this.categoria
  });

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: (){
          Navigator.push(
              context,
              MaterialPageRoute(
                  builder: (BuildContext context) => const CategoriaPage()
              ));
        },
      child: Container(
        height: 100.0,
        width: 100.0,
        padding: const EdgeInsets.all(8),
        // color: const Color(0xffEAEBD9),
        decoration:  BoxDecoration(
          color:  Colors.white,
          borderRadius: BorderRadius.circular(8.0),
          boxShadow: const <BoxShadow> [
            BoxShadow(
              color: Colors.black38,
              blurRadius: 5.0,
              offset: Offset(0.0,0.80),
            ),
          ],
        ),

        child:
        Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            IconButton(
              onPressed: null,
              icon: ImageIcon(
                AssetImage('assets/images/${categoria.nomeIcone}'),
                color: const Color(0xffFE7C3F),
                size: 40,
              ),
            ),
            Text(categoria.nome,
            textAlign: TextAlign.center),
          ],
        ),
      ),
    );
  }
}
