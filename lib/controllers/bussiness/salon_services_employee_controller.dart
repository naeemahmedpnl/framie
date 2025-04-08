import 'package:get/get.dart';

import '../../../models/salon.response.model.dart';
import '../../../service/repository/salon_repository.dart';

class SalonServicesEmployeeController extends GetxController {
  var selectedTab = "Services".obs;
  var salons = <ServiceSalon>[].obs;
  var isLoading = false.obs;

  final SalonRepository _repository = SalonRepository();

  @override
  void onInit() {
    super.onInit();
    fetchSalons();
  }

  void selectTab(String tab) {
    selectedTab.value = tab;
  }

  Future<void> fetchSalons() async {
    isLoading.value = true;
    var result = await _repository.fetchAllSalons();
    salons.assignAll(result);
    isLoading.value = false;
  }

  void handleBooking(String service) {
    Get.snackbar("Booking Confirmed", "You booked: $service",
        snackPosition: SnackPosition.BOTTOM);
  }
}
