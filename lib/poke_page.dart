import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;

class PokePage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final res = fetchPokemons();
    // final pokes
    return Center(
      child: Text("d"),
    );
  }

  Future<String> fetchPokemons() async {
    final response = await http.post(
      Uri.parse('https://graphql-pokemon2.vercel.app/'),
      headers: <String, String>{
        'Content-Type': 'application/json; charset=UTF-8',
      },
      body: '{ "query": "{ pokemons(first: 10) { id name } }" }',
    );
    if (response.statusCode == 200) {
      print(response.body);
      // ここでレスポンスを処理できます
      return response.body;
    } else {
      throw Exception('Failed to load data');
    }
  }
}
