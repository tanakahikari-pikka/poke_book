import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:poke_book/poke_repository.dart';
import 'package:poke_book/pokemon_tile.dart';

// ignore: use_key_in_widget_constructors
class PokePage extends ConsumerWidget {
  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final pokemons = ref.watch(pokemonsFutureProvider);

    return Scaffold(
      appBar: AppBar(
        title: const Text('PokeBook'),
      ),
      body: pokemons.when(
        data: (pokemonsList) {
          print(pokemonsList);
          return ListView.builder(
            itemCount: pokemonsList.length,
            itemBuilder: (context, index) {
              return ListTile(
                title: PokemonTile(
                  name: pokemonsList[index],
                  type: 'type',
                  imageUrl: 'https://via.placeholder.com/150',
                ),
                //  Text(pokemonsList[index]),
              );
            },
          );
        },
        loading: () => const Center(child: CircularProgressIndicator()),
        error: (error, stack) => Center(child: Text('Error: $error')),
      ),
    );
  }
}
