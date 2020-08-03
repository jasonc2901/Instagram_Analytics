import 'dart:async';
import 'package:instagram_analytics_app/networking/Response.dart';
import 'package:instagram_analytics_app/repository/InstaRepository.dart';
import 'package:instagram_analytics_app/models/InstaModel.dart';

class InstaBloc {
  InstaRepository _instaRepository;
  StreamController _instaDataController;

  StreamSink<Response<InstaModel>> get instaDataSink =>
      _instaDataController.sink;

  Stream<Response<InstaModel>> get instaDataStream =>
      _instaDataController.stream;

  InstaBloc(String username,String password) {
    _instaDataController = StreamController<Response<InstaModel>>();
    _instaRepository = InstaRepository();
    fetchInstaDetails(username, password);
  }

  fetchInstaDetails(String username, String password) async {
    instaDataSink.add(Response.loading('Fetching Insta Details!'));
    try {
      InstaModel instaDetails = await _instaRepository.fetchInstaData(username, password);
      instaDataSink.add(Response.completed(instaDetails));
    } catch (e) {
      instaDataSink.add(Response.error(e.toString()));
      print(e);
    }
  }

  dispose() {
    _instaDataController?.close();
  }
}
