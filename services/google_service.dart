import 'package:dio/dio.dart';

class GoogleImageSerach {
  static Future<dynamic> googleSearch(query) async {
    final String apiKey = "google_api_key";
    final String cx = "google_cx_key";
    final String API_URL =
        'https://www.googleapis.com/customsearch/v1?key=$apiKey&cx=$cx&q=$query&searchType=image';

    try {
      Response response = await Dio().get(API_URL);
      return response;
    } on DioError catch (e) {
      return e.response;
    } catch (e) {
      print(e.toString());
    }
  }
}
