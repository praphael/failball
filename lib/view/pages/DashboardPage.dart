import 'package:flutter/material.dart';

// DASHBOARD PAGE
class DashboardPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Dashboard'),
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              _buildUpcomingMatchCard(),
              SizedBox(height: 16),
              Text('Your Team Performance', style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold)),
              SizedBox(height: 8),
              _buildTeamPerformanceCard(),
              SizedBox(height: 16),
              Text('League Standings', style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold)),
              SizedBox(height: 8),
              _buildLeagueStandingsCard(),
              SizedBox(height: 16),
              Text('Recent Player News', style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold)),
              SizedBox(height: 8),
              _buildRecentNewsCard(),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildUpcomingMatchCard() {
    return Card(
      elevation: 4,
      child: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text('Upcoming Matchup', style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold)),
            SizedBox(height: 12),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Column(
                  children: [
                    Text('Your Team', style: TextStyle(fontWeight: FontWeight.bold)),
                    SizedBox(height: 8),
                    Text('120.5 pts', style: TextStyle(color: Colors.green, fontWeight: FontWeight.bold)),
                  ],
                ),
                Text('VS', style: TextStyle(fontWeight: FontWeight.bold)),
                Column(
                  children: [
                    Text('Opponent', style: TextStyle(fontWeight: FontWeight.bold)),
                    SizedBox(height: 8),
                    Text('105.2 pts', style: TextStyle(fontWeight: FontWeight.bold)),
                  ],
                ),
              ],
            ),
            SizedBox(height: 12),
            Text('Week 8 - In Progress', style: TextStyle(color: Colors.orange)),
          ],
        ),
      ),
    );
  }

  Widget _buildTeamPerformanceCard() {
    return Card(
      elevation: 4,
      child: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text('Record: 5-2', style: TextStyle(fontWeight: FontWeight.bold)),
                    Text('League Rank: 3rd', style: TextStyle(fontWeight: FontWeight.bold)),
                  ],
                ),
                Column(
                  crossAxisAlignment: CrossAxisAlignment.end,
                  children: [
                    Text('Points For: 845.2', style: TextStyle(fontWeight: FontWeight.bold)),
                    Text('Points Against: 782.6', style: TextStyle(fontWeight: FontWeight.bold)),
                  ],
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildLeagueStandingsCard() {
    return Card(
      elevation: 4,
      child: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text('Rank', style: TextStyle(fontWeight: FontWeight.bold)),
                Text('Team', style: TextStyle(fontWeight: FontWeight.bold)),
                Text('Record', style: TextStyle(fontWeight: FontWeight.bold)),
                Text('PF', style: TextStyle(fontWeight: FontWeight.bold)),
              ],
            ),
            Divider(),
            _buildStandingRow(1, 'Touchdown Titans', '6-1', '910.5'),
            _buildStandingRow(2, 'Field Goal Frenzy', '5-2', '872.3'),
            _buildStandingRow(3, 'Your Team', '5-2', '845.2', isUserTeam: true),
            _buildStandingRow(4, 'Red Zone Raiders', '4-3', '822.7'),
            _buildStandingRow(5, 'Blitz Brigade', '3-4', '780.1'),
          ],
        ),
      ),
    );
  }

  Widget _buildStandingRow(int rank, String team, String record, String points, {bool isUserTeam = false}) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 4.0),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Text(rank.toString()),
          Text(team, style: TextStyle(fontWeight: isUserTeam ? FontWeight.bold : FontWeight.normal, color: isUserTeam ? Colors.green : Colors.black)),
          Text(record),
          Text(points),
        ],
      ),
    );
  }

  Widget _buildRecentNewsCard() {
    return Card(
      elevation: 4,
      child: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            _buildNewsItem(
              'Patrick Mahomes (QB, KC)', 
              'Set to play despite shoulder concerns',
              '1h ago'
            ),
            Divider(),
            _buildNewsItem(
              'Jonathan Taylor (RB, IND)', 
              'Limited in practice, game-time decision',
              '3h ago'
            ),
            Divider(),
            _buildNewsItem(
              'Ja\'Marr Chase (WR, CIN)', 
              'Cleared from injury report, full go for Sunday',
              '5h ago'
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildNewsItem(String player, String news, String time) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 4.0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(player, style: TextStyle(fontWeight: FontWeight.bold)),
          SizedBox(height: 4),
          Text(news),
          SizedBox(height: 4),
          Text(time, style: TextStyle(color: Colors.grey, fontSize: 12)),
        ],
      ),
    );
  }
}