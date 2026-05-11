import 'package:flutter/material.dart';
import 'package:sd_beach_quality/screens/beach_quality_list.dart';
import 'package:sd_beach_quality/screens/home_screen.dart';

class Shell extends StatefulWidget {
  const Shell({super.key});

  @override
  State<Shell> createState() => _ShellState();
}

class _ShellState extends State<Shell> {
  int _currentIndex = 0;

  final _screens = const [HomeScreen(), BeachQualityList()];

  @override
  void initState() {
    super.initState();
  }

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
              selected: _currentIndex == 0,
              onTap: () => setState(() {
                _currentIndex = 0;
                Navigator.of(context).pop();
              }),
            ),
            ListTile(
              title: const Text("List"),
              selected: _currentIndex == 1,
              onTap: () => setState(() {
                _currentIndex = 1;
                Navigator.of(context).pop();
              }),
            ),
          ],
        ),
      ),
      body: IndexedStack(index: _currentIndex, children: _screens),
    );
  }
}
