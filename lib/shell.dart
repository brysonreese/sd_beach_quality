import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

class Shell extends StatelessWidget {
  final Widget child;

  const Shell({super.key, required this.child});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text("San Diego Beach Quality Report")),
      drawer: Drawer(
        child: ListView(
          padding: EdgeInsets.zero,
          children: [
            const DrawerHeader(
              decoration: BoxDecoration(color: Colors.blue),
              child: Text("SD Beach Quality Report"),
            ),
            ListTile(
              title: const Text("Home"),
              onTap: () {
                context.go('/');
                Navigator.of(context).pop();
              },
            ),
            ListTile(
              title: const Text("List"),
              onTap: () {
                context.go('/list');
                Navigator.of(context).pop();
              },
            ),
          ],
        ),
      ),
      body: child,
    );
  }
}
