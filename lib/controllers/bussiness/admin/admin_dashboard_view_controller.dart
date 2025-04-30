// import 'package:get/get.dart';
// import 'package:intl/intl.dart';

// class AdminDashboardController extends GetxController {
//   final location = 'Lakewood, California'.obs;
//   final currentMonth = 'November 2024'.obs;
//   final customerCount = 21950.obs;
//   final visitorCount = 1235.obs;
//   final customerGoal = 25000.obs;
//   final selectedTimeframe = 'Month'.obs;

//   final currentDate = DateTime.now().obs;

//   @override
//   void onInit() {
//     super.onInit();
//     updateCurrentMonth();
//   }

//   double get customerProgress => customerCount.value / customerGoal.value;

//   void changeTimeframe(String timeframe) {
//     selectedTimeframe.value = timeframe;
//     updateStats();
//   }

//   void navigateMonth(bool isNext) {
//     if (isNext) {
//       currentDate.value = DateTime(
//         currentDate.value.year,
//         currentDate.value.month + 1,
//         currentDate.value.day,
//       );
//     } else {
//       currentDate.value = DateTime(
//         currentDate.value.year,
//         currentDate.value.month - 1,
//         currentDate.value.day,
//       );
//     }
//     updateCurrentMonth();
//     updateStats();
//   }

//   void updateCurrentMonth() {
//     currentMonth.value = DateFormat('MMMM yyyy').format(currentDate.value);
//   }

//   void updateStats() {
//     switch (selectedTimeframe.value) {
//       case 'Day':
//         customerCount.value = 750;
//         visitorCount.value = 45;
//         break;
//       case 'Week':
//         customerCount.value = 5250;
//         visitorCount.value = 315;
//         break;
//       case 'Month':
//         customerCount.value = 21950;
//         visitorCount.value = 1235;
//         break;
//     }
//   }
// }



import 'package:beauty/service/repository/admin_auth_repository/dashboard_repository.dart';
import 'package:beauty/service/user_session/user_session.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';


class AdminDashboardController extends GetxController {

 late final ApiService apiService;
  
  // Initialize API service in the constructor
  AdminDashboardController() {
    // Check if ApiService is already registered
    if (!Get.isRegistered<ApiService>()) {
      Get.put(ApiService());
    }
    apiService = Get.find<ApiService>();
  }
  
  final location = 'Lakewood, California'.obs;
  final currentMonth = 'November 2024'.obs;
  final customerCount = 0.obs;
  final visitorCount = 0.obs;
  final customerGoal = 25000.obs;
  final selectedTimeframe = 'Month'.obs;
  final isLoading = false.obs;
  final errorMessage = ''.obs;

  final currentDate = DateTime.now().obs;
  
  // Get user ID from session
  String get userId => UserSession.userModel.value.id;

  @override
  void onInit() {
    super.onInit();
    updateCurrentMonth();
    fetchData();
  }

  double get customerProgress => customerCount.value / customerGoal.value;

  void changeTimeframe(String timeframe) {
    selectedTimeframe.value = timeframe;
    fetchData();
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
    fetchData();
  }

  void updateCurrentMonth() {
    currentMonth.value = DateFormat('MMMM yyyy').format(currentDate.value);
  }

  // New method to fetch data from API
  Future<void> fetchData() async {
    isLoading.value = true;
    errorMessage.value = '';
    
    try {
      // Convert timeframe to API parameter
      String timeType = selectedTimeframe.value.toLowerCase();
      
      // Fetch data from API
      final result = await apiService.getTotalCustomers(userId, timeType);
      
      // Check if API call was successful
      if (result['success'] == true) {
        // Set customer count from API response
        customerCount.value = result['data'] ?? 0;
        
        // Update visitor count (you might need a separate API for this or calculate it based on some logic)
        // For now, we'll just set a placeholder calculation
        visitorCount.value = (customerCount.value * 0.06).round();
      } else {
        errorMessage.value = 'Failed to load data';
      }
    } catch (e) {
      errorMessage.value = 'Error: ${e.toString()}';
      print('Error fetching data: $e');
    } finally {
      isLoading.value = false;
    }
  }
}