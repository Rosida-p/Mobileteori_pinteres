import 'package:flutter/material.dart';
import 'search_detail_page.dart';

class SearchPage extends StatelessWidget {
  const SearchPage({super.key});

  final List<Map<String, String>> ideas = const [
    {'image': 'assets/images/makanan.jpg', 'title': 'Makanan'},
    {'image': 'assets/images/kucing.jpg', 'title': 'Hewan'},
    {'image': 'assets/images/toko barang.jpg', 'title': 'Barang'},
    {'image': 'assets/images/bunga.jpg', 'title': 'Bunga'},
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        backgroundColor: Colors.white,
        elevation: 0,
        title: const Text(
          'Jelajahi ide',
          style: TextStyle(
            color: Colors.black,
            fontWeight: FontWeight.bold,
            fontSize: 23,
          ),
        ),
      ),
      body: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          
Padding(
  padding: const EdgeInsets.symmetric(horizontal: 12),
  child: GestureDetector(
    onTap: () {
      Navigator.push(
        context,
        MaterialPageRoute(
          builder: (context) => const SearchDetailPage(),
        ),
      );
    },
    child: AbsorbPointer(
      child: TextField(
        decoration: InputDecoration(
          hintText: 'Cari ide yang kamu suka',
          prefixIcon: const Icon(Icons.search),
          filled: true,
          fillColor: Colors.grey.shade100,
          border: OutlineInputBorder(
            borderRadius: BorderRadius.circular(25),
            borderSide: BorderSide.none,
          ),
        ),
      ),
    ),
  ),
),

          const Padding(
            padding: EdgeInsets.fromLTRB(12, 20, 12, 10),
            child: Text(
              'Temukan inspirasi',
              style: TextStyle(
                fontSize: 19,
                fontWeight: FontWeight.bold,
              ),
            ),
          ),
          Expanded(
            child: GridView.builder(
              padding: const EdgeInsets.symmetric(horizontal: 8),
              itemCount: ideas.length,
              gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                crossAxisCount: 2,
                crossAxisSpacing: 10,
                mainAxisSpacing: 12,
                childAspectRatio: 0.68,
              ),
              itemBuilder: (context, index) {
                final item = ideas[index];
                return Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Expanded(
                      child: ClipRRect(
                        borderRadius: BorderRadius.circular(16),
                        child: Image.asset(
                          item['image']!,
                          width: double.infinity,
                          fit: BoxFit.cover,
                          errorBuilder: (context, error, stackTrace) {
                            return Container(
                              color: Colors.grey.shade200,
                              child: const Center(
                                child: Icon(Icons.image_not_supported),
                              ),
                            );
                          },
                        ),
                      ),
                    ),
                    const SizedBox(height: 5),
                    Text(
                      item['title']!,
                      maxLines: 1,
                      overflow: TextOverflow.ellipsis,
                      style: const TextStyle(
                        fontWeight: FontWeight.w600,
                        fontSize: 13,
                      ),
                    ),
                  ],
                );
              },
            ),
          ),
        ],
      ),
    );
  }
}