import 'package:flutter/material.dart';
import 'package:carousel_slider/carousel_slider.dart';
import 'search_screen.dart';
import 'package:resume_app/utils/size_config.dart';

class TopScreen extends StatefulWidget {
  const TopScreen({super.key});

  @override
  State<TopScreen> createState() => _TopScreenState();
}

class _TopScreenState extends State<TopScreen> {
  @override
  Widget build(BuildContext context) {
    SizeConfig().init(context);
    return MaterialApp(
      title: 'Flutter Demo',
      theme: ThemeData(
        primarySwatch: Colors.blue,
        visualDensity: VisualDensity.adaptivePlatformDensity,
      ),
      home: Scaffold(
        appBar: AppBar(
          // title: Text("Private Page"),
          actions: [
            IconButton(onPressed: () => {}, icon: const Icon(Icons.chat)),
            IconButton(onPressed: () => {}, icon: const Icon(Icons.notifications))
          ],
        ),
        body: Center(
          child: Column(
            children: [
              const Carousel(),
            ],
          ),
        ),
        floatingActionButton: FloatingActionButton(
          child: const Icon(Icons.close),
          onPressed: () {
            Navigator.of(context).push(
              PageRouteBuilder(
                  pageBuilder: (context, animation, secondaryAnimation) {
                return const Search();
              }, ),
            );
          },
        ),
      ),
    );
  }
}

class Carousel extends StatelessWidget {
  const Carousel({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return CarouselSlider(
      options: CarouselOptions(
          height: SizeConfig.blockSizeVertical! * 20,
          autoPlay: true
      ),
      items: [
        Card(
          child: Container(
            height: SizeConfig.blockSizeVertical! * 80,
            width: SizeConfig.blockSizeHorizontal! * 100,
            color: Colors.pink,
          ),
        ),
      ],
    );
  }
}

