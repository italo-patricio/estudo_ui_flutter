abstract class StateBase {}

class InitialState extends StateBase {
  final String message;
  InitialState(this.message);
}

class LoadingState extends StateBase {
  final String message;
  LoadingState(this.message);
}

class NoDataToLoadState extends StateBase {
  final String message;
  NoDataToLoadState(this.message);
}

class LoadingMoreState extends StateBase {
  final String message;
  LoadingMoreState(this.message);
}

class ErrorState extends StateBase {
  final String messageError;
  ErrorState(this.messageError);
}

class SuccessState<T> extends StateBase {
  final List<T> data;

  SuccessState(this.data);
}