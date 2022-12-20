import 'dart:async';

import 'package:estudo_ui_flutter/core/states/state.dart';

class ListDataWithStateViewModel {
  final StreamController<StateBase> _currentState =
      StreamController<StateBase>.broadcast();

  final StreamController<List<DataSuccess>> _currentDataState =
      StreamController<List<DataSuccess>>.broadcast();

  StateBase _currentStateSync = InitialState('');
  final List<DataSuccess> _currentData = [];

  ListDataWithStateViewModel() {
    setState(InitialState('Estado inicial :D'));
    enableObservable();
  }

  Stream<StateBase> get currentState => _currentState.stream;

  Stream<List<DataSuccess>> get currentData => _currentDataState.stream;

  List<DataSuccess> get currentDataList => _currentData;

  dispose() {
    _currentState.close();
  }

  enableObservable() {
    _currentState.stream
        .where((element) => element is SuccessState)
        .listen((event) {
      final success = event as SuccessState;
      _currentData.addAll(success.data as List<DataSuccess>);
      _currentDataState.sink.add(_currentData);
    });
  }

  getData() async {
    setState(LoadingState('Carregando...'));
    await Future.delayed(const Duration(seconds: 3));

    final data = [
      ...List.generate(
          10, (index) => DataSuccess(name: 'Italo - $index', age: index))
    ];

    _currentData.clear();
    setState(SuccessState(data));
  }

  bool get isLoadingMore => (_currentStateSync is NoDataToLoadState ||
      _currentStateSync is LoadingState ||
      _currentStateSync is LoadingMoreState);

  getLoadMore() async {
    if (isLoadingMore) return;
    print('getLoadMore processing');

    setState(LoadingMoreState('Carregando mais...'));
    await Future.delayed(const Duration(seconds: 3));

    if (_currentData.length > 100) {
      setState(NoDataToLoadState('Nada mais para exibir!'));
    } else {
      final data = [
        ...List.generate(
            10, (index) => DataSuccess(name: 'Italo - $index', age: index))
      ];

      setState(SuccessState(data));
      // _currentData.addAll(data);
    }
  }

  setState(StateBase state) {
    _currentState.sink.add(state);
    _currentStateSync = state;
  }

  getDataWithError() async {
    setState(LoadingState('Carregando...'));
    await Future.delayed(const Duration(seconds: 3));
    setState(ErrorState('Deu ruim! :('));
  }
}

class DataSuccess {
  final String name;
  final int age;

  DataSuccess({name, age})
      : name = name,
        age = age;
}
