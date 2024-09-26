import 'package:kdigital_test/src/domain/models/character.dart';

abstract class CharactersRepository {
  Future<List<Character>?> getCharacters(int page);
}
