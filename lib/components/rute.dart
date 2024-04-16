import 'package:flutter/material.dart';
import 'package:tes/components/tampil_data.dart';

class MyRute extends StatelessWidget {
  const MyRute({super.key});

  @override
  Widget build(BuildContext context) {
    return IconButton(
        onPressed: () {
          Navigator.push(context,
              MaterialPageRoute(builder: (context) => const TampilData()));
        },
        icon: const Icon(Icons.add));
  }
}
