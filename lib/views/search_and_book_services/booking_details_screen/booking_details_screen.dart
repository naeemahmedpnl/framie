import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../confirm_booking_screen/confirm_booking_screen.dart';

class UnifiedBookingScreen extends StatefulWidget {
  const UnifiedBookingScreen({super.key});

  @override
  State<UnifiedBookingScreen> createState() => _UnifiedBookingScreenState();
}

class _UnifiedBookingScreenState extends State<UnifiedBookingScreen>
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
          child: Image.asset(
            "assets/images/booking_screen.png",
            height: 200,
            width: double.infinity,
            fit: BoxFit.cover,
          ),
        ),
        const SizedBox(height: 16),
        const Text(
          "Jazy Dewo",
          style: TextStyle(
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
            const Text("4.98", style: TextStyle(fontWeight: FontWeight.bold)),
          ],
        ),
        Text(
          "Last Booked: Today",
          style: TextStyle(color: Colors.grey.shade600),
        ),
      ],
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

  Widget _buildAboutTab() {
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
                    Icon(Icons.location_on, color: Colors.grey),
                    const SizedBox(width: 8),
                    Text(
                      "No 03,Brooklyn, Los Angeles, California",
                      style: TextStyle(color: Colors.grey.shade600),
                    ),
                  ],
                ),
                const SizedBox(height: 12),
                Row(
                  children: [
                    Icon(Icons.access_time, color: Colors.grey),
                    const SizedBox(width: 8),
                    Text(
                      "9AM-10PM, Mon -Sun",
                      style: TextStyle(color: Colors.grey.shade600),
                    ),
                  ],
                ),
                const SizedBox(height: 12),
                Row(
                  children: [
                    Icon(Icons.directions_walk, color: Colors.grey),
                    const SizedBox(width: 8),
                    Text(
                      "10 Miles away",
                      style: TextStyle(color: Colors.grey.shade600),
                    ),
                  ],
                ),
                const SizedBox(height: 12),
                Row(
                  children: [
                    Icon(Icons.star, color: Colors.amber),
                    const SizedBox(width: 8),
                    Text(
                      "4.7 (312)",
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
              "Lorem Ipsum is simply dummy text of the printing and typesetting industry. Lorem Ipsum has been the industry's standard",
              style: TextStyle(color: Colors.grey.shade600),
            ),
          ),
          const SizedBox(height: 16),
          // Services Section with Arrow
          _buildInfoRow(
            icon: Icons.star,
            title: "Services",
            content: "Hair Style, Hair Color.",
            showArrow: true,
            iconColor: Colors.purple,
          ),
          // Rating Section with Arrow
          _buildInfoRow(
            icon: Icons.star,
            title: "RATED 4.92",
            content: "1250 Reviews",
            showArrow: true,
            iconColor: Colors.purple,
          ),
          // Experience Section
          _buildInfoRow(
            icon: Icons.school,
            title: "Experience",
            content: "5 Years",
            showArrow: false,
            iconColor: Colors.purple,
          ),
          // Languages Section
          _buildInfoRow(
            icon: Icons.language,
            title: "Languages",
            content: "English, PL",
            showArrow: false,
            iconColor: Colors.purple,
          ),
          // Certification Section
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 16),
            child: Row(
              children: [
                Icon(Icons.verified, color: Colors.purple),
                const SizedBox(width: 8),
                Expanded(
                  child: Text(
                    "Fully insured and actively certified",
                    style: TextStyle(
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

  Widget _buildServicesTab() {
    return ListView(
      padding: const EdgeInsets.all(16),
      children: [
        _buildServiceCard(
          "Hair Treatments",
          "assets/images/hair_treatment1.png",
        ),
        _buildServiceCard(
          "Hair Treatments",
          "assets/images/hair_treatment1.png",
        ),
        _buildServiceCard(
          "Relaxing Massage",
          "assets/images/hair_treatment1.png",
        ),
      ],
    );
  }

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

  Widget _buildServiceCard(String title, String imagePath) {
    return Card(
      margin: const EdgeInsets.only(bottom: 16),
      child: Column(
        children: [
          Stack(
            children: [
              ClipRRect(
                borderRadius: BorderRadius.circular(8),
                child: Image.asset(
                  imagePath,
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
                        Get.to(() => ConfirmBookingScreen());
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
                  title,
                  style: const TextStyle(
                      fontSize: 18, fontWeight: FontWeight.bold),
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
