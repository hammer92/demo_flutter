import 'package:flutter/material.dart';
import 'package:flutter_app/data/repository/store_impl.dart';
import 'package:flutter_app/data/repository/store_repository.dart';
import 'package:flutter_app/model/city.dart';

class CitiesBloc extends ChangeNotifier {
  List<City> cities = [];
  final StoreRepository storage = StoreImpl();

//  CitiesBloc({@required this.storage});

  void loadCities() async {
    cities = await storage.getCities();
    notifyListeners();
  }

  void deleteCity(City city) async {
    await storage.deleteCity(city);
    loadCities();
  }
}