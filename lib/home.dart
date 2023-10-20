import 'package:appnews/models/newsResponse.dart';
import 'package:appnews/services/news_services.dart';
import 'package:flutter/material.dart';
// import 'package:newsapp/models/newsResponse.dart';
// import 'package:newsapp/services/news_services.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        appBar: AppBar(
          toolbarHeight: 100,
          flexibleSpace: const Image(
            image: AssetImage('asset/th.jpg'),
            width: 600,
            fit: BoxFit.cover,
          ),
          // backgroundColor: Colors.transparent,
        ),
        body: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 25),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const Text.rich(TextSpan(children: [
                TextSpan(
                    text: "Discover",
                    style: TextStyle(
                        fontSize: 20,
                        fontWeight: FontWeight.w900,
                        color: Colors.white60)),
                TextSpan(
                    text: "The World Tech",
                    style: TextStyle(
                        color: Color.fromARGB(255, 8, 0, 254),
                        fontSize: 20,
                        fontWeight: FontWeight.bold))
              ])

                  //  style: TextStyle(fontSize: 30, fontWeight: FontWeight.bold),
                  ),
              const Text(
                "Find intresting article and Updates",
                style: TextStyle(color: Color.fromARGB(255, 222, 222, 222)),
              ),
              const SizedBox(
                height: 20,
              ),
              Expanded(
                  child: FutureBuilder<List<Article>>(
                future: NewsApiServices().fetchNewsArticle(),
                builder: (context, snapshot) {
                  if (!snapshot.hasData) {
                    return const Center(
                        child: CircularProgressIndicator(
                      backgroundColor: Colors.redAccent,
                    ));
                  } else {
                    return Container(
                      child: ListView.builder(
                        itemCount: snapshot.data!.length,
                        itemBuilder: (context, index) {
                          return Column(
                            children: [
                              Text(
                                snapshot.data![index].publishedAt.toString(),
                                style: TextStyle(
                                    color: Color.fromARGB(255, 255, 255, 255)),
                              ),
                              Card(
                                child: Image(
                                    image: NetworkImage(snapshot
                                        .data![index].urlToImage
                                        .toString())),
                              ),
                              Text(
                                snapshot.data![index].description.toString(),
                                style: TextStyle(
                                    color: Color.fromARGB(255, 255, 255, 255)),
                              ),
                              Text(
                                snapshot.data![index].url.toString(),
                                style: TextStyle(
                                    color: Color.fromARGB(255, 34, 0, 255)),
                              ),

                            
                            ],
                          );
                        },
                      ),
                    );
                  }
                },
              ))
            ],
          ),
        ),
        backgroundColor: const Color.fromARGB(255, 0, 0, 0),
      ),
    );
  }
}
