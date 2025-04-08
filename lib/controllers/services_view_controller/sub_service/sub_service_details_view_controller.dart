import 'package:get/get.dart';

import '../../../models/sub_services_salon_model.dart';
import '../../../service/repository/sub_repository.dart';

class SubServiceDetailsController extends GetxController {
  var subServices = <SubServiceSalon>[].obs;
  var isLoading = false.obs;

  final SubSalonRepository _repository = SubSalonRepository();

  Future<void> fetchSalons(String serviceId) async {
    isLoading.value = true;
    var result = await _repository.fetchSubServicesByServiceID(serviceId);
    subServices.assignAll(result);
    isLoading.value = false;
  }
}
