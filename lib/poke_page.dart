import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:poke_book/poke_repository.dart';
import 'package:poke_book/pokemon_tile.dart';

// ignore: use_key_in_widget_constructors
class PokePage extends ConsumerWidget {
  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final pokemonsConstruct = ref.watch(pokemonsProvider);
    final pokemons = pokemonsConstruct.when(
      data: (pokemonsData) => AsyncValue.data(pokemonsData),
      loading: () => const AsyncValue.loading(),
      error: (error, stack) => AsyncValue.error(error, stack),
    );

    return Scaffold(
      appBar: AppBar(
        title: const Text('PokeBook'),
      ),
      body: pokemons.when(
        data: (pokemonsData) {
          return ListView.builder(
            itemCount: pokemonsData['pokemonsList'].length,
            itemBuilder: (context, index) {
              return PokemonTile(
                name: pokemonsData['pokemonsList'][index],
                imageUrl: pokemonsData['pokemonsImageList'][index],
              );
            },
          );
        },
        loading: () => const Center(
          child: CircularProgressIndicator(),
        ),
        error: (error, stack) => Center(
          child: Text(error.toString()),
        ),
      ),
    );
  }
}
