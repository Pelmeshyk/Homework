import 'package:mafioznik/abstract_classes/mafioznik.dart';

class GangBoss extends Mafioznik {

  GangBoss(this.status, this.name, this.gangName, this.isDuelSkill);

  @override
  String gangName;

  @override
  String name;

  @override
  String status;

  @override
  bool  isDuelSkill = true;

  @override
  void printGangName() {
    print(gangName);
  }

  @override
  void printName() {
    print(name);
  }

  @override
  void printStatus() {
    print(status);
  }
}
