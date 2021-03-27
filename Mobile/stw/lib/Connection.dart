import 'dart:io';
import 'dart:convert';

import 'package:stw/Advices.dart';
import 'package:flutter/material.dart';
import 'package:flutter/cupertino.dart';

import 'package:stw/Home.dart';
import 'package:stw/Global.dart';
import 'package:stw/Requests.dart';
import 'package:stw/LangueText.dart';

var message = " ";
var globalContext;
TextEditingController myUsername = TextEditingController();
TextEditingController myPassword = TextEditingController();

loadUser(String username, String password) async {
    var data;
    HttpClientResponse response;
    HttpClient client = new HttpClient()..badCertificateCallback = ((X509Certificate cert, String host, int port) => true);
    HttpClientRequest request = await client.postUrl(Uri.parse(Requests.connect));

    request.headers.set('content-type', 'application/json');
    request.add(utf8.encode(json.encode({"username": username, "password": password})));

    response = await request.close();
    data = await response.transform(utf8.decoder).join();
    print("Response: ${data}");
    var temp = json.decode(data);
    if (temp != null && temp['status'] == "success") {
        reload();
        Global.user = temp['data'];
        if (Global.user['language'] == "Fr") {
            LangueText().inFrench();
        } else if (Global.user['language'] == "Esp") {
            LangueText().inEspagnol();
        } else {
            LangueText().inEnglish();
        }

        Navigator.of(globalContext).pushNamed(HomePage.tag);
    } else
        message = temp['message'];
}
loadAppInfos() async {
    var data;
    HttpClientResponse response;
    HttpClient client = new HttpClient()..badCertificateCallback = ((X509Certificate cert, String host, int port) => true);
    HttpClientRequest request = await client.postUrl(Uri.parse(Requests.appInfos));

    request.headers.set('content-type', 'application/json');
    request.add(utf8.encode(json.encode({"username": "username", "password": "password"})));

    response = await request.close();
    data = await response.transform(utf8.decoder).join();
    print("Response: ${data}");
    var temp = json.decode(data);
    if (temp != null && temp['status'] == "success")
        Global.appliinfos = temp;
}
createUser(String username, String password) async {
    var data;
    HttpClientResponse response;
    HttpClient client = new HttpClient()..badCertificateCallback = ((X509Certificate cert, String host, int port) => true);
    HttpClientRequest request = await client.postUrl(Uri.parse(Requests.create));

    request.headers.set('content-type', 'application/json');
    request.add(utf8.encode(json.encode({"username": username, "password": password})));

    response = await request.close();
    data = await response.transform(utf8.decoder).join();
    print("Response: ${data}");
    var temp = json.decode(data);
    if (temp != null && temp['status'] == "success") {
        loadAppInfos();
        loadUser(username, password);
    } else
        message = temp['message'];
}


class LoginPage extends StatefulWidget {
    static String tag = 'login-page';

    @override
    _LoginPageState createState() => new _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  @override
  Widget build(BuildContext context) {
    globalContext = context;
    loadAppInfos();
    final logo = Hero(
        tag: 'hero',
        child: CircleAvatar(
            backgroundColor: Colors.transparent,
            radius: 48,
            child: Image.asset('assets/logo.png'),
        ),
    );

    final email = TextFormField(
        keyboardType: TextInputType.emailAddress,
        autofocus: false,
        controller: myUsername,
        // initialValue: 'alucard@gmail.com',
        decoration: InputDecoration(
            hintText: 'Username',
            contentPadding: EdgeInsets.fromLTRB(20, 10, 20, 10),
            border: OutlineInputBorder(borderRadius: BorderRadius.circular(32)),
        ),
    );

    final password = TextFormField(
        autofocus: false,
        // initialValue: 'some password',
        obscureText: true,
        controller: myPassword,
        decoration: InputDecoration(
            hintText: 'Password',
            contentPadding: EdgeInsets.fromLTRB(20, 10, 20, 10),
            border: OutlineInputBorder(borderRadius: BorderRadius.circular(32)),
        ),
        validator: (value) {
            if (value.isEmpty)
                return "";
            return value;
        }
    );

    final loginButton = Padding(
        padding: EdgeInsets.symmetric(vertical: 16),
        child: RaisedButton(
            shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(24)),
            onPressed: () {
                loadUser(myUsername.text, myPassword.text);
                // if (Global.user != null && Global.user['status'] == "success")
                //     Navigator.of(context).pushNamed(HomePage.tag);
            },
            padding: EdgeInsets.all(12),
            color: Colors.lightBlueAccent,
            child: Text('Log In', style: TextStyle(color: Colors.white)),
        ),
    );

    final createButton = Padding(
        padding: EdgeInsets.symmetric(vertical: 16),
        child: RaisedButton(
            shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(24)),
            onPressed: () {
                createUser(myUsername.text, myPassword.text);
                if (Global.user != null && Global.user['status'] == "success")
                    Navigator.of(context).pushNamed(HomePage.tag);
            },
            padding: EdgeInsets.all(12),
            color: Colors.lightBlueAccent,
            child: Text("S'inscrire", style: TextStyle(color: Colors.white)),
        ),
    );

    return Scaffold(
        backgroundColor: Colors.white,
        body: Center(
            child: ListView(
                shrinkWrap: true,
                padding: EdgeInsets.only(left: 24, right: 24),
                children: <Widget> [
                    logo,
                    SizedBox(height: 48),
                    email,
                    SizedBox(height: 8),
                    password,
                    SizedBox(height: 24),
                    Text(message),
                    SizedBox(height: 24),
                    loginButton,
                    // SizedBox(height: 24),
                    createButton
                ],
            ),
        ),
    );
  }
}