import 'package:controleclimatico/main.dart';
import 'package:controleclimatico/screens/newWindow.dart';
import 'package:controleclimatico/transaction/obter_clima.dart';
import 'package:flutter/material.dart';
import 'package:controleclimatico/util/util.dart' as util;

class Climatico extends StatefulWidget {
  @override
  _ClimaticoState createState() => _ClimaticoState();
}

class _ClimaticoState extends State<Climatico> {
  String _cidadeInserida;

  Future _openNewWindow(BuildContext context) async {
    Map result = await Navigator.of(context)
        .push(MaterialPageRoute<Map>(builder: (BuildContext context) {
      return MudarCidade();
    }));
    if (result != null && result.containsKey('cidade')) {
      _cidadeInserida = result['cidade'];
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Clima"),
        backgroundColor: Colors.redAccent,
        actions: <Widget>[
          IconButton(
              icon: Icon(Icons.menu), onPressed: () => _openNewWindow(context)),
        ],
      ),
      body: Stack(
        children: <Widget>[
          Center(
            child: Image.asset(
              "images/umblella.png",
              width: double.infinity,
              height: double.infinity,
              fit: BoxFit.cover,
            ),
          ),
          Container(
            alignment: Alignment.topRight,
            child: Row(
              mainAxisAlignment: MainAxisAlignment.end,
              children: <Widget>[Text("${_cidadeInserida == null
                  ? util.minhaCidade : _cidadeInserida}",
                style: styleCidade(),
              )
              ],
            ),
          ),
          Container(
            alignment: Alignment.center,
            child: Image.asset("images/light_rain.png"),
          ),
          refreshTemWidget(_cidadeInserida),
        ],
      ),
    );
  }

  Widget refreshTemWidget(String cidade) {
    return FutureBuilder(
        future:
        obterClima(util.appId, cidade == null ? util.minhaCidade : cidade),
        builder: (BuildContext context, AsyncSnapshot<Map> snapshot) {
          if (snapshot.hasData) {
            Map conteudo = snapshot.data;
            return Container(
              margin: const EdgeInsets.fromLTRB(30, 250, 0, 0),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: <Widget>[
                  ListTile(
                    title: Text(conteudo['main']['temp'].toString() + "C",
                      style: tempStyle(),
                    ),
                    subtitle: ListTile(
                      title: Text(
                        "Humidade: ${conteudo['main']['humidity'].toString()}\n"
                            "Min: ${conteudo['main']['temp_min']
                            .toString() } C\n"
                            "Max: ${conteudo['main']['temp_max']
                            .toString() } C",
                        style: extraTemp(),
                      ),
                    ),
                  )
                ],
              ),
            );
          } else {
            return Container(
              child: Text("Erro!"),
            );
          }
        });
  }

  TextStyle extraTemp() {
    return TextStyle(
        color: Colors.white70,
        fontStyle: FontStyle.normal,
        fontSize: 17.0
    );
  }

  TextStyle styleCidade() {
    return TextStyle(
        color: Colors.white,
        fontSize: 22.9,
        fontStyle: FontStyle.italic
    );
  }

  TextStyle tempStyle() {
    return TextStyle(
        color: Colors.white,
        fontWeight: FontWeight.w500,
        fontSize: 49.9,
        fontStyle: FontStyle.normal
    );
  }

}