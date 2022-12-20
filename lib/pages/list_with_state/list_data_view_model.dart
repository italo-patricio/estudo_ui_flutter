import 'dart:async';

import 'package:estudo_ui_flutter/core/states/state.dart';
import 'package:estudo_ui_flutter/core/stream/simple_stream.dart';

class ListDataWithStateViewModel {
  final SimpleStream<StateBase> _currentState = SimpleStream<StateBase>();

  final SimpleStream<List<DataSuccess>> _currentDataState =
      SimpleStream<List<DataSuccess>>();

  ListDataWithStateViewModel() {
    setState(InitialState('Estado inicial :D'));
    enableObservable();
  }

  SimpleStream<StateBase> get currentState => _currentState;

  SimpleStream<List<DataSuccess>> get currentData => _currentDataState;

  dispose() {
    _currentState.close();
  }

  enableObservable() {
    _currentState.output
        .where((element) => element is SuccessState)
        .listen((event) {
      final success = event as SuccessState;
      var data = currentData.current ?? [];

      data.addAll(success.data as List<DataSuccess>);
      currentData.update(data);
    });
  }

  getData() async {
    setState(LoadingState('Carregando...'));
    await Future.delayed(const Duration(seconds: 3));

    final data = [
      ...List.generate(
          10, (index) => DataSuccess(name: 'Italo - $index', age: index))
    ];

    _currentDataState.current?.clear();
    setState(SuccessState(data));
  }

  bool get isLoadingMore => (_currentState.current is NoDataToLoadState ||
      _currentState.current is LoadingState ||
      _currentState.current is LoadingMoreState);

  getLoadMore() async {
    if (isLoadingMore || _currentDataState.current == null) return;
    print('getLoadMore processing');

    setState(LoadingMoreState('Carregando mais...'));
    await Future.delayed(const Duration(seconds: 3));

    if (_currentDataState.current!.length > 100) {
      setState(NoDataToLoadState('Nada mais para exibir!'));
    } else {
      final data = [
        ...List.generate(
            10, (index) => DataSuccess(name: 'Italo - $index', age: index))
      ];

      setState(SuccessState(data));
    }
  }

  setState(StateBase state) {
    _currentState.update(state);
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
