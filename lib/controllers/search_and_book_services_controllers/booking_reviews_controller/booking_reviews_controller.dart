import 'package:get/get.dart';

class BookingReviewsController extends GetxController {
  var ratings = <Map<String, dynamic>>[
    {"stars": 5, "count": 255, "percentage": 40.0},
    {"stars": 4, "count": 200, "percentage": 38.0},
    {"stars": 3, "count": 25, "percentage": 10.0},
    {"stars": 2, "count": 25, "percentage": 10.0},
    {"stars": 1, "count": 10, "percentage": 2.0},
  ].obs;

  var reviews = <Map<String, dynamic>>[
    {
      "stars": 5,
      "text": "The strong pressure of this treatment is great for freeing up tense muscles while realigning muscle tissues and speeding up recovery."
    },
    {
      "stars": 5,
      "text": "The strong pressure of this treatment is great for freeing up tense muscles while realigning muscle tissues and speeding up recovery."
    },
  ].obs;
}
