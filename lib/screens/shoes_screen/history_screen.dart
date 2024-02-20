import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:video_player_app/provider/shoes_list_provider/shoes_list_provider.dart';
import 'package:video_player_app/utils/text_styles.dart';

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
    final totalSum =
        historyItem.fold(0, (sum, shoe) => sum + int.parse("${shoe.price}"));
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

                return Card(
                  elevation: 4,
                  margin: const EdgeInsets.only(bottom: 5),
                  shape: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(15),
                      borderSide: const BorderSide(color: Colors.transparent)),
                  child: ListTile(
                    shape: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(15),
                        borderSide:
                            const BorderSide(color: Colors.transparent)),
                    leading: ClipOval(
                      child: SizedBox(
                        width: 60,
                        height: 100,
                        child: Image(
                          fit: BoxFit.fill,
                          image: AssetImage(historyList.image),
                        ),
                      ),
                    ),
                    title: Text(
                      historyList.name,
                      style: TextStyles.smallText,
                    ),
                    trailing: Text(
                      '\$${historyList.price}',
                      style: TextStyles.textButton2,
                    ),
                  ),
                );
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
