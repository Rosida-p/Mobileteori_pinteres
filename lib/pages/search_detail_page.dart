
import 'package:flutter/material.dart';

class SearchDetailPage extends StatefulWidget {
  const SearchDetailPage({super.key});

  @override
  State<SearchDetailPage> createState() => _SearchDetailPageState();
}

class _SearchDetailPageState extends State<SearchDetailPage> {
  final TextEditingController searchController =
      TextEditingController();

  final List<String> recentSearches = [
    'Outfit aesthetic',
    'Dekorasi kamar',
    'Inspirasi bunga',
    'Minimalist room',
  ];

  final List<String> popularSearches = [
    'Outfit wanita',
    'Desain kamar tidur',
    'Korean style',
    'Ide dekorasi',
    'Resep makanan',
  ];

  @override
  void dispose() {
    searchController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        backgroundColor: Colors.white,
        elevation: 0,
        title: const Text(
          'Pencarian',
          style: TextStyle(
            color: Colors.black,
            fontWeight: FontWeight.bold,
          ),
        ),
      ),
      body: ListView(
        padding: const EdgeInsets.all(16),
        children: [
          TextField(
            controller: searchController,
            autofocus: true,
            decoration: InputDecoration(
              hintText: 'Cari ide yang kamu suka',
              prefixIcon: const Icon(Icons.search),
              suffixIcon: IconButton(
                icon: const Icon(Icons.close),
                onPressed: () {
                  searchController.clear();
                  setState(() {});
                },
              ),
              filled: true,
              fillColor: Colors.grey.shade100,
              border: OutlineInputBorder(
                borderRadius: BorderRadius.circular(25),
                borderSide: BorderSide.none,
              ),
            ),
            onSubmitted: (value) {
  final keyword = value.trim();

  if (keyword.isNotEmpty) {
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: Text('Mencari: $keyword'),
      ),
    );
  }
},
          ),
          const SizedBox(height: 24),
          const Text(
            'Pencarian terbaru',
            style: TextStyle(
              fontSize: 18,
              fontWeight: FontWeight.bold,
            ),
          ),
          const SizedBox(height: 10),
          ...recentSearches.map(
            (search) => ListTile(
              contentPadding: EdgeInsets.zero,
              leading: const Icon(Icons.history),
              title: Text(search),
              trailing: IconButton(
                icon: const Icon(Icons.north_west),
                onPressed: () {
                  searchController.text = search;
                  setState(() {});
                },
              ),
              onTap: () {
                searchController.text = search;
                setState(() {});
              },
            ),
          ),
          const SizedBox(height: 18),
          const Text(
            'Inspirasi populer',
            style: TextStyle(
              fontSize: 18,
              fontWeight: FontWeight.bold,
            ),
          ),
          const SizedBox(height: 12),
          ...popularSearches.map(
            (search) => ListTile(
              contentPadding: EdgeInsets.zero,
              leading: const Icon(Icons.trending_up),
              title: Text(search),
              trailing: const Icon(
                Icons.north_west,
                size: 20,
              ),
              onTap: () {
                searchController.text = search;
                setState(() {});
              },
            ),
          ),
        ],
      ),
    );
  }
}
