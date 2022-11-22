import 'package:flutter/material.dart';
import 'package:to_file/pages/categoriaPage.dart';
import 'package:to_file/pages/documentoPage.dart';
import 'package:to_file/pages/newCategoriaPage.dart';
import 'package:to_file/pages/pesquisaPage.dart';
import 'package:to_file/pages/sobrePage.dart';

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
      backgroundColor: const Color(0xffF5F5F5),
      appBar: AppBar(
        backgroundColor: const Color(0xff0C322C),
        title: Image.asset(
          'assets/images/appbar.png',
          height: 100.0,
          width: 120.0,
          fit: BoxFit.cover,
        ),

        actions:   [
          IconButton(
            onPressed: (){
              setState(() {
                pageSobre();
              });
            },
            icon: const Icon(
              Icons.info,
                color: Color(0xffFE7C3F)),
        ),
          const IconButton(
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
            margin: const EdgeInsets.only(top: 30.0),
            height: 65,
            width: 350,
            // alignment: Alignment.center,
            padding: const EdgeInsets.all(10),
            child: ElevatedButton(
              style: ButtonStyle(
                backgroundColor: MaterialStateProperty.all(Colors.white),
              ),
              onPressed: (){
                setState(() {
                  pageSearch();
                });
              },
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: const [
                  Text('pesquisar', style: TextStyle(
                    color: Color(0xffB9B1B1),
                  ),),
                  Icon(Icons.search,color: Color(0xffB9B1B1),
                  ),
                ],
            ),
            ),
          ),
          const SizedBox(height: 20),

          Container(
            height: 500.0,
            child: GridView.count(
              crossAxisCount: 3,
              primary: false,
              padding: const EdgeInsets.all(20),
              crossAxisSpacing: 10,
              mainAxisSpacing: 10,
              children: [
                GestureDetector(
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
                          children: const [
                            IconButton(
                              onPressed: null,
                              icon: ImageIcon(
                                AssetImage('assets/images/recibo.png'),
                                color: Color(0xffFE7C3F),
                                size: 40,
                              ),
                            ),
                            Text("Recibo"),
                          ],
                        ),
                  ),
                ),
                GestureDetector(
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
                          blurRadius: 3.0,
                          offset: Offset(0.0,0.80),
                        ),
                      ],
                    ),
                    child:
                    Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children:  const [
                         IconButton(
                          icon: ImageIcon(
                            AssetImage('assets/images/fatura.png'),
                            color: Color(0xffFE7C3F),
                            size: 40,
                          ),
                          onPressed: null,
                        ),
                         Text("Fatura"),
                      ],
                    ),
                  ),
                ),
                GestureDetector(
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
                          blurRadius: 3.0,
                          offset: Offset(0.0,0.80),
                        ),
                      ],
                    ),
                    child:
                    Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: const [
                        IconButton(
                          onPressed: null,
                          icon: ImageIcon(
                            AssetImage('assets/images/extrato-bancario.png'),
                            color: Color(0xffFE7C3F),
                            size: 40,
                          ),
                        ),
                        Text("Extrato Bancário",
                        textAlign: TextAlign.center),
                      ],
                    ),
                  ),
                ),
                GestureDetector(
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
                          blurRadius: 3.0,
                          offset: Offset(0.0,0.80),
                        ),
                      ],
                    ),
                    child:
                    Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: const [
                        IconButton(
                          onPressed: null,
                          icon: ImageIcon(
                            AssetImage('assets/images/notaFiscal.png'),
                            color: Color(0xffFE7C3F),
                            size: 40,
                          ),
                        ),
                        Text("Nota Fiscal"),
                      ],
                    ),
                  ),
                ),
                GestureDetector(
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
                          blurRadius: 3.0,
                          offset: Offset(0.0,0.80),
                        ),
                      ],
                    ),
                    child:
                    Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: const [
                        IconButton(
                          onPressed: null,
                          icon: ImageIcon(
                            AssetImage('assets/images/contrato.png'),
                            color: Color(0xffFE7C3F),
                            size: 40,
                          ),
                        ),
                        Text("Contrato"),
                      ],
                    ),
                  ),
                ),
                GestureDetector(
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
                          blurRadius: 3.0,
                          offset: Offset(0.0,0.80),
                        ),
                      ],
                    ),
                    child:
                    Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: const [
                        IconButton(
                          onPressed: null,
                          icon: ImageIcon(
                            AssetImage('assets/images/boleto.png'),
                            color: Color(0xffFE7C3F),
                            size: 40,
                          ),
                        ),
                        Text("Boleto"),
                      ],
                    ),
                  ),
                ),
                GestureDetector(
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
                          blurRadius: 3.0,
                          offset: Offset(0.0,0.80),
                        ),
                      ],
                    ),
                    child:
                    Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: const [
                        IconButton(
                          onPressed: null,
                          icon: ImageIcon(
                            AssetImage('assets/images/pessoal.png'),
                            color: Color(0xffFE7C3F),
                            size: 40,
                          ),
                        ),
                        Text("Pessoal"),
                      ],
                    ),
                  ),
                ),
                GestureDetector(
                  onTap: (){
                    Navigator.push(
                        context,
                        MaterialPageRoute(
                            builder: (BuildContext context) => const NewCategoriaPage()
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
                ),
              ],
            ),
          ),
        ],
      ),
      floatingActionButton:  FloatingActionButton(
        onPressed: (){
          setState(() {
            pageDocument();
          });
        },
        backgroundColor: const Color(0xff30BA78),
        child: const Icon(
            Icons.add,
            color: Colors.white,
            size: 40,
        ),
      ),
    );
  }

  void pageSobre() {
    Navigator.push(
        context,
        MaterialPageRoute(
            builder: (BuildContext context) => const SobrePage()
        ));
  }

 void pageDocument() {
   Navigator.push(
       context,
       MaterialPageRoute(
           builder: (BuildContext context) => const DocumentoPage()
       ));
 }

 void pageSearch() {
   Navigator.push(
       context,
       MaterialPageRoute(
           builder: (BuildContext context) => const PesquisaPage()
       ));
 }


}



