import 'package:mafioznik/abstract_classes/mafioznik.dart';

abstract class MafiaClan {
  late String name;
  List<Mafioznik> gang = [];

 void printGangMemberInformation() {
    for (var i = 0; i < gang.length; i++) {
      print("${gang[i].name} (${gang[i].status})");
    }
  }
}
