import 'package:flutter/material.dart';

class LeagueDetailsPage extends StatelessWidget {
  final dynamic league;

  const LeagueDetailsPage({super.key, required this.league});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('My Team'),
        actions: [
          IconButton(
            icon: Icon(Icons.edit),
            onPressed: () {
              // Navigate to edit team
            },
          ),
        ],
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Card(
                elevation: 4,
                child: Padding(
                  padding: const EdgeInsets.all(16.0),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text('EndZone Warriors', style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold)),
                      Text('5-2 (3rd Place)', style: TextStyle(fontSize: 16)),
                    ],
                  ),
                ),
              ),
              SizedBox(height: 16),
              Text('Starting Lineup', style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold)),
              SizedBox(height: 8),
              _buildPositionGroup('QB', [_buildPlayerCard('Josh Allen', 'BUF', '24.5')]),
              _buildPositionGroup('RB', [
                _buildPlayerCard('Christian McCaffrey', 'SF', '18.2'),
                _buildPlayerCard('Saquon Barkley', 'PHI', '15.7'),
              ]),
              _buildPositionGroup('WR', [
                _buildPlayerCard('Justin Jefferson', 'MIN', '22.3'),
                _buildPlayerCard('CeeDee Lamb', 'DAL', '17.8'),
                _buildPlayerCard('Amon-Ra St. Brown', 'DET', '14.4'),
              ]),
              _buildPositionGroup('TE', [_buildPlayerCard('Travis Kelce', 'KC', '12.5')]),
              _buildPositionGroup('FLEX', [_buildPlayerCard('DeVonta Smith', 'PHI', '10.2')]),
              _buildPositionGroup('K', [_buildPlayerCard('Justin Tucker', 'BAL', '8.0')]),
              _buildPositionGroup('DEF', [_buildPlayerCard('San Francisco 49ers', 'SF', '7.5')]),
              SizedBox(height: 16),
              Text('Bench', style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold)),
              SizedBox(height: 8),
              _buildPositionGroup('Bench', [
                _buildPlayerCard('Jalen Hurts', 'PHI', '0.0'),
                _buildPlayerCard('Tony Pollard', 'TEN', '0.0'),
                _buildPlayerCard('Diontae Johnson', 'CAR', '0.0'),
                _buildPlayerCard('Dalton Kincaid', 'BUF', '0.0'),
                _buildPlayerCard('Gabe Davis', 'JAX', '0.0'),
                _buildPlayerCard('Kenneth Walker III', 'SEA', '0.0'),
              ]),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildPositionGroup(String position, List<Widget> players) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Padding(
          padding: const EdgeInsets.symmetric(vertical: 8.0),
          child: Text(position, style: TextStyle(fontWeight: FontWeight.bold)),
        ),
        Column(
          children: players,
        ),
        SizedBox(height: 8),
      ],
    );
  }

  Widget _buildPlayerCard(String name, String team, String points) {
    return Card(
      elevation: 2,
      child: Padding(
        padding: const EdgeInsets.all(12.0),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(name, style: TextStyle(fontWeight: FontWeight.bold)),
                Text(team, style: TextStyle(color: Colors.grey)),
              ],
            ),
            Text('$points pts', style: TextStyle(fontWeight: FontWeight.bold)),
          ],
        ),
      ),
    );
  }
}