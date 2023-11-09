import 'dart:convert';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:http/http.dart' as http;

final pokemonsFutureProvider = FutureProvider<List<String>>((ref) async {
  final pokemons = await fetchPokemons();
  final pokemonsList = jsonDecode(pokemons)['data']['pokemons'] as List;
  return pokemonsList.map((e) => e['name'] as String).toList();
});

fetchPokemons() async {
  final response = await http.post(
    Uri.parse('https://graphql-pokemon2.vercel.app/'),
    headers: {
      'Content-Type': 'application/json; charset=UTF-8',
    },
    body: '{ "query": "{ pokemons(first: 10) { id name } }" }',
  );
  if (response.statusCode == 200) {
    return response.body;
  } else {
    throw Exception('Failed to load data');
  }
}
