import 'package:flutter/material.dart';

import 'saved_pins.dart';

class DetailPage extends StatefulWidget {
  final String image;
  final String title;
  final String description;
  final String category;

  const DetailPage({
    super.key,
    required this.image,
    required this.title,
    required this.description,
    required this.category,
  });

  @override
  State<DetailPage> createState() => _DetailPageState();
}

class _DetailPageState extends State<DetailPage> {
  late bool isSaved;

  @override
  void initState() {
    super.initState();
    // Cek apakah pin ini sudah pernah disimpan sebelumnya
    isSaved = SavedPins.isSaved(widget.image);
  }

  void _toggleSave() {
    SavedPins.toggle(
      SavedPin(
        image: widget.image,
        title: widget.title,
        description: widget.description,
        category: widget.category,
      ),
    );
    setState(() {
      isSaved = SavedPins.isSaved(widget.image);
    });

    ScaffoldMessenger.of(context).hideCurrentSnackBar();
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: Text(isSaved ? 'Disimpan ke profil' : 'Dihapus dari simpanan'),
        duration: const Duration(seconds: 1),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        backgroundColor: Colors.white,
        elevation: 0,
        iconTheme: const IconThemeData(color: Colors.black),
        title: const Text(
          'Detail Pin',
          style: TextStyle(color: Colors.black, fontWeight: FontWeight.bold),
        ),
      ),
      body: ListView(
        padding: const EdgeInsets.all(16),
        children: [
          ClipRRect(
            borderRadius: BorderRadius.circular(20),
            child: Image.asset(
              widget.image,
              height: 350,
              width: double.infinity,
              fit: BoxFit.cover,
              errorBuilder: (context, error, stackTrace) {
                return Container(
                  height: 350,
                  color: Colors.grey.shade200,
                  child: const Center(
                    child: Icon(Icons.image_not_supported, size: 48),
                  ),
                );
              },
            ),
          ),
          const SizedBox(height: 16),
          Row(
            children: [
              Expanded(
                child: Text(
                  widget.title,
                  style: const TextStyle(
                    fontSize: 22,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ),
              ElevatedButton(
                onPressed: _toggleSave,
                style: ElevatedButton.styleFrom(
                  backgroundColor: isSaved
                      ? Colors.black
                      : const Color(0xFFE60023),
                  foregroundColor: Colors.white,
                ),
                child: Text(isSaved ? 'Tersimpan' : 'Simpan'),
              ),
            ],
          ),
          const SizedBox(height: 8),
          Align(
            alignment: Alignment.centerLeft,
            child: Chip(
              label: Text(widget.category),
              backgroundColor: const Color(0xFFF1E8EA),
              side: BorderSide.none,
            ),
          ),
          const SizedBox(height: 8),
          Text(
            widget.description,
            style: const TextStyle(
              fontSize: 15,
              color: Colors.black87,
              height: 1.5,
            ),
          ),
          const SizedBox(height: 20),
          const Row(
            children: [
              CircleAvatar(
                backgroundColor: Color(0xFFFCE4EC),
                child: Icon(Icons.person, color: Color(0xFFE60023)),
              ),
              SizedBox(width: 10),
              Text(
                'Pinterest User',
                style: TextStyle(fontWeight: FontWeight.w600),
              ),
            ],
          ),
        ],
      ),
    );
  }
}
