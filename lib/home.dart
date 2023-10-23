
import 'dart:async';

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
   late StreamSubscription subscription;
  var isDeviceConnected = false;
  bool isAlertSet = false;

  @override
  void initState() {
    getConnectivity();
    super.initState();
  }

  getConnectivity() => subscription = Connectivity()
          .onConnectivityChanged
          .listen((ConnectivityResult result) async {
        isDeviceConnected = await InternetConnectionChecker().hasConnection;
        if (!isDeviceConnected && isAlertSet == false) {
          showDialogBox();
          setState(() => isAlertSet = true);
        }
      });

  @override
  void dispose() {
    subscription.cancel();
    super.dispose();
  }
  @override
  // void initState() {
  //   super.initState();
  // }

  @override
  Widget build(BuildContext context) {
        Provider.of<NewsProvider>(context, listen: false).getAllNews();

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
                              style:const TextStyle(color: Colors.white),
                            ),
                            Card(
                              child: Image.network(provider
                                  .articles[index].urlToImage
                                  .toString()),
                            ),
                            Text(
                              provider.articles[index].description.toString(),
                              style:const TextStyle(color: Colors.white),
                            ),
                            Text(
                              provider.articles[index].url.toString(),
                              style:const TextStyle(color: Color(0xFF2200FF)),
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
        backgroundColor:const Color(0xFF000000),
      ),
    );
  }
  showDialogBox() => showCupertinoDialog<String>(
      context: context,
      builder: (BuildContext context) => CupertinoAlertDialog(
            title: const Text("No Connection"),
            content: const Text('Please check Internet'),
            actions: <Widget>[
              TextButton(
                  onPressed: () async {
                    Navigator.pop(context, "Cancel");
                    setState(() => isAlertSet = false);
                    isDeviceConnected =
                        await InternetConnectionChecker().hasConnection;
                    if (!isDeviceConnected) {
                      showDialogBox();
                      setState(
                        () => isAlertSet = true,
                      );
                    }
                    ;
                  },
                  child: Text("OK")),
            ],
          ));
}
