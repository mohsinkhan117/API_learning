import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';

class API1 extends StatefulWidget {
  const API1({super.key});

  @override
  State<API1> createState() => _API1State();
}

class _API1State extends State<API1> {
  Map<String, dynamic>? user;

  Future<void> fetchUser() async {
    final response = await http.get(
      Uri.parse(
        "https://cors-anywhere.herokuapp.com/https://reqres.in/api/users/2",
      ),
      headers: {"Accept": "application/json"},
    );

    if (response.statusCode == 200) {
      setState(() {
        user = json.decode(response.body)["data"];
      });
    } else {
      print("Failed: ${response.statusCode}");
    }
  }

  @override
  void initState() {
    super.initState();
    fetchUser();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: user == null
            ? const CircularProgressIndicator()
            : Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Text("Name: ${user!['first_name']} ${user!['last_name']}"),
                  Image.network(user!['avatar']),
                ],
              ),
      ),
    );
  }
}
