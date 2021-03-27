import 'package:flutter/material.dart';

class MyAdvices extends StatelessWidget {
    const MyAdvices({Key key}) : super(key: key);

    @override
    Widget build(BuildContext context) {
        return Scaffold(
            backgroundColor: Colors.green,
            body: Center(
                    // elevation: 0,
                    child: SingleChildScrollView(
                        child: Column(
                            mainAxisSize: MainAxisSize.min,
                            children: <Widget> [
                                Card(
                                    shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(15)),
                                    child: Column(
                                        children: [
                                            SizedBox(height: 8),
                                            Text("Le savon Maison", style: TextStyle(fontSize: 18, color: Colors.black)),
                                            SizedBox(height: 8),
                                            Image(image: NetworkImage('https://static1.beaute.fr/articles/2/12/07/2/@/32812-le-retour-en-grace-du-savon-article_full-2.jpg')),
                                            SizedBox(height: 8),
                                            Text(
                                                "Le savon fait soi même c'est quand même vachement cool. Mais c'est pas une mince à faire.",
                                                maxLines: 10,
                                                textDirection: TextDirection.ltr,
                                                style: TextStyle(fontSize: 14, color: Colors.black),
                                            ),
                                            SizedBox(height: 8),
                                        ]
                                    )
                                ), SizedBox(height: 8),
                                Card(
                                    shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10)),
                                    child: Column(
                                        children: [
                                            SizedBox(height: 8),
                                            Text("Fermer le robinet quand on se brosse les dents !", style: TextStyle(fontSize: 18, color: Colors.black)),
                                            SizedBox(height: 8),
                                            Image(image: NetworkImage('https://flutter.github.io/assets-for-api-docs/assets/widgets/owl.jpg')),
                                            SizedBox(height: 8),
                                            Text(
                                                "Cela permet l'economie de beaucoup d'eau, rendez vous compte qu'a raison de 1L par minute, et de 3 minute par lavement, vous consommez minimum 6L d'eau par jour.",
                                                maxLines: 10,
                                                textDirection: TextDirection.ltr,
                                                style: TextStyle(fontSize: 14, color: Colors.black),
                                            ),
                                            SizedBox(height: 8),
                                        ]
                                    )
                                ),
                            ]
                        )
                    )
                )
            );
        // );
    }
}