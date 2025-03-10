import 'Lineup.dart';
import 'StatLine.dart';
import 'Player.dart';
import 'Team.dart';

class Matchup {
    Team team1;
    Team team2;
}

class GameWeek {
    Map<Team, Lineup> lineup;
    Map<Team, StatLineTeam> statLines;
    List<Matchup> matchups;
}