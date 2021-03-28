import 'dart:io';
import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:flutter/cupertino.dart';

import 'package:stw/main.dart';
import 'package:stw/Home.dart';
import 'package:stw/Global.dart';
import 'package:stw/Profile.dart';
import 'package:stw/Requests.dart';
import 'package:stw/LangueText.dart';

var _context;
var _Co2 = TextEditingController();
var _Water = TextEditingController();
var _Dechet = TextEditingController();

addNewInfos() async {
    var data;
    HttpClientResponse response;
    HttpClient client = new HttpClient()..badCertificateCallback = ((X509Certificate cert, String host, int port) => true);
    HttpClientRequest request = await client.postUrl(Uri.parse(Requests.addValue));

    print("co2: ${_Co2.text}, water: ${_Water.text}, dechet: ${_Dechet.text}");
    request.headers.set('content-type', 'application/json');
    request.add(utf8.encode(json.encode({
        "token": Global.user['token'],
        "co2": _Co2.text,
        "water": _Water.text,
        "dechet": _Dechet.text,
    })));

    response = await request.close();
    data = await response.transform(utf8.decoder).join();
    print("Response: ${data}");
    var temp = json.decode(data);
    if (temp['status'] == "success") {
        Global.user = temp['data'];
        print("DATA RESPONDED: ${temp}");
        Navigator.push(_context, MaterialPageRoute(builder: (context) => MyMainPage()));
    }
}

class FormValueAdder extends StatelessWidget {
    @override
    Widget build(BuildContext context) {
        _context = context;
        return Scaffold(
            appBar: new AppBar(
                title: new Text("Form Test"),
                actions: <Widget> [new IconButton(icon: const Icon(Icons.save), onPressed: () {})],
            ),
            body: new Column(
                children: <Widget>[
                    SizedBox(height: 40),
                    Text("Add a Value", style: TextStyle(fontSize: 32, color: Colors.green)),
                    SizedBox(height: 40),
                    new ListTile(
                        leading: const Icon(Icons.person),
                        title: new TextField(
                            keyboardType: TextInputType.number,
                            decoration: new InputDecoration(hintText: LangueText.mission_dechet),
                            controller: _Dechet
                        )
                    ),
                    SizedBox(height: 20),
                    new ListTile(
                        leading: const Icon(Icons.phone),
                        title: new TextField(
                            keyboardType: TextInputType.number,
                            decoration: new InputDecoration(hintText: LangueText.mission_carbone),
                            controller: _Co2
                        )
                    ),
                    SizedBox(height: 20),
                    new ListTile(
                        leading: const Icon(Icons.email),
                        title: new TextField(
                            keyboardType: TextInputType.number,
                            decoration: new InputDecoration(hintText: LangueText.mission_waterliter),
                            controller: _Water
                        )
                    ),
                    SizedBox(height: 95),
                    Container(
                        child: RaisedButton(
                            onPressed: () {addNewInfos();},
                            shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(80)),
                            elevation: 0,
                            padding: EdgeInsets.all(0),
                            child: Ink(
                                decoration: BoxDecoration(
                                    gradient: LinearGradient(
                                        begin: Alignment.centerRight,
                                        end: Alignment.centerLeft,
                                        colors: [Colors.blue, Colors.green]
                                    ),
                                    borderRadius: BorderRadius.circular(30),
                                ),
                                child: Container(
                                    constraints: BoxConstraints(maxWidth: 300, minHeight: 50),
                                    alignment: Alignment.center,
                                    child: Text(LangueText.profil_data, style: TextStyle(color: Colors.white, fontSize: 26, fontWeight:FontWeight.w300)),
                                ),
                            )
                        ),
                    ),
                ],
            ),
        );
    }
}