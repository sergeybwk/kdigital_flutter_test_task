import 'dart:async';
import 'dart:convert';

import 'package:kdigital_test/src/domain/models/character.dart';
import 'package:kdigital_test/src/data/repository/characters_repository.dart';
import 'package:http/http.dart';

class CharactersRepositoryImpl implements CharactersRepository {
  final Client client;

  CharactersRepositoryImpl(this.client);

  @override
  Future<List<Character>?> getCharacters(int page) async {
    Response charResult;
    try {
      charResult = await client.get(
        Uri.parse("https://rickandmortyapi.com/api/character/?page=$page"),
      );
    } catch (_) {
      return null;
    }
    final jsonMap = json.decode(charResult.body) as Map<String, dynamic>;

    if (jsonMap["results"] != null) {
      return List.of(
        (jsonMap["results"] as List<dynamic>).map(
          (value) => Character.fromJson(value),
        ),
      );
    } else {
      return [];
    }
  }
}
