import 'package:flutter/material.dart';

import 'package:stw/main.dart';
import 'package:stw/Global.dart';
import 'package:stw/LangueText.dart';

class HomePage extends StatelessWidget {
  static String tag = 'home-page';

  @override
  Widget build(BuildContext context) {
    final MyIcon = Hero(
        tag: 'PP',
        child: Padding(
            padding: EdgeInsets.all(16),
            child: CircleAvatar(
                radius: 72,
                backgroundColor: Colors.transparent,
                backgroundImage: AssetImage('assets/eco.jpg'),
            ),
        ),
    );

    final welcome = Padding(
        padding: EdgeInsets.all(8),
        child: Text(Global.user == null ? 'Welcome' : 'Welcome ' + Global.user['name'], style: TextStyle(fontSize: 28, color: Colors.white)),
    );

    final lorem = Padding(
        padding: EdgeInsets.all(8),
        child: Text(LangueText.discour, style: TextStyle(fontSize: 16, color: Colors.white)),
    );

    final body = Container(
        width: MediaQuery.of(context).size.width,
        padding: EdgeInsets.all(28),
        decoration: BoxDecoration(gradient: LinearGradient(colors: [Colors.blue, Colors.lightBlueAccent]),),
        child: Column(
            children: <Widget> [
                SizedBox(height: 50),
                MyIcon,
                SizedBox(height: 20),
                welcome,
                lorem,
                SizedBox(height: 60),
                Container(
                    child: RaisedButton(
                        onPressed: () {Navigator.push(context, MaterialPageRoute(builder: (context) => MyMainPage()));},
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
                                child: Text(LangueText.next, style: TextStyle(color: Colors.white, fontSize: 26, fontWeight:FontWeight.w300)),
                            ),
                        )
                    ),
                ),
            ]
        ),
    );

    return Scaffold(body: body);
  }
}