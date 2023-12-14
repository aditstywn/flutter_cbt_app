import 'package:dartz/dartz.dart';
import 'package:flutter_cbt/data/datasource/auth/auth_local_datasource.dart';
import 'package:flutter_cbt/data/models/response/content/content_response_model.dart';
import 'package:http/http.dart' as http;

import '../../../core/constants/variables.dart';

class ContentRemoteDatasource {
  Future<Either<String, ContentResponseModel>> getContentById(String id) async {
    final authData = await AuthLocalDatasource().getAuthData();
    final response = await http
        .get(Uri.parse('${Variables.baseUrl}/api/contents?id=$id'), headers: {
      'Content-Type': 'application/json',
      'Authorization': 'Bearer ${authData.accessToken}',
    });
    if (response.statusCode == 200) {
      return Right(ContentResponseModel.fromJson(response.body));
    } else {
      return const Left('Gagal Get Content');
    }
  }
}
