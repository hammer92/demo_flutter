import 'package:flutter/material.dart';
import 'package:flutter_app/model/city.dart';
import 'package:flutter_app/ui/cities/add/add_city_page.dart';
import 'package:flutter_app/ui/cities/cities_bloc.dart';
import 'package:flutter_app/ui/common/header_widget.dart';
import 'package:flutter_app/ui/ui_constants.dart';

class CitiesPage extends StatefulWidget {
  @override
  _CitiesPageState createState() => _CitiesPageState();
}

class _CitiesPageState extends State<CitiesPage> {
  final bloc = CitiesBloc();

  @override
  void initState() {
    bloc.loadCities();
    super.initState();
  }

  void _handleNavegatePress(BuildContext context) async {
    await Navigator.of(context).push(PageRouteBuilder(
        transitionDuration: const Duration(microseconds: 900),
        pageBuilder: (_, animation1, animation2) {
          return SlideTransition(
              position:
                  Tween<Offset>(begin: Offset(0.0, 0.1), end: Offset(0.0, 0.0))
                      .animate(animation1),
              child: AddCityPage());
        }));
    bloc.loadCities();
  }

  @override
  Widget build(BuildContext context) {
    return AnimatedBuilder(
        animation: bloc,
        builder: (context, child) {
          return Scaffold(
            appBar: AppBar(
                elevation: 0,
                backgroundColor: Colors.white,
                iconTheme: IconThemeData(color: Colors.black)),
            floatingActionButton: FloatingActionButton(
              child: Icon(Icons.add),
              backgroundColor: primaryColor,
              onPressed: () => _handleNavegatePress(context),
            ),
            body: Padding(
              padding: const EdgeInsets.all(25),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.stretch,
                children: <Widget>[
                  HeaderWidget(title: 'Mis Ciudades'),
                  Expanded(
                    child: bloc.cities.isEmpty
                        ? Center(
                            child: Text('No hay Ciudades'),
                          )
                        : ListView.builder(
                            itemCount: bloc.cities.length,
                            itemBuilder: (context, index) {
                              final city = bloc.cities[index];
                              return CityItem(
                                city: city,
                              );
                            }),
                  )
                ],
              ),
            ),
          );
        });
  }
}

class CityItem extends StatelessWidget {
  final City city;
  final VoidCallback onTap;

  const CityItem({
    Key key,
    this.city,
    this.onTap,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 8.0),
      child: Container(
        color: Colors.grey[200],
        padding: const EdgeInsets.all(20.0),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: <Widget>[
            Text(
              city.title,
              style: TextStyle(
                fontWeight: FontWeight.w700,
                fontSize: 20,
              ),
            ),
            InkWell(
              onTap: onTap,
              child: Icon(
                Icons.close,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
