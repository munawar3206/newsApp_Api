import 'package:appnews/controller/home_controller.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';


import 'home.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    
    return MultiProvider
    (providers: [
      ChangeNotifierProvider(create:(_)=> NewsProvider() )
    ],
      child: MaterialApp(
        
        debugShowCheckedModeBanner: false,
        title: 'Flutter Demo',
        theme: ThemeData(
          colorScheme:
              ColorScheme.fromSeed(seedColor: Color.fromARGB(255, 0, 64, 255)),
          useMaterial3: true,
        ),
        home:  HomePage(),
      ),
    );
  }
}
