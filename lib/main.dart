import 'package:assignment_3/pages/authentication/auth_page.dart';
import 'package:assignment_3/provider/theme.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:firebase_core/firebase_core.dart';
import 'firebase_options.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform
  );
  
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
        home: AuthPage(), // Set Homepage as the home screen
      );
      },
    );
  }
}

