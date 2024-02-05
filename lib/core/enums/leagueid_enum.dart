enum LeagueIds {
  turkey(203),
  turkey2(204),
  england(39),
  england2(40),
  spain(140),
  spain2(141),
  italy(135),
  italy2(136),
  germany(78),
  germany2(79),
  france(61),
  france2(62),
  netherlands(88),
  netherlands2(89),
  portugal(94),
  portugal2(95),
  belgium(144),
  belgium2(145);

  const LeagueIds(this.value);

  final int value;
}

String getFormattedName(LeagueIds league) {
  switch (league) {
    case LeagueIds.turkey:
      return 'Türkiye';
    case LeagueIds.turkey2:
      return 'Türkiye 2.Lig';
    case LeagueIds.england:
      return 'England';
    default:
      return 'Unknown';
  }
}
