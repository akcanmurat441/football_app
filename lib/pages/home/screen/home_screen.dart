import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_svg/svg.dart';
import 'package:football_app/core/service/fixture_service.dart';
import 'package:football_app/pages/home/models/grouped_fixture_model.dart';

import '../models/fixture_model.dart';

class HomeScreen extends ConsumerWidget {
  const HomeScreen({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return Scaffold(
      body: FutureBuilder(
        future: ref.watch(fixtureProvider).getFixture(),
        builder: (context, snapshot) {
          if (snapshot.hasData) {
            var fixtureList = snapshot.data;
            return BodyWidget(fixtureList: fixtureList);
          } else if (snapshot.connectionState == ConnectionState.waiting) {
            return const Center(child: CircularProgressIndicator());
          }
          return const Text('Hata oluştu2');
        },
      ),
    );
  }
}

class BodyWidget extends StatelessWidget {
  const BodyWidget({
    super.key,
    required this.fixtureList,
  });

  final List<GroupedFixtureModel>? fixtureList;

  @override
  Widget build(BuildContext context) {
    int count = 0;
    return ListView.builder(
      shrinkWrap: true,
      itemCount: fixtureList?.length,
      itemBuilder: (context, index) {
        var groupedFixture = fixtureList?[index];
        return Column(
          children: [
            Container(
              height: 30,
              width: double.maxFinite,
              decoration: BoxDecoration(
                color: Colors.grey[850],
              ),
              child: Row(
                children: [
                  const SizedBox(width: 4),
                  SizedBox(
                    height: 20,
                    width: 20,
                    child: ClipRRect(
                      clipBehavior: Clip.antiAlias,
                      borderRadius: BorderRadius.circular(30),
                      child: SvgPicture.network(
                        '${groupedFixture?.flag}',
                        fit: BoxFit.cover,
                      ),
                    ),
                  ),
                  const SizedBox(width: 8),
                  Text(
                    '${groupedFixture?.name}',
                    style: const TextStyle(
                      color: Colors.white,
                      fontSize: 14,
                      fontWeight: FontWeight.w600,
                    ),
                  ),
                  Expanded(
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.end,
                      children: [
                        IconButton(
                          padding: EdgeInsets.zero,
                          iconSize: 22,
                          onPressed: () {},
                          icon: const Icon(Icons.star_border_outlined),
                        ),
                      ],
                    ),
                  )
                ],
              ),
            ),
            ListView.builder(
              shrinkWrap: true,
              physics: const NeverScrollableScrollPhysics(),
              itemCount: groupedFixture?.fixtureList?.length,
              itemBuilder: (context, lenghtCount) {
                var item = groupedFixture?.fixtureList?[lenghtCount];
                count++;
                return Container(
                  height: 30,
                  decoration: BoxDecoration(
                    color: count.isEven ? Colors.grey[300] : Colors.white,
                  ),
                  child: Row(
                    children: [
                      Expanded(
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Padding(
                              padding: const EdgeInsets.only(left: 2.0),
                              child: getStatusToMatch(item?.fixture),
                            ),
                            Text(shortTeamName(item?.teams?.home?.name)),
                          ],
                        ),
                      ),
                      Padding(
                        padding: const EdgeInsets.symmetric(horizontal: 4.0),
                        child: SizedBox(
                          width: 30,
                          child: Center(child: getScoreToMatch(item)),
                        ),
                      ),
                      Expanded(
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.start,
                          children: [
                            Text(shortTeamName(item?.teams?.away?.name)),
                          ],
                        ),
                      ),
                    ],
                  ),
                );
              },
            )
          ],
        );
      },
    );
  }

  Text getStatusToMatch(Fixture? fixture) {
    var scoreTextStyle = const TextStyle(
      color: Colors.red,
      fontWeight: FontWeight.w600,
    );
    var startedTextStyle = const TextStyle(
      fontWeight: FontWeight.w600,
    );
    switch (fixture?.status?.short) {
      case "NS": //not started
        return Text(
          '${fixture?.date?.hour.toString().padLeft(2, '0')}:${fixture?.date?.minute.toString().padLeft(2, '0')}',
        );
      case "FT": //match finished
        return Text(
          "FT",
          style: startedTextStyle,
        );
      case "1H": //first Half
        return Text(
          "${fixture?.status?.elapsed}'",
          style: scoreTextStyle,
        );
      case "HT": //Second Half
        return Text(
          "HT",
          style: startedTextStyle,
        );
      case "2H": //Second Half
        return Text(
          "${fixture?.status?.elapsed}'",
          style: scoreTextStyle,
        );
      case "ET": //	Extra Time
        return Text(
          "ET",
          style: startedTextStyle,
        );
      case "BT": //	Break Time
        return Text(
          "BT",
          style: startedTextStyle,
        );
      case "P": //	Penalty In Progress
        return Text(
          "P",
          style: startedTextStyle,
        );
      case "SUSP": //	Match Suspended
        return Text(
          "SUSP",
          style: startedTextStyle,
        );
      case "INT": //	Match Interrupted
        return Text(
          "INT",
          style: startedTextStyle,
        );
      case "PEN": //	Match Finished
        return Text(
          "PEN",
          style: startedTextStyle,
        );
      case "CANC": //	Match Canceled
        return Text(
          "CNC",
          style: startedTextStyle,
        );
      case "PST": //	Match Canceled
        return Text(
          "PST",
          style: startedTextStyle,
        );
      case "LIVE": //	Match Finished
        return Text(
          "${fixture?.status?.elapsed}'",
          style: scoreTextStyle,
        );
      default:
        return const Text("");
    }
  }

  RichText getScoreToMatch(FixtureRootModel? root) {
    var liveStyle = const TextStyle(
      color: Colors.red,
      fontWeight: FontWeight.w600,
    );
    var winStyle = const TextStyle(
      fontWeight: FontWeight.w900,
      color: Colors.black,
    );
    var normalStyle = const TextStyle(
      fontWeight: FontWeight.w400,
      color: Colors.black,
    );

    if (root?.teams?.home?.winner == null &&
        root?.teams?.away?.winner == null &&
        root?.fixture?.status?.elapsed == null) {
      return RichText(
        text: const TextSpan(
          text: 'v ',
          style: TextStyle(
            color: Colors.black,
          ),
        ),
      );
    } else if (root?.fixture?.status?.short == '1H' ||
        root?.fixture?.status?.short == '2H' ||
        root?.fixture?.status?.short == 'HF') {
      return RichText(
        text: TextSpan(
          text: '${root?.goals?.home} - ${root?.goals?.away}',
          style: liveStyle,
        ),
      );
    } else {
      return RichText(
        text: TextSpan(
          children: [
            TextSpan(
              text: '${root?.goals?.home}',
              style:
                  (root?.teams?.home?.winner ?? false) ? winStyle : normalStyle,
            ),
            const TextSpan(
              text: ' - ',
              style: TextStyle(
                color: Colors.black,
              ),
            ),
            TextSpan(
              text: '${root?.goals?.away}',
              style:
                  (root?.teams?.away?.winner ?? false) ? winStyle : normalStyle,
            ),
          ],
        ),
      );
    }
  }

  String shortTeamName(String? teamName) {
    if (teamName == null) return "";
    if (teamName.length > 17) {
      return "${teamName.substring(0, 17)}.";
    } else {
      return teamName;
    }
  }
}
