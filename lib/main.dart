//import 'package:cloud_firestore/cloud_firestore.dart';

import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:lojavirtual/models/user_manager.dart';
import 'package:lojavirtual/screens/base/base_screen.dart';
import 'package:lojavirtual/screens/signup/signup_screen.dart';
import 'package:provider/provider.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key key}) : super(key: key);

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider(
      create: (_) => UserManager(),
      child: MaterialApp(
          debugShowCheckedModeBanner: false,
          title: 'Loja de D,Meninas',
          theme: ThemeData(
            primaryColor: const Color.fromARGB(255, 9, 27, 39),
            scaffoldBackgroundColor: const Color.fromARGB(255, 9, 27, 39),
            appBarTheme: const AppBarTheme(
              elevation: 0,
            ),
            visualDensity: VisualDensity.adaptivePlatformDensity,
          ),
          initialRoute: '/base',
          // ignore: missing_return
          onGenerateRoute: (settings) {
            switch (settings.name) {
              case '/signup':
                return MaterialPageRoute(
                  builder: (_) => SignUpScreen(),
                );
              case '/base':
                return MaterialPageRoute(builder: (_) => BaseScreen());
            }
          } //home: BaseScreen()
          ),
    );
  }
}
