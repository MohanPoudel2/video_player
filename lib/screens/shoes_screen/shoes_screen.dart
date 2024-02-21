import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:video_player_app/screens/shoes_screen/cart_screen.dart';
import 'package:video_player_app/screens/shoes_screen/history_screen.dart';
import '../../provider/shoes_list_provider/shoes_list_provider.dart';
import '../../reusable_widgets/new_shoes_widget.dart';
import '../../reusable_widgets/running_shoe_list_widget.dart';
import '../../reusable_widgets/text_form_field_widget.dart';
import '../../utils/text_styles.dart';
import 'package:badges/badges.dart' as badges;
class ShoesScreen extends StatefulWidget {
  const ShoesScreen({super.key});

  @override
  State<ShoesScreen> createState() => _ShoesScreenState();
}

class _ShoesScreenState extends State<ShoesScreen> {
  String _name = 'running';

  @override
  Widget build(BuildContext context) {
    var shoesListNotifier = Provider.of<NewShoesListProvider>(context);

    return Scaffold(
        body: SingleChildScrollView(
      child: Container(
        padding: const EdgeInsets.only(top: 30, left: 10, right: 10),
        decoration: const BoxDecoration(
            image: DecorationImage(
                image: AssetImage('assets/bg3.jpg'), fit: BoxFit.fill)),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                IconButton(
                    onPressed: () {
                      Navigator.pop(context);
                    },
                    icon: const Icon(Icons.arrow_back_ios)),
                IconButton(
                    onPressed: () {
                      Navigator.push(
                          context,
                          MaterialPageRoute(
                            builder: (context) => const CartScreen(),
                          ));
                    },
                    icon: badges.Badge(
                      position: badges.BadgePosition.topEnd(top: -14, end: -12),
                      badgeStyle: const badges.BadgeStyle(
                        elevation: 4,
                          shape: badges.BadgeShape.circle,
                          badgeColor: Colors.red,
                          padding: EdgeInsets.all(4),

                      ),
                      badgeContent: Text('${context.watch<NewShoesListProvider>().cartItems.length}'),
                      child: const Icon(Icons.shopping_cart),
                    ))
              ],
            ),
            const Text(
              'Store',
              style: TextStyles.bigText,
            ),
            const TextFormFieldWidget(),
            const SizedBox(height: 20),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                const Text(
                  'New Arrivals',
                  style: TextStyles.mediumText,
                ),
                TextButton(
                    onPressed: () {
                      Navigator.push(
                          context,
                          MaterialPageRoute(
                            builder: (context) =>  const HistoryScreen(),
                          ));
                    },
                    child: Text(
                      'History',
                      style: TextStyles.smallText.copyWith(color: Colors.red),
                    ))
              ],
            ),
            const SizedBox(
              height: 10,
            ),
            NewShoesWidget(
              shoesListNotifier: shoesListNotifier,
            ),
            const SizedBox(
              height: 15,
            ),
            Row(
              children: [
                buildTextButton(fillText: 'running', text: 'Running'),
                buildTextButton(fillText: 'training', text: 'Training'),
                buildTextButton(
                    fillText: 'Trail Running', text: 'Trail Running'),
              ],
            ),
            const SizedBox(
              height: 30,
            ),
            RunningShoesWidget(shoesListNotifier: shoesListNotifier),
          ],
        ),
      ),
    ));
  }

  TextButton buildTextButton({required String fillText, required String text}) {
    return TextButton(
      onPressed: () {
        setState(() {
          _name = fillText;
        });
      },
      child: Text(
        text,
        style:
            _name == fillText ? TextStyles.textButton1 : TextStyles.textButton2,
      ),
    );
  }
}
