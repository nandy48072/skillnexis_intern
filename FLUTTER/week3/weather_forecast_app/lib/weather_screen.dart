import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';

class WeatherScreen extends StatefulWidget{

  final String title;

  const WeatherScreen({super.key,required this.title});


  @override
  State<StatefulWidget> createState() =>_WeatherScreenState();

}

class _WeatherScreenState extends State<WeatherScreen>{

  final TextEditingController _cityController=TextEditingController();
  final String _apiKey='8eb1393b6d668d131a54b13a88c0cac6';

  bool _isLoading=false;
  String? _errorMessage;
  Map<String,dynamic>? _weatherData;

  Future<void> _fetchWeather(String city) async{

    if(city.trim().isEmpty){
      return;
    }

    setState(() {
      _isLoading=true;
      _errorMessage=null;
      _weatherData=null;

    });

    final url=Uri.parse(
      'https://api.openweathermap.org/data/2.5/weather?q=${city.trim()}&appid=$_apiKey&units=metric'
    );

    try{

      final response=await http.get(url);

      if(response.statusCode==200){
        setState(() {
          _weatherData=json.decode(response.body);
          _isLoading=false;
        });
      }
      else{
        final response =await http.get(url);
        final Map<String,dynamic> errorData=json.decode(response.body);
        setState(() {
          _errorMessage=errorData['message'] ?? 'City not found or invalid request';
          _isLoading=false;
        });
      }
    }
    catch(e){

      setState(() {
        _errorMessage='Network error. Please check your internet connection';
        _isLoading=false;
      });

    }
  }
  @override
  void dispose() {
    _cityController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {

    return Scaffold(
      appBar: AppBar(
        title: Text('Weather Forecast',
        style: TextStyle(fontWeight: FontWeight.bold),),
        backgroundColor: Colors.blue.shade700,
        foregroundColor: Colors.white,
        centerTitle: true,
      ),
      body: Padding(
        padding: const EdgeInsets.fromLTRB(10.0, 20.0, 10.0, 20.0),
        child: Column(
          children: [
            TextField(
              controller: _cityController,
              decoration: InputDecoration(
                labelText: 'Enter city name',
                border: const OutlineInputBorder(),
                suffixIcon: IconButton(
                    onPressed:()=> _fetchWeather(_cityController.text),
                    icon: Icon(Icons.search)
                )
              ),
              onSubmitted: (value) =>_fetchWeather(value),
            ),
            const SizedBox(height: 20,),
            ElevatedButton(
                onPressed: ()=>_fetchWeather(_cityController.text),
                child: Text('Get weather')
            ),
            const SizedBox(height: 10,),
            Expanded(
                child: Center(
                  child: _buildWeatherContent(),
                ))
          ],
        ),
        ),

    );
  }

  Widget _buildWeatherContent(){

    if(_isLoading){
       return CircularProgressIndicator();
    }

    if(_errorMessage!=null){

      return Card(
        child: Text(
          _errorMessage!,
          style: const TextStyle(
            color: Colors.red,
            fontSize: 16,
          ),
          textAlign: TextAlign.center,
        ),
      );

    }

    if (_weatherData == null) {
      return Card(
        elevation: 4,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(16),
        ),
        child: Padding(
          padding: const EdgeInsets.all(24.0),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: const [
              Icon(
                Icons.cloud_queue_rounded,
                size: 64,
                color: Colors.blueAccent,
              ),
              SizedBox(height: 16),
              Text(
                'Check the Weather',
                style: TextStyle(
                  fontSize: 20,
                  fontWeight: FontWeight.bold,
                ),
                textAlign: TextAlign.center,
              ),
              SizedBox(height: 8),
              Text(
                'Search for any city above to view its current temperature, humidity, and weather conditions.',
                style: TextStyle(
                  fontSize: 14,
                  color: Colors.grey,
                ),
                textAlign: TextAlign.center,
              ),
            ],
          ),
        ),
      );
    }

    final cityName=_weatherData!['name'];
    final temp=_weatherData!['main']['temp'];
    final humidity=_weatherData!['main']['humidity'];
    final weatherList=_weatherData!['weather'] as List;
    final description=weatherList.isNotEmpty? weatherList[0]['description']:'';
    final iconCode = weatherList.isNotEmpty ? weatherList[0]['icon'] : '01d';
    final iconUrl = 'https://openweathermap.org/img/wn/$iconCode@2x.png';

    return Card(
      elevation: 4,
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
      child: Padding(
        padding: const EdgeInsets.symmetric(vertical: 10,horizontal: 80),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            Text(
              cityName,
              style: const TextStyle(fontSize: 26, fontWeight: FontWeight.bold),
            ),
            // Weather Icon display[cite: 1]
            Image.network(
              iconUrl,
              width: 100,
              height: 100,
              errorBuilder: (context, error, stackTrace) =>
              const Icon(Icons.wb_sunny, size: 60, color: Colors.orange),
            ),
            // Temperature display[cite: 1]
            Text(
              '${temp.toStringAsFixed(1)} °C',
              style: const TextStyle(fontSize: 40, fontWeight: FontWeight.w600),
            ),
            const SizedBox(height: 8),
            Text(
              description.toString().toUpperCase(),
              style: const TextStyle(fontSize: 16, color: Colors.grey, fontWeight: FontWeight.w500),
            ),
            const SizedBox(height: 16),
            // Humidity display[cite: 1]
            Text(
              'Humidity: $humidity%',
              style: const TextStyle(fontSize: 18),
            ),
          ],
        ),
      ),
    );





  }



}