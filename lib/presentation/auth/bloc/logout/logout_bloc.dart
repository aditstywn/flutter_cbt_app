// ignore_for_file: public_member_api_docs, sort_constructors_first
// ignore: depend_on_referenced_packages
import 'package:bloc/bloc.dart';
import 'package:freezed_annotation/freezed_annotation.dart';

import 'package:flutter_cbt/data/datasource/auth/auth_remote_datasource.dart';

part 'logout_bloc.freezed.dart';
part 'logout_event.dart';
part 'logout_state.dart';

class LogoutBloc extends Bloc<LogoutEvent, LogoutState> {
  final AuthDatasource authDatasource;
  LogoutBloc(
    this.authDatasource,
  ) : super(const _Initial()) {
    on<_Logout>((event, emit) async {
      emit(const _Loading());
      final response = await authDatasource.logout();
      response.fold(
        (l) => emit(_Error(l)),
        (r) => emit(const _Success()),
      );
    });
  }
}
