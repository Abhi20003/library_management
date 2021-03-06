import 'package:library_management/screens/authenticate/authenticate.dart';
import 'package:library_management/screens/home/home_admin.dart';
import 'package:library_management/screens/home/list_view_user.dart';
import 'package:library_management/services/auth.dart';
import 'package:flutter/material.dart';
import 'package:library_management/screens/wrapper.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:provider/provider.dart';
import 'package:library_management/models/user.dart';
import 'package:library_management/screens/home/list_view_admin.dart';

int id = 0;

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return StreamProvider<Userdet?>.value(
      initialData: null,
      value: AuthService().user,
      child: MaterialApp(
        initialRoute: '/',
        routes: {
          '/listUserBooks': (context) => ListUserBooks(),
          '/listAdminBooks': (context) => ListAdminBooks(),
        },
        home: Wrapper(),
      ),
    );
  }
}
