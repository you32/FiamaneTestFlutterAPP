import 'package:fiamane_test/pages/change_theme_page.dart';
import 'package:fiamane_test/pages/user_data_page.dart';
import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';

void main() => runApp(MyApp());

class MyApp extends StatefulWidget {
  @override
  _MyAppState createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  bool _isDarkTheme = false; // variable to keep track of the theme mode
  int _currentIndex = 0; // variable to keep track of the selected page index
  final List<Widget> _pages = [    ChangeThemePage(),    UserDataPage(),  ]; // the two pages to be displayed

  @override
  void initState() {
    super.initState();
    _loadTheme(); // loads the theme mode when the app is started
  }

  void _loadTheme() async {
    final prefs = await SharedPreferences.getInstance();
    setState(() {
      _isDarkTheme = prefs.getBool('isDarkTheme') ?? false;
    });
  }

  void _toggleTheme() async { // changes the theme mode and saves it to shared preferences
    final prefs = await SharedPreferences.getInstance();
    setState(() {
      _isDarkTheme = !_isDarkTheme;
      prefs.setBool('isDarkTheme', _isDarkTheme);
    });
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Theme Demo',
      theme: _isDarkTheme ? ThemeData.dark() : ThemeData.light(), // sets the theme mode based on the value of _isDarkTheme
      home: Scaffold(
        appBar: AppBar(
          title: Text('FiAmane Test Demo'),
        ),
        body: _currentIndex == 0 ? Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Text(
                'Welcome to Fiamane Flutter App',
                style: Theme.of(context).textTheme.headline6,
              ),
              SizedBox(height: 20),
              ElevatedButton(
                onPressed: _toggleTheme,
                child: Text('Switch Theme'),
              ),
            ],
          ),
        ):  _pages[_currentIndex], // displays the selected page
        bottomNavigationBar: BottomNavigationBar(
          currentIndex: _currentIndex, // sets the selected index of the bottom navigation bar
          onTap: (index) {
            setState(() {
              _currentIndex = index; // updates the selected index when a bottom navigation bar item is tapped
            });
          },
          items: [
            BottomNavigationBarItem(
              icon: Icon(Icons.palette),
              label: 'Change Theme',
            ),
            BottomNavigationBarItem(
              icon: Icon(Icons.person),
              label: 'Users Data',
            ),
          ],
        ),

      ),
    );
  }
}
