import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../../models/admin_models/all_employees_model.dart';
import '../../../models/salon.response.model.dart';
import 'confirm_booking_stylist_view.dart';

class SalonDetailsUserView extends StatefulWidget {
  final AllEmployees employees;
  final List<ServiceSalon> services;
  const SalonDetailsUserView({
    super.key,
    required this.employees,
    required this.services,
  });

  @override
  State<SalonDetailsUserView> createState() => _SalonDetailsUserViewState();
}

class _SalonDetailsUserViewState extends State<SalonDetailsUserView>
    with SingleTickerProviderStateMixin {
  late TabController _tabController;

  final String bioText =
      '''Lorem ipsum dolor sit amet, consectetur adipiscing elit. Quisque sit amet enim ac enim pretium ornare. Aenean sagittis libero vitae metus cursus tincidunt.''';

  final List<Map<String, dynamic>> ratings = [
    {"stars": 5, "count": "255", "percentage": "40"},
    {"stars": 4, "count": "200", "percentage": "38"},
    {"stars": 3, "count": "25", "percentage": "10"},
    {"stars": 2, "count": "25", "percentage": "10"},
    {"stars": 1, "count": "10", "percentage": "2"},
  ];

  final List<Map<String, String>> reviews = [
    {
      "stars": "5",
      "text":
          "The strong pressure of this treatment is great for freeing up tense muscles while realigning muscle tissues and speeding up recovery.",
      "verified": "true"
    },
    {
      "stars": "5",
      "text":
          "The strong pressure of this treatment is great for freeing up tense muscles while realigning muscle tissues and speeding up recovery.",
      "verified": "true"
    },
  ];

  @override
  void initState() {
    super.initState();
    _tabController = TabController(length: 4, vsync: this);
  }

  @override
  void dispose() {
    _tabController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Booking"),
        leading: IconButton(
          icon: const Icon(Icons.arrow_back_ios),
          onPressed: () => Navigator.pop(context),
        ),
        actions: [
          IconButton(
            icon: const Icon(Icons.favorite_border),
            onPressed: () {},
          ),
          IconButton(
            icon: const Icon(Icons.share),
            onPressed: () {},
          ),
        ],
      ),
      body: Column(
        children: [
          _buildHeader(),
          _buildTabs(),
          Expanded(
            child: TabBarView(
              controller: _tabController,
              children: [
                _buildAboutTab(),
                _buildServicesTab(),
                _buildReviewsTab(),
                _buildBioTab(),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildHeader() {
  return Column(
    children: [
      ClipRRect(
        child: Image.network(
          "https://appsdemo.pro/Framie/${widget.employees.employeeImage}",
          height: 200,
          width: double.infinity,
          fit: BoxFit.cover,
          errorBuilder: (context, error, stackTrace) => const Icon(Icons.error, size: 100),
        ),
      ),
      const SizedBox(height: 16),
      Text(
        widget.employees.employeeName,
        style: const TextStyle(
          fontSize: 24,
          fontWeight: FontWeight.bold,
          color: Colors.purple,
        ),
      ),
      Row(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          const Icon(Icons.star, color: Colors.amber, size: 20),
          const SizedBox(width: 4),
          const Text("Not available", style: TextStyle(fontWeight: FontWeight.bold)), // Rating not available in API
        ],
      ),
      Text(
        "Last Booked: Not available", // Last booked not available in API
        style: TextStyle(color: Colors.grey.shade600),
      ),
    ],
  );
}


Widget _buildAboutTab() {
  // Format working days into a string
  String workingDaysString = widget.employees.workingDays
      .where((day) => day.isActive)
      .map((day) => "${day.day}: ${day.startTime}-${day.endTime}")
      .join(", ");

  // Get the list of days the employee works
  String daysString = widget.employees.workingDays
      .where((day) => day.isActive)
      .map((day) => day.day.substring(0, 3)) // Shorten to "Mon", "Tue", etc.
      .join("-");

  return SingleChildScrollView(
    child: Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const SizedBox(height: 16),
        // Basic Info Section
        Padding(
          padding: const EdgeInsets.symmetric(horizontal: 16),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Row(
                children: [
                  const Icon(Icons.location_on, color: Colors.grey),
                  const SizedBox(width: 8),
                  Text(
                    "Not available", // Location not available in API
                    style: TextStyle(color: Colors.grey.shade600),
                  ),
                ],
              ),
              const SizedBox(height: 12),
              Row(
                children: [
                  const Icon(Icons.access_time, color: Colors.grey),
                  const SizedBox(width: 8),
                  Text(
                    workingDaysString.isNotEmpty
                        ? "${widget.employees.workingDays.first.startTime}-${widget.employees.workingDays.first.endTime}, $daysString"
                        : "Not available",
                    style: TextStyle(color: Colors.grey.shade600),
                  ),
                ],
              ),
              const SizedBox(height: 12),
              Row(
                children: [
                  const Icon(Icons.directions_walk, color: Colors.grey),
                  const SizedBox(width: 8),
                  Text(
                    "Not available", // Distance not available in API
                    style: TextStyle(color: Colors.grey.shade600),
                  ),
                ],
              ),
              const SizedBox(height: 12),
              Row(
                children: [
                  const Icon(Icons.star, color: Colors.amber),
                  const SizedBox(width: 8),
                  Text(
                    "Not available", // Rating not available in API
                    style: TextStyle(color: Colors.grey.shade600),
                  ),
                ],
              ),
            ],
          ),
        ),
        const SizedBox(height: 16),
        Padding(
          padding: const EdgeInsets.symmetric(horizontal: 16),
          child: Text(
            widget.employees.about.isNotEmpty
                ? widget.employees.about
                : "No description available",
            style: TextStyle(color: Colors.grey.shade600),
          ),
        ),
        const SizedBox(height: 16),
        // Services Section with Arrow
        _buildInfoRow(
          icon: Icons.star,
          title: "Services",
          content: widget.employees.availableServices.isNotEmpty
              ? widget.employees.availableServices.map((service) => service.title).join(", ")
              : "No services available",
          showArrow: true,
          iconColor: Colors.purple,
        ),
        // Rating Section with Arrow
        _buildInfoRow(
          icon: Icons.star,
          title: "Rating",
          content: "Not available", // Rating not available in API
          showArrow: true,
          iconColor: Colors.purple,
        ),
        // Experience Section
        _buildInfoRow(
          icon: Icons.school,
          title: "Experience",
          content: "Not available", // Experience not available in API
          showArrow: false,
          iconColor: Colors.purple,
        ),
        // Languages Section
        _buildInfoRow(
          icon: Icons.language,
          title: "Languages",
          content: "Not available", // Languages not available in API
          showArrow: false,
          iconColor: Colors.purple,
        ),
        // Certification Section
        Padding(
          padding: const EdgeInsets.symmetric(horizontal: 16),
          child: Row(
            children: [
              const Icon(Icons.verified, color: Colors.purple),
              const SizedBox(width: 8),
              Expanded(
                child: Text(
                  "Not available", // Certification status not available in API
                  style: const TextStyle(
                    fontSize: 16,
                    color: Colors.black87,
                  ),
                ),
              ),
            ],
          ),
        ),
      ],
    ),
  );
}





  Widget _buildTabs() {
    return TabBar(
      controller: _tabController,
      labelColor: Colors.purple,
      unselectedLabelColor: Colors.grey,
      indicatorColor: Colors.purple,
      tabs: const [
        Tab(text: "About"),
        Tab(text: "Services"),
        Tab(text: "Reviews"),
        Tab(text: "BIO"),
      ],
    );
  }


  Widget _buildServicesTab() {
  return ListView(
    padding: const EdgeInsets.all(16),
    children: [
      for (ServiceSalon service in widget.services.where((service) =>
          widget.employees.availableServices.any((availableService) =>
              availableService.id == service.id)))
        _buildServiceCard(service),
    ],
  );
}



// Widget _buildBioTab() {
//   return SingleChildScrollView(
//     child: Padding(
//       padding: const EdgeInsets.all(16),
//       child: Column(
//         crossAxisAlignment: CrossAxisAlignment.start,
//         children: [
//           const Text(
//             "Bio",
//             style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
//           ),
//           const SizedBox(height: 16),
//           Text(
//             widget.employees.about.isNotEmpty
//                 ? widget.employees.about
//                 : "No bio available",
//             style: TextStyle(color: Colors.grey.shade600),
//           ),
//         ],
//       ),
//     ),
//   );
// }




// Widget _buildReviewsTab() {
//   return ListView(
//     padding: const EdgeInsets.all(16),
//     children: [
//       const Text(
//         "Reviews",
//         style: TextStyle(fontWeight: FontWeight.bold, fontSize: 16),
//       ),
//       Text(
//         "Not available", // Reviews not available in API
//         style: TextStyle(color: Colors.grey.shade600),
//       ),
//     ],
//   );
// }

  Widget _buildReviewsTab() {
    return ListView(
      padding: const EdgeInsets.all(16),
      children: [
        const Text(
          "1250 Reviews",
          style: TextStyle(fontWeight: FontWeight.bold, fontSize: 16),
        ),
        Text(
          "4.88 out of 5.0",
          style: TextStyle(color: Colors.grey.shade600),
        ),
        const SizedBox(height: 16),
        Column(
          children: ratings.map((rating) => _buildRatingRow(rating)).toList(),
        ),
        const SizedBox(height: 16),
        Column(
          children: reviews.map((review) => _buildReviewCard(review)).toList(),
        ),
      ],
    );
  }

  Widget _buildBioTab() {
    return SingleChildScrollView(
      child: Padding(
        padding: const EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const Text(
              "Bio",
              style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
            ),
            const SizedBox(height: 16),
            Text(
              bioText,
              style: TextStyle(color: Colors.grey.shade600),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildInfoRow({
    required IconData icon,
    required String title,
    required String content,
    required bool showArrow,
    required Color iconColor,
  }) {
    return Column(
      children: [
        Padding(
          padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
          child: Row(
            children: [
              Icon(icon, color: iconColor),
              const SizedBox(width: 8),
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      title,
                      style: TextStyle(
                        color: Colors.grey.shade600,
                        fontSize: 14,
                      ),
                    ),
                    Text(
                      content,
                      style: const TextStyle(
                        fontSize: 16,
                        color: Colors.black87,
                      ),
                    ),
                  ],
                ),
              ),
              if (showArrow)
                Icon(Icons.arrow_forward_ios, color: Colors.grey, size: 16),
            ],
          ),
        ),
        Divider(color: Colors.grey.shade200),
      ],
    );
  }

  Widget _buildServiceCard(ServiceSalon service) {
    return Card(
      margin: const EdgeInsets.only(bottom: 16),
      child: Column(
        children: [
          Stack(
            children: [
              ClipRRect(
                borderRadius: BorderRadius.circular(8),
                child: Image.network(
                  'https://appsdemo.pro/Framie/${service.bannerImage}',
                  height: 200,
                  width: double.infinity,
                  fit: BoxFit.cover,
                ),
              ),
              Positioned(
                bottom: 20,
                left: 0,
                right: 0,
                child: Center(
                  child: SizedBox(
                    width: 180,
                    child: ElevatedButton(
                      onPressed: () {
                        Get.to(() => ConfirmBookingStylistScreen(
                              serviceName: service.title.toString(),
                              employees: widget.employees,
                              services: service,
                            ));
                      },
                      style: ElevatedButton.styleFrom(
                        backgroundColor: Colors.purple,
                        foregroundColor: Colors.white,
                      ),
                      child: const Text("Book Now"),
                    ),
                  ),
                ),
              )
            ],
          ),
          Padding(
            padding: const EdgeInsets.all(16),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Text(
                  service.title.toString(),
                  style: const TextStyle(
                    fontSize: 18,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildRatingRow(Map<String, dynamic> rating) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 4),
      child: Row(
        children: [
          Row(
            children: List.generate(
              5,
              (index) => Icon(
                Icons.star,
                color: index < rating["stars"] ? Colors.amber : Colors.grey,
                size: 18,
              ),
            ),
          ),
          const SizedBox(width: 8),
          Text(rating["count"]),
          const SizedBox(width: 4),
          Text("(${rating["percentage"]}%)"),
        ],
      ),
    );
  }

  Widget _buildReviewCard(Map<String, String> review) {
    return Card(
      color: Colors.purple.shade700,
      margin: const EdgeInsets.symmetric(vertical: 8),
      child: Padding(
        padding: const EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              children: [
                Row(
                  children: List.generate(
                    5,
                    (i) => Icon(
                      Icons.star,
                      color: i < int.parse(review["stars"]!)
                          ? Colors.amber
                          : Colors.grey,
                      size: 18,
                    ),
                  ),
                ),
                const SizedBox(width: 8),
                if (review["verified"] == "true")
                  const Text(
                    "✔ Verified Appointment",
                    style: TextStyle(
                        color: Colors.white, fontWeight: FontWeight.bold),
                  ),
              ],
            ),
            const SizedBox(height: 8),
            Text(
              review["text"]!,
              style: const TextStyle(color: Colors.white),
            ),
          ],
        ),
      ),
    );
  }
}
