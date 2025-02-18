import 'package:mafioznik/abstract_classes/mafioznik.dart';

class GangBoss extends Mafioznik {

  GangBoss(this.name);

  @override
  String name;

  @override
  String status = "boss";

  @override
  bool  isDuelSkill = true;
}
