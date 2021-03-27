import 'package:flutter/material.dart';
import 'package:flutter/cupertino.dart';

import 'package:stw/Global.dart';

class WorldPage extends StatefulWidget {
    const WorldPage({Key key}) : super(key: key);

    @override
    _WorldPageState createState() => _WorldPageState();
}

class _WorldPageState extends State<WorldPage> {
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
                                colors: [Colors.greenAccent, Colors.blue]
                            )
                        ),
                        child: Container(
                            width: double.infinity,
                            height: 450,
                            child: Center(
                                child: Column(
                                    crossAxisAlignment: CrossAxisAlignment.center,
                                    mainAxisAlignment: MainAxisAlignment.center,
                                    children: [
                                        CircleAvatar(backgroundImage: NetworkImage("https://www.technocrazed.com/wp-content/uploads/2015/12/Earth-Wallpaper-115.jpg"), radius: 50),
                                        SizedBox(height: 10),
                                        Text("Statistiques Mondiale", style: TextStyle(fontSize: 22, color: Colors.white)),
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
                                                                    Text("Accounts", style: TextStyle(color: Colors.redAccent, fontSize: 22, fontWeight: FontWeight.bold)),
                                                                    SizedBox(height: 5),
                                                                    Text((Global.appliinfos == null || Global.appliinfos['accounts'] == null ? "0" : Global.appliinfos['accounts'].toString()), style: TextStyle(fontSize: 20, color: Colors.pinkAccent))
                                                                ]
                                                            )
                                                        )
                                                    ]
                                                )
                                            )
                                        )
                                    ]
                                )
                            )
                        )
                    ),
                    Container(
                        decoration: BoxDecoration(
                            gradient: LinearGradient(
                                begin: Alignment.topCenter,
                                end: Alignment.bottomCenter,
                                colors: [Colors.blue, Colors.greenAccent]
                            )
                        ),
                        child: Container(
                            width: double.infinity,
                            height: 200,
                            child: Center(
                                child: Column(
                                    crossAxisAlignment: CrossAxisAlignment.center,
                                    mainAxisAlignment: MainAxisAlignment.center,
                                    children: [
                                        Card(
                                            margin: EdgeInsets.symmetric(horizontal: 20, vertical: 5),
                                            color: Colors.white,
                                            elevation: 5,
                                            child:
                                            Padding(
                                                padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 22),
                                                child: Row(
                                                    children: [
                                                        Expanded(
                                                            child: Column(
                                                                children: [
                                                                    Text("Déchets", style: TextStyle(color: Colors.redAccent, fontSize: 22, fontWeight: FontWeight.bold)),
                                                                    SizedBox(height: 5),
                                                                    Text((Global.appliinfos == null || Global.appliinfos['dechets'] == null ? "0" : Global.appliinfos['dechets'].toString()), style: TextStyle(fontSize: 20, color: Colors.pinkAccent))
                                                                ],
                                                            ),
                                                        ),
                                                        Expanded(
                                                            child: Column(
                                                                children: [
                                                                    Text("Co2 (Kg)", style: TextStyle(color: Colors.redAccent, fontSize: 22, fontWeight: FontWeight.bold)),
                                                                    SizedBox(height: 5),
                                                                    Text((Global.appliinfos == null || Global.appliinfos['CarbonEco'] == null ? "0" : Global.appliinfos['CarbonEco'].toString()), style: TextStyle(fontSize: 20, color: Colors.pinkAccent))
                                                                ],
                                                            ),
                                                        ),
                                                        Expanded(
                                                            child: Column(
                                                                children: [
                                                                    Text("Eau (L)", style: TextStyle(color: Colors.redAccent, fontSize: 22, fontWeight: FontWeight.bold)),
                                                                    SizedBox(height: 5),
                                                                    Text((Global.appliinfos == null || Global.appliinfos['WaterLiter'] == null ? "0" : Global.appliinfos['WaterLiter'].toString()), style: TextStyle(fontSize: 20, color: Colors.pinkAccent))
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
                ],
            ),
        );
    }
}
