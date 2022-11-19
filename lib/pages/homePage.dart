import 'package:flutter/material.dart';
import 'package:to_file/pages/categoriaPage.dart';

class HomePage extends StatefulWidget {
  const HomePage({Key? key}) : super(key: key);

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {

 TextEditingController? textController;

  @override
  Widget build(BuildContext context) {
    return  Scaffold(
      backgroundColor: Color(0xffF5F5F5),
      appBar: AppBar(
        backgroundColor: const Color(0xff0C322C),
        title: Text('LOGO'),
        // title: Image.asset('assets/images/logo-appbar.png',fit: BoxFit.cover),
        actions:  const [
          IconButton(
            onPressed: null,
            icon: Icon(
              Icons.info,
                color: Color(0xffFE7C3F)),
        ),
          IconButton(
              onPressed: null,
              icon: Icon(
                Icons.notifications,
                color: Color(0xffFE7C3F),
              ))
        ],

      ),
      
      body: Column(
        children: [
          Container(
            margin: const EdgeInsets.all(5),
            width: 350.0,
            child:
            const ElevatedButton(
              onPressed: null,
              child: Text('pesquisar'),
            ),
          ),

          const SizedBox(height: 20),

          GestureDetector(
            onTap: (){
              Navigator.push(
                  context,
                  MaterialPageRoute(
                      builder: (BuildContext context) => const CategoriaPage()
              ));
            },
            child: Container(
              height: 500.0,
              child: GridView.count(
                crossAxisCount: 3,
                primary: false,
                padding: const EdgeInsets.all(20),
                crossAxisSpacing: 10,
                mainAxisSpacing: 10,
                children: [
                  Container(
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
                          children: const [
                            IconButton(
                              onPressed: null,
                              icon: Icon(
                                Icons.document_scanner,
                                color: Color(0xffFE7C3F),
                              ),
                            ),
                            Text("Recibo"),
                          ],
                        ),
                  ),
                  Container(
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
                          blurRadius: 3.0,
                          offset: Offset(0.0,0.80),
                        ),
                      ],
                    ),
                    child:
                    Column(
                      children: const [
                        IconButton(
                          onPressed: null,
                          icon: Icon(
                            Icons.document_scanner,
                            color: Color(0xffFE7C3F),
                          ),
                        ),
                        Text("Fatura"),
                      ],
                    ),
                  ),
                  Container(
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
                          blurRadius: 3.0,
                          offset: Offset(0.0,0.80),
                        ),
                      ],
                    ),
                    child:
                    Column(
                      children: const [
                        IconButton(
                          onPressed: null,
                          icon: Icon(
                            Icons.document_scanner,
                            color: Color(0xffFE7C3F),
                          ),
                        ),
                        Text("Extrato Bancário"),
                      ],
                    ),
                  ),
                  Container(
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
                          blurRadius: 3.0,
                          offset: Offset(0.0,0.80),
                        ),
                      ],
                    ),
                    child:
                    Column(
                      children: const [
                        IconButton(
                          onPressed: null,
                          icon: Icon(
                            Icons.document_scanner,
                            color: Color(0xffFE7C3F),
                          ),
                        ),
                        Text("Nota Fiscal"),
                      ],
                    ),
                  ),
                  Container(
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
                          blurRadius: 3.0,
                          offset: Offset(0.0,0.80),
                        ),
                      ],
                    ),
                    child:
                    Column(
                      children: const [
                        IconButton(
                          onPressed: null,
                          icon: Icon(
                            Icons.document_scanner,
                            color: Color(0xffFE7C3F),
                          ),
                        ),
                        Text("Contrato"),
                      ],
                    ),
                  ),
                  Container(
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
                          blurRadius: 3.0,
                          offset: Offset(0.0,0.80),
                        ),
                      ],
                    ),
                    child:
                    Column(
                      children: const [
                        IconButton(
                          onPressed: null,
                          icon: Icon(
                            Icons.document_scanner,
                            color: Color(0xffFE7C3F),
                          ),
                        ),
                        Text("Boleto"),
                      ],
                    ),
                  ),
                  Container(
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
                          blurRadius: 3.0,
                          offset: Offset(0.0,0.80),
                        ),
                      ],
                    ),
                    child:
                    Column(
                      children: const [
                        IconButton(
                          onPressed: null,
                          icon: Icon(
                            Icons.document_scanner,
                            color: Color(0xffFE7C3F),
                          ),
                        ),
                        Text("Pessoal"),
                      ],
                    ),
                  ),
                  Container(
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
                          blurRadius: 3.0,
                          offset: Offset(0.0,0.80),
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
                ],
              ),
            ),
          ),
        ],
      ),
      floatingActionButton: const FloatingActionButton(
        onPressed: null,
        backgroundColor: Color(0xff30BA78),
        child: Icon(
            Icons.add,
            color: Colors.white,
            size: 40,
        ),
      ),
    );


  }
}



