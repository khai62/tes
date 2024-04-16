import 'package:flutter/material.dart';
import 'package:tes/pustaka.dart';

class MyAppbar extends StatefulWidget implements PreferredSizeWidget {
  const MyAppbar({super.key});

  @override
  State<MyAppbar> createState() => _MyAppbarState();

  @override
  Size get preferredSize => const Size.fromHeight(kToolbarHeight);
}

class _MyAppbarState extends State<MyAppbar> {
  @override
  Widget build(BuildContext context) {
    return AppBar(
      title: const Text('AQFLite'),
      backgroundColor: Colors.blue[100],
      centerTitle: true,
      actions: [
        IconButton(
          onPressed: () {
            Navigator.push(
                context,
                MaterialPageRoute(
                    builder: (context) => const CreateScreen())).then((value) {
              setState(() {});
            });
          },
          icon: const Icon(Icons.add),
        )
      ],
    );
  }
}
