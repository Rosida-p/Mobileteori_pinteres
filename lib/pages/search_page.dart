import 'dart:async';
import 'dart:math';

import 'package:flutter/material.dart';

import 'search_detail_page.dart';

class _HeroItem {
  final String label;
  final String title;
  final String source;
  final String image;

  const _HeroItem({
    required this.label,
    required this.title,
    required this.source,
    required this.image,
  });
}

class _IdeaSection {
  final String label;
  final String title;
  final List<String> images;

  const _IdeaSection({
    required this.label,
    required this.title,
    required this.images,
  });
}

class SearchPage extends StatefulWidget {
  const SearchPage({super.key});

  // ===== Data banner atas (ganti gambar/teks sesuai keinginan) =====
  static const List<_HeroItem> heroes = [
    _HeroItem(
      label: 'Ide segar untuk semua',
      title: 'Koleksi Makanan Favorit',
      source: 'Kuliner',
      image: 'assets/images/makanan.jpg',
    ),
    _HeroItem(
      label: 'Lucu dan menggemaskan',
      title: 'Hewan Peliharaan Imut',
      source: 'Hewan',
      image: 'assets/images/kucing.jpg',
    ),
    _HeroItem(
      label: 'Tampil beda hari ini',
      title: 'Inspirasi Bunga Cantik',
      source: 'Bunga',
      image: 'assets/images/bunga.jpg',
    ),
    _HeroItem(
      label: 'Temukan barang unik',
      title: 'Barang Pilihan Toko',
      source: 'Belanja',
      image: 'assets/images/toko barang.jpg',
    ),
  ];

  // ===== Data section (ganti nama file sesuai aset di assets/images/) =====
  static const List<_IdeaSection> sections = [
    _IdeaSection(
      label: 'Populer di Pinterest',
      title: 'Gambar aesthetic',
      images: [
        'assets/images/bunga.jpg',
        'assets/images/makanan.jpg',
        'assets/images/kucing.jpg',
        'assets/images/toko barang.jpg',
      ],
    ),
    _IdeaSection(
      label: 'Populer di Pinterest',
      title: 'Pp lucu',
      images: [
        'assets/images/kucing.jpg',
        'assets/images/toko barang.jpg',
        'assets/images/bunga.jpg',
        'assets/images/makanan.jpg',
      ],
    ),
    _IdeaSection(
      label: 'Ide-ide buat Anda',
      title: 'Makanan',
      images: [
        'assets/images/makanan.jpg',
        'assets/images/bunga.jpg',
        'assets/images/kucing.jpg',
        'assets/images/toko barang.jpg',
      ],
    ),
    _IdeaSection(
      label: 'Ide-ide buat Anda',
      title: 'Barang unik',
      images: [
        'assets/images/toko barang.jpg',
        'assets/images/kucing.jpg',
        'assets/images/bunga.jpg',
        'assets/images/makanan.jpg',
      ],
    ),
  ];

  @override
  State<SearchPage> createState() => _SearchPageState();
}

class _SearchPageState extends State<SearchPage> {
  final PageController _pageController = PageController();
  Timer? _timer;
  int _page = 0;

  @override
  void initState() {
    super.initState();
    _timer = Timer.periodic(const Duration(seconds: 4), (_) {
      if (!_pageController.hasClients) return;
      final next = (_page + 1) % SearchPage.heroes.length;
      _pageController.animateToPage(
        next,
        duration: const Duration(milliseconds: 450),
        curve: Curves.easeInOut,
      );
    });
  }

  @override
  void dispose() {
    _timer?.cancel();
    _pageController.dispose();
    super.dispose();
  }

  void _openSearch({String? query}) {
    Navigator.push(
      context,
      MaterialPageRoute(
        builder: (context) => SearchDetailPage(initialQuery: query),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;
    final topInset = MediaQuery.of(context).padding.top;
    final heroHeight = min(size.height * 0.47, 460.0);

    return Scaffold(
      backgroundColor: Colors.white,
      body: ListView(
        padding: const EdgeInsets.only(bottom: 120),
        children: [
          // ===== Banner + search bar melayang =====
          SizedBox(
            height: heroHeight,
            child: Stack(
              children: [
                PageView.builder(
                  controller: _pageController,
                  itemCount: SearchPage.heroes.length,
                  onPageChanged: (i) => setState(() => _page = i),
                  itemBuilder: (context, index) {
                    return _HeroSlide(item: SearchPage.heroes[index]);
                  },
                ),
                Positioned(
                  top: topInset + 8,
                  left: 8,
                  right: 8,
                  child: _buildSearchBar(),
                ),
              ],
            ),
          ),

          // ===== Titik indikator =====
          Padding(
            padding: const EdgeInsets.symmetric(vertical: 14),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: List.generate(SearchPage.heroes.length, (i) {
                final active = i == _page;
                return AnimatedContainer(
                  duration: const Duration(milliseconds: 250),
                  margin: const EdgeInsets.symmetric(horizontal: 4),
                  width: active ? 10 : 8,
                  height: active ? 10 : 8,
                  decoration: BoxDecoration(
                    shape: BoxShape.circle,
                    color: active ? Colors.black : Colors.grey.shade400,
                  ),
                );
              }),
            ),
          ),

          // ===== Section gambar =====
          ...SearchPage.sections.map(
            (section) => _SectionBlock(
              section: section,
              onSearchTap: () => _openSearch(query: section.title),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildSearchBar() {
    return GestureDetector(
      onTap: () => _openSearch(),
      child: Container(
        height: 52,
        padding: const EdgeInsets.symmetric(horizontal: 16),
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(28),
          border: Border.all(color: Colors.grey.shade400, width: 1.2),
        ),
        child: Row(
          children: [
            const Icon(Icons.search, size: 26, color: Colors.black87),
            const SizedBox(width: 12),
            Expanded(
              child: Text(
                'Cari ide',
                style: TextStyle(fontSize: 17, color: Colors.grey.shade600),
              ),
            ),
            GestureDetector(
              onTap: () {
                ScaffoldMessenger.of(context).showSnackBar(
                  const SnackBar(
                    content: Text('Pencarian lewat kamera belum tersedia'),
                  ),
                );
              },
              child: const Icon(
                Icons.photo_camera_outlined,
                size: 26,
                color: Colors.black87,
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class _HeroSlide extends StatelessWidget {
  final _HeroItem item;

  const _HeroSlide({required this.item});

  @override
  Widget build(BuildContext context) {
    return Stack(
      fit: StackFit.expand,
      children: [
        Image.asset(
          item.image,
          fit: BoxFit.cover,
          errorBuilder: (context, error, stackTrace) {
            return Container(
              color: Colors.grey.shade300,
              child: const Center(child: Icon(Icons.image_not_supported)),
            );
          },
        ),
        // Gradasi gelap di bawah supaya teks terbaca
        const DecoratedBox(
          decoration: BoxDecoration(
            gradient: LinearGradient(
              begin: Alignment.topCenter,
              end: Alignment.bottomCenter,
              colors: [Colors.transparent, Colors.transparent, Colors.black87],
              stops: [0.0, 0.5, 1.0],
            ),
          ),
        ),
        Positioned(
          left: 16,
          right: 16,
          bottom: 20,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            mainAxisSize: MainAxisSize.min,
            children: [
              Text(
                item.label,
                style: const TextStyle(color: Colors.white, fontSize: 16),
              ),
              const SizedBox(height: 4),
              Text(
                item.title,
                maxLines: 2,
                overflow: TextOverflow.ellipsis,
                style: const TextStyle(
                  color: Colors.white,
                  fontSize: 30,
                  fontWeight: FontWeight.w800,
                  height: 1.15,
                ),
              ),
              const SizedBox(height: 10),
              Row(
                children: [
                  Container(
                    width: 28,
                    height: 28,
                    decoration: const BoxDecoration(
                      color: Color(0xFFE60023),
                      shape: BoxShape.circle,
                    ),
                    alignment: Alignment.center,
                    child: const Text(
                      'P',
                      style: TextStyle(
                        color: Colors.white,
                        fontWeight: FontWeight.bold,
                        fontSize: 16,
                      ),
                    ),
                  ),
                  const SizedBox(width: 8),
                  Text(
                    item.source,
                    style: const TextStyle(
                      color: Colors.white,
                      fontSize: 15,
                      fontWeight: FontWeight.w700,
                    ),
                  ),
                ],
              ),
            ],
          ),
        ),
      ],
    );
  }
}

class _SectionBlock extends StatelessWidget {
  final _IdeaSection section;
  final VoidCallback onSearchTap;

  const _SectionBlock({required this.section, required this.onSearchTap});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 22),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 14),
            child: Row(
              children: [
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        section.label,
                        style: const TextStyle(
                          fontSize: 13.5,
                          color: Colors.black87,
                        ),
                      ),
                      const SizedBox(height: 2),
                      Text(
                        section.title,
                        maxLines: 1,
                        overflow: TextOverflow.ellipsis,
                        style: const TextStyle(
                          fontSize: 22,
                          fontWeight: FontWeight.w800,
                          color: Colors.black,
                        ),
                      ),
                    ],
                  ),
                ),
                const SizedBox(width: 12),
                InkWell(
                  onTap: onSearchTap,
                  borderRadius: BorderRadius.circular(14),
                  child: Container(
                    width: 48,
                    height: 48,
                    decoration: BoxDecoration(
                      color: Colors.grey.shade200,
                      borderRadius: BorderRadius.circular(14),
                    ),
                    child: const Icon(Icons.search, color: Colors.black87),
                  ),
                ),
              ],
            ),
          ),
          const SizedBox(height: 12),
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 4),
            child: ClipRRect(
              borderRadius: BorderRadius.circular(20),
              child: SizedBox(
                height: 210,
                child: Row(
                  children: section.images
                      .map(
                        (path) => Expanded(
                          child: GestureDetector(
                            onTap: onSearchTap,
                            child: Image.asset(
                              path,
                              height: 210,
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
                      )
                      .toList(),
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
