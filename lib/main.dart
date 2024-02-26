import 'package:assignment_3/provider/theme.dart';
import 'package:flutter/material.dart';
import 'package:assignment_3/Homepage.dart';
import 'package:provider/provider.dart';

void main() {
  // runApp(ChangeNotifier(
  //   child: MyApp(),
  //   create: (BuildContext context)=> ThemeProvider(isDarkMode=true),

  // ) );
 return  runApp(ChangeNotifierProvider(
  child: MyApp(),
  create: (BuildContext context)=>ThemeProvider(isDarkMode: true),
  ));
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Consumer<ThemeProvider>(
      builder: (context, themeProvider, child){
       return MaterialApp(
        theme: themeProvider.getTheme,
        // theme: ThemeData(
        //   colorScheme: ColorScheme.fromSeed(seedColor: Colors.deepPurple),
        //   useMaterial3: true,
        // ),
        home: Homepage(), // Set Homepage as the home screen
      );
      },
    );
  }
}

