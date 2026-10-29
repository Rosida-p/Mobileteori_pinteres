
import 'package:flutter/material.dart';

class DetailPage extends StatefulWidget {
  const DetailPage({super.key});

  @override
  State<DetailPage> createState() => _DetailPageState();
}

class _DetailPageState extends State<DetailPage> {
  bool isSaved = false;

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
          style: TextStyle(
            color: Colors.black,
            fontWeight: FontWeight.bold,
          ),
        ),
      ),
      body: ListView(
        padding: const EdgeInsets.all(16),
        children: [
          ClipRRect(
            borderRadius: BorderRadius.circular(20),
            child: Image.asset(
              'assets/images/bunga.jpg',
              height: 350,
              width: double.infinity,
              fit: BoxFit.cover,
            ),
          ),
          const SizedBox(height: 16),
          Row(
            children: [
              const Expanded(
                child: Text(
                  'Inspirasi Bunga Cantik',
                  style: TextStyle(
                    fontSize: 22,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ),
              ElevatedButton(
                onPressed: () {
                  setState(() {
                    isSaved = !isSaved;
                  });
                },
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
          const SizedBox(height: 10),
          const Text(
            'Temukan inspirasi bunga yang cantik untuk '
            'dekorasi dan memperindah ruanganmu.',
            style: TextStyle(
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
                child: Icon(
                  Icons.person,
                  color: Color(0xFFE60023),
                ),
              ),
              SizedBox(width: 10),
              Text(
                'Pinterest User',
                style: TextStyle(
                  fontWeight: FontWeight.w600,
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }
}
