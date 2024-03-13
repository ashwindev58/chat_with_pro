import 'package:flutter/material.dart';

import 'widgets/chatoverview.dart';

class DashboardScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Chat with Pro'),
      ),
      drawer: Drawer(
        child: ListView(
          padding: EdgeInsets.zero,
          children: <Widget>[
            DrawerHeader(
              decoration: BoxDecoration(
                color: Colors.blue,
              ),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  CircleAvatar(
                    radius: 30.0,
                    backgroundColor: Colors.white,
                    // Add user's profile picture
                  ),
                  SizedBox(height: 10.0),
                  Text(
                    'John Doe',
                    style: TextStyle(color: Colors.white, fontSize: 18.0),
                  ),
                  Text(
                    'Available',
                    style: TextStyle(color: Colors.white, fontSize: 14.0),
                  ),
                ],
              ),
            ),
            ListTile(
              title: Text('Chats'),
              leading: Icon(Icons.chat, color: Colors.blue),
              // Add onTap callback for navigation
            ),
            ListTile(
              title: Text('Professionals Directory'),
              leading: Icon(Icons.people, color: Colors.green),
              // Add onTap callback for navigation
            ),
            // Add more list items for other sections
          ],
        ),
      ),
      body: SingleChildScrollView(
        padding: EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // Quick Actions Widget
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceAround,
              children: [
                QuickActionIcon(
                  icon: Icons.message,
                  label: 'New Chat',
                  color: Colors.blue,
                  // Add onTap callback for action
                ),
                QuickActionIcon(
                  icon: Icons.schedule,
                  label: 'Schedule Appointment',
                  color: Colors.orange,
                  // Add onTap callback for action
                ),
                QuickActionIcon(
                  icon: Icons.notifications,
                  label: 'Notifications',
                  color: Colors.red,
                  // Add onTap callback for action
                ),
              ],
            ),
            SizedBox(height: 20.0),
            // Chats Overview Widget
            ChatOverviewWidget(),
            SizedBox(height: 20.0),
            // Professionals Directory Highlights Widget
            ProfessionalsDirectoryWidget(),
            // Add other widgets as per your UI design
          ],
        ),
      ),
    );
  }
}

class QuickActionIcon extends StatelessWidget {
  final IconData icon;
  final String label;
  final Color color;
  final VoidCallback? onTap;

  const QuickActionIcon({
    required this.icon,
    required this.label,
    required this.color,
    this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: Column(
        children: [
          CircleAvatar(
            backgroundColor: color,
            child: Icon(icon, color: Colors.white),
          ),
          SizedBox(height: 8.0),
          Text(
            label,
            style: TextStyle(color: Colors.grey),
          ),
        ],
      ),
    );
  }
}
