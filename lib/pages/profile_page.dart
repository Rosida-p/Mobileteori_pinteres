import 'package:flutter/material.dart';

import 'detail_page.dart';
import 'saved_pins.dart';

class ProfilePage extends StatelessWidget {
  const ProfilePage({super.key});

  // Jumlah kolom menyesuaikan lebar layar
  int columnsFor(double width) {
    if (width > 1000) return 4;
    if (width > 650) return 3;
    return 2;
  }

  @override
  Widget build(BuildContext context) {
    final width = MediaQuery.of(context).size.width;

    return Scaffold(
      backgroundColor: Colors.white,
      body: SafeArea(
        child: ListView(
          padding: const EdgeInsets.symmetric(horizontal: 16),
          children: [
            const SizedBox(height: 16),
            const Center(
              child: CircleAvatar(
                radius: 48,
                backgroundColor: Color(0xFFFCE4EC),
                backgroundImage: AssetImage('assets/images/profil.jpg'),
              ),
            ),

            const SizedBox(height: 12),
            const Center(
              child: Text(
                'Rosida',
                style: TextStyle(fontSize: 23, fontWeight: FontWeight.bold),
              ),
            ),

            const SizedBox(height: 5),
            Center(
              child: Text(
                '@rosida',
                style: TextStyle(color: Colors.grey.shade600, fontSize: 14),
              ),
            ),

            const SizedBox(height: 8),
            const Center(
              child: Text(
                'Kumpulan ide dan inspirasi favoritmu ',
                textAlign: TextAlign.center,
              ),
            ),

            const SizedBox(height: 18),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                OutlinedButton(
                  onPressed: () {},
                  style: OutlinedButton.styleFrom(
                    foregroundColor: Colors.black,
                    side: BorderSide.none,
                    backgroundColor: Colors.grey.shade200,
                  ),
                  child: const Text('Edit profil'),
                ),
                const SizedBox(width: 10),
                OutlinedButton(
                  onPressed: () {},
                  style: OutlinedButton.styleFrom(
                    foregroundColor: Colors.black,
                    side: BorderSide.none,
                    backgroundColor: Colors.grey.shade200,
                  ),
                  child: const Text('Bagikan profil'),
                ),
              ],
            ),

            const SizedBox(height: 25),
            const Center(
              child: Text(
                'Disimpan',
                style: TextStyle(fontSize: 17, fontWeight: FontWeight.bold),
              ),
            ),

            const SizedBox(height: 15),

            // Otomatis refresh setiap ada pin yang disimpan / dihapus
            ValueListenableBuilder<List<SavedPin>>(
              valueListenable: SavedPins.notifier,
              builder: (context, saved, _) {
                if (saved.isEmpty) {
                  return Padding(
                    padding: const EdgeInsets.symmetric(vertical: 40),
                    child: Column(
                      children: [
                        Icon(
                          Icons.bookmark_border,
                          size: 48,
                          color: Colors.grey.shade400,
                        ),
                        const SizedBox(height: 8),
                        Text(
                          'Belum ada pin yang disimpan',
                          style: TextStyle(color: Colors.grey.shade600),
                        ),
                      ],
                    ),
                  );
                }

                return GridView.builder(
                  shrinkWrap: true,
                  physics: const NeverScrollableScrollPhysics(),
                  itemCount: saved.length,
                  gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                    crossAxisCount: columnsFor(width),
                    crossAxisSpacing: 10,
                    mainAxisSpacing: 12,
                    childAspectRatio: 0.68,
                  ),
                  itemBuilder: (context, index) {
                    final pin = saved[index];
                    return GestureDetector(
                      onTap: () {
                        Navigator.push(
                          context,
                          MaterialPageRoute(
                            builder: (context) => DetailPage(
                              image: pin.image,
                              title: pin.title,
                              description: pin.description,
                              category: pin.category,
                            ),
                          ),
                        );
                      },
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Expanded(
                            child: ClipRRect(
                              borderRadius: BorderRadius.circular(16),
                              child: Image.asset(
                                pin.image,
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
                            pin.title,
                            maxLines: 1,
                            overflow: TextOverflow.ellipsis,
                            style: const TextStyle(
                              fontWeight: FontWeight.w600,
                              fontSize: 13,
                            ),
                          ),
                        ],
                      ),
                    );
                  },
                );
              },
            ),
            const SizedBox(height: 16),
          ],
        ),
      ),
    );
  }
}
