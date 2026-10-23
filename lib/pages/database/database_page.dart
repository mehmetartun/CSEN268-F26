import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import 'cubit/database_cubit.dart';
import 'views/error_view.dart';
import 'views/insert_view.dart';
import 'views/loaded_view.dart';
import 'views/loading_view.dart';

class DatabasePage extends StatelessWidget {
  const DatabasePage({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => DatabaseCubit()..init(),
      child: BlocBuilder<DatabaseCubit, DatabaseState>(
        builder: (context, state) {
          switch (state) {
            case DatabaseError _:
              return ErrorView(error: state.error);
            case DatabaseInsert _:
              return InsertView(
                addUser: BlocProvider.of<DatabaseCubit>(context).insertUser,
              );
            case DatabaseLoaded _:
              return LoadedView(
                users: state.users,
                addUserRequest: BlocProvider.of<DatabaseCubit>(
                  context,
                ).showInsertView,
                deleteUser: BlocProvider.of<DatabaseCubit>(context).deleteUser,
              );
            case DatabaseLoading _:
            case DatabaseInitial _:
              return LoadingView();
          }
          ;
        },
      ),
    );
  }
}
