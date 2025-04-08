import '/utils/widgets/custom_button.dart';
import 'package:flutter/material.dart';

class RateAppScreen extends StatefulWidget {
  const RateAppScreen({super.key});

  @override
  State<RateAppScreen> createState() => _RateAppScreenState();
}

class _RateAppScreenState extends State<RateAppScreen> {
  int _rating = 4;
  final List<String> _tags = ['Clean', 'Professional', 'Best Service', 'Kind'];
  final List<bool> _selectedTags = [true, true, true, true];
  final TextEditingController _feedbackController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        backgroundColor: Colors.white,
        elevation: 0,
        title: const Text(
          'Rate This App',
          style: TextStyle(
            color: Colors.black,
            fontSize: 20,
            fontWeight: FontWeight.w600,
          ),
        ),
        centerTitle: true,
        leading: IconButton(
          icon: const Icon(Icons.close, color: Colors.black, size: 28),
          onPressed: () => Navigator.of(context).pop(),
        ),
        automaticallyImplyLeading: false,
      ),
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 24),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              const Spacer(flex: 2),

              // Rating text
              const Center(
                child: Text(
                  'Rate Your Experience',
                  style: TextStyle(
                    fontSize: 20,
                    color: Color(0xFF666666),
                    fontWeight: FontWeight.w500,
                  ),
                ),
              ),

              const SizedBox(height: 30),

              // Star Rating
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: List.generate(5, (index) {
                  return GestureDetector(
                    onTap: () {
                      setState(() {
                        _rating = index + 1;
                      });
                    },
                    child: Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 8.0),
                      child: Icon(
                        Icons.star,
                        size: 48,
                        color: index < _rating
                            ? const Color(
                                0xFFFFCC00) // Gold color for selected stars
                            : const Color(0xFFDDDDDD), // Gray for unselected
                      ),
                    ),
                  );
                }),
              ),

              const SizedBox(height: 50),

              // Tags
              Wrap(
                spacing: 10,
                runSpacing: 12,
                alignment: WrapAlignment.center,
                children: [
                  _buildTagChip(0),
                  _buildTagChip(1),
                ],
              ),

              const SizedBox(height: 12),

              Wrap(
                spacing: 10,
                runSpacing: 12,
                alignment: WrapAlignment.center,
                children: [
                  _buildTagChip(2),
                  _buildTagChip(3),
                ],
              ),

              const SizedBox(height: 50),

              // Feedback question
              const Text(
                'How was your overall experience?',
                style: TextStyle(
                  fontSize: 16,
                  color: Color(0xFF666666),
                  fontWeight: FontWeight.w500,
                ),
                textAlign: TextAlign.left,
              ),

              const SizedBox(height: 10),

              // Text input (underline only)
              TextField(
                controller: _feedbackController,
                decoration: const InputDecoration(
                  border: UnderlineInputBorder(),
                  focusedBorder: UnderlineInputBorder(
                    borderSide: BorderSide(color: Colors.grey),
                  ),
                ),
                maxLines: 1,
              ),

              const Spacer(),

              CustomButton(
                text: 'Done',
                onPressed: () {
                  _showSubmittedDialog(context);
                },
              ),

              const SizedBox(height: 24),
            ],
          ),
        ),
      ),
    );
  }

  void _showSubmittedDialog(BuildContext context) {
    showDialog(
      context: context,
      barrierDismissible: false,
      builder: (BuildContext context) {
        return Dialog(
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(20),
          ),
          elevation: 0,
          backgroundColor: Colors.white,
          child: Padding(
            padding: const EdgeInsets.all(20),
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                // Success icon with green background
                Container(
                  width: 80,
                  height: 80,
                  decoration: BoxDecoration(
                    color: const Color(0xFFEAF7EA),
                    shape: BoxShape.circle,
                  ),
                  child: Center(
                    child: Container(
                      width: 50,
                      height: 50,
                      decoration: const BoxDecoration(
                        color: Color(0xFF4CAF50),
                        shape: BoxShape.circle,
                      ),
                      child: const Icon(
                        Icons.check,
                        color: Colors.white,
                        size: 30,
                      ),
                    ),
                  ),
                ),
                const SizedBox(height: 20),
                // Submitted text
                const Text(
                  'Submitted!',
                  style: TextStyle(
                    fontSize: 24,
                    fontWeight: FontWeight.bold,
                    color: Color(0xFFAA2288),
                  ),
                ),
                const SizedBox(height: 12),
                // Thank you text
                const Text(
                  'Thanks for sharing your\nfeedback with us!',
                  textAlign: TextAlign.center,
                  style: TextStyle(
                    fontSize: 16,
                    color: Colors.black87,
                  ),
                ),
                const SizedBox(height: 30),
                // Continue button
                SizedBox(
                  width: double.infinity,
                  child: ElevatedButton(
                    onPressed: () {
                      Navigator.of(context).pop(); // Close dialog
                      Navigator.of(context).pop(); // Close rate screen
                    },
                    style: ElevatedButton.styleFrom(
                      backgroundColor: const Color(0xFFAA2288),
                      foregroundColor: Colors.white,
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(30),
                      ),
                      padding: const EdgeInsets.symmetric(vertical: 16),
                      elevation: 0,
                    ),
                    child: const Text(
                      'Continue',
                      style: TextStyle(
                        fontSize: 18,
                        fontWeight: FontWeight.w600,
                      ),
                    ),
                  ),
                ),
              ],
            ),
          ),
        );
      },
    );
  }

  Widget _buildTagChip(int index) {
    final bool isSelected = _selectedTags[index];
    final bool isThirdTag = index == 2;

    return ChoiceChip(
      label: Text(
        _tags[index],
        style: TextStyle(
          color: isSelected && !isThirdTag
              ? const Color(0xFFAA2288)
              : Colors.black,
          fontWeight: FontWeight.w500,
        ),
      ),
      selected: isSelected,
      selectedColor: isThirdTag ? const Color(0xFFDDDDDD) : Colors.white,
      backgroundColor: Colors.white,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(50),
        side: BorderSide(
          color: isThirdTag ? Colors.transparent : const Color(0xFFAA2288),
          width: 1.5,
        ),
      ),
      padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 12),
      onSelected: (bool selected) {
        setState(() {
          _selectedTags[index] = selected;
        });
      },
    );
  }
}
