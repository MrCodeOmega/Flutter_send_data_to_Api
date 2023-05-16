import 'package:dio/dio.dart';

class ImageService {
  static Future<dynamic> uploadFile(filePath) async {
    final String PROJECT = "all";
    final String API_KEY = "your_API_Key";
    final String API_URL = "your_api URL" + PROJECT + "?api-key=";

    //Send Image to API/////
    try {
      FormData formData = FormData.fromMap({
        "images": await MultipartFile.fromFile(filePath, filename: "images")
      });

      Response response = await Dio().post(
        API_URL + API_KEY,
        data: formData,
      );
      return response;
    } on DioError catch (e) {
      return e.response;
    } catch (e) {
      print(e.toString());
    }
  }
}
