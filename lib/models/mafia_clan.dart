import 'package:mafioznik/abstract_classes/mafioznik.dart';

class MafiaClan {
  late String name;
  List<Mafioznik> gang = [];

  MafiaClan(this.name, this.gang);

  printGangMemberInformation() {
    for (var i = 0; i < gang.length; i++) {
      print("${gang[i].name} (${gang[i].status})");
    }
  }
}
