import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'package:provider/provider.dart';
import 'package:video_player_app/provider/shoes_list_provider/shoes_list_provider.dart';
import 'package:video_player_app/q&a/q_&_a.dart';
import 'package:video_player_app/screens/country_list/country_list_screen.dart';
import 'package:video_player_app/screens/login_screen/login_screen.dart';
import 'package:video_player_app/screens/shoes_screen/shoes_screen.dart';
import 'package:video_player_app/screens/video_screen/video_details.dart';
import 'package:video_player_app/utils/text_styles.dart';
import '../../reusable_widgets/card_widget.dart';

class HomeScreen extends StatelessWidget {
  final String? accountEmail;
  final GoogleSignIn googleSignIn;

  const HomeScreen({super.key, required this.accountEmail, required this.googleSignIn});

  @override
  Widget build(BuildContext context) {

    final fullEmail=accountEmail;
    final parts=extractUsernameFromEmail(fullEmail!);

    return Scaffold(
      body: Container(
        padding: const EdgeInsets.only(top: 20, left: 10, right: 10),
        decoration: const BoxDecoration(
            image: DecorationImage(
                fit: BoxFit.fill, image: AssetImage('assets/bg3.jpg'))),
        child: SafeArea(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text(
                    'Hello!Welcome\n$parts',
                    style: TextStyles.mediumTextStyle,
                  ),
                  GestureDetector(
                    onTap: () {
                      showDialog(
                          context: context,
                          builder: (context) => AlertDialog(
                                title: const Icon(
                                  Icons.warning_amber,
                                  size: 50,
                                ),
                                content:
                                    const Text('Are you sure you wanna Sign-Out?'),
                                actions: [
                                  TextButton(
                                      onPressed: () async {
                                        await handleSignOut().whenComplete(
                                            () => Navigator.push(context,MaterialPageRoute(builder: (context) =>const LoginScreen(),) ));
                                      },
                                      child: const Text('Yes')),
                                  TextButton(
                                      onPressed: () {
                                        Navigator.pop(context);
                                      },
                                      child: const Text('No')),
                                ],
                              ));
                    },
                    child: const ImageIcon(AssetImage('assets/log_out.png')),
                  ),
                ],
              ),
              const SizedBox(
                height: 30,
              ),
              GestureDetector(
                  onTap: () {
                    Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (context) => const VideoDetailsScreen(),
                        ));
                  },
                  child: const CardWidget(
                      name: 'Videos', image: 'assets/movie.png')),
              GestureDetector(
                onTap: () {
                  Provider.of<NewShoesListProvider>(context, listen: false);
                  Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (context) => const ShoesScreen(),
                      ));
                },
                child: const CardWidget(
                    name: 'Shoes E-Commerce', image: 'assets/shoes.jpg'),
              ),
              GestureDetector(
                onTap: () {
                  Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (context) => const CountryList(),
                      ));
                },
                child: const CardWidget(
                    name: 'Countries List', image: 'assets/countries.jpg'),
              ),
              GestureDetector(
                  onTap: () {
                    Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (context) => const QuestionAndAnswer(),
                        ));
                  },
                  child:
                      const CardWidget(name: 'Q & A', image: 'assets/qanda.jpg')),
            ],
          ),
        ),
      ),
    );
  }

  Future<void> handleSignOut() async {
    try {
      await googleSignIn.signOut();
    } catch (error) {
      if (kDebugMode) {
        print(error);
      }
    }
  }
  String extractUsernameFromEmail(String email) {
    final parts = email.split('@');
    if (parts.length == 2) {
      return parts[0];
    } else {
      return 'Invalid Email';
    }
  }
}
