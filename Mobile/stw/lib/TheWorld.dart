import 'package:flutter/material.dart';
import 'package:flutter/cupertino.dart';

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
                height: 350,
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
                                                Text("Posts", style: TextStyle(color: Colors.redAccent, fontSize: 22, fontWeight: FontWeight.bold)),
                                                SizedBox(height: 5),
                                                Text("1200", style: TextStyle(fontSize: 20, color: Colors.pinkAccent))
                                            ],
                                        ),
                                    ),
                                    Expanded(
                                        child: Column(
                                            children: [
                                                Text(
                                                    "Followers",
                                                    style: TextStyle(color: Colors.redAccent, fontSize: 22, fontWeight: FontWeight.bold),
                                                ),
                                                SizedBox(height: 5),
                                                Text("21.2K", style: TextStyle(fontSize: 20, color: Colors.pinkAccent))
                                            ],
                                        ),
                                    ),
                                    Expanded(
                                        child: Column(
                                            children: [
                                                Text("Follow", style: TextStyle(color: Colors.redAccent, fontSize: 22, fontWeight: FontWeight.bold)),
                                                SizedBox(height: 5),
                                                Text("1200", style: TextStyle(fontSize: 20, color: Colors.pinkAccent))
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
          Container(
              child: Padding(
                  padding: const EdgeInsets.symmetric(vertical: 30,horizontal: 16),
                  child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                          Text("Info:", style: TextStyle(color: Colors.redAccent, fontStyle: FontStyle.normal, fontSize: 28)),
                          SizedBox(height: 10),
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
                          child: Text("Ajout d'une donnée.", style: TextStyle(color: Colors.white, fontSize: 26, fontWeight:FontWeight.w300)),
                      ),
                  )
              ),
          ),
        ],
      ),
    );
  }
}