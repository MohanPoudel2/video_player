import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';

import '../../../models/all_country_list.dart';
import '../country_deatils.dart';
import '../data_base/country_db.dart';


class OfflineCountryList extends StatelessWidget {
  const OfflineCountryList({
    super.key,
    required this.countriesDataBase,
  });

  final CountriesDataBase countriesDataBase;

  @override
  Widget build(BuildContext context) {
    void onCountrySelected(AllCountryList selectedCountry) {
      Navigator.push(
        context,
        MaterialPageRoute(
          builder: (context) => CountryDetails(countryList: selectedCountry),
        ),
      );
    }
    return FutureBuilder<List<Map<String, dynamic>>>(
      future: countriesDataBase.getData(),
      builder: (context, snapshot) {
        if (snapshot.connectionState == ConnectionState.waiting) {
          // Waiting for the data from the database
          return const Center(
            child: CircularProgressIndicator(),
          );
        } else if (snapshot.hasError) {
          // Error getting the data from the database
          return Center(
            child: Text('Something went wrong${snapshot.error}'),
          );
        } else if (!snapshot.hasData || snapshot.data!.isEmpty) {
          // No data available in the database
          return const Center(
            child: Text('No data available'),
          );
        } else {
          // Data available in the database, show the list of countries
          final countries = snapshot.data!;
          return ListView.builder(
            itemCount: countries.length,
            itemBuilder: (context, index) {
              final selectedCountry = AllCountryList(
                id: countries[index]['id'],
                flags: Flags(png: countries[index]['image']),
                name: countries[index]['name'],
                capital: countries[index]['capitalCity'],
                region: countries[index]['region'],
                subregion: countries[index]['subRegion'],
              );
              return GestureDetector(
                onTap: () {
                  onCountrySelected(selectedCountry);
                },
                child: Card(
                  child: Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Row(
                      mainAxisAlignment:
                      MainAxisAlignment.spaceAround,
                      children: [
                        Expanded(
                          flex: 1,
                          child:CachedNetworkImage(
                            imageUrl: "${countries[index]['image']}",
                            placeholder: (context, url) => const Center(child: CircularProgressIndicator()),
                            errorWidget: (context, url, error) => const Icon(Icons.error),
                          ),

                          // Image.network(
                          //     '${countries[index]['image']}')

                        ),
                        const SizedBox(
                          width: 10,
                        ),
                        Expanded(
                          flex: 2,
                          child: Column(
                            crossAxisAlignment:
                            CrossAxisAlignment.start,
                            children: [
                              Text(
                                '${countries[index]['name']}',
                                style: Theme.of(context)
                                    .textTheme
                                    .titleSmall,
                              ),
                              Text(
                                  'Capital City : ${countries[index]['capitalCity']}'),
                              Text(
                                  'Region : ${countries[index]['region']}'),
                              Text(
                                  'SubRegion : ${countries[index]['subRegion']}'),
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
    );
  }
}
