import 'package:get/get.dart';

class BasketController extends GetxController {
  var selectedLocation = "Lorem ipsum street 4568".obs;
  var selectedStartTime = "".obs;
  var selectedPro = "".obs;
  var totalDuration = 60.obs; // Default duration in minutes
  var totalPrice = 30.obs; // Example price

  // List of selected services
  var services = [
    {
      "name": "Haircut & Styling",
      "duration": 60,
      "recommended": 90,
      "price": 10
    },
    {
      "name": "Deep tissue",
      "duration": 60,
      "recommended": 90,
      "price": 20
    }
  ].obs;

  // Function to set start time
  void setStartTime(String time) {
    selectedStartTime.value = time;
  }

  // Function to select a professional
  void setProfessional(String pro) {
    selectedPro.value = pro;
  }

  // Function to remove a service
  void removeService(int index) {
    totalPrice.value -= services[index]["price"] as int;
    services.removeAt(index);
  }
}
