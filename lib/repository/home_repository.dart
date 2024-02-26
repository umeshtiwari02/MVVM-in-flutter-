import 'package:mvvm/data/network/base_api_services.dart';
import 'package:mvvm/data/network/network_api_services.dart';
import 'package:mvvm/model/movies_model.dart';
import 'package:mvvm/res/app_url.dart';

class HomeRepository {
  BaseApiServices _apiServices = NetworkApiService();

  Future<MovieListModel> fetchMovieList() async {
    try {
      dynamic response =
          await _apiServices.getGetApiResponse(AppUrl.moviesListUrl);

      return response = MovieListModel.fromJson(response);
    } catch (e) {
      throw e;
    }
  }
}
