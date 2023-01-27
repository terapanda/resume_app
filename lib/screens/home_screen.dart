import 'package:flutter/material.dart';
import 'package:carousel_slider/carousel_slider.dart';
import 'package:resume_app/screens/image_picker.dart';
import 'package:url_launcher/url_launcher.dart';
import 'search/search_screen.dart';
import 'package:resume_app/utils/size_config.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:flutter/foundation.dart';

import 'search/search_screen.dart';
import 'mypage_screen.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  @override
  Widget build(BuildContext context) {
    SizeConfig().init(context);
    return Scaffold(
      appBar: AppBar(
        automaticallyImplyLeading: false,
        actions: [
          IconButton(onPressed: () => {}, icon: const Icon(Icons.chat)),
          IconButton(
            onPressed: () => {
              Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (context) => MypageScreen(),
                ),
              )
            },
            icon: const Icon(
              Icons.account_circle,
            ),
          )
        ],
      ),
      body: Center(
        child: Column(
          children: [
            Carousel(),
            Text('Develop Language'),
            DevelopmentLanguageList(),
            Text('Reccomend Engineer'),
            RecommendEngineer(),
          ],
        ),
      ),
      floatingActionButton: FloatingActionButton(
        child: const Icon(Icons.close),
        onPressed: () {
          Navigator.of(context).push(
            PageRouteBuilder(
                pageBuilder: (context, animation, secondaryAnimation) {
              return SearchScreen(searchValue: '');
            }, transitionsBuilder:
                    (context, animation, secondaryAnimation, child) {
              final Offset begin = Offset(0.0, 1.0);
              final Offset end = Offset.zero;
              final Animatable<Offset> tween = Tween(begin: begin, end: end)
                  .chain(CurveTween(curve: Curves.easeInOut));
              final Animation<Offset> offsetAnimation = animation.drive(tween);
              return SlideTransition(position: offsetAnimation, child: child);
            }),
          );
        },
      ),
    );
  }
}

Future<void> _launchUrl(url) async {
  final Uri _url = Uri.parse(url);
  if (!await launchUrl(_url)) {
    throw 'Could not launch $_url';
  }
}

class Carousel extends StatelessWidget {
  const Carousel({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return CarouselSlider(
      options: CarouselOptions(
          height: SizeConfig.blockSizeVertical! * 20, autoPlay: true),
      items: [
        TextButton(
          child: Card(
            child: Container(
              height: SizeConfig.blockSizeVertical! * 80,
              width: SizeConfig.blockSizeHorizontal! * 80,
              child: Image.asset('images/image1.png'),
            ),
          ),
          onPressed: () => _launchUrl('https://www.sun21.co.jp/'),
        ),
        TextButton(
          child: Card(
            child: Container(
              height: SizeConfig.blockSizeVertical! * 80,
              width: SizeConfig.blockSizeHorizontal! * 80,
              child: Image.asset('images/image2.png'),
            ),
          ),
          onPressed: () => _launchUrl('https://kurashi-study.net/'),
        ),
        TextButton(
          child: Card(
            child: Container(
              height: SizeConfig.blockSizeVertical! * 80,
              width: SizeConfig.blockSizeHorizontal! * 80,
              child: Image.asset('images/image3.png'),
            ),
          ),
          onPressed: () => _launchUrl('https://kurashi-japan.net/?lang=ja'),
        ),
      ],
    );
  }
}

class DevelopmentLanguageList extends StatelessWidget {
  const DevelopmentLanguageList({super.key});

  @override
  Widget build(BuildContext context) {
    List devlist = [
      {'icon': FontAwesomeIcons.react, 'language': 'react'},
      {'icon': FontAwesomeIcons.vuejs, 'language': 'vuejs'},
      {'icon': FontAwesomeIcons.angular, 'language': 'angular'},
      {'icon': FontAwesomeIcons.js, 'language': 'js'},
      {'icon': FontAwesomeIcons.node, 'language': 'node'},
      {'icon': FontAwesomeIcons.java, 'language': 'java'},
      {'icon': FontAwesomeIcons.php, 'language': 'php'},
      {'icon': FontAwesomeIcons.python, 'language': 'python'},
      {'icon': FontAwesomeIcons.c, 'language': 'c'},
      {'icon': FontAwesomeIcons.rust, 'language': 'rust'},
      {'icon': FontAwesomeIcons.android, 'language': 'android'},
      {'icon': FontAwesomeIcons.apple, 'language': 'apple'},
      {'icon': FontAwesomeIcons.swift, 'language': 'swift'},
      {'icon': FontAwesomeIcons.unity, 'language': 'unity'},
      {'icon': FontAwesomeIcons.f, 'language': 'f'},
    ];
    return Container(
      child: Column(mainAxisAlignment: MainAxisAlignment.center, children: [
        Row(
          children: [
            InkWell(
              onTap: () {
                Navigator.of(context).push(
                  PageRouteBuilder(
                      pageBuilder: (context, animation, secondaryAnimation) {
                    return SearchScreen(searchValue: 'react');
                  }, transitionsBuilder:
                          (context, animation, secondaryAnimation, child) {
                    final Offset begin = Offset(0.0, 1.0);
                    final Offset end = Offset.zero;
                    final Animatable<Offset> tween =
                        Tween(begin: begin, end: end)
                            .chain(CurveTween(curve: Curves.easeInOut));
                    final Animation<Offset> offsetAnimation =
                        animation.drive(tween);
                    return SlideTransition(
                        position: offsetAnimation, child: child);
                  }),
                );
              },
              child: Container(
                // color: Colors.amberAccent,
                height: SizeConfig.blockSizeVertical! * 9,
                width: SizeConfig.blockSizeVertical! * 9,
                child: Icon(FontAwesomeIcons.react),
              ),
            ),
            InkWell(
              onTap: () {
                Navigator.of(context).push(
                  PageRouteBuilder(
                      pageBuilder: (context, animation, secondaryAnimation) {
                    return SearchScreen(searchValue: 'vuejs');
                  }, transitionsBuilder:
                          (context, animation, secondaryAnimation, child) {
                    final Offset begin = Offset(0.0, 1.0);
                    final Offset end = Offset.zero;
                    final Animatable<Offset> tween =
                        Tween(begin: begin, end: end)
                            .chain(CurveTween(curve: Curves.easeInOut));
                    final Animation<Offset> offsetAnimation =
                        animation.drive(tween);
                    return SlideTransition(
                        position: offsetAnimation, child: child);
                  }),
                );
              },
              child: Container(
                // color: Colors.amberAccent,
                height: SizeConfig.blockSizeVertical! * 9,
                width: SizeConfig.blockSizeVertical! * 9,
                child: Icon(FontAwesomeIcons.vuejs),
              ),
            ),
            InkWell(
              onTap: () {
                Navigator.of(context).push(
                  PageRouteBuilder(
                      pageBuilder: (context, animation, secondaryAnimation) {
                    return SearchScreen(searchValue: 'angular');
                  }, transitionsBuilder:
                          (context, animation, secondaryAnimation, child) {
                    final Offset begin = Offset(0.0, 1.0);
                    final Offset end = Offset.zero;
                    final Animatable<Offset> tween =
                        Tween(begin: begin, end: end)
                            .chain(CurveTween(curve: Curves.easeInOut));
                    final Animation<Offset> offsetAnimation =
                        animation.drive(tween);
                    return SlideTransition(
                        position: offsetAnimation, child: child);
                  }),
                );
              },
              child: Container(
                // color: Colors.amberAccent,
                height: SizeConfig.blockSizeVertical! * 9,
                width: SizeConfig.blockSizeVertical! * 9,
                child: Icon(FontAwesomeIcons.angular),
              ),
            ),
            InkWell(
              onTap: () {
                Navigator.of(context).push(
                  PageRouteBuilder(
                      pageBuilder: (context, animation, secondaryAnimation) {
                    return SearchScreen(searchValue: 'js');
                  }, transitionsBuilder:
                          (context, animation, secondaryAnimation, child) {
                    final Offset begin = Offset(0.0, 1.0);
                    final Offset end = Offset.zero;
                    final Animatable<Offset> tween =
                        Tween(begin: begin, end: end)
                            .chain(CurveTween(curve: Curves.easeInOut));
                    final Animation<Offset> offsetAnimation =
                        animation.drive(tween);
                    return SlideTransition(
                        position: offsetAnimation, child: child);
                  }),
                );
              },
              child: Container(
                // color: Colors.amberAccent,
                height: SizeConfig.blockSizeVertical! * 9,
                width: SizeConfig.blockSizeVertical! * 9,
                child: Icon(FontAwesomeIcons.js),
              ),
            ),
            InkWell(
              onTap: () {
                Navigator.of(context).push(
                  PageRouteBuilder(
                      pageBuilder: (context, animation, secondaryAnimation) {
                    return SearchScreen(searchValue: 'node');
                  }, transitionsBuilder:
                          (context, animation, secondaryAnimation, child) {
                    final Offset begin = Offset(0.0, 1.0);
                    final Offset end = Offset.zero;
                    final Animatable<Offset> tween =
                        Tween(begin: begin, end: end)
                            .chain(CurveTween(curve: Curves.easeInOut));
                    final Animation<Offset> offsetAnimation =
                        animation.drive(tween);
                    return SlideTransition(
                        position: offsetAnimation, child: child);
                  }),
                );
              },
              child: Container(
                // color: Colors.amberAccent,
                height: SizeConfig.blockSizeVertical! * 9,
                width: SizeConfig.blockSizeVertical! * 9,
                child: Icon(FontAwesomeIcons.node),
              ),
            ),
          ],
        ),
        Row(
          children: [
            InkWell(
              onTap: () {
                Navigator.of(context).push(
                  PageRouteBuilder(
                      pageBuilder: (context, animation, secondaryAnimation) {
                    return SearchScreen(searchValue: 'java');
                  }, transitionsBuilder:
                          (context, animation, secondaryAnimation, child) {
                    final Offset begin = Offset(0.0, 1.0);
                    final Offset end = Offset.zero;
                    final Animatable<Offset> tween =
                        Tween(begin: begin, end: end)
                            .chain(CurveTween(curve: Curves.easeInOut));
                    final Animation<Offset> offsetAnimation =
                        animation.drive(tween);
                    return SlideTransition(
                        position: offsetAnimation, child: child);
                  }),
                );
              },
              child: Container(
                // color: Colors.amberAccent,
                height: SizeConfig.blockSizeVertical! * 9,
                width: SizeConfig.blockSizeVertical! * 9,
                child: Icon(FontAwesomeIcons.java),
              ),
            ),
            InkWell(
              onTap: () {
                Navigator.of(context).push(
                  PageRouteBuilder(
                      pageBuilder: (context, animation, secondaryAnimation) {
                    return SearchScreen(searchValue: 'php');
                  }, transitionsBuilder:
                          (context, animation, secondaryAnimation, child) {
                    final Offset begin = Offset(0.0, 1.0);
                    final Offset end = Offset.zero;
                    final Animatable<Offset> tween =
                        Tween(begin: begin, end: end)
                            .chain(CurveTween(curve: Curves.easeInOut));
                    final Animation<Offset> offsetAnimation =
                        animation.drive(tween);
                    return SlideTransition(
                        position: offsetAnimation, child: child);
                  }),
                );
              },
              child: Container(
                // color: Colors.amberAccent,
                height: SizeConfig.blockSizeVertical! * 9,
                width: SizeConfig.blockSizeVertical! * 9,
                child: Icon(FontAwesomeIcons.php),
              ),
            ),
            InkWell(
              onTap: () {
                Navigator.of(context).push(
                  PageRouteBuilder(
                      pageBuilder: (context, animation, secondaryAnimation) {
                    return SearchScreen(searchValue: 'python');
                  }, transitionsBuilder:
                          (context, animation, secondaryAnimation, child) {
                    final Offset begin = Offset(0.0, 1.0);
                    final Offset end = Offset.zero;
                    final Animatable<Offset> tween =
                        Tween(begin: begin, end: end)
                            .chain(CurveTween(curve: Curves.easeInOut));
                    final Animation<Offset> offsetAnimation =
                        animation.drive(tween);
                    return SlideTransition(
                        position: offsetAnimation, child: child);
                  }),
                );
              },
              child: Container(
                // color: Colors.amberAccent,
                height: SizeConfig.blockSizeVertical! * 9,
                width: SizeConfig.blockSizeVertical! * 9,
                child: Icon(FontAwesomeIcons.python),
              ),
            ),
            InkWell(
              onTap: () {
                Navigator.of(context).push(
                  PageRouteBuilder(
                      pageBuilder: (context, animation, secondaryAnimation) {
                    return SearchScreen(searchValue: 'c');
                  }, transitionsBuilder:
                          (context, animation, secondaryAnimation, child) {
                    final Offset begin = Offset(0.0, 1.0);
                    final Offset end = Offset.zero;
                    final Animatable<Offset> tween =
                        Tween(begin: begin, end: end)
                            .chain(CurveTween(curve: Curves.easeInOut));
                    final Animation<Offset> offsetAnimation =
                        animation.drive(tween);
                    return SlideTransition(
                        position: offsetAnimation, child: child);
                  }),
                );
              },
              child: Container(
                // color: Colors.amberAccent,
                height: SizeConfig.blockSizeVertical! * 9,
                width: SizeConfig.blockSizeVertical! * 9,
                child: Icon(FontAwesomeIcons.c),
              ),
            ),
            InkWell(
              onTap: () {
                Navigator.of(context).push(
                  PageRouteBuilder(
                      pageBuilder: (context, animation, secondaryAnimation) {
                    return SearchScreen(searchValue: 'rust');
                  }, transitionsBuilder:
                          (context, animation, secondaryAnimation, child) {
                    final Offset begin = Offset(0.0, 1.0);
                    final Offset end = Offset.zero;
                    final Animatable<Offset> tween =
                        Tween(begin: begin, end: end)
                            .chain(CurveTween(curve: Curves.easeInOut));
                    final Animation<Offset> offsetAnimation =
                        animation.drive(tween);
                    return SlideTransition(
                        position: offsetAnimation, child: child);
                  }),
                );
              },
              child: Container(
                // color: Colors.amberAccent,
                height: SizeConfig.blockSizeVertical! * 9,
                width: SizeConfig.blockSizeVertical! * 9,
                child: Icon(FontAwesomeIcons.rust),
              ),
            ),
          ],
        ),
        Row(
          children: [
            InkWell(
              onTap: () {
                Navigator.of(context).push(
                  PageRouteBuilder(
                      pageBuilder: (context, animation, secondaryAnimation) {
                    return SearchScreen(searchValue: 'android');
                  }, transitionsBuilder:
                          (context, animation, secondaryAnimation, child) {
                    final Offset begin = Offset(0.0, 1.0);
                    final Offset end = Offset.zero;
                    final Animatable<Offset> tween =
                        Tween(begin: begin, end: end)
                            .chain(CurveTween(curve: Curves.easeInOut));
                    final Animation<Offset> offsetAnimation =
                        animation.drive(tween);
                    return SlideTransition(
                        position: offsetAnimation, child: child);
                  }),
                );
              },
              child: Container(
                // color: Colors.amberAccent,
                height: SizeConfig.blockSizeVertical! * 9,
                width: SizeConfig.blockSizeVertical! * 9,
                child: Icon(FontAwesomeIcons.android),
              ),
            ),
            InkWell(
              onTap: () {
                Navigator.of(context).push(
                  PageRouteBuilder(
                      pageBuilder: (context, animation, secondaryAnimation) {
                    return SearchScreen(searchValue: 'apple');
                  }, transitionsBuilder:
                          (context, animation, secondaryAnimation, child) {
                    final Offset begin = Offset(0.0, 1.0);
                    final Offset end = Offset.zero;
                    final Animatable<Offset> tween =
                        Tween(begin: begin, end: end)
                            .chain(CurveTween(curve: Curves.easeInOut));
                    final Animation<Offset> offsetAnimation =
                        animation.drive(tween);
                    return SlideTransition(
                        position: offsetAnimation, child: child);
                  }),
                );
              },
              child: Container(
                // color: Colors.amberAccent,
                height: SizeConfig.blockSizeVertical! * 9,
                width: SizeConfig.blockSizeVertical! * 9,
                child: Icon(FontAwesomeIcons.apple),
              ),
            ),
            InkWell(
              onTap: () {
                Navigator.of(context).push(
                  PageRouteBuilder(
                      pageBuilder: (context, animation, secondaryAnimation) {
                    return SearchScreen(searchValue: 'unity');
                  }, transitionsBuilder:
                          (context, animation, secondaryAnimation, child) {
                    final Offset begin = Offset(0.0, 1.0);
                    final Offset end = Offset.zero;
                    final Animatable<Offset> tween =
                        Tween(begin: begin, end: end)
                            .chain(CurveTween(curve: Curves.easeInOut));
                    final Animation<Offset> offsetAnimation =
                        animation.drive(tween);
                    return SlideTransition(
                        position: offsetAnimation, child: child);
                  }),
                );
              },
              child: Container(
                // color: Colors.amberAccent,
                height: SizeConfig.blockSizeVertical! * 9,
                width: SizeConfig.blockSizeVertical! * 9,
                child: Icon(FontAwesomeIcons.unity),
              ),
            ),
            InkWell(
              onTap: () {
                Navigator.of(context).push(
                  PageRouteBuilder(
                      pageBuilder: (context, animation, secondaryAnimation) {
                    return SearchScreen(searchValue: 'swift');
                  }, transitionsBuilder:
                          (context, animation, secondaryAnimation, child) {
                    final Offset begin = Offset(0.0, 1.0);
                    final Offset end = Offset.zero;
                    final Animatable<Offset> tween =
                        Tween(begin: begin, end: end)
                            .chain(CurveTween(curve: Curves.easeInOut));
                    final Animation<Offset> offsetAnimation =
                        animation.drive(tween);
                    return SlideTransition(
                        position: offsetAnimation, child: child);
                  }),
                );
              },
              child: Container(
                // color: Colors.amberAccent,
                height: SizeConfig.blockSizeVertical! * 9,
                width: SizeConfig.blockSizeVertical! * 9,
                child: Icon(FontAwesomeIcons.swift),
              ),
            ),
            InkWell(
              onTap: () {
                Navigator.of(context).push(
                  PageRouteBuilder(
                      pageBuilder: (context, animation, secondaryAnimation) {
                    return SearchScreen(searchValue: 'f');
                  }, transitionsBuilder:
                          (context, animation, secondaryAnimation, child) {
                    final Offset begin = Offset(0.0, 1.0);
                    final Offset end = Offset.zero;
                    final Animatable<Offset> tween =
                        Tween(begin: begin, end: end)
                            .chain(CurveTween(curve: Curves.easeInOut));
                    final Animation<Offset> offsetAnimation =
                        animation.drive(tween);
                    return SlideTransition(
                        position: offsetAnimation, child: child);
                  }),
                );
              },
              child: Container(
                // color: Colors.amberAccent,
                height: SizeConfig.blockSizeVertical! * 9,
                width: SizeConfig.blockSizeVertical! * 9,
                child: Icon(FontAwesomeIcons.f),
              ),
            ),
          ],
        ),
      ]),
    );
  }
}

class RecommendEngineer extends StatefulWidget {
  const RecommendEngineer({super.key});

  @override
  State<RecommendEngineer> createState() => _RecommendEngineerState();
}

class _RecommendEngineerState extends State<RecommendEngineer> {
  final List<String> _contents = [];
  final int loadLength = 30;

  int _lastIndex = 0;
  @override
  Widget build(BuildContext context) {
    return Container(
      height: SizeConfig.blockSizeVertical! * 28,
      color: Colors.amber,
    );
  }
}
