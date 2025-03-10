import 'package:flutter/material.dart';

import 'LeagueDetailsPage.dart';

// LEAGUES PAGE
class LeaguesPage extends StatelessWidget {
  final List<Map<String, dynamic>> leagues = [
    {
      'name': 'Friends League',
      'teams': 10,
      'teamName': 'EndZone Warriors',
      'standing': '3rd (5-2)',
      'commissioner': 'John Smith',
      'isPublic': false,
    },
    {
      'name': 'Office League',
      'teams': 12,
      'teamName': 'Monday Blues',
      'standing': '5th (4-3)',
      'commissioner': 'Mike Johnson',
      'isPublic': false,
    },
    {
      'name': 'Public Championship',
      'teams': 14,
      'teamName': 'Field Generals',
      'standing': '8th (3-4)',
      'commissioner': 'Fantasy App',
      'isPublic': true,
    },
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('My Leagues'),
        actions: [
          IconButton(
            icon: Icon(Icons.add),
            onPressed: () {
              // _showCreateJoinLeagueDialog(context);
            },
          ),
        ],
      ),
      body: ListView.builder(
        itemCount: leagues.length,
        itemBuilder: (context, index) {
          final league = leagues[index];
          return Card(
            margin: EdgeInsets.symmetric(horizontal: 16.0, vertical: 8.0),
            child: ListTile(
              title: Text(league['name'], style: TextStyle(fontWeight: FontWeight.bold)),
              subtitle: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  SizedBox(height: 4),
                  Text('Your Team: ${league['teamName']}'),
                  Text('Standing: ${league['standing']}'),
                  SizedBox(height: 4),
                ],
              ),
              trailing: Icon(Icons.chevron_right),
              onTap: () {
                // Navigate to league details
                Navigator.push(
                  context,
                  MaterialPageRoute(builder: (context) => LeagueDetailsPage(league: league)),
                );
              },
            ),
          );
        },
      ),
    );
  }

  // void _showCreateJoinLeagueDialog(BuildContext context) {
  //   showDialog(
  //     context: context,
  //     builder: (BuildContext context) {
  //       return AlertDialog(
  //         title: Text('League Options'),
  //         content: Column(
  //           mainAxisSize: MainAxisSize.min,
  //           children: [
  //             ListTile(
  //               leading: Icon(Icons.add_circle, color: Colors.green),
  //               title: Text('Create New League'),
  //               onTap: () {
  //                 // Navigate to league details
  //                 Navigator.push(
  //                   context,
  //                   MaterialPageRoute(builder: (context) => LeagueDetailsPage(league: league)),
  //                 );
  //               }) // ListTitle
  //           ] // children
  //         ) // Column
  //       ); // AlertDialog
  //     } // builder
  //   ); // showDialog
  // } // _showCreateJoinLeagueDialog
}
  