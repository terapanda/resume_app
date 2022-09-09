import 'package:flutter/material.dart';
import 'package:resume_app/utils/size_config.dart';
import 'search_screen.dart';

class TopScreen extends StatefulWidget {
  const TopScreen({super.key});

  @override
  State<TopScreen> createState() => _TopScreenState();
}

class _TopScreenState extends State<TopScreen> {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      theme: ThemeData(
        primarySwatch: Colors.blue,
        visualDensity: VisualDensity.adaptivePlatformDensity,
      ),
      home: Scaffold(
        appBar: AppBar(
          title: Text("Private Page"),
        ),
        body: Center(
          child: Column(
            children: [
              ElevatedButton(
                onPressed: () {},
                child: const Text('edit'),
              )
            ],
          ),
        ),
        floatingActionButton: FloatingActionButton(
          child: Icon(Icons.close),
          onPressed: () {
            Navigator.of(context).push(
              PageRouteBuilder(
                  pageBuilder: (context, animation, secondaryAnimation) {
                return Search();
              }, transitionsBuilder:
                      (context, animation, secondaryAnimation, child) {
                final Offset begin = Offset(0.0, 1.0);
                final Offset end = Offset.zero;
                final Animatable<Offset> tween = Tween(begin: begin, end: end)
                    .chain(CurveTween(curve: Curves.easeInOut));
                final Animation<Offset> offsetAnimation =
                    animation.drive(tween);
                return SlideTransition(position: offsetAnimation, child: child);
              }),
            );
          },
        ),
      ),
    );
  }
}
