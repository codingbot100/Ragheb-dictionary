// import 'package:flutter/material.dart';
// import 'package:hive_flutter/hive_flutter.dart';

// main() async {
//   await Hive.initFlutter();
//   runApp(HomeView());
// }

// class HomeView extends StatefulWidget {
//   const HomeView({super.key});

//   @override
//   State<HomeView> createState() => _HomeViewState();
// }

// class _HomeViewState extends State<HomeView> {
//   final TextEditingController _fullnameController = TextEditingController();
//   final TextEditingController _ageController = TextEditingController();
//   final TextEditingController _cityController = TextEditingController();
//   @override
//   Widget build(BuildContext context) {
//     return MaterialApp(
//         home: Scaffold(
//       body: Center(
//           child: Column(
//         children: [
//           Center(
//             child: Padding(
//               padding: const EdgeInsets.all(20.0),
//               child: Expanded(
//                 child: Column(
//                   children: [
//                     TextField(
//                       controller: _fullnameController,
//                       decoration: InputDecoration(hintText: 'Full Name'),
//                     ),
//                     TextField(
//                       controller: _ageController,
//                       decoration: InputDecoration(hintText: 'You age'),
//                       keyboardType: TextInputType.number,
//                     ),
//                     TextField(
//                       controller: _cityController,
//                       decoration: InputDecoration(hintText: 'City'),
//                     ),
//                     SizedBox(
//                       height: 50,
//                     ),
//                     TextButton(
//                         onPressed: () {
//                           _saveData;
//                         },
//                         child: Text("Save Data")),
//                     TextButton(
//                         onPressed: () {
//                           _loadData();
//                         },
//                         child: Text("Load form cache")),
//                   ],
//                 ),
//               ),
//             ),
//           )
//         ],
//       )),
//     ));
//   }

//   void _saveData() async {
//     print("SaveData");
//     String fullname = _fullnameController.text;
//     int age = int.parse(_ageController.text);
//     String city = _cityController.text;

//     var box = await Hive.openBox("userInfo");

//     box.put('fullName', fullname);
//     box.put('age', age);
//     box.put('city', city);
//     box.close();
//   }

//   void _loadData() async {
//     print("loadData");
//     var box = await Hive.openBox("userInfo");
//     _fullnameController.text = box.get('fullName');
//     _ageController.text = "${(box.get('age'))}";
//     _cityController.text = box.get('city');
//     box.close();
//     setState(() {});
//   }
// }
