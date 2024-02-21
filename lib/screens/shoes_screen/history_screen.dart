import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:video_player_app/provider/shoes_list_provider/shoes_list_provider.dart';
import 'package:video_player_app/utils/text_styles.dart';

import '../../reusable_widgets/history_card.dart';

class HistoryScreen extends StatefulWidget {
  const HistoryScreen({super.key});

  @override
  State<HistoryScreen> createState() => _HistoryScreenState();
}

class _HistoryScreenState extends State<HistoryScreen> {
  @override
  void initState() {
    super.initState();
    Provider.of<NewShoesListProvider>(context, listen: false).loadHistory();
  }

  @override
  Widget build(BuildContext context) {
    final historyCart = context.watch<NewShoesListProvider>();

    final historyItem = historyCart.historyCartList;
    final totalSum = historyItem.fold(
        0, (sum, shoe) => sum + int.parse("${shoe.price * shoe.quantity}"));
    return Scaffold(
      body: Container(
        padding: const EdgeInsets.only(top: 40, right: 10, left: 10),
        decoration: const BoxDecoration(
            image: DecorationImage(
                image: AssetImage('assets/bg3.jpg'), fit: BoxFit.fill)),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              children: [
                IconButton(
                    onPressed: () {
                      Navigator.pop(context);
                    },
                    icon: const Icon(Icons.arrow_back)),
                const SizedBox(
                  width: 10,
                ),
                Text(
                  'History',
                  style: TextStyles.mediumText.copyWith(color: Colors.red),
                )
              ],
            ),
            Expanded(
                child: ListView.builder(
              itemCount: historyItem.length,
              itemBuilder: (context, index) {
                final historyList = historyItem[index];
                return MyCard(historyList: historyList);
              },
            )),
            Padding(
              padding: const EdgeInsets.only(bottom: 20),
              child: Center(
                  child: Text(
                'You have spend a total of \$ $totalSum',
                style: TextStyles.smallText,
              )),
            )
          ],
        ),
      ),
    );
  }
}
