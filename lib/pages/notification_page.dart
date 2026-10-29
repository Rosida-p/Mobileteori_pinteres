
import 'package:flutter/material.dart';

class NotificationPage extends StatelessWidget {
  const NotificationPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        backgroundColor: Colors.white,
        title: const Text(
          'Notifikasi',
          style: TextStyle(
            fontWeight: FontWeight.bold,
            color: Colors.black,
          ),
        ),
      ),
      body: ListView(
        padding: const EdgeInsets.all(16),
        children: const [
          Text(
            'Hari ini',
            style: TextStyle(
              fontSize: 20,
              fontWeight: FontWeight.bold,
            ),
          ),
          SizedBox(height: 20),
          ListTile(
            leading: CircleAvatar(
              backgroundColor: Color(0xFFFCE4EC),
              child: Icon(
                Icons.favorite,
                color: Color(0xFFE60023),
              ),
            ),
            title: Text('Inspirasi baru untuk kamu'),
            subtitle: Text(
              'Temukan ide dekorasi yang sedang populer.',
            ),
            trailing: Icon(Icons.circle, size: 9,
                color: Color(0xFFE60023)),
          ),
          ListTile(
            leading: CircleAvatar(
              backgroundColor: Color(0xFFFCE4EC),
              child: Icon(
                Icons.person,
                color: Color(0xFFE60023),
              ),
            ),
            title: Text('Selamat datang!'),
            subtitle: Text(
              'Mulai jelajahi ide yang kamu sukai.',
            ),
          ),
          ListTile(
            leading: CircleAvatar(
              backgroundColor: Color(0xFFFCE4EC),
              child: Icon(
                Icons.bookmark,
                color: Color(0xFFE60023),
              ),
            ),
            title: Text('Simpan inspirasi favoritmu'),
            subtitle: Text(
              'Kumpulkan gambar yang menarik untukmu.',
            ),
          ),
        ],
      ),
    );
  }
}
