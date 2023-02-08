import 'package:flutter/material.dart';
import 'package:resume_app/screens/top_screen.dart';
import 'package:rive/rive.dart';

class AppSplashScreen extends StatefulWidget {
  const AppSplashScreen({Key? key}) : super(key: key);

  @override
  State<AppSplashScreen> createState() => _AppSplashScreenState();
}

class _AppSplashScreenState extends State<AppSplashScreen> {
  bool _isLoading = true;

  @override
  void initState() {
    super.initState();
    Future(() async {
      await Future<void>.delayed(const Duration(seconds: 8));
      setState(() {
        // 8秒後にsplashをまだスキップしてなければ強制画面遷移
        if (_isLoading) {
          gotoTopScreen();
        }
      });
    });
  }

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
        onTap: () {
          // splash中にタップしたらスキップして画面遷移
          _isLoading = false;
          gotoTopScreen();
        },
        child: const Scaffold(
            body: Center(
          // Riveファイルの再生を行う
          child: RiveAnimation.asset(
            'assets/splash.riv',
          ),
        )));
  }

  /// TopScreenに遷移
  void gotoTopScreen() {
    Navigator.push(
      context,
      MaterialPageRoute(
        builder: (context) => TopScreen(),
      ),
    );
  }
}
