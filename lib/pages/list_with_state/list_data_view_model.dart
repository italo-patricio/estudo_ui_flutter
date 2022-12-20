import 'dart:async';

import 'package:estudo_ui_flutter/core/states/state.dart';

class ListDataWithStateViewModel {
  final StreamController<StateBase> _currentState =
      StreamController<StateBase>();
  
  final StreamController<List<DataSuccess>> _currentDataState =
      StreamController<List<DataSuccess>>();

  final List<DataSuccess> _currentData = [];

  ListDataWithStateViewModel() {
    _currentState.sink.add(InitialState('Estado inicial :D'));
    
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
    _currentState.sink.add(LoadingState('Carregando...'));
    await Future.delayed(const Duration(seconds: 3));

    final data = [
      ...List.generate(
          10, (index) => DataSuccess(name: 'Italo - $index', age: index))
    ];

    _currentData.clear();
    _currentState.sink.add(SuccessState(data));
    _currentData.addAll(data);
  }

  getLoadMore() async {
    _currentState.sink.add(LoadingMoreState('Carregando mais...'));
    await Future.delayed(const Duration(seconds: 3));

    if(_currentData.length > 30) {
      _currentState.sink.add(NoDataToLoadState('Nada mais para exibir!'));
    } else {
      final data = [
        ...List.generate(
            10, (index) => DataSuccess(name: 'Italo - $index', age: index))
      ];

      _currentState.sink.add(SuccessState(data));
      _currentData.addAll(data);
    }

  }

  getDataWithError() async {
    _currentState.sink.add(LoadingState('Carregando...'));
    await Future.delayed(const Duration(seconds: 3));
    _currentState.sink.add(ErrorState('Deu ruim! :('));
  }
}

class DataSuccess {
  final String name;
  final int age;

  DataSuccess({name, age})
      : name = name,
        age = age;
}
