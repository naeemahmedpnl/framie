import 'package:flutter/material.dart';

class UnderlinedTextField extends StatelessWidget {
  final String? label;
  final String hint;
  final TextEditingController controller;
  final String? prefix;
  final bool showPrefixDropdown;
  final bool showTrailingDropdown;
  final Function()? onTap;
  final Function()? onPrefixTap;
  final bool readOnly;
  final TextInputType keyboardType;

  const UnderlinedTextField({
    super.key,
    this.label,
    required this.hint,
    required this.controller,
    this.prefix,
    this.showPrefixDropdown = false,
    this.showTrailingDropdown = false,
    this.onTap,
    this.onPrefixTap,
    this.readOnly = false,
    this.keyboardType = TextInputType.text,
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Row(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            if (prefix != null) ...[
              GestureDetector(
                onTap: onPrefixTap,
                child: Row(
                  children: [
                    Text(
                      prefix!,
                      style: const TextStyle(
                        fontSize: 16,
                        color: Colors.black87,
                      ),
                    ),
                    if (showPrefixDropdown)
                      const Icon(
                        Icons.arrow_drop_down,
                        color: Colors.grey,
                      ),
                  ],
                ),
              ),
              const SizedBox(width: 12),
            ],
            Expanded(
              child: TextField(
                controller: controller,
                readOnly: readOnly,
                onTap: onTap,
                keyboardType: keyboardType,
                decoration: InputDecoration(
                  hintText: hint,
                  hintStyle: TextStyle(
                    color: Colors.grey.shade400,
                    fontSize: 16,
                  ),
                  border: InputBorder.none,
                ),
              ),
            ),
            if (showTrailingDropdown)
              const Icon(
                Icons.keyboard_arrow_down,
                color: Colors.grey,
              ),
          ],
        ),
        const SizedBox(height: 4),
        Container(
          height: 1,
          color: Colors.grey.shade300,
        ),
      ],
    );
  }
}
