import 'dart:convert';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:http/http.dart' as http;

final pokemonsFutureProvider =
    FutureProvider<Map<String, dynamic>>((ref) async {
  final pokemonsData = await fetchPokemons();
  final decodedPokemons = jsonDecode(pokemonsData)['data']['pokemons'] as List;
  final List<String> pokemonsList =
      decodedPokemons.map((e) => e['name'] as String).toList();
  final List<String> pokemonsImageList =
      decodedPokemons.map((e) => e['image'] as String).toList();
  return {
    'pokemonsList': pokemonsList,
    'pokemonsImageList': pokemonsImageList,
  };
});

final pokemonsProvider = Provider((ref) {
  final pokemonsConstruct = ref.watch(pokemonsFutureProvider);
  final pokemons = pokemonsConstruct.when(
    data: (pokemonsData) => AsyncValue.data(pokemonsData),
    loading: () => const AsyncValue.loading(),
    error: (error, stack) => AsyncValue.error(error, stack),
  );

  return pokemons;
});

fetchPokemons() async {
  final response = await http.post(
    Uri.parse('https://graphql-pokemon2.vercel.app/'),
    headers: {
      'Content-Type': 'application/json; charset=UTF-8',
    },
    body: '{ "query": "{ pokemons(first: 100) { id name image } }" }',
  );
  if (response.statusCode == 200) {
    return response.body;
  } else {
    throw Exception('Failed to load data');
  }
}
