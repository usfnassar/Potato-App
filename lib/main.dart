import 'package:flutter/material.dart';
import 'package:dio/dio.dart';
import 'package:flutter/services.dart';
import 'package:potato_project/consts.dart';
import 'package:potato_project/screens/admin_screen.dart';
import 'package:potato_project/screens/archive_screen.dart';
import 'package:potato_project/screens/home_page.dart';
import 'package:potato_project/screens/login_screen.dart';
import 'package:potato_project/screens/plants_data_screen.dart';
import 'package:potato_project/screens/profile_screen.dart';
import 'package:potato_project/screens/result_archive_screen.dart';
import 'package:potato_project/screens/result_screen.dart';
import 'package:potato_project/screens/registerscreen.dart';
import 'package:potato_project/services/login_user.dart';
import 'package:shared_preferences/shared_preferences.dart';


void main() async{
  WidgetsFlutterBinding.ensureInitialized();
  SharedPreferences prefs = await SharedPreferences.getInstance();
 final String? token = await prefs.getString(KToken);

print(token);
  runApp( MyApp(Token: token,));
}

class MyApp extends StatelessWidget {
   MyApp({super.key,required this.Token});
String? Token;
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    // SystemChrome.setPreferredOrientations([
    //   DeviceOrientation.portraitUp,
    //   DeviceOrientation.portraitDown,
    // ]);
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        colorSchemeSeed:Colors.green,
        // primarySwatch: Colors.green,

        useMaterial3: false,

      ),
      routes: {
        LoginScreen.id:(context) => LoginScreen(),
        RegisterScreen.id:(context) => RegisterScreen(),
        HomePage.id:(context) => HomePage(),
        AdminScreen.id:(context) => AdminScreen(),
        ResultPage.id:(context) => ResultPage(),
        ProfileScreen.id:(context) => ProfileScreen(),
        ArchiveScreen.id:(context) => ArchiveScreen(),
        PlantDataScreen.id:(context) => PlantDataScreen(),
        ResultArchivePage.id:(context) => ResultArchivePage(),
      },
      initialRoute: Token==null?LoginScreen.id:HomePage.id,
      // home:LoginScreen(),
    );
  }
}


