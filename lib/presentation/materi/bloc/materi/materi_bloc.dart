// ignore_for_file: public_member_api_docs, sort_constructors_first
// ignore: depend_on_referenced_packages
import 'package:bloc/bloc.dart';
import 'package:freezed_annotation/freezed_annotation.dart';

import 'package:flutter_cbt/data/datasource/materi/materi_remote_datasource.dart';
import 'package:flutter_cbt/data/models/response/materi/materi_response_model.dart';

part 'materi_bloc.freezed.dart';
part 'materi_event.dart';
part 'materi_state.dart';

class MateriBloc extends Bloc<MateriEvent, MateriState> {
  final MateriRemoteDatasource materiRemoteDatasource;
  MateriBloc(
    this.materiRemoteDatasource,
  ) : super(const _Initial()) {
    on<_GetAllMateri>(
      (event, emit) async {
        emit(const _Loading());
        final response = await materiRemoteDatasource.getAllMateri();
        response.fold(
          (l) => emit(_Error(l)),
          (r) => emit(_Success(r)),
        );
      },
    );
  }
}
