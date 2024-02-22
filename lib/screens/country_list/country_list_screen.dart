

import 'dart:io';

import 'package:connectivity_plus/connectivity_plus.dart';
import 'package:flutter/material.dart';
import '../../service/api_service.dart';
import 'data_base/country_db.dart';
import 'online_and_offline_widget/offline_country_list.dart';
import 'online_and_offline_widget/online_country_list.dart';

class CountryList extends StatefulWidget {
  const CountryList({super.key});

  @override
  State<CountryList> createState() => _CountryListState();
}

class _CountryListState extends State<CountryList> {
  final ApiService apiService = ApiService();
  final CountriesDataBase countriesDataBase = CountriesDataBase();
  @override

  @override
  Widget build(BuildContext context) {

    Future<bool> hasInternetConnection() async {
      // Check if there is a network connection
      var connectivityResult = await Connectivity().checkConnectivity();
      if (connectivityResult == ConnectivityResult.none) {
        // No network connection
        return false;
      } else {
        // Network connection, but check if there is internet access
        try {
          // Ping a website and see if it responds
          var result = await InternetAddress.lookup('example.com');
          if (result.isNotEmpty && result[0].rawAddress.isNotEmpty) {
            // Internet access
            return true;
          } else {
            // No internet access
            return false;
          }
        } on SocketException catch (_) {
          // Error pinging the website
          return false;
        }
      }
    }


    return Scaffold(
        appBar: AppBar(
          elevation: 2,
          title: const Text('Countries List'),
          centerTitle: true,
        ),
        body: FutureBuilder(
          future: hasInternetConnection(),
          builder: (context, snapshot) {
            if (snapshot.connectionState == ConnectionState.waiting) {
              // Waiting for the result of the method
              return const Center(
                child: CircularProgressIndicator(),
              );
            } else if (snapshot.hasError) {
              // Error calling the method
              return const Center(
                child: Text('Something went wrong'),
              );
            } else if (!snapshot.hasData || snapshot.data == false) {
              // No internet connection
              return OfflineCountryList(countriesDataBase: countriesDataBase);

            } else {
              // Internet connection, fetch the data from the API
              return OnlineCountryList(apiService: apiService, countriesDataBase: countriesDataBase);
            }
          },
        )

    );
  }
}



