// ignore_for_file: use_build_context_synchronously

import 'package:flutter/material.dart';
import 'package:flutter_staggered_grid_view/flutter_staggered_grid_view.dart';
import 'package:tes/pustaka.dart';

// class MyHomePage extends StatefulWidget {
//   const MyHomePage({super.key});

//   @override
//   State<MyHomePage> createState() => _MyHomePageState();
// }

// class _MyHomePageState extends State<MyHomePage> {
//   DatabaseDB db = DatabaseDB();

//   @override
//   void initState() {
//     db.database();
//     super.initState();
//   }

//   @override
//   Widget build(BuildContext context) {
//     return MaterialApp(
//       home: Scaffold(
//         appBar: AppBar(
//           title: const Text('My Home'),
//           actions: const [MyRute()],
//         ),
//         body: Container(
//           width: double.infinity,
//           height: double.infinity,
//           padding: const EdgeInsets.only(
//             left: 20,
//             right: 20,
//             bottom: 10,
//           ),
//           child: Column(children: [
//             Expanded(
//                 child: MasonryGridView.count(
//               crossAxisCount: 1,
//               mainAxisSpacing: 20,
//               crossAxisSpacing: 20,
//               itemCount: dataList.length,
//               itemBuilder: ((context, index) {
//                 Category item = dataList[index];
//                 return InkWell(
//                   onTap: (() async {
//                     int result = await db.insert({
//                       'name': item.name,
//                       'text': item.text,
//                       'image': item.image,
//                     });
//                     if (result != -1) {
//                       print('Data berhasil disisipkan ke dalam database.');
//                     } else {
//                       print('Gagal menyisipkan data ke dalam database.');
//                     }
//                     await Navigator.push(
//                         context,
//                         MaterialPageRoute(
//                             builder: (context) => const TampilData()));
//                   }),
//                   child: Column(
//                     children: [
//                       Container(
//                         width: double.infinity,
//                         padding: const EdgeInsets.all(20),
//                         decoration: const BoxDecoration(
//                           color: Color.fromRGBO(184, 245, 220, 0.400),
//                           borderRadius: BorderRadius.all(Radius.circular(15)),
//                         ),
//                         child: Text(
//                           item.name,
//                           style: const TextStyle(fontWeight: FontWeight.bold),
//                         ),
//                       )
//                     ],
//                   ),
//                 );
//               }),
//             )),
//           ]),
//         ),
//       ),
//     );
//   }
// }

class MyHomePage extends StatefulWidget {
  const MyHomePage({super.key});

  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  late DatabaseDB db;

  @override
  void initState() {
    super.initState();
    db = DatabaseDB();
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: Scaffold(
        appBar: AppBar(
          title: const Text('My Home'),
          actions: const [MyRute()],
        ),
        body: Container(
          width: double.infinity,
          height: double.infinity,
          padding: const EdgeInsets.only(
            left: 20,
            right: 20,
            bottom: 10,
          ),
          child: Column(
            children: [
              Expanded(
                child: FutureBuilder<void>(
                  future: db.database(),
                  builder: (context, snapshot) {
                    if (snapshot.connectionState == ConnectionState.waiting) {
                      return const Center(
                        child: CircularProgressIndicator(),
                      );
                    } else if (snapshot.hasError) {
                      return const Center(
                        child: Text('Error initializing database'),
                      );
                    } else {
                      return MasonryGridView.count(
                        crossAxisCount: 1,
                        mainAxisSpacing: 20,
                        crossAxisSpacing: 20,
                        itemCount: dataList.length,
                        itemBuilder: ((context, index) {
                          Category item = dataList[index];
                          return InkWell(
                            onTap: () async {
                              int result = await db.insert({
                                'name': item.name,
                                'text': item.text,
                                'image': item.image,
                              });
                              if (result != -1) {
                                print(
                                    'Data berhasil disisipkan ke dalam database.');
                              } else {
                                print(
                                    'Gagal menyisipkan data ke dalam database.');
                              }
                              Navigator.push(
                                context,
                                MaterialPageRoute(
                                    builder: (context) => const TampilData()),
                              );
                            },
                            child: Column(
                              children: [
                                Container(
                                  width: double.infinity,
                                  padding: const EdgeInsets.all(20),
                                  decoration: const BoxDecoration(
                                    color: Color.fromRGBO(184, 245, 220, 0.400),
                                    borderRadius:
                                        BorderRadius.all(Radius.circular(15)),
                                  ),
                                  child: Text(
                                    item.name!,
                                    style: const TextStyle(
                                        fontWeight: FontWeight.bold),
                                  ),
                                )
                              ],
                            ),
                          );
                        }),
                      );
                    }
                  },
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
