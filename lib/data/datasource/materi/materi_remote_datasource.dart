import 'package:dartz/dartz.dart';
import 'package:flutter_cbt/data/datasource/auth/auth_local_datasource.dart';
import 'package:http/http.dart' as http;

import '../../../core/constants/variables.dart';
import '../../models/response/materi/materi_response_model.dart';

class MateriRemoteDatasource {
  Future<Either<String, MateriResponseModel>> getAllMateri() async {
    final authData = await AuthLocalDatasource().getAuthData();
    final response =
        await http.get(Uri.parse('${Variables.baseUrl}/api/materis'), headers: {
      'Content-Type': 'application/json',
      'Authorization': 'Bearer ${authData.accessToken}',
    });
    if (response.statusCode == 200) {
      return Right(MateriResponseModel.fromJson(response.body));
    } else {
      return const Left('Gagal Get Materi');
    }
  }
}
