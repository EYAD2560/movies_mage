import 'package:flutter/material.dart';

class CustomSearchBar extends StatelessWidget {
  const CustomSearchBar({
    super.key,
    required this.controller,
    required this.onSearchChanged,
  });

  final TextEditingController controller;
  final void Function(String query) onSearchChanged;

  @override
  Widget build(BuildContext context) {
    return TextField(
      cursorColor: Colors.blue,

      controller: controller,
      onChanged: onSearchChanged,
      textInputAction: TextInputAction.search,
      style: const TextStyle(color: Colors.black),
      decoration: InputDecoration(
        hintText: 'Search ',
        hintStyle: const TextStyle(color: Colors.black54),
        prefixIcon: const Icon(Icons.search, color: Colors.black),
        suffixIcon: controller.text.isNotEmpty
            ? IconButton(
                onPressed: () {
                  controller.clear();
                  onSearchChanged(''); 
                },
                icon: const Icon(Icons.clear, color: Colors.black54),
              )
            : null,
        filled: true,
        fillColor: Colors.white,
        contentPadding: const EdgeInsets.symmetric(vertical: 0, horizontal: 16),
        border: OutlineInputBorder(
          borderRadius: BorderRadius.circular(12),
          borderSide: BorderSide.none,
        ),
      ),
    );
  }
}
