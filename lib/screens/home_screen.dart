import 'package:flutter/material.dart';
import 'package:carousel_slider/carousel_slider.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:resume_app/screens/auth_edit/auth_edit_screen.dart';
import 'package:resume_app/utils/auth_check.dart';
import 'package:resume_app/utils/hex_color.dart';
import 'package:url_launcher/url_launcher.dart';
import '../provider/person_provider.dart';
import 'search/search_screen.dart';
import 'package:resume_app/utils/size_config.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';

import 'mypage_screen.dart';

class HomeScreen extends ConsumerStatefulWidget {
  const HomeScreen({super.key});

  @override
  ConsumerState<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends ConsumerState<HomeScreen> {
  @override
  void initState() {
    super.initState();
    // ログインしたユーザー情報プロバイダー
    final userstate = ref.read(userStateProvider);
  }

  @override
  Widget build(BuildContext context) {
    SizeConfig().init(context);
    return Scaffold(
      appBar: AppBar(
        automaticallyImplyLeading: false,
        actions: [
          IconButton(onPressed: () => {}, icon: const Icon(Icons.chat)),
          PopupMenuButton(
            icon: const Icon(Icons.more_vert),
            itemBuilder: (context) {
              return [
                makePopupMenuItem('edit', Icons.account_circle, ''),
                if (allowAdmin(ref))
                  makePopupMenuItem('auth', Icons.account_circle, "権限"),
              ];
            },
            onSelected: (String value) {
              if (value == 'edit') {
                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) => const MypageScreen(),
                  ),
                );
              } else if (value == 'auth') {
                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) => const AuthEditScreen(),
                  ),
                );
              }
            },
          )
        ],
      ),
      body: Center(
        child: Column(
          children: [
            const Carousel(),
            const Text('Develop Language'),
            const DevelopmentLanguageList(),
            const Text('Reccomend Engineer'),
            const RecommendEngineer(),
          ],
        ),
      ),
      floatingActionButton: FloatingActionButton(
        child: const Icon(Icons.close),
        onPressed: () {
          Navigator.push(
            context,
            MaterialPageRoute(
              builder: (context) => const SearchScreen(searchValue: ''),
            ),
          );
        },
      ),
    );
  }
}

PopupMenuItem<String> makePopupMenuItem(
    String itemValue, IconData icon, String title) {
  return PopupMenuItem(
    value: itemValue,
    child: Row(
      mainAxisAlignment: MainAxisAlignment.start,
      children: [
        Icon(
          icon,
          size: 24,
          color: HexColor(),
        ),
        const Padding(padding: EdgeInsets.only(right: 16)),
        Text(title.isNotEmpty ? title : itemValue.toUpperCase()),
      ],
    ),
  );
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
                    return const SearchScreen(searchValue: 'react');
                  }, transitionsBuilder:
                          (context, animation, secondaryAnimation, child) {
                    const Offset begin = Offset(0.0, 1.0);
                    const Offset end = Offset.zero;
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
                child: const Icon(FontAwesomeIcons.react),
              ),
            ),
            InkWell(
              onTap: () {
                Navigator.of(context).push(
                  PageRouteBuilder(
                      pageBuilder: (context, animation, secondaryAnimation) {
                    return const SearchScreen(searchValue: 'vuejs');
                  }, transitionsBuilder:
                          (context, animation, secondaryAnimation, child) {
                    const Offset begin = Offset(0.0, 1.0);
                    const Offset end = Offset.zero;
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
                child: const Icon(FontAwesomeIcons.vuejs),
              ),
            ),
            InkWell(
              onTap: () {
                Navigator.of(context).push(
                  PageRouteBuilder(
                      pageBuilder: (context, animation, secondaryAnimation) {
                    return const SearchScreen(searchValue: 'angular');
                  }, transitionsBuilder:
                          (context, animation, secondaryAnimation, child) {
                    const Offset begin = Offset(0.0, 1.0);
                    const Offset end = Offset.zero;
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
                child: const Icon(FontAwesomeIcons.angular),
              ),
            ),
            InkWell(
              onTap: () {
                Navigator.of(context).push(
                  PageRouteBuilder(
                      pageBuilder: (context, animation, secondaryAnimation) {
                    return const SearchScreen(searchValue: 'js');
                  }, transitionsBuilder:
                          (context, animation, secondaryAnimation, child) {
                    const Offset begin = Offset(0.0, 1.0);
                    const Offset end = Offset.zero;
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
                child: const Icon(FontAwesomeIcons.js),
              ),
            ),
            InkWell(
              onTap: () {
                Navigator.of(context).push(
                  PageRouteBuilder(
                      pageBuilder: (context, animation, secondaryAnimation) {
                    return const SearchScreen(searchValue: 'node');
                  }, transitionsBuilder:
                          (context, animation, secondaryAnimation, child) {
                    const Offset begin = Offset(0.0, 1.0);
                    const Offset end = Offset.zero;
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
                child: const Icon(FontAwesomeIcons.node),
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
                    return const SearchScreen(searchValue: 'java');
                  }, transitionsBuilder:
                          (context, animation, secondaryAnimation, child) {
                    const Offset begin = Offset(0.0, 1.0);
                    const Offset end = Offset.zero;
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
                child: const Icon(FontAwesomeIcons.java),
              ),
            ),
            InkWell(
              onTap: () {
                Navigator.of(context).push(
                  PageRouteBuilder(
                      pageBuilder: (context, animation, secondaryAnimation) {
                    return const SearchScreen(searchValue: 'php');
                  }, transitionsBuilder:
                          (context, animation, secondaryAnimation, child) {
                    const Offset begin = Offset(0.0, 1.0);
                    const Offset end = Offset.zero;
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
                child: const Icon(FontAwesomeIcons.php),
              ),
            ),
            InkWell(
              onTap: () {
                Navigator.of(context).push(
                  PageRouteBuilder(
                      pageBuilder: (context, animation, secondaryAnimation) {
                    return const SearchScreen(searchValue: 'python');
                  }, transitionsBuilder:
                          (context, animation, secondaryAnimation, child) {
                    const Offset begin = Offset(0.0, 1.0);
                    const Offset end = Offset.zero;
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
                child: const Icon(FontAwesomeIcons.python),
              ),
            ),
            InkWell(
              onTap: () {
                Navigator.of(context).push(
                  PageRouteBuilder(
                      pageBuilder: (context, animation, secondaryAnimation) {
                    return const SearchScreen(searchValue: 'c');
                  }, transitionsBuilder:
                          (context, animation, secondaryAnimation, child) {
                    const Offset begin = Offset(0.0, 1.0);
                    const Offset end = Offset.zero;
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
                child: const Icon(FontAwesomeIcons.c),
              ),
            ),
            InkWell(
              onTap: () {
                Navigator.of(context).push(
                  PageRouteBuilder(
                      pageBuilder: (context, animation, secondaryAnimation) {
                    return const SearchScreen(searchValue: 'rust');
                  }, transitionsBuilder:
                          (context, animation, secondaryAnimation, child) {
                    const Offset begin = Offset(0.0, 1.0);
                    const Offset end = Offset.zero;
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
                child: const Icon(FontAwesomeIcons.rust),
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
                    return const SearchScreen(searchValue: 'android');
                  }, transitionsBuilder:
                          (context, animation, secondaryAnimation, child) {
                    const Offset begin = Offset(0.0, 1.0);
                    const Offset end = Offset.zero;
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
                child: const Icon(FontAwesomeIcons.android),
              ),
            ),
            InkWell(
              onTap: () {
                Navigator.of(context).push(
                  PageRouteBuilder(
                      pageBuilder: (context, animation, secondaryAnimation) {
                    return const SearchScreen(searchValue: 'apple');
                  }, transitionsBuilder:
                          (context, animation, secondaryAnimation, child) {
                    const Offset begin = Offset(0.0, 1.0);
                    const Offset end = Offset.zero;
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
                child: const Icon(FontAwesomeIcons.apple),
              ),
            ),
            InkWell(
              onTap: () {
                Navigator.of(context).push(
                  PageRouteBuilder(
                      pageBuilder: (context, animation, secondaryAnimation) {
                    return const SearchScreen(searchValue: 'unity');
                  }, transitionsBuilder:
                          (context, animation, secondaryAnimation, child) {
                    const Offset begin = Offset(0.0, 1.0);
                    const Offset end = Offset.zero;
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
                child: const Icon(FontAwesomeIcons.unity),
              ),
            ),
            InkWell(
              onTap: () {
                Navigator.of(context).push(
                  PageRouteBuilder(
                      pageBuilder: (context, animation, secondaryAnimation) {
                    return const SearchScreen(searchValue: 'swift');
                  }, transitionsBuilder:
                          (context, animation, secondaryAnimation, child) {
                    const Offset begin = Offset(0.0, 1.0);
                    const Offset end = Offset.zero;
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
                child: const Icon(FontAwesomeIcons.swift),
              ),
            ),
            InkWell(
              onTap: () {
                Navigator.of(context).push(
                  PageRouteBuilder(
                      pageBuilder: (context, animation, secondaryAnimation) {
                    return const SearchScreen(searchValue: 'f');
                  }, transitionsBuilder:
                          (context, animation, secondaryAnimation, child) {
                    const Offset begin = Offset(0.0, 1.0);
                    const Offset end = Offset.zero;
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
                child: const Icon(FontAwesomeIcons.f),
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
