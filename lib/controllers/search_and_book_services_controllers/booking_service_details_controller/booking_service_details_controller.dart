import 'package:get/get.dart';

class BookingServiceDetailsController extends GetxController {
  // Available options
  final RxString selectedDuration = "60 Minutes".obs;
  final RxString selectedCondition = "Stiff, sore muscle".obs;
  final RxString selectedPressure = "Strong".obs;

  // Dropdown options
  final List<String> durations = ["30 Minutes", "60 Minutes", "90 Minutes"];
  final List<String> conditions = ["Stiff, sore muscle", "Relaxation", "Pain relief"];
  final List<String> pressures = ["Light", "Medium", "Strong"];

  // Function to update selections
  void updateDuration(String newValue) => selectedDuration.value = newValue;
  void updateCondition(String newValue) => selectedCondition.value = newValue;
  void updatePressure(String newValue) => selectedPressure.value = newValue;
}
