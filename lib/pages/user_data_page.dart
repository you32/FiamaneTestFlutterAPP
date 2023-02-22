// Import necessary packages and files
import 'package:flutter/material.dart';
import '../models/user.dart';
import '../services/api_service.dart';

// Define a stateful widget for the User Data page
class UserDataPage extends StatefulWidget {
  @override
  _UserDataPageState createState() => _UserDataPageState();
}

// Define the state for the User Data page
class _UserDataPageState extends State<UserDataPage> {
  late Future<List<User>> _futureUsers; // Future to store the list of users

  @override
  void initState() {
    super.initState();
    _futureUsers = ApiService.getUsers(); // Call the API to fetch the list of users
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: FutureBuilder<List<User>>(
        // Use FutureBuilder to handle the state of the list of users
        future: _futureUsers,
        builder: (BuildContext context, AsyncSnapshot<List<User>> snapshot) {
          if (snapshot.hasData) {
            // If the data has been successfully fetched, show the list of users
            return ListView.builder(
              itemCount: snapshot.data!.length,
              itemBuilder: (BuildContext context, int index) {
                final user = snapshot.data![index];
                return ListTile(
                  leading: CircleAvatar(
                    backgroundImage: NetworkImage(user.avatar),
                  ),
                  title: Text('${user.firstName} ${user.lastName}'),
                  subtitle: Text(user.email),
                );
              },
            );
          } else if (snapshot.hasError) {
            // If there's an error fetching the data, show an error message
            return Center(child: Text('Error'));
          } else {
            // If the data is still being fetched, show a loading indicator
            return Center(child: CircularProgressIndicator());
          }
        },
      ),
    );
  }
}
