import 'dart:convert';

import 'package:http/http.dart' as http;
import 'package:news_app/contans/strings.dart';
import 'package:news_app/models/news_info.dart';

class API_Manager{

Future <NewsModel> getNews() async{
     var client = http.Client();
     var newsModel = null;

     try {
       var response = await client.get(Uri.parse(Strings.news_url));

       if (response.statusCode == 200) {
         var jsonString = response.body;
         var jsonMap = json.decode(jsonString);

         newsModel = NewsModel.fromJson(jsonMap);
       }
     }catch(Exception){
       return newsModel;
     }
     return newsModel;
  }
}