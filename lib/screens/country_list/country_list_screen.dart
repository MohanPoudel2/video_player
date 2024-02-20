import 'package:flutter/material.dart';
import 'package:video_player_app/models/all_country_list.dart';
import 'package:video_player_app/screens/country_list/country_deatils.dart';

import '../../service/api_service.dart';

class CountryList extends StatelessWidget {
  const CountryList({super.key});

  @override
  Widget build(BuildContext context) {
    void onCountrySelected(AllCountryList selectedCountry) {
      Navigator.push(
        context,
        MaterialPageRoute(
          builder: (context) => CountryDetails(countryList:selectedCountry),
        ),
      );
    }
    final ApiService apiService = ApiService();
    return Scaffold(
        appBar: AppBar(
          elevation: 2,
          title: const Text('Countries List'),
          centerTitle: true,
        ),
        body: FutureBuilder(
          future: apiService.fetchAllCountry(),
          builder: (context, snapshot) {
            if (snapshot.connectionState == ConnectionState.waiting) {
              return const Center(
                child: CircularProgressIndicator(),
              );
            } else if (snapshot.hasError) {
              return const Center(
                child: Text('Something went wrong'),
              );
            } else if (!snapshot.hasData || snapshot.data!.isEmpty) {
              return const Center(
                child: Text('No data available'),
              );
            } else {
              final countries = snapshot.data!;
              return ListView.builder(
                itemCount: countries.length,
                itemBuilder: (context, index) {
                  final selectedCountry = countries[index];
                  return GestureDetector(
                    onTap: (){
                      onCountrySelected(selectedCountry);
                    },
                    child: Card(
                      child: Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceAround,
                          children: [
                            Expanded(
                                flex: 1,
                                child: Image.network(
                                    '${countries[index].flags?.png}')),
                            const SizedBox(
                              width: 10,
                            ),
                            Expanded(
                              flex: 2,
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Text(
                                    '${countries[index].name}',
                                    style: Theme.of(context).textTheme.titleSmall,
                                  ),
                                  Text(
                                      'Capital City : ${countries[index].capital}'),
                                  Text('Region : ${countries[index].region}'),
                                  Text(
                                      'SubRegion : ${countries[index].subregion}'),
                                ],
                              ),
                            ),
                          ],
                        ),
                      ),
                    ),
                  );
                },
              );
            }
          },
        ));

  }

}
