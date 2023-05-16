import 'package:flutter/material.dart';
import 'package:flutter_plant_identity_app/models/plant_model.dart';
import 'package:flutter_plant_identity_app/pages/detail_page.dart';
import 'package:flutter_plant_identity_app/services/google_service.dart';
import 'package:get/get.dart';
import 'package:image_picker/image_picker.dart';
import '../services/service.dart';

class PlantController extends GetxController {
  var isLoading = false.obs;
  var imageUrl = "";
  var plantImage = "";
  var plantImage2 = "";
  var plantImage3 = "";
  var family = "";
  var species1 = "";
  var species2 = "";
  var species3 = "";

  void uploadImage(ImageSource imageSource) async {
    try {
      final pickedFile = await ImagePicker().pickImage(source: imageSource);
      isLoading(true);
      List<Plant> _plantModel = [];

      if (pickedFile != null) {
        var response = await ImageService.uploadFile(pickedFile.path);

        print("Status : ////" + response.statusCode.toString());

        ////////When api response do these methods/////
        if (response.statusCode == 200) {
          print(response.data["results"][0]["species"]["genus"]
                  ["scientificName"]
              .toString());

          Get.snackbar("Success", "Image uploaded successfully",
              colorText: Color.fromARGB(255, 0, 61, 32),
              backgroundColor: Colors.white,
              barBlur: 0.8,
              margin: EdgeInsets.only(top: 5, left: 10, right: 10));

          //////////////Data Results ///////////////////
          imageUrl = response.data["results"][0]["species"]["genus"]
                  ["scientificName"]
              .toString();
          family = response.data["results"][0]["species"]["family"]
                  ["scientificNameWithoutAuthor"]
              .toString();
          species1 = response.data["results"][0]["species"]
                  ["scientificNameWithoutAuthor"]
              .toString();
          species2 = response.data["results"][1]["species"]
                  ["scientificNameWithoutAuthor"]
              .toString();
          species3 = response.data["results"][2]["species"]
                  ["scientificNameWithoutAuthor"]
              .toString();

          ///////////////////**Google Image Search *////////////////////////////////////

          var googleResponse = await GoogleImageSerach.googleSearch(imageUrl);
          plantImage = googleResponse.data["items"][0]["link"].toString();
          plantImage2 = googleResponse.data["items"][1]["link"].toString();
          plantImage3 = googleResponse.data["items"][2]["link"].toString();

          Get.to(
              () => DetailPage(
                    plantName: imageUrl,
                    plantImage: plantImage,
                    plantImage2: plantImage2,
                    plantImage3: plantImage3,
                    family: family,
                    species1: species1,
                    species2: species2,
                    species3: species3,
                  ),
              transition: Transition.rightToLeft,
              duration: Duration(seconds: 1));
        }
        if (response.statusCode == 400) {
          Get.snackbar('Failed', 'Error Code: ${response.statusCode}',
              colorText: Colors.redAccent,
              margin: EdgeInsets.only(top: 5, left: 10, right: 10));
        }
      } else {
        Get.snackbar('Failed', 'Image not selected',
            colorText: Color.fromARGB(255, 172, 6, 6),
            margin: EdgeInsets.only(top: 5, left: 10, right: 10));
      }
    } finally {
      isLoading(false);
    }
  }
}
