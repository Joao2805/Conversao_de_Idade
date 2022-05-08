import 'package:flutter/material.dart';

void main() async {
  runApp(
    MaterialApp(
      debugShowCheckedModeBanner: false,
      home: Home(),
      theme: ThemeData(
        hintColor: Colors.blue,
        primaryColor: Colors.white,
        inputDecorationTheme: InputDecorationTheme(
          enabledBorder:
              OutlineInputBorder(borderSide: BorderSide(color: Colors.black)),
          focusedBorder:
              OutlineInputBorder(borderSide: BorderSide(color: Colors.black)),
          hintStyle: TextStyle(color: Colors.grey[400]),
        ),
      ),
    ),
  );
}

class Home extends StatefulWidget {
  @override
  _HomeState createState() => _HomeState();
}

class _HomeState extends State<Home> {
  final anoController = TextEditingController();
  final mesController = TextEditingController();
  final diaController = TextEditingController();

  GlobalKey<FormState> _formKey = GlobalKey<FormState>();

  String _mensagem = "";

  int ano = 0;
  int mes = 0;
  int dia = 0;

  _diaMesAnoParaDias() {
    setState(() {
      ano = int.parse(anoController.text);
      mes = int.parse(mesController.text);
      dia = int.parse(diaController.text);

      int dias = ano * 360 + mes * 30 + dia;
      _mensagem = "Você tem ${dias.toString()} dia(s)";
      anoController.clear();
      mesController.clear();
      diaController.clear();
    });
  }

  void _limpaCampos() {
    anoController.clear();
    mesController.clear();
    diaController.clear();
    setState(() {
      _mensagem = "Informe seus dados!";
      _formKey = GlobalKey<FormState>();
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        title: Text("Ano/Mes/Dia para Dias - Fatec Ferraz"),
        backgroundColor: Colors.grey[200],
        centerTitle: true,
        actions: <Widget>[
          IconButton(
            icon: Icon(Icons.refresh),
            onPressed: _limpaCampos,
          )
        ],
      ),
      body: SingleChildScrollView(
        padding: EdgeInsets.all(10),
        child: Form(
          key: _formKey,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              Icon(
                Icons.date_range,
                size: 100,
                color: Colors.pink[700],
              ),
              construirTextField("Ano", "Qtde:", anoController,
                  "Favor Insira a qtde. de Ano(s)"),
              Divider(),
              construirTextField("Mês", "Qtde:", mesController,
                  "Favor Insira a qtde. de Mes(es)"),
              Divider(),
              construirTextField("Dia", "Qtde:", diaController,
                  "Favor Insira a qtde. de Dia(s)"),
              Padding(
                padding: EdgeInsets.fromLTRB(250, 50, 250, 50),
                child: FlatButton(                  
                  color: Colors.grey[400],
                  hoverColor: Colors.pink[800],
                  height: 50,
                  child: Text(
                    "Converter",
                    style: TextStyle(
                      fontSize: 30,
                      color: Colors.white,
                    ),
                  ),
                  onPressed: () {
                    if (_formKey.currentState!.validate()) {
                      _diaMesAnoParaDias();
                    }
                  },
                ),
              ),
              Center(
                child: Text(
                  _mensagem,
                  style: TextStyle(
                    color: Colors.black,
                    fontWeight: FontWeight.bold,
                    fontStyle: FontStyle.italic,
                    fontSize: 30,
                  ),
                ),
              ) //
            ],
          ),
        ),
      ),
    );
    //);
  }
}

Widget construirTextField(String texto, String prefixo, TextEditingController c,
    String mensagemErro) {
  return TextFormField(
    controller: c,
    decoration: InputDecoration(
      labelText: texto,
      labelStyle: TextStyle(color: Colors.black),
      border: OutlineInputBorder(),
      prefixText: prefixo,
    ),
    style: TextStyle(
      color: Colors.black,
      fontSize: 15,
    ),
    //onChanged: f,
    keyboardType: TextInputType.number,
    validator: (value) {
      if (value!.isEmpty) {
        return mensagemErro;
      } else {
        return null;
      }
    },
  );
}