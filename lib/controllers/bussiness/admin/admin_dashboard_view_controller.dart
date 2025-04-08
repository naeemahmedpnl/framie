import 'package:get/get.dart';
import 'package:intl/intl.dart';

class AdminDashboardController extends GetxController {
  final location = 'Lakewood, California'.obs;
  final currentMonth = 'November 2024'.obs;
  final customerCount = 21950.obs;
  final visitorCount = 1235.obs;
  final customerGoal = 25000.obs;
  final selectedTimeframe = 'Month'.obs;

  final currentDate = DateTime.now().obs;

  @override
  void onInit() {
    super.onInit();
    updateCurrentMonth();
  }

  double get customerProgress => customerCount.value / customerGoal.value;

  void changeTimeframe(String timeframe) {
    selectedTimeframe.value = timeframe;
    updateStats();
  }

  void navigateMonth(bool isNext) {
    if (isNext) {
      currentDate.value = DateTime(
        currentDate.value.year,
        currentDate.value.month + 1,
        currentDate.value.day,
      );
    } else {
      currentDate.value = DateTime(
        currentDate.value.year,
        currentDate.value.month - 1,
        currentDate.value.day,
      );
    }
    updateCurrentMonth();
    updateStats();
  }

  void updateCurrentMonth() {
    currentMonth.value = DateFormat('MMMM yyyy').format(currentDate.value);
  }

  void updateStats() {
    switch (selectedTimeframe.value) {
      case 'Day':
        customerCount.value = 750;
        visitorCount.value = 45;
        break;
      case 'Week':
        customerCount.value = 5250;
        visitorCount.value = 315;
        break;
      case 'Month':
        customerCount.value = 21950;
        visitorCount.value = 1235;
        break;
    }
  }
}
