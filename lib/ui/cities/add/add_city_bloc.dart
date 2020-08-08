import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:flutter_app/data/data_constants.dart';
import 'package:flutter_app/data/repository/store_impl.dart';
import 'package:flutter_app/data/repository/store_repository.dart';
import 'package:flutter_app/model/city.dart';
import 'package:flutter_app/model/weather.dart';
import 'package:flutter_app/ui/common/debouncer.dart';
import 'package:http/http.dart' as http;

class AddCityBloc extends ChangeNotifier {
  final debouncer = Debouncer();
  final StoreRepository storage = StoreImpl();
  List<City> cities = [];
  bool loading = false;
  String errorMessage;

//  AddCityBloc({
//    @required this.storage,
//    @required this.apiService,
//  });

  void onChangetText(String text) {
    debouncer.run(() {
      if (text.isNotEmpty) requestSearch(text);
    });
  }

  void requestSearch(String text) async {
    loading = true;
    notifyListeners();
    final url = '${api}search/?query=$text';
    final response = await http.get(url);
    final data = jsonDecode(response.body) as List;
    cities = data.map((e) => City.fromJson(e)).toList();
    loading = false;
    notifyListeners();
  }

  Future<bool> addCity(City city) async {
    loading = true;
    notifyListeners();
    final url = '$api${city.id}';
    final response = await http.get(url);
    final data = jsonDecode(response.body);
//    final newCity = await apiService.getWeathers(city);
    final weatherData = data['consolidated_weather'] as List;
    final weathers = weatherData.map((e) => Weather.fromJson(e)).toList();
    final newCity = city.fromWeathers(weathers);
    try {
      await storage.saveCity(newCity);
      errorMessage = null;
    } on Exception catch (ex) {
      print(ex.toString());
      errorMessage = ex.toString();
    }
    loading = false;
    notifyListeners();
    return errorMessage == null;
  }
}
