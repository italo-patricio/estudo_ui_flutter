import 'package:estudo_ui_flutter/core/states/state.dart';
import 'package:estudo_ui_flutter/pages/list_with_state/list_data_view_model.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';

class MyListDataWithStatePage extends StatefulWidget {
  const MyListDataWithStatePage({super.key});

  @override
  State<MyListDataWithStatePage> createState() =>
      _MyListDataWithStatePageState();
}

class _MyListDataWithStatePageState extends State<MyListDataWithStatePage> {
  final ListDataWithStateViewModel _viewModel = ListDataWithStateViewModel();
  late ScrollController _scrollController;

  @override
  void initState() {
    _scrollController = ScrollController();
    _scrollController.addListener(_scrollListener);

    super.initState();

    _viewModel.getData();
  }

  bool _valueExpectedPercent(
      double percentExpected, double valueCurrent, double valueMax) {
    final value = (percentExpected * valueMax) / 100;

    return (valueCurrent >= value);
  }

  _scrollListener() {
    if (_valueExpectedPercent(90, _scrollController.offset,
            _scrollController.position.maxScrollExtent) &&
        !_viewModel.isLoadingMore) {
      // reach the bottom
      if (kDebugMode) {
        print(
            'current: ${_scrollController.offset} max: ${_scrollController.position.maxScrollExtent}');
      }
      _viewModel.getLoadMore();
    }
    if (_scrollController.offset <=
            _scrollController.position.minScrollExtent &&
        !_scrollController.position.outOfRange) {
      // reach the top
    }
  }

  @override
  void dispose() {
    _viewModel.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    print('building list data');
    return SafeArea(
      child: Scaffold(
        appBar: AppBar(),
        body: RefreshIndicator(
          onRefresh: () async {
            return _viewModel.getData();
          },
          child: Column(             
            children: [
              Expanded(child: buildListData()),
            ],
          ),
        ),
      ),
    );
  }

  Widget buildListData() {
    return StreamBuilder<StateBase>(
      stream: _viewModel.currentState,
      builder: (context, snapshot) {
        if (snapshot.connectionState == ConnectionState.waiting) {
          return const Center(
              child: Text('Carregando tela, por favor aguarde..'));
        }

        if (!snapshot.hasData) {
          return SizedBox(
            height: MediaQuery.of(context).size.height,
            child: Container(),
          );
        }

        if (snapshot.data is LoadingState) {
          final data = snapshot.data as LoadingState;
          return SizedBox(
            height: MediaQuery.of(context).size.height,
            child: Center(
                child: CircularProgressIndicator(
              semanticsValue: data.message,
            )),
          );
        }

        if (snapshot.data is ErrorState) {
          final data = snapshot.data as ErrorState;
          return SizedBox(
            height: MediaQuery.of(context).size.height,
            child: Text(data.messageError),
          );
        }

        return ListView.builder(
          itemCount: _viewModel.currentDataList.length,
          shrinkWrap: true,
          physics: const AlwaysScrollableScrollPhysics(),
          controller: _scrollController,
          itemBuilder: (context, index) {
            Widget? widgetAppend;
            if (index == (_viewModel.currentDataList.length - 1) &&
                _viewModel.currentDataList.length > 9) {
              if (snapshot.data is LoadingMoreState) {
                widgetAppend = const Center(child: CircularProgressIndicator());
              }

              if (snapshot.data is NoDataToLoadState) {
                widgetAppend = Center(
                    child: Text((snapshot.data as NoDataToLoadState).message));
              }
            }

            return Column(
              children: [
                buildListItem(_viewModel.currentDataList, index),
                widgetAppend ?? Container()
              ],
            );
          },
        );
      },
    );
  }

  Widget buildListItem(List<DataSuccess> data, int index) {
    return Card(
      child: ListTile(
        title: Text(
            'Index: $index Nome: ${data[index].name} Idade: ${data[index].age}'),
      ),
    );
  }
}
