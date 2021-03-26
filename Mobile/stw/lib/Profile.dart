import 'package:flutter/material.dart';
import 'package:flutter/cupertino.dart';

import 'package:stw/Global.dart';

class Profil extends StatefulWidget {
    const Profil({Key key}) : super(key: key);

    @override
    _ProfilState createState() => _ProfilState();
}

class _ProfilState extends State<Profil> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Column(
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
                                                Text("Déchets", style: TextStyle(color: Colors.redAccent, fontSize: 22, fontWeight: FontWeight.bold)),
                                                SizedBox(height: 5),
                                                Text((Global.user['mission']['dechets'] == null ? "0" : Global.user['mission']['dechets'].toString()), style: TextStyle(fontSize: 20, color: Colors.pinkAccent))
                                            ],
                                        ),
                                    ),
                                    Expanded(
                                        child: Column(
                                            children: [
                                                Text("Co2 (Kg)", style: TextStyle(color: Colors.redAccent, fontSize: 22, fontWeight: FontWeight.bold)),
                                                SizedBox(height: 5),
                                                Text((Global.user['mission']['CarbonEco'] == null ? "0" : Global.user['mission']['CarbonEco'].toString()), style: TextStyle(fontSize: 20, color: Colors.pinkAccent))
                                            ],
                                        ),
                                    ),
                                    Expanded(
                                        child: Column(
                                            children: [
                                                Text("Eau (L)", style: TextStyle(color: Colors.redAccent, fontSize: 22, fontWeight: FontWeight.bold)),
                                                SizedBox(height: 5),
                                                Text((Global.user['mission']['WaterLiter'] == null ? "0" : Global.user['mission']['WaterLiter'].toString()), style: TextStyle(fontSize: 20, color: Colors.pinkAccent))
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
                          // Text("Info:", style: TextStyle(color: Colors.redAccent, fontStyle: FontStyle.normal, fontSize: 28)),
                          // SizedBox(height: 10),
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
                              colors: [Colors.green,Colors.blue]
                          ),
                          borderRadius: BorderRadius.circular(30),
                      ),
                      child: Container(
                          constraints: BoxConstraints(maxWidth: 300, minHeight: 50),
                          alignment: Alignment.center,
                          child: Text("Contact me", style: TextStyle(color: Colors.white, fontSize: 26, fontWeight:FontWeight.w300)),
                      ),
                  )
              ),
          ),
        ],
      ),
    );
  }
}