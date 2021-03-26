import 'package:flutter/material.dart';

import 'package:stw/Home.dart';
import 'package:stw/Profile.dart';
import 'package:stw/TheWorld.dart';
import 'package:stw/Connection.dart';

void main() => runApp(MyApp());

class MyApp extends StatelessWidget {
    final routes = <String, WidgetBuilder>{
        LoginPage.tag: (context) => LoginPage(),
        HomePage.tag: (context) => MyMainPage()
        // HomePage.tag: (context) => HomePage()
    };

    @override
    Widget build(BuildContext context) {
        return MaterialApp(
            title: 'Kodeversitas',
            debugShowCheckedModeBanner: false,
            theme: ThemeData(primarySwatch: Colors.lightBlue, fontFamily: 'Nunito'),
            home: LoginPage(),
            routes: routes,
        );
    }
}

class MyMainPage extends StatefulWidget {
    const MyMainPage({Key key}) : super(key: key);

    @override
    _MyMainPageState createState() => _MyMainPageState();
}

class _MyMainPageState extends State<MyMainPage> {
    int _selectedIndex = 0;
    static const TextStyle optionStyle = TextStyle(fontSize: 30, fontWeight: FontWeight.bold);
    static const List<Widget> _widgetOptions = <Widget> [
        Text('Index 1: Home', style: optionStyle),
        Text('Index 2: Advices', style: optionStyle),
        Profil(),
        WorldPage(),
        Text('Index 5: Shop', style: optionStyle),
    ];

    void _onItemTapped(int index) {
        setState(() {_selectedIndex = index;});
    }

    @override
    Widget build(BuildContext context) {
        return Scaffold(
            appBar: AppBar(title: const Text('#SaveTheWorld')),
            body: Center(child: _widgetOptions.elementAt(_selectedIndex)),
            bottomNavigationBar: BottomNavigationBar(
                items: const <BottomNavigationBarItem>[
                    BottomNavigationBarItem(backgroundColor: Colors.blue, icon: Icon(Icons.home), label: 'Home'),
                    BottomNavigationBarItem(backgroundColor: Colors.blue, icon: Icon(Icons.help_outline_outlined), label: 'Advices'),
                    BottomNavigationBarItem(backgroundColor: Colors.blue, icon: Icon(Icons.person), label: 'My Profil'),
                    BottomNavigationBarItem(backgroundColor: Colors.blue, icon: Icon(Icons.eco_outlined), label: 'The World'),
                    BottomNavigationBarItem(backgroundColor: Colors.blue, icon: Icon(Icons.shopping_bag_outlined), label: 'Shop'),
                ],
                currentIndex: _selectedIndex,
                selectedItemColor: Colors.white,
                onTap: _onItemTapped,
            ),
        );
    }
}
