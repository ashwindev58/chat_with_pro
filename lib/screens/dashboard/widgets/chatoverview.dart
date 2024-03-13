import 'package:flutter/material.dart';

class ChatOverviewWidget extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          'Chats Overview',
          style: TextStyle(fontSize: 20.0, fontWeight: FontWeight.bold),
        ),
        SizedBox(height: 10.0),
        Container(
          height: 150.0,
          child: ListView.builder(
            scrollDirection: Axis.horizontal,
            itemCount: 5,
            itemBuilder: (context, index) {
              // Replace this with actual chat data
              return ChatCard(
                profileImage: 'https://raw.githubusercontent.com/ashwindev58/images/main/businside.jpg',
                userName: 'User $index',
                lastMessage: 'Hello, how can I help you?',
                timestamp: '2h ago',
              );
            },
          ),
        ),
      ],
    );
  }
}

class ProfessionalsDirectoryWidget extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          'Professionals Directory',
          style: TextStyle(fontSize: 20.0, fontWeight: FontWeight.bold),
        ),
        SizedBox(height: 10.0),
        Container(
          height: 150.0,
          child: ListView.builder(
            scrollDirection: Axis.horizontal,
            itemCount: 5,
            itemBuilder: (context, index) {
              // Replace this with actual professional data
              return ProfessionalCard(
                profileImage: 'https://raw.githubusercontent.com/ashwindev58/images/main/plastore.png',
                professionalName: 'Professional $index',
                expertise: 'Specialty $index',
              );
            },
          ),
        ),
      ],
    );
  }
}

class ChatCard extends StatelessWidget {
  final String profileImage;
  final String userName;
  final String lastMessage;
  final String timestamp;

  ChatCard({
    required this.profileImage,
    required this.userName,
    required this.lastMessage,
    required this.timestamp,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      width: 200.0,
      margin: EdgeInsets.only(right: 16.0),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(12.0),
        color: Colors.blue[100],
      ),
      child: Padding(
        padding: const EdgeInsets.all(12.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            ClipRRect(
              borderRadius: BorderRadius.circular(50.0),
              child: Image.network(
                profileImage,
                width: 50.0,
                height: 50.0,
                fit: BoxFit.cover,
              ),
            ),
            SizedBox(height: 8.0),
            Text(
              userName,
              style: TextStyle(fontWeight: FontWeight.bold),
            ),
            Text(
              lastMessage,
              maxLines: 2,
              overflow: TextOverflow.ellipsis,
            ),
            Spacer(),
            Text(
              timestamp,
              style: TextStyle(color: Colors.grey),
            ),
          ],
        ),
      ),
    );
  }
}

class ProfessionalCard extends StatelessWidget {
  final String profileImage;
  final String professionalName;
  final String expertise;

  ProfessionalCard({
    required this.profileImage,
    required this.professionalName,
    required this.expertise,
  });
// .
  @override
  Widget build(BuildContext context) {
    return Container(
      width: 200.0,
      margin: EdgeInsets.only(right: 16.0),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(12.0),
        color: Colors.green[100],
      ),
      child: Padding(
        padding: const EdgeInsets.all(12.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              children: [
                ClipRRect(
                  borderRadius: BorderRadius.circular(50.0),
                  child: Image.network(
                    profileImage,
                    width: 50.0,
                    height: 50.0,
                    fit: BoxFit.cover,
                  ),
                ),
              ],
            ),
            SizedBox(height: 8.0),
            Text(
              professionalName,
              style: TextStyle(fontWeight: FontWeight.bold),
            ),
            Text(
              expertise,
              maxLines: 2,
              overflow: TextOverflow.ellipsis,
            ),
            Spacer(),
            Text('View Profile'),
          ],
        ),
      ),
    );
  }
}
