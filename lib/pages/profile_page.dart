import 'package:flutter/material.dart';

class ProfilePage extends StatelessWidget {
  const ProfilePage({super.key});

  final List<Map<String, String>> pins = const [
    {'image': 'assets/images/bunga.jpg', 'title': 'Bunga'},
    {'image': 'assets/images/kucing.jpg', 'title': 'Hewan'},
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: SafeArea(
        child: ListView(
          padding: const EdgeInsets.symmetric(horizontal: 16),
          children: [
            const SizedBox(height: 8),
            const Row(
              mainAxisAlignment: MainAxisAlignment.end,
            ),

            const SizedBox(height: 8),
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
            GridView.builder(
              shrinkWrap: true,
              physics: const NeverScrollableScrollPhysics(),
              itemCount: pins.length,
              gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                crossAxisCount: 2,
                crossAxisSpacing: 10,
                mainAxisSpacing: 12,
                childAspectRatio: 0.68,
              ),
              itemBuilder: (context, index) {
                final pin = pins[index];
                return Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Expanded(
                      child: ClipRRect(
                        borderRadius: BorderRadius.circular(16),
                        child: Image.asset(
                          pin['image']!,
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
                      pin['title']!,
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
            const SizedBox(height: 16),
          ],
        ),
      ),
    );
  }
}