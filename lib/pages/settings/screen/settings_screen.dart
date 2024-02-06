import 'package:flutter/material.dart';
import 'package:football_app/core/enums/leagueid_enum.dart';

class SettingsScreen extends StatefulWidget {
  const SettingsScreen({super.key});

  @override
  State<SettingsScreen> createState() => _SettingsScreenState();
}

class _SettingsScreenState extends State<SettingsScreen> {
  bool status = false;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SingleChildScrollView(
        scrollDirection: Axis.vertical,
        physics: const BouncingScrollPhysics(),
        child: Column(
          children: LeagueIds.values
              .map((e) => SwitchListTile(
                    title: Text('  ${getFormattedName(e)}'),
                    value: status,
                    onChanged: (value) {
                      setState(() {
                        status = value;
                      });
                    },
                    secondary: const Icon(Icons.lightbulb_outline),
                  ))
              .toList(),
        ),
      ),
    );
  }
}
