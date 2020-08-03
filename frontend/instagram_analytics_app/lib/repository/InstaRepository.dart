import 'package:instagram_analytics_app/networking/ApiProvider.dart';
import 'package:instagram_analytics_app/models/InstaModel.dart';
import 'dart:async';

class InstaRepository {
  ApiProvider _provider = ApiProvider();

  Future<InstaModel> fetchInstaData(String username, String password) async {
    final response = await _provider.get("api/user?username=" + username + "&password=" + password);
    return InstaModel.fromJson(response);
  }
}