import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:flutter/material.dart';

class ApiPhotoJuggarView extends StatelessWidget {
  const ApiPhotoJuggarView({super.key});

  Future<List<ApiModelJuggar>> getPhotos() async {
    final response = await http.get(
      Uri.parse('https://jsonplaceholder.typicode.com/photos'),
      headers: {'Accept': 'application/json'},
    );

    if (response.statusCode == 200) {
      final data = jsonDecode(response.body) as List;
      return data
          .map(
            (i) => ApiModelJuggar(
              id: i['id'].toString(),
              title: i['title'],
              url: i['url'],
            ),
          )
          .toList();
    } else {
      print(response.statusCode);
      throw Exception('Failed to load photos');
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('API Photos')),
      body: FutureBuilder<List<ApiModelJuggar>>(
        future: getPhotos(),
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return const Center(child: CircularProgressIndicator());
          } else if (snapshot.hasError) {
            return Center(child: Text('Error: ${snapshot.error}'));
          } else if (!snapshot.hasData || snapshot.data!.isEmpty) {
            return const Center(child: Text('No Data in snapshot'));
          }

          final photos = snapshot.data!;
          return ListView.builder(
            itemCount: photos.length,
            itemBuilder: (context, index) => ListTile(
              title: Text(photos[index].title),
              leading: CircleAvatar(
                backgroundImage: NetworkImage(photos[index].url),
              ),
            ),
          );
        },
      ),
    );
  }
}

class ApiModelJuggar {
  final String id, title, url;
  ApiModelJuggar({required this.id, required this.title, required this.url});
}
