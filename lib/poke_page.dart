import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:poke_book/poke_repository.dart';
import 'package:poke_book/pokemon_tile.dart';

// ignore: use_key_in_widget_constructors
class PokePage extends ConsumerWidget {
  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final pokemons = ref.watch(pokemonsProvider);

    return Scaffold(
      appBar: AppBar(
        title: const Text('PokeBook'),
      ),
      body: pokemons.when(
        data: (pokemons) {
          return ListView.builder(
            itemCount: pokemons['pokemonsList'].length,
            itemBuilder: (context, index) {
              return PokemonTile(
                name: pokemons['pokemonsList'][index],
                imageUrl: pokemons['pokemonsImageList'][index],
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
