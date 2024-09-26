import 'package:kdigital_test/src/domain/models/character.dart';
import 'package:equatable/equatable.dart';

enum MainPageStatus {
  InitialMainPage,
  UnSuccessfulMainPage,
  SuccessfulMainPage,
  ListReachedFinish
}

class MainPageState extends Equatable {
  const MainPageState(
      {this.lastPageLoaded = 0, this.characters = const [], this.status});

  final int lastPageLoaded;
  final List<Character> characters;
  final MainPageStatus? status;

  MainPageState copyWith(
      {List<Character>? newCharacterList,
      MainPageStatus? newStatus,
      int? newLastPageLoaded}) {
    return MainPageState(
        characters: newCharacterList ?? this.characters,
        lastPageLoaded: newLastPageLoaded ?? this.lastPageLoaded,
        status: newStatus ?? this.status);
  }

  @override
  List<Object?> get props => [characters, lastPageLoaded, status];
}
