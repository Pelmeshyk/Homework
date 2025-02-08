import 'package:mafioznik/abstract_classes/mafioznik.dart';

class GangMember extends Mafioznik {
  GangMember(this.status, this.name, this.gangName, this.isDuelSkill);

  @override
  String gangName;

  @override
  String name;

  @override
  String status;

  @override
  bool  isDuelSkill = false;

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
