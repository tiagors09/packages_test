import 'dart:convert';

import 'package:cached_network_image/cached_network_image.dart';
import 'package:dio/dio.dart';
import 'package:flutter/material.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  Future<Map<String, dynamic>> getData() async {
    final dio = Dio();

    final response = await dio.get<String>(
      'https://raw.githubusercontent.com/chuva-inc/exercicios-2023/master/dart/assets/activities.json',
    );

    return jsonDecode(response.data!);
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: Scaffold(
        body: FutureBuilder(
          future: getData(),
          builder: (context, snapshot) {
            var data = [];
            if (snapshot.hasData) {
              data = snapshot.data!['data'];

              return ListView.builder(
                padding: const EdgeInsets.symmetric(horizontal: 20),
                itemCount: data.length,
                itemBuilder: (context, index) {
                  final activity = data[index];
                  return Card(
                    child: ListTile(
                      title: Text(activity['title']['pt-br']),
                    ),
                  );
                },
              );
            }

            if (snapshot.hasError) {
              return const Center(child: Text('Error'));
            }

            return const CircularProgressIndicator();
          },
        ),
      ),
    );
  }
}
