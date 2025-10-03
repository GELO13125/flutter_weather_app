import 'package:flutter/material.dart';

class SearchField extends StatelessWidget {
  final TextEditingController controller;
  final VoidCallback onSearch;

  const SearchField({
    super.key,
    required this.controller,
    required this.onSearch,
  });

  @override
  Widget build(BuildContext context) {
    return TextField(
      controller: controller,
      decoration: InputDecoration(
        border: OutlineInputBorder(borderRadius: BorderRadius.circular(12)),
        filled: true,
        fillColor: Colors.white.withOpacity(0.85),
        hintText: "Enter city name",
      ),
      onTap: () => controller.clear(),
      onSubmitted: (_) => onSearch(),
    );
  }
}
