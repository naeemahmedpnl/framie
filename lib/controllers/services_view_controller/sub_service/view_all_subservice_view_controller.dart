import 'package:get/get.dart';

import '../../../models/sub_services_salon_model.dart';
import '../../../service/repository/sub_repository.dart';

class ViewAllSubServiceByAdminIdController extends GetxController {
  var subServices = <SubServiceSalon>[].obs;
  var isLoading = false.obs;

  final SubSalonRepository _repository = SubSalonRepository();

  @override
  void onInit() {
    super.onInit();
    fetchSalons();
  }

  Future<void> fetchSalons() async {
    isLoading.value = true;
    var result = await _repository.fetchSubServicesByAdminID();
    subServices.assignAll(result);
    isLoading.value = false;
  }
}
