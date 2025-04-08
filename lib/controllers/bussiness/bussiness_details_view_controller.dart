import 'package:get/get.dart';

import '../../models/bussiness_profile_admin.dart';
import '../../service/repository/bussiness_repositry.dart';

class BussinessDetailsViewController extends GetxController {
  var bussinessData = Rxn<BusinessDataAdmin>();
  var isLoading = false.obs;

  final BussinessRepository _repository = BussinessRepository();

  @override
  void onInit() {
    super.onInit();
    fetchSalon();
  }

  Future<void> fetchSalon() async {
    isLoading.value = true;
    var result = await _repository.fetchBussinessAdminToken();
    if (result != null) {
      bussinessData.value = result as BusinessDataAdmin?;
    }
    isLoading.value = false;
  }
}
