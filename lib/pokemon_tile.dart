import 'package:flutter/material.dart';

class PokemonTile extends StatelessWidget {
  const PokemonTile({
    Key? key,
    required this.name,
    required this.imageUrl,
  }) : super(key: key);

  final String name;
  final String imageUrl;

  @override
  Widget build(BuildContext context) {
    return ListTile(
      leading: Image.network(imageUrl),
      title: Text(name),
    );
  }
}
