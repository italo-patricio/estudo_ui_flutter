import 'package:estudo_ui_flutter/core/states/state.dart';
import 'package:estudo_ui_flutter/pages/list_with_state/list_data_view_model.dart';
import 'package:flutter/material.dart';

class MyListDataWithStatePage extends StatefulWidget {
  const MyListDataWithStatePage({super.key});

  @override
  State<MyListDataWithStatePage> createState() =>
      _MyListDataWithStatePageState();
}

class _MyListDataWithStatePageState extends State<MyListDataWithStatePage> {
  final ListDataWithStateViewModel _viewModel = ListDataWithStateViewModel();

  @override
  void initState() {
    super.initState();
  }

  @override
  void dispose() {
    _viewModel.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    print('building list data');
    return Scaffold(
      appBar: AppBar(),
      body: SafeArea(
        child: ListView(
          children: [
            ElevatedButton(
              onPressed: (() {
                _viewModel.getData();
              }),
              child: const Text('Carregar com sucesso'),
            ),
            const SizedBox(
              height: 10,
            ),
            ElevatedButton(
              onPressed: (() {
                _viewModel.getDataWithError();
              }),
              child: const Text('Carregar com error'),
            ),
            buildListData(),
          ],
        ),
      ),
    );
  }

  Center buildListData() {
    return Center(
      child: StreamBuilder<StateBase>(
        stream: _viewModel.currentState,
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return const Text('Carregando tela, por favor aguarde..');
          }

          if (!snapshot.hasData) {
            return Container();
          }

          if (snapshot.data is LoadingState) {
            final data = snapshot.data as LoadingState;
            return Text(data.message);
          }

          if (snapshot.data is ErrorState) {
            final data = snapshot.data as ErrorState;
            return Text(data.messageError);
          }

          return Container(
            margin: const EdgeInsets.only(bottom: 90),
            child: ListView.builder(
              itemCount: _viewModel.currentDataList.length,
              shrinkWrap: true,
              physics: const ScrollPhysics(),
              itemBuilder: (context, index) {
                if (index == (_viewModel.currentDataList.length - 1) && _viewModel.currentDataList.length > 9) {
                  
                  if (snapshot.data is LoadingMoreState) {
                    return Center(child: Text((snapshot.data as LoadingMoreState).message));
                  }
                  
                  if (snapshot.data is NoDataToLoadState) {
                    return Center(child: Text((snapshot.data as NoDataToLoadState).message));
                  }
                  
                  return ElevatedButton(
                    onPressed: (() {
                      _viewModel.getLoadMore();
                    }),
                    child: const Text('Carregar mais'),
                  );
                }
                return buildListItem(_viewModel.currentDataList, index);
              },
            ),
          );
        },
      ),
    );
  }

  Widget buildListItem(List<DataSuccess> data, int index) {
    return Card(
      child: ListTile(
        title: Text('Nome: ${data[index].name} Idade: ${data[index].age}'),
      ),
    );
  }
}
