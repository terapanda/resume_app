import 'package:flutter/material.dart';

class Search extends StatefulWidget {
  const Search({super.key});

  @override
  State<Search> createState() => _SearchState();
}

class _SearchState extends State<Search> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title:  const Text("Private Page"),
      ),
      body: Center(
          child: Column(
        children: [ElevatedButton(onPressed: () {}, child: const Text('fasf'))],
      )),
    );
  }
}
