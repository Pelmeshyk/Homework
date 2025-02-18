import 'package:mafioznik/models/gang_boss.dart';
import 'package:mafioznik/abstract_classes/mafia_clan.dart';
import '../abstract_classes/mafioznik.dart';

class NorthLondonClan extends MafiaClan {
  NorthLondonClan(this.gang){
    if (gang.every((mafioznik) => mafioznik is! GangBoss)) {
      throw ArgumentError('A clan must contain at least one boss');
    }
  }
  @override
  String name = "NorthLondonClan";

  @override
  List<Mafioznik> gang;

}
