import 'dart:math';

import 'package:mafioznik/abstract_classes/mafioznik.dart';
import 'package:mafioznik/models/gang_boss.dart';
import 'package:mafioznik/models/gang_member.dart';
import 'package:mafioznik/models/north_london_clan.dart';
import 'package:mafioznik/models/south_london_clan.dart';

void main(List<String> arguments) {
  var mihael = GangBoss("Michael");
  var alex = GangMember("Alex");
  var sviatoslav = GangMember("Sviatoslav");
  var roman = GangMember("Roman");

  var oleg = GangBoss("Oleg");
  var sonia = GangMember("Sonia");
  var mark = GangMember("Mark");
  var alexandr = GangMember("Alexandr");

  var northLondonClan = NorthLondonClan([mihael, alex, sviatoslav, roman]);
  var southLondonClan = SouthLondonClan([oleg, sonia, mark, alexandr]);

  print("${northLondonClan.name} current team: ");
  northLondonClan.printGangMemberInformation();
  print("");
  print("${southLondonClan.name} current team: ");
  southLondonClan.printGangMemberInformation();
  print("");

  clansFight(northLondonClan.gang, southLondonClan.gang, northLondonClan.name,
      southLondonClan.name);
}

clansFight(List<Mafioznik> firstMafiaClan, List<Mafioznik> secondMafiaClan,
    String firstMafiaClanName, String secondMafiaClanName) {
  Random rand = Random();

  while (firstMafiaClan.isNotEmpty && secondMafiaClan.isNotEmpty) {
    Mafioznik mafioznik1 = firstMafiaClan[rand.nextInt(firstMafiaClan.length)];
    Mafioznik mafioznik2 =
        secondMafiaClan[rand.nextInt(secondMafiaClan.length)];

    print(
        "${mafioznik1.name} (${mafioznik1.status}, $firstMafiaClanName) fight with ${mafioznik2.name} (${mafioznik2.status}, $secondMafiaClanName)");

    fightRandom(rand, mafioznik1, firstMafiaClan, mafioznik2, secondMafiaClan,
        firstMafiaClanName, secondMafiaClanName);
    print("");
    writeAllTheFighters(firstMafiaClan, firstMafiaClanName);
    print("");
    writeAllTheFighters(secondMafiaClan, secondMafiaClanName);
    print(
        "__________________________________________________________________________________________________________________________________________________________________________________________________");
  }
  fightResult(firstMafiaClan, secondMafiaClanName, firstMafiaClanName);
}

void fightResult(List<Mafioznik> firstMafiaClan, String secondMafiaClanName,
    String firstMafiaClanName) {
  if (firstMafiaClan.isEmpty) {
    print(
        '$secondMafiaClanName won this fight, and receives 50 000  dollars!!!');
  } else {
    print(
        '$firstMafiaClanName won this fight, and receives 50 000  dollars!!!');
  }
}

void fightRandom(
    Random rand,
    Mafioznik mafioznik1,
    List<Mafioznik> firstMafiaClan,
    Mafioznik mafioznik2,
    List<Mafioznik> secondMafiaClan,
    String firstMafiaClanName,
    String secondMafiaClanName) {
//  print(mafioznik1.isDuelSkill);
//  print(mafioznik2.isDuelSkill);

  if (mafioznik1.isDuelSkill && mafioznik2.isDuelSkill) {
    bool mafioznikWins = rand.nextBool();
    printDefaultWinner(
      mafioznikWins,
      mafioznik1,
      secondMafiaClan,
      mafioznik2,
      firstMafiaClan,
      firstMafiaClanName,
      secondMafiaClanName,
    );
  }
  if (mafioznik1.isDuelSkill && mafioznik2.isDuelSkill == false) {
    bool mafioznikWins = rand.nextDouble() <= 0.65;
    printDefaultWinner(mafioznikWins, mafioznik1, secondMafiaClan, mafioznik2,
        firstMafiaClan, firstMafiaClanName, secondMafiaClanName);
  }
  if (mafioznik2.isDuelSkill && mafioznik1.isDuelSkill == false) {
    bool mafioznikWins = rand.nextDouble() <= 0.65;
    printDefaultWinner(mafioznikWins, mafioznik1, secondMafiaClan, mafioznik2,
        firstMafiaClan, firstMafiaClanName, secondMafiaClanName);
  }
  if (mafioznik1.isDuelSkill == false && mafioznik2.isDuelSkill == false) {
    bool mafioznikWins = rand.nextBool();
    printDefaultWinner(mafioznikWins, mafioznik1, secondMafiaClan, mafioznik2,
        firstMafiaClan, firstMafiaClanName, secondMafiaClanName);
  }
}

void printDefaultWinner(
    bool mafioznikWins,
    Mafioznik mafioznik1,
    List<Mafioznik> secondMafiaClan,
    Mafioznik mafioznik2,
    List<Mafioznik> firstMafiaClan,
    String firstMafiaClanName,
    String secondMafiaClanName) {
  if (mafioznik2.isDuelSkill && mafioznik1.isDuelSkill == false) {
    if (mafioznikWins) {
      print(
          '${mafioznik2.name} (${mafioznik2.status}, $secondMafiaClanName) wins!');
      firstMafiaClan.remove(mafioznik1);
    } else {
      print(
          '${mafioznik1.name} (${mafioznik1.status}, $firstMafiaClanName) wins!');
      secondMafiaClan.remove(mafioznik2);
    }
  } else {
    if (mafioznikWins) {
      print(
          '${mafioznik1.name} (${mafioznik1.status}, $firstMafiaClanName) wins!');
      secondMafiaClan.remove(mafioznik2);
    } else {
      print(
          '${mafioznik2.name} (${mafioznik2.status}, $secondMafiaClanName) wins!');
      firstMafiaClan.remove(mafioznik1);
    }
  }
}

void writeAllTheFighters(List<Mafioznik> mafiaClan, String mafiaClansName) {
  print("$mafiaClansName current team: ");
  if (mafiaClan.isEmpty) {
    print("They all died :)");
    return;
  }
  for (int i = 0; i < mafiaClan.length; i++) {
    print("${mafiaClan[i].name} (${mafiaClan[i].status})");
  }
}
