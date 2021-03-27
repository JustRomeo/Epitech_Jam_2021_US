import 'package:flutter/material.dart';

import 'dart:io';
import 'dart:convert';

import 'package:flutter/cupertino.dart';

// import 'package:stw/Global.dart';
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
                Text(Desc, maxLines: 10, textDirection: TextDirection.ltr, style: TextStyle(fontSize: 14, color: Colors.black)),
                SizedBox(height: 8),
            ]
        )
    );
}

loadPublications(List<dynamic> liste) {
    if (liste == null)
        return;
    publications = <Widget> [];
    publications.add(getPublication("ATTENTION AU COVID", "Continuons de rester attentif !!", "https://wrif.com/wp-content/uploads/sites/24/2020/03/stop-covid-19.jpg"));
    for (var i = 0; i < liste.length; i ++) {
        publications.add(getPublication(liste[i]['title'], liste[i]['desc'], liste[i]['img']));
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
                    onRefresh: reload(),
                    child: SingleChildScrollView(
                        child: Column(
                            mainAxisSize: MainAxisSize.min,
                            children:
                            // publications
                            <Widget> [
                                getPublication("Le Composte", "Le composte permet de produire du terreau à partir de déchet organiques.", "https://i0.wp.com/sivom-region-cluses.fr/wp-content/uploads/2017/06/composteur-credit-sivom.jpg?fit=1500%2C1125"),
                                SizedBox(height: 8),
                                getPublication("Le Savon Maison", "Le savon fait soi même c'est quand même vachement cool. Mais c'est pas une mince à faire.", 'https://static1.beaute.fr/articles/2/12/07/2/@/32812-le-retour-en-grace-du-savon-article_full-2.jpg'),
                                SizedBox(height: 8),
                                getPublication("Fermer le robinet quand on se brosse les dents !", "Cela permet l'economie de beaucoup d'eau, rendez vous compte qu'a raison de 1L par minute, et de 3 minute par lavement, vous consommez minimum 6L d'eau par jour.", "https://i.pinimg.com/originals/9e/dc/36/9edc36b72a7ead337b0af035acf7ea54.jpg"),
                                SizedBox(height: 8)
                            ]
                        )
                    )
                )
            )
        );
    }
}
