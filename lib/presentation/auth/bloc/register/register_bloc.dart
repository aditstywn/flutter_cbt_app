// ignore_for_file: public_member_api_docs, sort_constructors_first
// ignore: depend_on_referenced_packages
import 'package:bloc/bloc.dart';
import 'package:freezed_annotation/freezed_annotation.dart';

import 'package:flutter_cbt/data/datasource/auth/auth_remote_datasource.dart';
import 'package:flutter_cbt/data/models/response/auth/auth_response_model.dart';

import '../../../../data/models/request/auth/register_request_model.dart';

part 'register_bloc.freezed.dart';
part 'register_event.dart';
part 'register_state.dart';

class RegisterBloc extends Bloc<RegisterEvent, RegisterState> {
  final AuthDatasource authDatasource;
  RegisterBloc(
    this.authDatasource,
  ) : super(const _Initial()) {
    on<_Register>((event, emit) async {
      emit(const _Loading());
      final response =
          await authDatasource.register(event.registerRequestModel);
      response.fold(
        (l) => emit(_Error(l)),
        (r) => emit(_Success(r)),
      );
    });
  }
}
