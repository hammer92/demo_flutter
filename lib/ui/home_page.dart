import 'package:flutter/material.dart';
import 'package:flutter_app/ui/cities/cities_page.dart';
import 'package:flutter_app/ui/home/empty_widget.dart';
import 'package:flutter_app/ui/home/weathers_widget.dart';
import 'package:flutter_app/ui/home_bloc.dart';

class HomePage extends StatefulWidget {
  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {

  HomeBloc bloc;

  void _handleNavegatePress(BuildContext context) {
    Navigator.of(context).push(MaterialPageRoute(builder: (_) => CitiesPage()));
  }

  @override
  void initState() {
    bloc = HomeBloc(
//      apiService: context.read<ApiRepository>(),
//      storage: context.read<StoreRepository>(),
    );
    bloc.loadCities();
//    WidgetsBinding.instance.addObserver(this);
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return AnimatedBuilder(
      animation: bloc,
      builder: (context, child) {
        return Scaffold(
            body: bloc.cities.isEmpty ? EmptyWidget(
              onTap: () => _handleNavegatePress(context),
            ) : Center(
              child: WeathersWidget(cities: bloc.cities,),
            )
        );
      },
    );
  }
}
