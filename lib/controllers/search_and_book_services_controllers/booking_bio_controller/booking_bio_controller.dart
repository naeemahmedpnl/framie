import 'package:get/get.dart';

class BookingBioController extends GetxController {
  // Sample Bio Data
  final RxString bioText = RxString(
    "Lorem ipsum dolor sit amet, consectetur adipiscing elit. "
    "Quisque sit amet enim ac enim pretium ornare. Aenean sagittis libero vitae metus cursus tincidunt. "
    "Ut eget imperdiet lacus, nec pretium justo. Etiam ac nunc tellus. "
    "Pellentesque sed accumsan ex. Aliquam dictum imperdiet est, ut faucibus quam eleifend nec. "
    "Aliquam eleifend erat vel pulvinar dapibus. Morbi sodales mauris nec placerat rutrum. "
    "Sed quam quam, luctus vitae commodo nec."
  );

  // Function to update bio dynamically (if needed in the future)
  void updateBio(String newBio) {
    bioText.value = newBio;
  }
}
