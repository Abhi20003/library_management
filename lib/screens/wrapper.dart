import 'package:library_management/screens/authenticate/authenticate.dart';
import 'package:library_management/screens/home/home_user.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:library_management/models/user.dart';
import 'package:library_management/screens/home/home_admin.dart';

class Wrapper extends StatelessWidget {
  const Wrapper({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final user = Provider.of<Userdet?>(context);

    if (user == null) {
      return Authenticate();
    } else if (user.uid == 'S3p6Ivye23XcTV1bwG3PGGbnImv2') {
      return HomeAdmin();
    } else {
      print(user.uid);
      return HomeUser();
    }
    //return either home or authenticate widget
  }
}
