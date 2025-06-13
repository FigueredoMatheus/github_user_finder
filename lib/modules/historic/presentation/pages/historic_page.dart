import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:github_user_finder/modules/historic/presentation/widgets/custom_paginated_list.dart';
import 'package:github_user_finder/core/widgets/loading_state_body.dart';
import 'package:github_user_finder/modules/historic/presentation/bloc/historic_bloc.dart';

class HistoricPage extends StatefulWidget {
  const HistoricPage({super.key});

  @override
  State<HistoricPage> createState() => _HistoricPageState();
}

class _HistoricPageState extends State<HistoricPage> {
  final ScrollController scrollController = ScrollController();

  @override
  void initState() {
    super.initState();
    context.read<HistoricBloc>().add(LoadHistoryInitial());

    scrollController.addListener(() {
      if (scrollController.position.pixels >=
          scrollController.position.maxScrollExtent - 200) {
        context.read<HistoricBloc>().add(LoadMoreHistoryRequested());
      }
    });
  }

  @override
  void dispose() {
    scrollController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      extendBody: false,
      resizeToAvoidBottomInset: false,
      appBar: AppBar(
        backgroundColor: Colors.deepPurple,
        title: Text('Buscador de Usuários do GitHub'),
        titleTextStyle: const TextStyle(
          color: Colors.white,
          fontSize: 16,
        ),
      ),
      body: BlocBuilder<HistoricBloc, HistoricState>(
        builder: (context, state) {
          if (state is HistoricInitial) {
            return LoadingStateBody();
          }

          if (state is HistoricLoaded) {
            return CustomPaginatedUsersList(
              users: state.users,
              scrollController: scrollController,
              hasReachedEnd: state.hasReachedEnd,
            );
          }

          return Container();
        },
      ),
    );
  }
}
