import 'package:flutter/material.dart';
import 'package:flutter_app/data/repository/store_impl.dart';
import 'package:flutter_app/data/repository/store_repository.dart';
import 'package:flutter_app/model/city.dart';

class HomeBloc extends ChangeNotifier {
  List<City> cities = [];
  final StoreRepository storage = StoreImpl();

//  HomeBloc({this.storage,
////    this.apiService
//  });
//  final ApiRepository apiService;
  bool loading = false;

  void loadCities() async {
//    final lastUpdate = await storage.getLastUpdate();
//    final now = DateTime.now();
//    final localCities = await storage.getCities();
//    if (localCities.isEmpty) return;
//    if (lastUpdate == null || (formatDate.format(now) != formatDate.format(lastUpdate))) {
//      List<City> citiesUpdated = [];
//      loading = true;
//      notifyListeners();
//      for (City city in localCities) {
//        final cityUpdated = await apiService.getWeathers(city);
//        citiesUpdated.add(cityUpdated);
//      }
//      await storage.saveCities(citiesUpdated);
//      await storage.saveLastUpdate();
//      cities = citiesUpdated;
//      loading = false;
//    } else {
      cities = await storage.getCities();
//    }
    notifyListeners();
  }
}
