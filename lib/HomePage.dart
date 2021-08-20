// // import 'package:firebase_auth/firebase_auth.dart';
// import 'package:flutter/material.dart';

// class HomePage extends StatefulWidget {
//   @override
//   _HomePageState createState() => _HomePageState();
// }

// class _HomePageState extends State<HomePage> {
//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       // appBar: AppBar(
//       //   leading: IconButton(
//       //     icon: Icon(
//       //       Icons.message,
//       //       color: Colors.orange[300],
//       //     ),
//       //   ),
//       //   automaticallyImplyLeading: false,
//       //   title: Text(
//       //     "Cmon Messenger",
//       //     style: TextStyle(color: Colors.black),
//       //   ),
//       //   centerTitle: true,
//       //   backgroundColor: Colors.transparent,
//       //   elevation: 0,
//       // ),
//       extendBody: true,
//       bottomNavigationBar: BottomNavigationBar(
//         type: BottomNavigationBarType.fixed,
//         backgroundColor: Colors.white,
//         items: [
//           BottomNavigationBarItem(
//             icon: Icon(
//               Icons.message,
//               color: Colors.grey,
//             ),
//           ),
//         ],
//       ),
//     );
//   }
// }
import 'package:flutter/material.dart';
import 'package:phone_verification_flutter/main.dart';

import 'chatrooms.dart';

void main() => runApp(MyApp());

class HomePage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Cmonn',
      debugShowCheckedModeBanner: false,
      initialRoute: '/',
      routes: {'/': (context) => ChatRooms()},
    );
  }
}
