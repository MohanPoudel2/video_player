import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';

import '../../../models/all_country_list.dart';
import '../../../service/api_service.dart';
import '../country_deatils.dart';
import '../data_base/country_db.dart';


class OnlineCountryList extends StatelessWidget {
  const OnlineCountryList({
    super.key,
    required this.apiService,
    required this.countriesDataBase,
  });

  final ApiService apiService;
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
    return FutureBuilder(
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
          countriesDataBase.insertCountries(countries);
          return ListView.builder(
            itemCount: countries.length,
            itemBuilder: (context, index) {
              final selectedCountry = countries[index];
              return GestureDetector(
                onTap: () {
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
                          child:CachedNetworkImage(
                            imageUrl: "${countries[index].flags?.png}",
                            placeholder: (context, url) => const Center(child: CircularProgressIndicator()),
                            errorWidget: (context, url, error) => const Icon(Icons.error),
                          ),

                          // Image.network(
                          //     '${countries[index].flags?.png}')
                        ),
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
                                style:
                                Theme.of(context).textTheme.titleSmall,
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
    );
  }
}