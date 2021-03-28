import 'dart:io';
import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:flutter/cupertino.dart';

import 'package:stw/Requests.dart';

var shopList = <Widget> [];

reloadMyShop() async {
    var data;
    HttpClientResponse response;
    HttpClient client = new HttpClient()..badCertificateCallback = ((X509Certificate cert, String host, int port) => true);
    HttpClientRequest request = await client.postUrl(Uri.parse(Requests.getShop));

    request.headers.set('content-type', 'application/json');
    request.add(utf8.encode(json.encode({"username": "username", "password": "password"})));

    response = await request.close();
    data = await response.transform(utf8.decoder).join();
    var temp = json.decode(data);
    if (temp != null && temp['status'] == "success") {
        print("LIST: ${temp['data']}");
        loadArticles(temp['data']);
    } else {
        print("FAIL CAUSE ${temp}");
    }
    print("Reload");
}

getArticle(String Title, String Desc, String Link, double Price) {
    if (Title == null)
        Title = " ";
    if (Desc == null)
        Desc = " ";
    if (Link == null)
        Link = "https://st3.depositphotos.com/1008648/13952/i/450/depositphotos_139528780-stock-photo-pink-and-grey-question-marks.jpg";
    // print("Go Load: ${Link}");
    return Card(
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(15)),
        child: Column(
            children: [
                SizedBox(height: 8),
                Text(Title, style: TextStyle(fontSize: 18, color: Colors.black)),
                SizedBox(height: 8),
                Image(image: NetworkImage(Link)),
                SizedBox(height: 8),
                Row(
                    children: <Widget> [
                        Expanded(
                            child: Padding(
                                padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 22),
                                child: Column(children: [Text(Desc, maxLines: 10, style: TextStyle(fontSize: 14, color: Colors.black))]),
                            ),
                        )
                    ],
                ),
                SizedBox(height: 8),
                Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 22),
                    child: Row(
                        children: <Widget> [
                            Expanded(
                                child: Column(
                                    children: [
                                        Container(
                                            child: RaisedButton(
                                                onPressed: () {}, //Navigator.push(context, MaterialPageRoute(builder: (context) => FormValueAdder()));},
                                                shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(80)),
                                                elevation: 0,
                                                padding: EdgeInsets.all(0),
                                                child: Ink(
                                                    decoration: BoxDecoration(
                                                        gradient: LinearGradient(begin: Alignment.centerRight, end: Alignment.centerLeft, colors: [Colors.pink,Colors.pinkAccent]),
                                                        borderRadius: BorderRadius.circular(30),
                                                    ),
                                                    child: Container(
                                                        constraints: BoxConstraints(maxWidth: 250, minHeight: 45),
                                                        alignment: Alignment.center,
                                                        child: Text(Price.toString() + "€", style: TextStyle(color: Colors.white, fontSize: 20, fontWeight:FontWeight.w300)),
                                                    ),
                                                )
                                            ),
                                        ),
                                    ],
                                ),
                            )
                        ]
                    )
                )
            ]
        )
    );
}

loadArticles(var liste) {
    if (liste == null)
        return;
    shopList = <Widget> [];
    for (var i = 0; i < liste.length; i ++) {
        String mylink = "";
        if (liste[i]['img'] == "/image/get?type=1")
            mylink = "https://www.systemed.fr/images/conseils/huit-recuperateurs-eau-pluie-300-a-550-litres.jpg";
        else if (liste[i]['img'] == "/image/get?type=2")
            mylink = "https://cdn.habitat.fr/thumbnails/product/770/770111/box/1200/1200/80/poubelle-ronde-3l-1_770111.jpg";
        else if (liste[i]['img'] == "/image/get?type=3")
            mylink = "https://www.maisoncreative.com/sites/art-de-vivre/files/mc-creer-un-composteur.jpg";
        else
            mylink = Requests.host + liste[i]['img'];
        shopList.add(getArticle(liste[i]['title'], liste[i]['Desc'], mylink, liste[i]['price']));
        shopList.add(SizedBox(height: 8));
    }
}

class MyShop extends StatelessWidget {
    const MyShop({Key key}) : super(key: key);

    @override
    Widget build(BuildContext context) {
        reloadMyShop();
        return Scaffold(
            backgroundColor: Colors.green,
            body: Center(
                child: RefreshIndicator(
                    onRefresh: () {return Future.sync(() => reloadMyShop());},
                    child: SingleChildScrollView(child: Column(mainAxisSize: MainAxisSize.min, children: shopList))
                )
            )
        );
    }
}
