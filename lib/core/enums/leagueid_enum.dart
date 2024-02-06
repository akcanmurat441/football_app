enum LeagueIds {
  turkey(203),
  turkey2(204),
  turkeycup(206),
  england(39),
  england2(40),
  englandcup(45),
  spain(140),
  spain2(141),
  spaincup(143),
  italy(135),
  italy2(136),
  italycup(137),
  germany(78),
  germany2(79),
  germanysupercup(82),
  france(61),
  france2(62),
  francecup(66),
  netherlands(88),
  netherlands2(89),
  netherlands2cup(90),
  portugal(94),
  portugal2(95),
  portugalcup(96),
  belgium(144),
  belgium2(145),
  belgiumcup(147);

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
