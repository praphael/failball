import 'package:flutter/material.dart';

// PLAYER LIST PAGE
class PlayerListPage extends StatefulWidget {
  @override
  _PlayerListPageState createState() => _PlayerListPageState();
}

class _PlayerListPageState extends State<PlayerListPage> {
  String _searchQuery = '';
  String _positionFilter = 'All';
  
  final List<String> positions = ['All', 'QB', 'RB', 'WR', 'TE', 'K', 'DEF'];
  
  // Sample player data
  final List<Map<String, dynamic>> allPlayers = [
    {'name': 'Patrick Mahomes', 'position': 'QB', 'team': 'KC', 'points': '301.2', 'status': 'Healthy'},
    {'name': 'Josh Allen', 'position': 'QB', 'team': 'BUF', 'points': '290.5', 'status': 'Healthy'},
    {'name': 'Lamar Jackson', 'position': 'QB', 'team': 'BAL', 'points': '287.8', 'status': 'Healthy'},
    {'name': 'Christian McCaffrey', 'position': 'RB', 'team': 'SF', 'points': '278.4', 'status': 'IR'},
    {'name': 'Saquon Barkley', 'position': 'RB', 'team': 'PHI', 'points': '240.1', 'status': 'Healthy'},
    {'name': 'Derrick Henry', 'position': 'RB', 'team': 'BAL', 'points': '235.7', 'status': 'Questionable'},
    {'name': 'Justin Jefferson', 'position': 'WR', 'team': 'MIN', 'points': '250.3', 'status': 'Healthy'},
    {'name': 'CeeDee Lamb', 'position': 'WR', 'team': 'DAL', 'points': '242.7', 'status': 'Healthy'},
    {'name': 'Tyreek Hill', 'position': 'WR', 'team': 'MIA', 'points': '238.9', 'status': 'Healthy'},
    {'name': 'Travis Kelce', 'position': 'TE', 'team': 'KC', 'points': '180.5', 'status': 'Healthy'},
    {'name': 'Mark Andrews', 'position': 'TE', 'team': 'BAL', 'points': '160.2', 'status': 'Healthy'},
    {'name': 'Justin Tucker', 'position': 'K', 'team': 'BAL', 'points': '125.0', 'status': 'Healthy'},
    {'name': 'San Francisco 49ers', 'position': 'DEF', 'team': 'SF', 'points': '142.0', 'status': 'NA'},
  ];

  List<Map<String, dynamic>> get filteredPlayers {
    return allPlayers.where((player) {
      final nameMatches = player['name'].toLowerCase().contains(_searchQuery.toLowerCase());
      final positionMatches = _positionFilter == 'All' || player['position'] == _positionFilter;
      return nameMatches && positionMatches;
    }).toList();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Players'),
      ),
      body: Column(
        children: [
          Padding(
            padding: const EdgeInsets.all(16.0),
            child: TextField(
              decoration: InputDecoration(
                labelText: 'Search Players',
                prefixIcon: Icon(Icons.search),
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(10.0),
                ),
              ),
              onChanged: (value) {
                setState(() {
                  _searchQuery = value;
                });
              },
            ),
          ),
          Container(
            height: 50,
            child: ListView(
              scrollDirection: Axis.horizontal,
              padding: EdgeInsets.symmetric(horizontal: 16.0),
              children: positions.map((position) {
                return Padding(
                  padding: const EdgeInsets.only(right: 8.0),
                  child: ChoiceChip(
                    label: Text(position),
                    selected: _positionFilter == position,
                    onSelected: (selected) {
                      setState(() {
                        _positionFilter = position;
                      });
                    },
                  ),
                );
              }).toList(),
            ),
          ),
          Expanded(
            child: ListView.builder(
              itemCount: filteredPlayers.length,
              itemBuilder: (context, index) {
                final player = filteredPlayers[index];
                return Card(
                  margin: EdgeInsets.symmetric(horizontal: 16.0, vertical: 4.0),
                  child: ListTile(
                    title: Text(player['name'], style: TextStyle(fontWeight: FontWeight.bold)),
                    subtitle: Text('${player['position']} | ${player['team']}'),
                    trailing: Row(
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        Column(
                          mainAxisAlignment: MainAxisAlignment.center,
                          crossAxisAlignment: CrossAxisAlignment.end,
                          children: [
                            Text('${player['points']} pts', style: TextStyle(fontWeight: FontWeight.bold)),
                            Text(
                              player['status'],
                              style: TextStyle(
                                color: player['status'] == 'Healthy' 
                                    ? Colors.green 
                                    : player['status'] == 'IR' 
                                        ? Colors.red 
                                        : Colors.orange,
                                fontSize: 12,
                              ),
                            ),
                          ],
                        ),
                        SizedBox(width: 8),
                        Icon(Icons.add_circle_outline, color: Colors.green),
                      ],
                    ),
                    onTap: () {
                      // Show player details
                      _showPlayerDetails(context, player);
                    },
                  ),
                );
              },
            ),
          ),
        ],
      ),
    );
  }

  void _showPlayerDetails(BuildContext context, Map<String, dynamic> player) {
    showModalBottomSheet(
      context: context,
      isScrollControlled: true,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.vertical(top: Radius.circular(20)),
      ),
      builder: (context) {
        return Container(
          padding: EdgeInsets.all(16),
          height: MediaQuery.of(context).size.height * 0.7,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text(
                    player['name'],
                    style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
                  ),
                  IconButton(
                    icon: Icon(Icons.close),
                    onPressed: () => Navigator.pop(context),
                  ),
                ],
              ),
              SizedBox(height: 8),
              Row(
                children: [
                  Container(
                    padding: EdgeInsets.symmetric(horizontal: 8, vertical: 4),
                    decoration: BoxDecoration(
                      color: Colors.grey[200],
                      borderRadius: BorderRadius.circular(4),
                    ),
                    child: Text(player['position']),
                  ),
                  SizedBox(width: 8),
                  Container(
                    padding: EdgeInsets.symmetric(horizontal: 8, vertical: 4),
                    decoration: BoxDecoration(
                      color: Colors.grey[200],
                      borderRadius: BorderRadius.circular(4),
                    ),
                    child: Text(player['team']),
                  ),
                  SizedBox(width: 8),
                  Container(
                    padding: EdgeInsets.symmetric(horizontal: 8, vertical: 4),
                    decoration: BoxDecoration(
                      color: player['status'] == 'Healthy' 
                          ? Colors.green[100] 
                          : player['status'] == 'IR' 
                              ? Colors.red[100] 
                              : Colors.orange[100],
                      borderRadius: BorderRadius.circular(4),
                    ),
                    child: Text(player['status']),
                  ),
                ],
              ),
              SizedBox(height: 24),
              Text('Season Stats', style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold)),
              SizedBox(height: 8),
              Card(
                child: Padding(
                  padding: const EdgeInsets.all(16.0),
                  child: Column(
                    children: [
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          _buildStatItem('Points', player['points']),
                          _buildStatItem('Rank', '#${(index % 10) + 1}'),
                          _buildStatItem('Avg', '${(double.parse(player['points']) / 7).toStringAsFixed(1)}'),
                        ],
                      ),
                      SizedBox(height: 16),
                      // Position-specific stats
                      if (player['position'] == 'QB') _buildQBStats(),
                      if (player['position'] == 'RB') _buildRBStats(),
                      if (player['position'] == 'WR') _buildWRStats(),
                      if (player['position'] == 'TE') _buildTEStats(),
                    ],
                  ),
                ),
              ),
              SizedBox(height: 24),
              Text('Recent News', style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold)),
              SizedBox(height: 8),
              Card(
                child: Padding(
                  padding: const EdgeInsets.all(16.0),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text('2h ago', style: TextStyle(color: Colors.grey, fontSize: 12)),
                      SizedBox(height: 4),
                      Text(
                        'Coach mentioned ${player['name']} will have a full workload this weekend against the ${_getRandomOpponent(player['team'])}.',
                        style: TextStyle(fontSize: 14),
                      ),
                      SizedBox(height: 16),
                      Text('1d ago', style: TextStyle(color: Colors.grey, fontSize: 12)),
                      SizedBox(height: 4),
                      Text(
                        '${player['name']} was a full participant in Wednesday\'s practice.',
                        style: TextStyle(fontSize: 14),
                      ),
                    ],
                  ),
                ),
              ),
              Spacer(),
              ElevatedButton(
                onPressed: () {
                  // Add player to team
                  Navigator.pop(context);
                  ScaffoldMessenger.of(context).showSnackBar(
                    SnackBar(content: Text('${player['name']} added to your team'))
                  );
                },
                child: Text('Add to Team'),
                style: ElevatedButton.styleFrom(
                  minimumSize: Size(double.infinity, 50),
                ),
              ),
            ],
          ),
        );
      },
    );
  }

  Widget _buildStatItem(String label, String value) {
    return Column(
      children: [
        Text(label, style: TextStyle(color: Colors.grey)),
        SizedBox(height: 4),
        Text(value, style: TextStyle(fontWeight: FontWeight.bold, fontSize: 18)),
      ],
    );
  }

  Widget _buildQBStats() {
    return Column(
      children: [
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            _buildStatItem('Pass Yds', '2,450'),
            _buildStatItem('Pass TD', '18'),
            _buildStatItem('INT', '4'),
          ],
        ),
        SizedBox(height: 12),
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            _buildStatItem('Comp', '210'),
            _buildStatItem('Rush Yds', '180'),
            _buildStatItem('Rush TD', '2'),
          ],
        ),
      ],
    );
  }

  Widget _buildRBStats() {
    return Column(
      children: [
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            _buildStatItem('Rush Yds', '825'),
            _buildStatItem('Rush TD', '7'),
            _buildStatItem('YPC', '4.8'),
          ],
        ),
        SizedBox(height: 12),
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            _buildStatItem('Rec', '25'),
            _buildStatItem('Rec Yds', '220'),
            _buildStatItem('Rec TD', '2'),
          ],
        ),
      ],
    );
  }

  Widget _buildWRStats() {
    return Column(
      children: [
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            _buildStatItem('Rec', '62'),
            _buildStatItem('Targets', '83'),
            _buildStatItem('Rec Yds', '780'),
          ],
        ),
        SizedBox(height: 12),
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            _buildStatItem('Rec TD', '5'),
            _buildStatItem('YPR', '12.6'),
            _buildStatItem('Rush Yds', '15'),
          ],
        ),
      ],
    );
  }

  Widget _buildTEStats() {
    return Column(
      children: [
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            _buildStatItem('Rec', '48'),
            _buildStatItem('Targets', '65'),
            _buildStatItem('Rec Yds', '560'),
          ],
        ),
        SizedBox(height: 12),
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            _buildStatItem('Rec TD', '4'),
            _buildStatItem('YPR', '11.7'),
            _buildStatItem('20+ Yds', '7'),
          ],
        ),
      ],
    );
  }

  String _getRandomOpponent(String team) {
    final teams = ['KC', 'BUF', 'BAL', 'CIN', 'SF', 'DAL', 'PHI', 'DET', 'TB', 'GB'];
    teams.remove(team);
    return teams[DateTime.now().millisecond % teams.length];
  }

  int get index => DateTime.now().millisecond;
}
