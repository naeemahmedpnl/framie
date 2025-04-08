import 'package:flutter/material.dart';

class LicenseView extends StatelessWidget {
  const LicenseView({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        backgroundColor: Colors.white,
        elevation: 0,
        title: const Text(
          'License',
          style: TextStyle(
            color: Colors.black,
            fontSize: 20,
            fontWeight: FontWeight.w500,
          ),
        ),
        centerTitle: true,
        leading: IconButton(
          icon: const Icon(Icons.arrow_back_ios, color: Colors.black, size: 20),
          onPressed: () => Navigator.of(context).pop(),
        ),
        actions: [
          IconButton(
            icon: const Icon(Icons.help_outline, color: Colors.black, size: 24),
            onPressed: () {
              // Add help functionality here
            },
          ),
        ],
      ),
      body: SafeArea(
        child: SingleChildScrollView(
          padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 16),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: const [
              LoremParagraph(),
              SizedBox(height: 24),
              LongLoremParagraph(),
              SizedBox(height: 24),
              LoremParagraph(endWithPeriod: true),
              SizedBox(height: 24),
              LongLoremParagraph(),
            ],
          ),
        ),
      ),
    );
  }
}

// Widget to display a standard lorem ipsum paragraph
class LoremParagraph extends StatelessWidget {
  final bool endWithPeriod;

  const LoremParagraph({super.key, this.endWithPeriod = false});

  @override
  Widget build(BuildContext context) {
    return Text(
      'Duis aute irure dolor in reprehenderit in voluptate velit esse cillum dolore eu fugiat nulla pariatuDuis aute irure dolor in reprehenderit in voluptate velit esse cillum dolore eu fugiat nulla pariatu${endWithPeriod ? '.' : ''}',
      style: const TextStyle(
        fontSize: 14,
        color: Color(0xFF777777),
        height: 1.5,
      ),
    );
  }
}

// Widget to display a longer lorem ipsum paragraph
class LongLoremParagraph extends StatelessWidget {
  const LongLoremParagraph({super.key});

  @override
  Widget build(BuildContext context) {
    return Text(
      'Duis aute irure dolor in reprehenderit in voluptate velit esse cillum dolore eu fugiat nulla pariatu'
      'Duis aute irure dolor in reprehenderit in voluptate velit esse cillum dolore eu fugiat nulla pariatu '
      'Duis aute irure dolor in reprehenderit in voluptate velit esse cillum dolore eu fugiat nulla pariatu'
      'Duis aute irure dolor in reprehenderit in voluptate velit esse cillum dolore eu fugiat nulla pariatu',
      style: const TextStyle(
        fontSize: 14,
        color: Color(0xFF777777),
        height: 1.5,
      ),
    );
  }
}
