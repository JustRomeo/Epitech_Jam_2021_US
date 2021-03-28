import 'dart:io';
import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:flutter/cupertino.dart';

import 'package:stw/Requests.dart';

var publications = <Widget> [];

reload() async {
    var data;
    HttpClientResponse response;
    HttpClient client = new HttpClient()..badCertificateCallback = ((X509Certificate cert, String host, int port) => true);
    HttpClientRequest request = await client.postUrl(Uri.parse(Requests.getPublications));

    request.headers.set('content-type', 'application/json');
    request.add(utf8.encode(json.encode({"username": "username", "password": "password"})));

    response = await request.close();
    data = await response.transform(utf8.decoder).join();
    var temp = json.decode(data);
    if (temp != null && temp['status'] == "success") {
        print("LIST: ${temp['data']}");
        loadPublications(temp['data']);
    } else {
        print("FAIL CAUSE ${temp}");
    }
    print("Reload");
}

getPublication(String Title, String Desc, String Link) {
    if (Title == null)
        Title = " ";
    if (Desc == null)
        Desc = " ";
    if (Link == null)
        Link = "https://st3.depositphotos.com/1008648/13952/i/450/depositphotos_139528780-stock-photo-pink-and-grey-question-marks.jpg";
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
                                child: Column(
                                    children: [
                                        // Text(Desc, style: TextStyle(color: Colors.redAccent, fontSize: 22, fontWeight: FontWeight.bold)),
                                        Text(Desc, maxLines: 10, style: TextStyle(fontSize: 14, color: Colors.black))
                                    ],
                                ),
                            ),
                        )
                        // SizedBox(width: 15),
                    ],
                ),
                SizedBox(height: 8),
            ]
        )
    );
}

loadPublications(var liste) {
    if (liste == null)
        return;
    publications = <Widget> [];
    publications.add(getPublication("ATTENTION AU COVID", "Continuons de rester attentif !!", "https://wrif.com/wp-content/uploads/sites/24/2020/03/stop-covid-19.jpg"));
    publications.add(SizedBox(height: 8));
    for (var i = 0; i < liste.length; i ++) {
        publications.add(getPublication(liste[i]['title'], liste[i]['Desc'], liste[i]['img']));
        publications.add(SizedBox(height: 8));
    }
}

class MyAdvices extends StatelessWidget {
    const MyAdvices({Key key}) : super(key: key);

    @override
    Widget build(BuildContext context) {
        reload();
        return Scaffold(
            backgroundColor: Colors.green,
            body: Center(
                child: RefreshIndicator(
                    onRefresh: () {return Future.sync(() => reload());},
                    child: SingleChildScrollView(
                        child: Column(
                            mainAxisSize: MainAxisSize.min,
                            children: publications
                        )
                    )
                )
            )
        );
    }
}
