import 'package:flutter/material.dart';
import 'notification_page.dart';
import 'detail_page.dart';
import 'package:flutter_staggered_grid_view/flutter_staggered_grid_view.dart';

class Pin {
  final String image;
  final String title;
  final double height;

  const Pin(this.image, this.title, this.height);
}

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  static const Color red = Color(0xFFE60023);
  static const Color bg = Color(0xFFFFF9FA);

  static const List<String> categories = [
    'Semua',
    'Hewan',
    'Fashion',
    'Pemandangan',
    'Bunga',
  ];

  static const List<Pin> pins = [
    Pin('assets/images/kucing.jpg', 'Hewan', 200),
    Pin('assets/images/pemandangan.jpg', 'Pemandangan', 240),
    Pin('assets/images/kucing1.jpg', 'Hewan', 200),
    Pin('assets/images/baju.jpg', 'Fashion', 210),
    Pin('assets/images/bunga.jpg', 'Bunga', 250),
    Pin('assets/images/fashion 1.jpg', 'Fashion', 200),
    Pin('assets/images/bunga1.jpg', 'Bunga', 280),
    Pin('assets/images/pemandangan 1.jpg', 'Pemandangan', 240),
  ];

  String selected = 'Semua';

  // Index pin yang lolos filter kategori
  List<int> get visible => [
        for (var i = 0; i < pins.length; i++)
          if (selected == 'Semua' || pins[i].title == selected) i,
      ];

  // Jumlah kolom menyesuaikan lebar layar (browser lebar = lebih banyak kolom)
  int columnsFor(double width) {
    if (width > 1000) return 4;
    if (width > 650) return 3;
    return 2;
  }

  @override
  Widget build(BuildContext context) {
    final items = visible;
    final width = MediaQuery.of(context).size.width;

    return Scaffold(
      backgroundColor: bg,
      appBar: AppBar(
        backgroundColor: bg,
        elevation: 0,
        title: const Text(
          'Pinterest',
          style: TextStyle(
            color: red,
            fontSize: 27,
            fontWeight: FontWeight.bold,
          ),
        ),
        actions: [
          IconButton(
            icon: const Icon(
              Icons.notifications_none,
              color: Colors.black,
              size: 27,
            ),
            onPressed: () {
              Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (context) => const NotificationPage(),
                ),
              );
            },
          ),
          Padding(
            padding: const EdgeInsets.only(right: 16, left: 4),
            child: ClipOval(
              child: Image.asset(
                'assets/images/profil.jpg',
                width: 32,
                height: 32,
                fit: BoxFit.cover,
              ),
            ),
          ),
        ],
      ),
      body: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          // CHIP KATEGORI
          SizedBox(
            height: 48,
            child: ListView.separated(
              scrollDirection: Axis.horizontal,
              padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 6),
              itemCount: categories.length,
              separatorBuilder: (_, __) => const SizedBox(width: 8),
              itemBuilder: (context, i) {
                final cat = categories[i];
                final isSelected = cat == selected;
                return ChoiceChip(
                  label: Text(cat),
                  selected: isSelected,
                  showCheckmark: false,
                  selectedColor: red,
                  backgroundColor: const Color(0xFFF1E8EA),
                  side: BorderSide.none,
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(20),
                  ),
                  labelStyle: TextStyle(
                    color: isSelected ? Colors.white : const Color(0xFF292323),
                    fontWeight: FontWeight.w500,
                  ),
                  onSelected: (_) => setState(() => selected = cat),
                );
              },
            ),
          ),
          const SizedBox(height: 8),

          // GRID MASONRY
          Expanded(
            child: MasonryGridView.count(
              padding: const EdgeInsets.fromLTRB(10, 0, 10, 12),
              crossAxisCount: columnsFor(width),
              mainAxisSpacing: 10,
              crossAxisSpacing: 10,
              itemCount: items.length,
              itemBuilder: (context, i) {
                final index = items[i];
                final pin = pins[index];

                return GestureDetector(
                  onTap: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (context) => const DetailPage(),
                      ),
                    );
                  },
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      ClipRRect(
  borderRadius: BorderRadius.circular(16),
  child: Image.asset(
    pin.image,
    height: pin.height,
    width: double.infinity,
    fit: BoxFit.cover,
    errorBuilder: (context, error, stackTrace) {
      return Container(
        height: pin.height,
        color: Colors.grey.shade200,
        child: const Center(
          child: Icon(Icons.image_not_supported),
        ),
      );
    },
  ),
),
                    ],
                  ),
                );
              },
            ),
          ),
        ],
      ),
    );
  }
}