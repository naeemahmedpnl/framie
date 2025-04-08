import 'package:get/get.dart';

// Models
class TreatmentItem {
  final String id;
  final String imageUrl;
  final String title;
  final bool isFavorite;

  TreatmentItem({
    required this.id,
    required this.imageUrl,
    required this.title,
    this.isFavorite = false,
  });
}

class AddFavoritesController extends GetxController {
  final RxList<TreatmentItem> allTreatments = <TreatmentItem>[].obs;
  final RxList<TreatmentItem> favorites = <TreatmentItem>[].obs;
  final RxInt cartCount = 1.obs;

  @override
  void onInit() {
    super.onInit();
    loadTreatments();
  }

  void loadTreatments() {
    // Sample data
    allTreatments.value = [
      TreatmentItem(
        id: '1',
        imageUrl: 'assets/images/slider.png',
        title: 'Hair Treatments',
        isFavorite: true,
      ),
      TreatmentItem(
        id: '2',
        imageUrl: 'assets/images/slider.png',
        title: 'Hair Treatments',
        isFavorite: true,
      ),
    ];

    // Filter favorites
    updateFavorites();
  }

  void updateFavorites() {
    favorites.value = allTreatments.where((item) => item.isFavorite).toList();
  }

  void toggleFavorite(String id) {
    final index = allTreatments.indexWhere((item) => item.id == id);
    if (index != -1) {
      final item = allTreatments[index];
      allTreatments[index] = TreatmentItem(
        id: item.id,
        imageUrl: item.imageUrl,
        title: item.title,
        isFavorite: !item.isFavorite,
      );
      updateFavorites();
    }
  }

  void addFavorite() {
    // Logic to navigate to add favorites screen
    Get.toNamed('/services');
  }
}
