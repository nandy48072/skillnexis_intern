import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';


class NewsScreen extends StatefulWidget{

  const NewsScreen({super.key});

  @override
  State<StatefulWidget> createState() =>_NewsScreenState();


}

class _NewsScreenState extends State<NewsScreen>{
  //for refernece
  /*{
  "status": "success",
  "totalResults": 100,
  "results": [
    {
      "article_id": "...",
      "title": "News Title",
      "description": "Article summary...",
      "image_url": "https://...",
      "link": "https://..."
    }
  ]
}*/

  final String _apiKey='pub_27c0bc7707a14d558d6342f529b55466';
  late Future<List<dynamic>> _futureNews;

  @override
  void initState() {
    super.initState();
    _futureNews = _fetchNews();
  }

  Future<List<dynamic>> _fetchNews() async{

    final url=Uri.parse('https://newsdata.io/api/1/latest?apikey=$_apiKey&language=en');
    final response=await http.get(url);


    if(response.statusCode==200){
      final data=json.decode(response.body);
      return data['results'];
    }
    else{
      throw Exception('Failed to load news: ${response.statusCode}');
    }
  }

  @override
  Widget build(BuildContext context) {

    return Scaffold(

      appBar: AppBar(
        title: const Text('News Report'),
        centerTitle: true,
        backgroundColor: Colors.lightBlue,
        foregroundColor: Colors.white,
      ),
      body: FutureBuilder<List<dynamic>>(
          future: _futureNews,
          builder: (context,snapshot){

            if(snapshot.connectionState==ConnectionState.waiting){
              return const Center(child: CircularProgressIndicator());
            }
            else if(snapshot.hasError){
              return Center(
                child: Padding(
                  padding: const EdgeInsets.all(16.0),
                  child: Text(
                    'Error loading news:\n${snapshot.error}',
                    textAlign: TextAlign.center,
                    style: const TextStyle(color: Colors.red),
                  ),
                ),
              );
            }
            else if(!snapshot.hasData||snapshot.data!.isEmpty){
              return const Center(child: Text('No articles found.'));
            }
            final articles=snapshot.data!;
            return ListView.builder(
              itemCount: articles.length,
                itemBuilder: (context,index){

                final article=articles[index];

                return Card(

                  margin: const EdgeInsets.symmetric(horizontal: 12,vertical: 6),
                  elevation: 3,
                  child: ListTile(
                    contentPadding: const EdgeInsets.all(10),
                    leading: article['image_url'] !=null
                    ?ClipRRect(
                      borderRadius:BorderRadius.circular(6),
                      child: Image.network(
                        article['image_url'],
                        width: 80,
                        height: 80,
                        fit: BoxFit.cover,
                        errorBuilder: (context,error,stackTrace)=>
                        Container(
                          width: 80,
                          height: 80,
                          color: Colors.grey[300],
                          child: const Icon(Icons.broken_image),
                        ),
                      ),

                    ):
                    Container(
                      width: 80,
                      height: 80,
                      decoration: BoxDecoration(
                        color: Colors.grey[300],
                        borderRadius: BorderRadius.circular(6),
                      ),
                      child: const Icon(Icons.article, color: Colors.grey),
                    ),
                    title: Text(
                      article['title'] ?? 'No Title',
                      maxLines: 2,
                      overflow: TextOverflow.ellipsis,
                      style: const TextStyle(
                        fontWeight: FontWeight.bold,
                        fontSize: 14,
                      ),
                    ),
                    subtitle: Padding(
                      padding: const EdgeInsets.only(top: 6.0),
                      child: Text(
                        article['description'] ?? 'No description available.',
                        maxLines: 2,
                        overflow: TextOverflow.ellipsis,
                        style: TextStyle(color: Colors.grey[600], fontSize: 12),
                      ),
                    ),

                  ),
                );

                });
          }),
    );

  }


}