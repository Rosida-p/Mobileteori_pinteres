import 'package:flutter/material.dart';

class SearchDetailPage extends StatefulWidget {
  final String? initialQuery;

  const SearchDetailPage({super.key, this.initialQuery});

  @override
  State<SearchDetailPage> createState() => _SearchDetailPageState();
}

class _SearchDetailPageState extends State<SearchDetailPage> {
  final TextEditingController _controller = TextEditingController();
  final FocusNode _focusNode = FocusNode();

  // Ganti dengan nama aset yang ada di assets/images/
  static const List<String> _assets = [
    'assets/images/makanan.jpg',
    'assets/images/kucing.jpg',
    'assets/images/toko barang.jpg',
    'assets/images/bunga.jpg',
  ];

  // Tinggi gambar hasil pencarian (variasi ala Pinterest)
  static const List<double> _heights = [220, 280, 190, 260, 240, 200, 270, 230];

  // Kata kunci yang dipakai untuk saran saat mengetik
  static const List<String> _allKeywords = [
    'tulisan papan tulis',
    'poster film netflix',
    'gambar tema landscape 16:9',
    'gambar tema',
    'background',
    'background estetik',
    'roda gigi',
    'ilustrasi penjualan',
    'drama korea',
    'dekorasi kamar',
    'inspirasi bunga',
    'makanan enak',
    'hewan lucu',
    'outfit aesthetic',
  ];

  final List<String> _recent = [
    'tulisan papan tulis',
    'poster film netflix',
    'gambar tema landscape 16:9',
    'gambar tema',
    'background',
    'roda gigi',
    'ilustrasi penjualan',
  ];

  bool _submitted = false;
  String _activeQuery = '';

  @override
  void initState() {
    super.initState();
    final q = widget.initialQuery;
    if (q != null && q.trim().isNotEmpty) {
      _controller.text = q;
      _submitted = true;
      _activeQuery = q.trim();
    }
  }

  @override
  void dispose() {
    _controller.dispose();
    _focusNode.dispose();
    super.dispose();
  }

  String _imageFor(String keyword) {
    return _assets[keyword.hashCode.abs() % _assets.length];
  }

  void _submit(String value) {
    final keyword = value.trim();
    if (keyword.isEmpty) return;
    setState(() {
      _controller.text = keyword;
      _controller.selection = TextSelection.collapsed(offset: keyword.length);
      _submitted = true;
      _activeQuery = keyword;
      _recent.remove(keyword);
      _recent.insert(0, keyword);
    });
    _focusNode.unfocus();
  }

  Widget _buildImage(String path, {double? height, double? width}) {
    return Image.asset(
      path,
      height: height,
      width: width,
      fit: BoxFit.cover,
      errorBuilder: (context, error, stackTrace) {
        return Container(
          height: height,
          width: width,
          color: Colors.grey.shade200,
          child: const Center(child: Icon(Icons.image_not_supported)),
        );
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: SafeArea(
        child: Column(
          children: [
            _buildSearchBar(),
            Expanded(child: _buildBody()),
          ],
        ),
      ),
    );
  }

  Widget _buildSearchBar() {
    return Padding(
      padding: const EdgeInsets.fromLTRB(8, 8, 8, 8),
      child: Row(
        children: [
          Expanded(
            child: SizedBox(
              height: 52,
              child: TextField(
                controller: _controller,
                focusNode: _focusNode,
                autofocus: widget.initialQuery == null,
                textInputAction: TextInputAction.search,
                style: const TextStyle(fontSize: 17),
                onChanged: (_) => setState(() => _submitted = false),
                onSubmitted: _submit,
                decoration: InputDecoration(
                  hintText: 'Cari ide',
                  hintStyle: TextStyle(
                    fontSize: 17,
                    color: Colors.grey.shade600,
                  ),
                  contentPadding: const EdgeInsets.symmetric(horizontal: 18),
                  suffixIcon: const Icon(
                    Icons.photo_camera_outlined,
                    color: Colors.black87,
                  ),
                  enabledBorder: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(28),
                    borderSide: BorderSide(
                      color: Colors.grey.shade600,
                      width: 1.2,
                    ),
                  ),
                  focusedBorder: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(28),
                    borderSide: const BorderSide(
                      color: Colors.black87,
                      width: 1.8,
                    ),
                  ),
                ),
              ),
            ),
          ),
          TextButton(
            onPressed: () => Navigator.pop(context),
            child: const Text(
              'Batal',
              style: TextStyle(
                color: Colors.black,
                fontSize: 17,
                fontWeight: FontWeight.w500,
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildBody() {
    if (_submitted) return _buildResults();
    if (_controller.text.trim().isEmpty) return _buildRecent();
    return _buildSuggestions();
  }

  // Daftar pencarian terbaru
  Widget _buildRecent() {
    if (_recent.isEmpty) {
      return const Center(child: Text('Belum ada pencarian'));
    }
    return ListView.builder(
      padding: const EdgeInsets.fromLTRB(16, 8, 8, 120),
      itemCount: _recent.length,
      itemBuilder: (context, index) {
        final keyword = _recent[index];
        return InkWell(
          onTap: () => _submit(keyword),
          child: Padding(
            padding: const EdgeInsets.symmetric(vertical: 8),
            child: Row(
              children: [
                ClipRRect(
                  borderRadius: BorderRadius.circular(18),
                  child: _buildImage(_imageFor(keyword), height: 76, width: 76),
                ),
                const SizedBox(width: 20),
                Expanded(
                  child: Text(
                    keyword,
                    style: const TextStyle(
                      fontSize: 20,
                      fontWeight: FontWeight.w500,
                    ),
                  ),
                ),
                IconButton(
                  icon: const Icon(Icons.close, color: Colors.black54),
                  onPressed: () => setState(() => _recent.removeAt(index)),
                ),
              ],
            ),
          ),
        );
      },
    );
  }

  // Saran saat mengetik
  Widget _buildSuggestions() {
    final text = _controller.text.trim().toLowerCase();
    final suggestions = _allKeywords
        .where((k) => k.toLowerCase().contains(text))
        .toList();

    return ListView(
      padding: const EdgeInsets.fromLTRB(8, 4, 8, 120),
      children: [
        // Selalu tampilkan teks yang sedang diketik sebagai opsi pertama
        ListTile(
          leading: const Icon(Icons.search),
          title: Text(
            _controller.text.trim(),
            style: const TextStyle(fontSize: 18, fontWeight: FontWeight.w600),
          ),
          onTap: () => _submit(_controller.text),
        ),
        ...suggestions.map(
          (s) => ListTile(
            leading: const Icon(Icons.search, color: Colors.black54),
            title: Text(s, style: const TextStyle(fontSize: 18)),
            trailing: const Icon(Icons.north_west, size: 20),
            onTap: () => _submit(s),
          ),
        ),
      ],
    );
  }

  // Hasil pencarian: grid 2 kolom ala Pinterest
  Widget _buildResults() {
    const int total = 12;
    final left = <Widget>[];
    final right = <Widget>[];

    for (int i = 0; i < total; i++) {
      final card = Padding(
        padding: const EdgeInsets.only(bottom: 8),
        child: ClipRRect(
          borderRadius: BorderRadius.circular(16),
          child: _buildImage(
            _assets[(i + _activeQuery.length) % _assets.length],
            height: _heights[i % _heights.length],
            width: double.infinity,
          ),
        ),
      );
      if (i.isEven) {
        left.add(card);
      } else {
        right.add(card);
      }
    }

    return SingleChildScrollView(
      padding: const EdgeInsets.fromLTRB(8, 4, 8, 120),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Padding(
            padding: const EdgeInsets.fromLTRB(4, 4, 4, 12),
            child: Text(
              'Hasil untuk "$_activeQuery"',
              style: const TextStyle(fontSize: 18, fontWeight: FontWeight.w700),
            ),
          ),
          Row(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Expanded(child: Column(children: left)),
              const SizedBox(width: 8),
              Expanded(child: Column(children: right)),
            ],
          ),
        ],
      ),
    );
  }
}
