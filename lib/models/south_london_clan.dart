import 'package:mafioznik/abstract_classes/mafia_clan.dart';
import '../abstract_classes/mafioznik.dart';
import 'gang_boss.dart';

class SouthLondonClan extends MafiaClan {
  SouthLondonClan(this.gang){
    if (gang.every((mafioznik) => mafioznik is! GangBoss)) {
      throw ArgumentError('A clan must contain at least one boss');
    }
  }

  @override
  String name = "SouthLondonClan";

  @override
  List<Mafioznik> gang;
}
