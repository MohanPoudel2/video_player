import 'dart:convert';

import 'package:path/path.dart';
import 'package:sqflite/sqflite.dart';
import 'package:crypto/crypto.dart';
import '../../../models/all_country_list.dart';

class CountriesDataBase {
  late Database countryDb;
  final String dbName = 'countries.sqlite';
  //final String country = 'country_list_table';

  String createId(String input) {
    var bytes = utf8.encode(input);

    var digest = sha256.convert(bytes);

    return digest.toString();
  }
CountriesDataBase(){
  _createDataBase();
}
  Future<Database> _createDataBase() async {
    var databasePath = await getDatabasesPath();
    String path = join(databasePath, dbName);
    countryDb = await openDatabase(
      path,
      onCreate: (db, version) {
        db.execute(
            'create table if not exists country_list_table(id text primary key, image text, name text, capitalCity text, region text, subRegion text);');
      },
      version: 1,
    );
    return countryDb;
  }

  Future<void> insertCountry(AllCountryList country) async {
    String id=createId(country.name!);
    await countryDb.rawInsert(
      'INSERT OR REPLACE INTO country_list_table(id, image, name, capitalCity, region, subRegion) VALUES (?,?,?,?,?,?)', // Use ON CONFLICT REPLACE
      [
        id,
        country.flags?.png,
        country.name,
        country.capital,
        country.region,
        country.subregion,
      ],
    );
  }
  Future<List<AllCountryList>> getCountries() async {
    final List<Map<String, dynamic>> maps = await countryDb.rawQuery(
      'select * from country_list_table',
    );
    return List.generate(
      maps.length,
          (i) => AllCountryList(
        id: maps[i]['id'],
        flags: Flags(png: maps[i]['image']),
        name: maps[i]['name'],
        capital: maps[i]['capitalCity'],
        region: maps[i]['region'],
        subregion: maps[i]['subRegion'],
      ),
    );
  }
  Future<void> insertCountries(List<AllCountryList> countries) async {
    for (var country in countries) {
      await insertCountry(country);
    }
  }
  // Define a function to fetch the data from your database
  Future<List<Map<String, dynamic>>> getData() async {
    // Open the database
    var databasePath = await getDatabasesPath();
    String path = join(databasePath, 'countries.sqlite');
    Database db = await openDatabase(path);

    // Query the data from the country_list_table
    List<Map<String, dynamic>> data = await db.query('country_list_table');

    // Close the database
   // await db.close();

    // Return the data as a list of maps
    return data;
  }


}
