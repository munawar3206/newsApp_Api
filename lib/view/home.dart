import 'dart:async';

import 'package:appnews/controller/connectivity_provider.dart';
import 'package:appnews/controller/home_controller.dart';
import 'package:connectivity_plus/connectivity_plus.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:internet_connection_checker/internet_connection_checker.dart';
import 'package:provider/provider.dart';

class HomePage extends StatefulWidget {
  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  @override
  void initState() {
    Provider.of<InternetConnectivityProvider>(context, listen: false)
        .getInternetConnectivity(context);
    Provider.of<NewsProvider>(context, listen: false).getAllNews();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    print("erre");
    return SafeArea(
      child: Scaffold(
        appBar: AppBar(
          toolbarHeight: 125,
          flexibleSpace: Image.asset(
            'asset/th.jpg',
            fit: BoxFit.cover,
          ), // Use 'Image.asset' to load images from assets
        ),
        
        body: Consumer<NewsProvider>(
          builder: (context, provider, child) {
            if (provider.isLoading) {
              return const Center(
                child: CircularProgressIndicator(),
              );
            }
            return Padding(
              padding: const EdgeInsets.all(8.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  const Text.rich(
                    TextSpan(children: [
                      TextSpan(
                        text: "Discover",
                        style: TextStyle(
                          fontSize: 20,
                          fontWeight: FontWeight.w900,
                          color: Colors.white60,
                        ),
                      ),
                      TextSpan(
                        text: "The World Tech",
                        style: TextStyle(
                          color: Color(0xFF0800FE),
                          fontSize: 20,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    ]),
                  ),
                  const Text(
                    "Find interesting articles and Updates",
                    style: TextStyle(color: Color(0xFFDEDEDE)),
                  ),
                  const SizedBox(
                    height: 20,
                  ),
                  Expanded(
                    child: ListView.builder(
                      itemCount: provider.articles.length,
                      itemBuilder: (context, index) {
                        return Column(
                          children: [
                            Text(
                              provider.articles[index].publishedAt.toString(),
                              style: const TextStyle(color: Colors.white),
                            ),
                            Card(
                              child: Image.network(provider
                                  .articles[index].urlToImage
                                  .toString()),
                            ),
                            Text(
                              provider.articles[index].description.toString(),
                              style: const TextStyle(color: Colors.white),
                            ),
                            Text(
                              provider.articles[index].url.toString(),
                              style: const TextStyle(color: Color(0xFF2200FF)),
                            ),
                          ],
                        );
                      },
                    ),
                  ),
                ],
              ),
            );
          },
        ),
        backgroundColor: const Color(0xFF000000),
      ),
    );
  }
}
