

import 'package:flutter/material.dart';

class MudarCidade extends StatelessWidget{

  TextEditingController _cidadeCampoControl = TextEditingController();

  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.red,
        title: Text("Alterar cidade"),
        centerTitle: true,
      ),
      body: Stack(
        fit: StackFit.expand,
        children: <Widget>[
          Center(
            child: Image.asset("images/white_snow.png",
                width: double.infinity,
                height: double.infinity,
                fit: BoxFit.cover
            ),
          ),
          ListView(
            children: <Widget>[
              ListTile(
                title: TextField(
                  decoration: InputDecoration(
                    hintText: "Cidade",
                  ),
                  controller: _cidadeCampoControl,
                  keyboardType: TextInputType.text,
                ),
              ),
              ListTile(
                title: FlatButton(onPressed: (){
                  Navigator.pop(context, {
                    'cidade': _cidadeCampoControl.text
                  });
                },
                    textColor: Colors.white70,
                    color: Colors.redAccent,
                    child: Text("Informa o tempo")),
              )
            ],
          )
        ],
      ),
    );
  }
}