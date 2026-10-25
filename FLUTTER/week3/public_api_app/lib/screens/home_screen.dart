import 'package:flutter/material.dart';
import 'weather_screen.dart';
import 'news_screen.dart';

class HomeScreen extends StatefulWidget{

  final String title;

  const  HomeScreen({super.key, required this.title});

  @override
  State<StatefulWidget> createState()=>_HomeScreenState();


}

class _HomeScreenState extends State<HomeScreen>{

  int _selectedIndex=0;
  @override
  Widget build(BuildContext context) {

    //define screen widgets
    final List<Widget> screens=[
      const WeatherScreen(),
      const NewsScreen()
    ];

    return Scaffold(


      body: screens[_selectedIndex],
      bottomNavigationBar: BottomNavigationBar(

        currentIndex: _selectedIndex,
        selectedItemColor: Colors.lightBlue.shade500,
        items: const [
          BottomNavigationBarItem(icon: Icon(Icons.wb_cloudy_outlined),label: 'weather'),
          BottomNavigationBarItem(icon: Icon(Icons.newspaper_outlined),label: 'news')
        ],
        onTap: (index){
            setState(() {
              _selectedIndex=index;
            });
        },
      ),
    );
  }
}