import 'dart:developer';

import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:football_app/core/enums/leagueid_enum.dart';
import 'package:football_app/core/service/base_service.dart';
import 'package:football_app/core/service/general_providers.dart';
import 'package:football_app/pages/home/models/fixture_model.dart';
import 'package:football_app/pages/home/models/grouped_fixture_model.dart';

final fixtureProvider = Provider<FixtureService>((ref) {
  return FixtureService(dio: ref.read(dioProvider));
});

class FixtureService extends BaseService {
  FixtureService({required super.dio});

  Future<List<GroupedFixtureModel>> getFixture() async {
    List<FixtureRootModel> fixtureList = [];
    List<GroupedFixtureModel> groupedFixtureList = [];
    try {
      var data = await getAll("/fixtures?season=2023&date=2024-02-04");
      fixtureList = List<FixtureRootModel>.from(
        (data as List).map(
          (fixtureData) => FixtureRootModel.fromJson(fixtureData),
        ),
      );

      Map<int?, List<FixtureRootModel>> groupedMap = {};
      for (var fixture in fixtureList) {
        int? leagueId = fixture.league?.id;

        if (!groupedMap.containsKey(leagueId)) {
          groupedMap[leagueId] = [];
        }

        groupedMap[leagueId]!.add(fixture);
      }

      groupedMap.forEach((leagueId, fixtures) {
        if (LeagueIds.values.any(
          (element) => element.value == leagueId,
        )) {
          groupedFixtureList.add(
            GroupedFixtureModel(
              league: leagueId,
              fixtureList: fixtures,
              name: fixtures.first.league?.name,
              flag: fixtures.first.league?.flag,
            ),
          );
        }
      });
    } catch (e) {
      log(e.toString());
    }
    return groupedFixtureList;
  }
}
