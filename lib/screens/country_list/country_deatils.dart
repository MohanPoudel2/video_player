import 'package:flutter/material.dart';
import 'package:video_player_app/models/all_country_list.dart';
import 'package:video_player_app/utils/text_styles.dart';

class CountryDetails extends StatelessWidget {
  final AllCountryList countryList;
  const CountryDetails({super.key, required this.countryList});

  @override
  Widget build(BuildContext context) {
    return  Scaffold(
        appBar: AppBar(
          title: Text(countryList.name??''),
        ),
        body:Padding(
          padding: const EdgeInsets.only(left: 10),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Container(
                alignment: Alignment.center,
                child: Card(
                    elevation: 4,
                    child: Image.network('${countryList.flags?.png}')),
              ),
              const SizedBox(height: 20,),
              Text('Name: ${countryList.name}',style: TextStyles.mediumTextStyle,),
              Text('Region: ${countryList.region}',style: TextStyles.mediumTextStyle,),
              Text('Population: ${countryList.population}',style: TextStyles.mediumTextStyle,),
              Text('Capital City: ${countryList.capital}',style: TextStyles.mediumTextStyle,),
              Text('Area: ${countryList.area}km',style: TextStyles.mediumTextStyle,),
            ],
          ),
        )
    );
  }
}
