import 'package:flutter/material.dart';
import 'package:news_app/models/news_info.dart';
import 'package:news_app/services/api_manager.dart';

class HomePage extends StatefulWidget {
  const HomePage({Key? key}) : super(key: key);

  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {

  late Future<NewsModel> _newsModel;

  @override
  void initState() {

    _newsModel = API_Manager().getNews();

    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('News App'),
        centerTitle: true,
      ),
      body: Container(
        child: FutureBuilder<NewsModel>(
          future: _newsModel,
          builder: (context,snapshot){
            if(snapshot.hasData){
              return ListView.builder(
                itemCount: snapshot.data!.articles.length,
                  itemBuilder: (context, index){
                  var articles = snapshot.data!.articles[index];
                return Container(
                  height: 100,
                  margin:const EdgeInsets.all(8),
                  child: Row(
                    children: [

                      Card(
                        clipBehavior: Clip.antiAlias,
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(24),
                        ),
                        child: AspectRatio(
                          aspectRatio: 1,
                          child:Image.network(
                              articles.urlToImage,
                            fit: BoxFit.cover,

                          ),
                        ),
                      ),
                     SizedBox(width: 16,),
                     Flexible(child:
                     Column(
                       crossAxisAlignment: CrossAxisAlignment.start,
                       children: [
                         Text(articles.title,overflow: TextOverflow.ellipsis,
                         style: const TextStyle(fontSize: 20,fontWeight: FontWeight.bold
                         ),
                         ),
                         SizedBox(height: 10,),
                         Text(articles.description,
                         maxLines: 2,
                         overflow: TextOverflow.ellipsis,)
                       ],
                     ),
                     )
                      //Image.network(articles.urlToImage)
                    ],
                  ),
                );
              }
              );
            }else{
              return Center(child: CircularProgressIndicator());
            }

          },
        ),
      ),
    );
  }
}
