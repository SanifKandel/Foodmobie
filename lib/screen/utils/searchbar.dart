import 'package:flutter/material.dart';

class SearchBar extends StatelessWidget {
  final Function(String) onSearch;

  const SearchBar({super.key, required this.onSearch});
  @override
  Widget build(BuildContext context) {
    return TextField(
      decoration: const InputDecoration(
        border: OutlineInputBorder(
          borderRadius: BorderRadius.all(Radius.circular(16)),
          borderSide: BorderSide(color: Colors.teal, width: 3.0),
        ),
        hintText: "Search...",
        prefixIcon: Icon(Icons.search),
      ),
      onChanged: (value) {
        onSearch(value);
      },
    );
  }
}
