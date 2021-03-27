import 'dart:io';
import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:flutter/cupertino.dart';
import 'package:multiselect_formfield/multiselect_formfield.dart';

import 'package:stw/Global.dart';
import 'package:stw/LangueText.dart';
import 'package:stw/Requests.dart';

var _myActivities = "";

class Profil extends StatefulWidget {
    const Profil({Key key}) : super(key: key);

    @override
    _ProfilState createState() => _ProfilState();
}

setLanguage() async {
    var data;
    HttpClientResponse response;
    HttpClient client = new HttpClient()..badCertificateCallback = ((X509Certificate cert, String host, int port) => true);
    HttpClientRequest request = await client.postUrl(Uri.parse(Requests.setLanguage));

    request.headers.set('content-type', 'application/json');
    request.add(utf8.encode(json.encode({"token": Global.user['token'], "language": _myActivities.toString()})));

    response = await request.close();
    data = await response.transform(utf8.decoder).join();
    print("Response: ${data}");
}

class _ProfilState extends State<Profil> {

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: SingleChildScrollView(
          child: Column(
          children: [
            Container(
                decoration: BoxDecoration(
                    gradient: LinearGradient(
                        begin: Alignment.topCenter,
                        end: Alignment.bottomCenter,
                        colors: [Colors.blue, Colors.green]
                    )
                ),
                child: Container(
                  width: double.infinity,
                  height: 350,
                  child: Center(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.center,
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        CircleAvatar(
                            backgroundImage: NetworkImage("https://i.vimeocdn.com/portrait/44771460_640x640"),
                            radius: 50,
                        ),
                        SizedBox(height: 10),
                        Text((Global.user['name'] == null ? "Anonyme" : Global.user['name']), style: TextStyle(fontSize: 22, color: Colors.white)),
                        SizedBox(height: 10),
                        Card(
                          margin: EdgeInsets.symmetric(horizontal: 20,vertical: 5),
                          clipBehavior: Clip.antiAlias,
                          color: Colors.white,
                          elevation: 5,
                          child: Padding(
                              padding: const EdgeInsets.symmetric(horizontal: 8,vertical: 22),
                              child: Row(
                                  children: [
                                      Expanded(
                                          child: Column(
                                              children: [
                                                  Text(LangueText.mission_dechet, style: TextStyle(color: Colors.redAccent, fontSize: 22, fontWeight: FontWeight.bold)),
                                                  SizedBox(height: 5),
                                                  Text((Global.user['mission']['dechets'] == null ? "Nan" : Global.user['mission']['dechets'].toString()), style: TextStyle(fontSize: 20, color: Colors.pinkAccent))
                                              ],
                                          ),
                                      ),
                                      Expanded(
                                          child: Column(
                                              children: [
                                                  Text(LangueText.mission_carbone, style: TextStyle(color: Colors.redAccent, fontSize: 22, fontWeight: FontWeight.bold)),
                                                  SizedBox(height: 5),
                                                  Text((Global.user['mission']['CarbonEco'] == null ? "Nan" : Global.user['mission']['CarbonEco'].toString()), style: TextStyle(fontSize: 20, color: Colors.pinkAccent))
                                              ],
                                          ),
                                      ),
                                      Expanded(
                                          child: Column(
                                              children: [
                                                  Text(LangueText.mission_waterliter, style: TextStyle(color: Colors.redAccent, fontSize: 22, fontWeight: FontWeight.bold)),
                                                  SizedBox(height: 5),
                                                  Text((Global.user['mission']['WaterLiter'] == null ? "Nan" : Global.user['mission']['WaterLiter'].toString()), style: TextStyle(fontSize: 20, color: Colors.pinkAccent))
                                              ],
                                          ),
                                      ),
                                  ],
                              ),
                          ),
                        )
                      ],
                    ),
                  ),
                )
            ),
            SizedBox(height: 20),
            Column(
                children: <Widget> [
                    Text('90%'),
                    SizedBox(width: 15),
                    Card(
                        child: LinearProgressIndicator(
                            backgroundColor: Colors.cyanAccent,
                            valueColor: const AlwaysStoppedAnimation<Color>(Colors.blue),
                            value: 0.9,
                        )
                    )
                ],
            ),
            Container(
                child: Padding(
                    padding: const EdgeInsets.symmetric(vertical: 30, horizontal: 16),
                    child: Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                            Text(
                                "#SaveTheWorld",
                                style: TextStyle(
                                    fontSize: 22,
                                    fontStyle: FontStyle.italic,
                                    fontWeight: FontWeight.w300,
                                    color: Colors.black,
                                    letterSpacing: 2,
                                ),
                            ),
                        ],
                    ),
                ),
            ),
            SizedBox(height: 20),
            Container(
                child: RaisedButton(
                    onPressed: () {},
                    shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(80)),
                    elevation: 0,
                    padding: EdgeInsets.all(0),
                    child: Ink(
                        decoration: BoxDecoration(
                            gradient: LinearGradient(
                                begin: Alignment.centerRight,
                                end: Alignment.centerLeft,
                                colors: [Colors.pink,Colors.pinkAccent]
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
            SizedBox(height: 20),
            MultiSelectFormField(
                title: Text("Language"),
                autovalidate: true,
                validator: (value) {
                    print("Selected");
                    if (value == null)
                        return 'Please select one or more options';
                    value = [value[0]];
                    print(value);
                    return null;
                },
                dataSource: [
                    {"display": "Français", "value": "Fr"},
                    {"display": "English", "value": "En"},
                    {"display": "Espanol", "value": "Esp"},
                ],
                textField: 'display',
                valueField: 'value',
                okButtonLabel: 'OK',
                cancelButtonLabel: 'CANCEL',
                initialValue: [Global.user['language']],
                onSaved: (value) {
                    print("Saved ${value}");
                    if (value == null)
                        return;
                    // setState(() {_myActivities = value[0];});
                    _myActivities = value[0];
                    setLanguage();
                },
            )
          ],
        ),
        )
    );
  }
}