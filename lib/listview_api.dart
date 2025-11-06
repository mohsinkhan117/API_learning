import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:learning/api_model.dart';

class MyAPIData extends StatefulWidget {
  const MyAPIData({super.key});

  @override
  State<MyAPIData> createState() => _MyAPIDataState();
}

class _MyAPIDataState extends State<MyAPIData> {
  Future<List<Photo>> fetchPhotos() async {
    final response = await http.get(
      Uri.parse('https://jsonplaceholder.typicode.com/photos'),
      headers: {'Accept': 'application/json'},
    );
    debugPrint('Status: ${response.statusCode}');
    // debugPrint('Body: ${response.body}');
    if (response.statusCode == 200) {
      var data = jsonDecode(response.body) as List;

      return data.map((e) => Photo.fromJson(e)).toList();
    } else {
      throw Exception('Failed to load photos: ${response.statusCode}');
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('API')),
      body: FutureBuilder<List<Photo>>(
        future: fetchPhotos(),
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return const Center(child: CircularProgressIndicator());
          } else if (snapshot.hasError) {
            return Center(child: Text('Error: ${snapshot.error}'));
          } else if (!snapshot.hasData || snapshot.data!.isEmpty) {
            return const Center(child: Text('No Data Found'));
          } else {
            final photos = snapshot.data!;
            return ListView.separated(
              itemBuilder: (context, index) => ListTile(
                leading: CircleAvatar(
                  child: Image.network(photos[index].url ?? ''),
                  radius: 25.0,
                ),
                title: Text(photos[index].title ?? ''),
                subtitle: Text('${photos[index].id}'),
              ),
              separatorBuilder: (context, index) => const Divider(),
              itemCount: photos.length,
            );
          }
        },
      ),
    );
  }
}
