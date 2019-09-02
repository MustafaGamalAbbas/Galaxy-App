import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:galaxy/bloc/fetchingSharedPreference/bloc.dart';
import 'package:galaxy/bloc/planets/bloc.dart';
import 'package:galaxy/models/Planet.dart';
import 'package:galaxy/ui/widgets/home/planetCard/PlanetCard.dart';

class PlanetsListWidget extends StatefulWidget {
 
  _PlanetsListWidgetState createState() => _PlanetsListWidgetState();
}

class _PlanetsListWidgetState extends State<PlanetsListWidget> {
   List<Planet> _planets= new List<Planet> ();

  _PlanetsListWidgetState();

  @override
  Widget build(BuildContext context) {
    final FetchingSharedPreferenceBloc _bloc  =FetchingSharedPreferenceBloc()..dispatch(BackGroundColor());
   
    return BlocProvider(

      builder: (context) => _bloc,
      child: BlocBuilder<FetchingSharedPreferenceBloc,
          FetchingSharedPreferenceState>(builder: (context, state) {
        if (state is BackgroundSharedpreferenceState) {
           return BlocProvider(
             builder: (context)=>PlanetsBloc()..dispatch(GetPlanetsListEvent()),
                        child: BlocBuilder<PlanetsBloc, PlanetsState>(
                          builder: (context, snapshot) {
                            if(snapshot is OnReceiveDataState )
                              _planets = planets = snapshot.planets ; 
                            return new Expanded(
              flex: 1,
              child: new Container(
                color: new Color(state.background),
                child: new CustomScrollView(
                  scrollDirection: Axis.vertical,
                  slivers: <Widget>[
                    new SliverPadding(
                      padding: const EdgeInsets.symmetric(vertical: 24.0),
                      sliver: new SliverFixedExtentList(
                            itemExtent: 152.0,
                            delegate: new SliverChildBuilderDelegate(
                              (context, index) => new PlanetCard(_planets[index]),
                              childCount: _planets.length,
                            ),
                      ),
                    ),
                  ],
                ),
              ),
          );
                          }
                        ),
           );
        } else
          return new Container(height: 0.0,width: 0.0,);
      }),
    );
  }
}

class PlanetsList extends StatelessWidget {
  final List<Planet> _planets;

  PlanetsList(this._planets);

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      builder: (context) => FetchingSharedPreferenceBloc()..dispatch(BackGroundColor()),
      child: BlocBuilder<FetchingSharedPreferenceBloc,
          FetchingSharedPreferenceState>(builder: (context, state) {
        if (state is BackgroundSharedpreferenceState)
          return new Expanded(
            flex: 1,
            child: new Container(
              color: new Color(state.background),
              child: new CustomScrollView(
                scrollDirection: Axis.vertical,
                slivers: <Widget>[
                  new SliverPadding(
                    padding: const EdgeInsets.symmetric(vertical: 24.0),
                    sliver: new SliverFixedExtentList(
                      itemExtent: 152.0,
                      delegate: new SliverChildBuilderDelegate(
                        (context, index) => new PlanetCard(_planets[index]),
                        childCount: _planets.length,
                      ),
                    ),
                  ),
                ],
              ),
            ),
          );
        else
          return  new Container(width: 0.0, height: 0.0);
      }),
    );
  }
}
