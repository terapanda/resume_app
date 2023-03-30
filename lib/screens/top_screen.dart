import 'package:flutter/material.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import '../model/person.dart';
import '../provider/person_provider.dart';
import '../services/firebaseService.dart';
import 'home_screen.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'package:resume_app/provider/user_state.dart';

class TopScreen extends ConsumerWidget {
  TopScreen({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return WillPopScope(
        onWillPop: () async => false,
        child: Scaffold(
          appBar: AppBar(
            automaticallyImplyLeading: false,
          ),
          body: Center(
            child:
                Column(mainAxisAlignment: MainAxisAlignment.center, children: [
              ElevatedButton.icon(
                  onPressed: (() async {
                    try {
                      final userCredential = await signInWithGoogle(ref);
                      Navigator.of(context).push(
                        PageRouteBuilder(pageBuilder:
                            (context, animation, secondaryAnimation) {
                          return HomeScreen();
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
                    } on FirebaseAuthException catch (e) {
                      print('FirebaseAuthException');
                      print('${e.code}');
                    } on Exception catch (e) {
                      print('Other Exception');
                      print('${e.toString()}');
                    }
                  }),
                  icon: Icon(FontAwesomeIcons.google),
                  label: Text("サインイン"))
            ]),
          ),
        ));
  }
}

Future<UserCredential> signInWithGoogle(WidgetRef ref) async {
  // Trigger the authentication flow
  final GoogleSignInAccount? googleUser = await GoogleSignIn().signIn();

  // Obtain the auth details from the request
  final GoogleSignInAuthentication? googleAuth =
      await googleUser?.authentication;

  // Create a new credential
  final credential = GoogleAuthProvider.credential(
    accessToken: googleAuth?.accessToken,
    idToken: googleAuth?.idToken,
  );

  final _googleUser = {
    'id': googleUser!.id,
    'email': googleUser.email,
    'name': googleUser.displayName
  };

  // ログインしたユーザー情報を退避
  ref.read(GoogleUserInfoProvider.notifier).state = _googleUser;

  // Person loginUserInfo = await FirebaseService.fetchConvertPerson();
  // ref.read(personProvider.notifier).state = loginUserInfo;

  // loginしているユーザー情報取得
  final loginUserData = await FirebaseService.fetchUserData(googleUser.id);

  ref.read(userStateProvider.notifier).state = loginUserData.data();

  final userstate = ref.read(userStateProvider);

  final masterData = ref.read(masterDataProvider);
  // Once signed in, return the UserCredential
  return await FirebaseAuth.instance.signInWithCredential(credential);
}
