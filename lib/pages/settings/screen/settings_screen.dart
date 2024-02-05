import 'package:flutter/material.dart';
import 'package:football_app/core/enums/leagueid_enum.dart';

class SettingsScreen extends StatelessWidget {
  const SettingsScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Column(
        children:
            LeagueIds.values.map((e) => Text(getFormattedName(e))).toList(),
      ),
    );
  }
}
