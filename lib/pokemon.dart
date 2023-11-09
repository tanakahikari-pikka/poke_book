import 'package:freezed_annotation/freezed_annotation.dart';

part 'pokemon.freezed.dart';
part 'pokemon.g.dart';

@freezed
class Pokemon with _$Pokemon {
  // freezedを用いて実装
  const factory Pokemon({
    required String name,
    required String type,
    required String imageUrl,
  }) = _Create;
  factory Pokemon.fromJson(Map<String, dynamic> json) =>
      _$PokemonFromJson(json);
}
