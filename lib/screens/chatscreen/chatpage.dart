import 'package:flutter/material.dart';

import '../../constants/constants.dart';

class ProfessionalsListScreen extends StatefulWidget {
  @override
  _ProfessionalsListScreenState createState() =>
      _ProfessionalsListScreenState();
}

class _ProfessionalsListScreenState extends State<ProfessionalsListScreen> {
  final List<Professional> professionals = [
    Professional(name: 'Dr. John Doe', expertise: 'Dentist'),
    Professional(name: 'Dr. Jane Smith', expertise: 'Psychologist'),
    Professional(name: 'Dr. Jane Smith', expertise: 'Psychologist'),
    Professional(name: 'Dr. Jane Smith', expertise: 'Psychologist'),
    Professional(name: 'Dr. Jane Smith', expertise: 'Psychologist'),
    Professional(name: 'Dr. Alex Johnson', expertise: 'Pediatrician'),
    Professional(name: 'Dr. Emily Brown', expertise: 'Dermatologist'),
  ];

  List<Professional> filteredProfessionals = [];

  String searchText = '';

  @override
  void initState() {
    super.initState();
    filteredProfessionals = List.from(professionals);
  }

  void filterProfessionals(String query) {
    if (query.isEmpty) {
      setState(() {
        filteredProfessionals = List.from(professionals);
        searchText = query;
      });
      return;
    }

    final lowerCaseQuery = query.toLowerCase();
    setState(() {
      searchText = query;
      filteredProfessionals = professionals.where((professional) {
        return professional.name.toLowerCase().contains(lowerCaseQuery) ||
            professional.expertise.toLowerCase().contains(lowerCaseQuery);
      }).toList();
    });
  }

  void sortProfessionals(String sortBy) {
    setState(() {
      switch (sortBy) {
        case 'name':
          filteredProfessionals.sort((a, b) => a.name.compareTo(b.name));
          break;
        case 'expertise':
          filteredProfessionals
              .sort((a, b) => a.expertise.compareTo(b.expertise));
          break;
        default:
          break;
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: backGroundStyle,
      child: Scaffold(
        backgroundColor: Colors.transparent,
        appBar: AppBar(
          backgroundColor: Colors.transparent,
          title: Text('Find a Professional',style: TextStyle(fontWeight: FontWeight.bold),),
          centerTitle: true,
          actions: [
            IconButton(
              icon: Icon(Icons.search),
              onPressed: () {
                showSearch(
                    context: context,
                    delegate: ProfessionalSearchDelegate(filterProfessionals));
              },
            ),
            PopupMenuButton(
              itemBuilder: (context) => [
                PopupMenuItem(
                  child: Text('Sort by Name'),
                  value: 'name',
                ),
                PopupMenuItem(
                  child: Text('Sort by Expertise'),
                  value: 'expertise',
                ),
              ],
              onSelected: sortProfessionals,
            ),
          ],
        ),
        body: ListView.builder(
          itemCount: filteredProfessionals.length,
          itemBuilder: (context, index) {
            return ProfessionalListItem(
              professional: filteredProfessionals[index],
              onTap: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) =>
                        ChatScreen(professional: filteredProfessionals[index]),
                  ),
                );
              },
            );
          },
        ),
      ),
    );
  }
}

class ProfessionalListItem extends StatelessWidget {
  final Professional professional;
  final VoidCallback onTap;

  ProfessionalListItem({required this.professional, required this.onTap});

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        margin: EdgeInsets.symmetric(horizontal: 16.0, vertical: 8.0),
        padding: EdgeInsets.all(16.0),
        decoration: BoxDecoration(
          color: Colors.white.withOpacity(0.1).withAlpha(40),
          borderRadius: BorderRadius.circular(16.0),
          boxShadow: [
            BoxShadow(
              color: Colors.grey.withOpacity(0.3),
              spreadRadius: 2,
              blurRadius: 4,
              offset: Offset(0, 2),
            ),
          ],
        ),
        child: Row(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            CircleAvatar(
              radius: 36.0,
              backgroundColor: Colors.blue.withOpacity(0.9),
              child: Text(
                professional.name[0],
                style: TextStyle(
                  color: Colors.white,
                  fontSize: 24.0,
                  fontWeight: FontWeight.bold,
                ),
              ),
            ),
            SizedBox(width: 16.0),
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  professional.name,
                  style: TextStyle(
                    fontSize: 18.0,color: Colors.white,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                SizedBox(height: 4.0),
                Text(
                  professional.expertise,
                  style: TextStyle(
                    fontSize: 14.0,
                    color: Colors.white.withOpacity(0.9),
                  ),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}

class ChatScreen extends StatelessWidget {
  final Professional professional;

  ChatScreen({required this.professional});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Chat with ${professional.name}'),
        centerTitle: true,
      ),
      body: Center(
        child: Text('Chat interface with ${professional.name} goes here.'),
      ),
    );
  }
}

class Professional {
  final String name;
  final String expertise;

  Professional({required this.name, required this.expertise});
}

class ProfessionalSearchDelegate extends SearchDelegate<String> {
  final Function(String) filterCallback;

  ProfessionalSearchDelegate(this.filterCallback);

  @override
  List<Widget> buildActions(BuildContext context) {
    return [
      IconButton(
        icon: Icon(Icons.clear),
        onPressed: () {
          query = '';
        },
      ),
    ];
  }

  @override
  Widget buildLeading(BuildContext context) {
    return IconButton(
      icon: Icon(Icons.arrow_back),
      onPressed: () {
        close(context, '');
      },
    );
  }

  @override
  Widget buildResults(BuildContext context) {
    filterCallback(query);
    return Container();
  }

  @override
  Widget buildSuggestions(BuildContext context) {
    final suggestionList = query.isEmpty
        ? []
        : ['Dentist', 'Psychologist', 'Pediatrician', 'Dermatologist']
            .where((text) => text.toLowerCase().startsWith(query.toLowerCase()))
            .toList();

    return ListView.builder(
      itemCount: suggestionList.length,
      itemBuilder: (context, index) {
        return ListTile(
          title: Text(suggestionList[index]),
          onTap: () {
            query = suggestionList[index];
            showResults(context);
          },
        );
      },
    );
  }
}
