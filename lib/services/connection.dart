import 'package:connectivity_plus/connectivity_plus.dart';
import 'package:flutter/material.dart';

// class Connection {
//   Future<bool> hasConnection(ConnectivityResult result) async {
//     var result = await (Connectivity().checkConnectivity());
//     if (result == ConnectivityResult.mobile ||
//         result == ConnectivityResult.wifi) {
//       return true;
//       // I am connected to a mobile network.
//     } else {
//       return false;
//       // I am connected to a wifi network.
//     }
//   }
// }

Future<bool> hasConnection() async {
  var result = await Connectivity().checkConnectivity();
  if (result == ConnectivityResult.wifi ||
      result == ConnectivityResult.mobile) {
    return Future.value(true);
  } else {
    return Future.value(false);
  }
}

// class Connection extends StatefulWidget {
//   const Connection({Key? key}) : super(key: key);

//   @override
//   State<Connection> createState() => _ConnectionState();
// }

// class _ConnectionState extends State<Connection> {
//   @override
//   var subscription;
//   String? status;

//   @override
//   void initState() {
//     // TODO: implement initState
//     super.initState();
//     subscription = Connectivity()
//         .onConnectivityChanged
//         .listen((ConnectivityResult result) async {
//       bool current = await hasConnection(result);
//       if (current) {
//         setState(() {
//           status = "Online";
//         });
//       } else {
//         setState(() {
//           status = "Offline";
//         });
//       }
//     });
//   }

//   @override
//   void dispose() {
//     // TODO: implement dispose
//     super.dispose();
//     subscription.cancel();
//   }

//   Widget build(BuildContext context) {
//     return Container();
//   }
// }
