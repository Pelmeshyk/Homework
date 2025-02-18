import 'package:mafioznik/abstract_classes/mafioznik.dart';

class GangMember extends Mafioznik {
  GangMember(this.name);

  @override
  String name;

  @override
  String status = "casual";

  @override
  bool  isDuelSkill = false;
}
