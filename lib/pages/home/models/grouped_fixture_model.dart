import 'package:football_app/pages/home/models/fixture_model.dart';

class GroupedFixtureModel {
  int? league;
  String? name;
  String? flag;
  List<FixtureRootModel>? fixtureList;

  GroupedFixtureModel({this.league, this.fixtureList, this.name, this.flag});
}
