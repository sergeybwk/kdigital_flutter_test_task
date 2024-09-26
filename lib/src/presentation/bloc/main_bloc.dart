import 'package:kdigital_test/src/data/repository/characters_repository.dart';
import 'package:kdigital_test/src/presentation/bloc/main_event.dart';
import 'package:kdigital_test/src/presentation/bloc/main_state.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:stream_transform/stream_transform.dart';
import 'package:bloc_concurrency/bloc_concurrency.dart';
import '../../domain/models/character.dart';

const throttleDuration = Duration(milliseconds: 250);

EventTransformer<T> throttleDroppable<T>(Duration duration) {
  return (events, mapper) {
    return droppable<T>().call(events.throttle(duration), mapper);
  };
}

class MainPageBloc extends Bloc<MainPageEvent, MainPageState> {
  final CharactersRepository _charactersRepository;

  MainPageBloc(
    this._charactersRepository,
  ) : super(MainPageState(status: MainPageStatus.InitialMainPage)) {
    on<GetTestDataOnMainPageEvent>(
        (event, emitter) => _getDataOnMainPageCasino(event, emitter),
        transformer: throttleDroppable(throttleDuration));
    on<DataLoadedOnMainPageEvent>(
      (event, emitter) => _dataLoadedOnMainPageCasino(event, emitter),
    );
  }

  Future<void> _dataLoadedOnMainPageCasino(
    DataLoadedOnMainPageEvent event,
    Emitter<MainPageState> emit,
  ) async {
    if (event.characters != null) {
      if (event.characters!.isEmpty) {
        emit(state.copyWith(newStatus: MainPageStatus.ListReachedFinish));
      } else {
        emit(state.copyWith(
            newCharacterList: List.of(state.characters)
              ..addAll(event.characters as List<Character>),
            newStatus: MainPageStatus.SuccessfulMainPage,
            newLastPageLoaded: state.lastPageLoaded + 1));
      }
    } else {
      emit(state.copyWith(newStatus: MainPageStatus.UnSuccessfulMainPage));
    }
  }

  Future<void> _getDataOnMainPageCasino(
    GetTestDataOnMainPageEvent event,
    Emitter<MainPageState> emit,
  ) async {
    _charactersRepository.getCharacters(state.lastPageLoaded + 1).then(
      (value) {
        add(DataLoadedOnMainPageEvent(value));
      },
    );
  }
}
