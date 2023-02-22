import 'package:http/http.dart' as http;
import 'dart:convert';

import '../models/user.dart';

// Define a class that provides a static method to retrieve user data from the API
class ApiService {
  static const String baseUrl = 'https://reqres.in/api';
  static const String usersEndpoint = '$baseUrl/users';

  // Static method that retrieves a list of User objects from the API
  static Future<List<User>> getUsers() async {
    // Send an HTTP GET request to the API endpoint
    final response = await http.get(Uri.parse(usersEndpoint));
    if (response.statusCode == 200) {
      // If the response is successful (status code 200), parse the response body JSON
      final jsonData = jsonDecode(response.body);
      final List<dynamic> usersJson = jsonData['data'];
      // Convert each JSON object to a User object and return a list of Users
      return usersJson.map((json) => User.fromJson(json)).toList();
    } else {
      // If the response is not successful, throw an exception
      throw Exception('Failed to load users');
    }
  }
}
