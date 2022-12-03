import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';

class Digimon extends StatelessWidget {
  final String apiUrl = "https://digimon-api.vercel.app/api/digimon";

  const Digimon({super.key});

  Future<List<dynamic>> _fecthDigimons() async {
    var result = await http.get(Uri.parse(apiUrl));
    return json.decode(result.body);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        title: const Text('Digimon List'),
      ),
      body: FutureBuilder<List<dynamic>>(
        future: _fecthDigimons(),
        builder: (BuildContext context, AsyncSnapshot snapshot) {
          if (snapshot.hasData) {
            return ListView.builder(
                padding: const EdgeInsets.all(10),
                itemCount: snapshot.data.length,
                itemBuilder: (BuildContext context, int index) {
                  return Card(
                    child: Padding(
                      padding: const EdgeInsets.all(10.0),
                      child: ListTile(
                        leading: CircleAvatar(
                            backgroundColor: Colors.black,
                            radius: 30,
                            child: Image.network(snapshot.data[index]['img'])),
                        title: Text(
                          snapshot.data[index]['name'],
                          textAlign: TextAlign.justify,
                          style: TextStyle(
                              fontSize: 18, fontWeight: FontWeight.bold,
                          color: Colors.pink),
                        ),
                        subtitle: Text(
                          // ignore: prefer_interpolation_to_compose_strings
                          snapshot.data[index]['level'],
                          style: const TextStyle(fontStyle: FontStyle.italic),
                        ),
                      ),
                    ),
                  );
                });
          } else {
            return const Center(child: CircularProgressIndicator());
          }
        },
      ),
    );
  }
}
