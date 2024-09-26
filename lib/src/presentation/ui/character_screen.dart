import 'package:kdigital_test/src/presentation/bloc/main_bloc.dart';
import 'package:kdigital_test/src/presentation/bloc/main_event.dart';
import 'package:kdigital_test/src/presentation/bloc/main_state.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:kdigital_test/src/presentation/ui/widgets/character_widget.dart';

@immutable
class CharactersScreen extends StatefulWidget {
  @override
  State<CharactersScreen> createState() => _CharactersScreenState();
}

class _CharactersScreenState extends State<CharactersScreen> {
  final ScrollController _scrollController = ScrollController();

  void _addListValues() {
    if (_isBottom) {
      context.read<MainPageBloc>().add(const GetTestDataOnMainPageEvent());
    }
  }

  bool get _isBottom {
    if (!_scrollController.hasClients) {
      return false;
    }
    return _scrollController.position.maxScrollExtent * 0.9 <=
        _scrollController.offset;
  }

  @override
  void initState() {
    super.initState();
    _scrollController.addListener(_addListValues);
  }

  @override
  void dispose() {
    _scrollController.removeListener(_addListValues);
    _scrollController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: BlocConsumer<MainPageBloc, MainPageState>(
        listener: (context, state) {},
        builder: (blocContext, state) {
        if (state.status == MainPageStatus.InitialMainPage) {
          return _loadingWidget(context);
        } else if (state.status == MainPageStatus.SuccessfulMainPage ||
            state.status == MainPageStatus.ListReachedFinish) {
          return _successfulWidget(context, state);
        } else {
          return Center(child: Text("error"));
        }
      },
    ));
  }

  Widget _loadingWidget(BuildContext context) {
    return Center(
      child: Container(
        width: 50,
        height: 50,
        margin: EdgeInsets.all(16),
        decoration: BoxDecoration(
          borderRadius: const BorderRadius.all(Radius.circular(12)),
        ),
        child: const CircularProgressIndicator(),
      ),
    );
  }

  Widget _successfulWidget(BuildContext context, MainPageState state) {
    return ListView.builder(
      controller: _scrollController,
      itemCount: state.characters.length + 1,
      itemBuilder: (context, index) {
        if (index < state.characters.length) {
          return CharacterWidget(character: state.characters[index]);
        } else if (state.status != MainPageStatus.ListReachedFinish) {
          return _loadingWidget(context);
        }
      },
    );
  }
}
