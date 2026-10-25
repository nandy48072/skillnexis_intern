import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';

class WeatherScreen extends StatefulWidget{

  const WeatherScreen({super.key});

  @override
  State<StatefulWidget> createState() =>_WeatherScreenState();


}

class _WeatherScreenState extends State<WeatherScreen>{

  List<dynamic> _weatherData=[];
  bool _isLoading=true;
  String _errorMessage='';

  @override
  @override
  void initState() {

    super.initState();
    _fetchWeatherData();
  }

  Future<void> _fetchWeatherData() async{

    final url = Uri.parse(
      'https://api.open-meteo.com/v1/forecast?latitude=13.0827&longitude=80.2707&daily=temperature_2m_max,temperature_2m_min,weathercode&timezone=auto',
    );

    try{
      final response=await http.get(url);

      if(response.statusCode==200){

        final data=json.decode(response.body);
        final List<dynamic> dates=data['daily']['time'];
        final List<dynamic> maxTemps=data['daily']['temperature_2m_max'];
        final List<dynamic> minTemps=data['daily']['temperature_2m_min'];

        List<dynamic> tempList=[];
        for(int i=0;i<dates.length;i++){

            tempList.add({
              'date': dates[i],
              'maxTemp': maxTemps[i],
              'minTemp': minTemps[i]
            });
        }

        setState(() {
          _weatherData=tempList;
          _isLoading=false;
        });

      }
      else{

        setState(() {
            _errorMessage='Failed to load data';
            _isLoading=false;
        });
      }

    }
    catch(e){
        setState(() {
          _errorMessage='Error:$e';
          _isLoading=false;
        });
    }
  }

  @override
  Widget build(BuildContext context) {

    return Scaffold(

      appBar: AppBar(
        title: const Text('Weather Report'),
        centerTitle: true,
        backgroundColor: Colors.lightBlue,
        foregroundColor: Colors.white,
      ),
      body: Padding(
          padding: EdgeInsetsGeometry.all(16),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
                const Text('7-Day Weather Forecast',
            style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
          ),
              const SizedBox(height: 12,),
              Expanded(
                  child: _isLoading
                      ? const Center(child:CircularProgressIndicator())
                      : _errorMessage.isNotEmpty
                      ? Text(_errorMessage)
                      :ListView.builder(
                      itemCount: _weatherData.length,
                      itemBuilder: (context,index){
                        final item=_weatherData[index];
                        return Card(
                            elevation: 3,
                          margin:const EdgeInsets.symmetric(vertical: 6),
                          child: ListTile(
                            leading: const Icon(Icons.wb_cloudy_outlined,
                            color: Colors.orange,
                            size: 36,),
                            title: Text('Date : ${item['date']}'),
                            subtitle: Text(
                              'Min ${item['minTemp']}°C | Max ${item['maxTemp']}°C'
                            ),
                            trailing: const Icon(Icons.arrow_forward_ios,size: 16,),
                          ),
                        );
                      })
                      )
            ],
          ),
      ),
    );
  }


}