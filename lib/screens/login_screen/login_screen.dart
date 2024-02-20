import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'package:sign_in_button/sign_in_button.dart';

import '../../utils/app_colors.dart';
import '../home_screen/home_screen.dart';

class LoginScreen extends StatefulWidget {
  const LoginScreen({super.key});

  @override
  State<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  @override
  Widget build(BuildContext context) {
    String? userAccount;
    const List<String> scopes = <String>[
      'email',
      'https://www.googleapis.com/auth/contacts.readonly',
    ];
    GoogleSignIn googleSignIn = GoogleSignIn(
      scopes: scopes,
    );
    Future<void> handleSignIn() async {
      try {
        final account = await googleSignIn.signIn();
        if (account != null) {
          setState(() {
            userAccount = account.email;
          });
        }
      } catch (error) {
        if (kDebugMode) {
          print(error);
        }
      }
    }


    return Scaffold(
        
        body: SafeArea(
          child: Scaffold(
            body: SingleChildScrollView(
              child: Column(
                children: [
                   const Image(image: AssetImage('assets/welcome.jpg')),
                  const SizedBox(
                    height: 100,
                  ),
                  Container(
                    padding: const EdgeInsets.only(right:20, bottom: 20,left: 20),
                    child: TextFormField(
                      decoration: InputDecoration(
                          icon: const Icon(Icons.mail),
                          iconColor: AppColors.iconColor,
                          hintText: 'Enter your Email here',
                          border: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(30),
                              borderSide: const BorderSide(
                                  color: AppColors.bottomNev))),
                    ),
                  ),
                  Container(
                    padding: const EdgeInsets.only(right: 20,left: 20),
                    child: TextFormField(
                      obscureText: true,
                      decoration: InputDecoration(
                          icon: const Icon(Icons.password_sharp),
                          iconColor: AppColors.iconColor,
                          hintText: 'Enter your Password here',
                          border: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(30),
                              borderSide: const BorderSide(
                                  color: AppColors.bottomNev))),
                    ),
                  ),
                  GestureDetector(
                    onTap: () {
                      Navigator.push(
                          context,
                          MaterialPageRoute(
                            builder: (context) =>
                                 HomeScreen(accountEmail: '',googleSignIn: googleSignIn),
                          ));
                    },
                    child: Container(
                      margin: const EdgeInsets.only(top: 30, bottom: 20),
                      height: 60,
                      width: 200,
                      decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(20),
                          color: AppColors.iconColor),
                      child: const Center(
                        child: Text('Sign In'),
                      ),
                    ),
                  ),
                  const Text('-OR-'),
                  Padding(
                    padding: const EdgeInsets.only(top: 20.0),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        SignInButton(
                          Buttons.google,
                          onPressed: () async {
                            await handleSignIn().whenComplete(() {
                              Navigator.of(context, rootNavigator: true).pushAndRemoveUntil(
                                MaterialPageRoute(
                                  builder: (context) => HomeScreen(accountEmail: userAccount,googleSignIn: googleSignIn,),
                                ),
                                    (route) => false,
                              );
                            });
                            debugPrint('successfully sign in$userAccount');
                          },
                          text: "Sign Up with google",
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            ),
          ),
        ));
  }
}
