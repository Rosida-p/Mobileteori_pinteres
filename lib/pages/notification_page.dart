import 'package:flutter/material.dart';

class NotificationPage extends StatelessWidget {
  const NotificationPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFFFFF9FA),
      appBar: AppBar(
        backgroundColor: const Color(0xFFFFF9FA),
        centerTitle: true,
        title: const Text(
          'Notifikasi',
          style: TextStyle(fontWeight: FontWeight.bold, color: Colors.black),
        ),
      ),
      body: Center(
        child: ConstrainedBox(
          constraints: const BoxConstraints(maxWidth: 600),
          child: ListView(
            padding: const EdgeInsets.all(16),
            children: const [
              Text(
                'Hari ini',
                style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
              ),
              SizedBox(height: 12),

              // Belum dibaca: latar merah muda + judul tebal
              Card(
                color: Colors.white,
                elevation: 0,
                child: ListTile(
                  leading: CircleAvatar(
                    radius: 26,
                    backgroundImage: AssetImage('assets/images/bunga.jpg'),
                  ),
                  title: Text('Bunga yang sangat indah'),

                  subtitle: Text(
                    'Temukan macam - macam bunga yang sangat bagus.',
                  ),
                  trailing: Text('2 jam lalu', style: TextStyle(fontSize: 11)),
                ),
              ),
              Card(
                color: Colors.white,
                elevation: 0,
                child: ListTile(
                  leading: CircleAvatar(
                    radius: 26,
                    backgroundImage: AssetImage('assets/images/kucing.jpg'),
                  ),
                  title: Text('Hewan yang sangat lucu'),
                  subtitle: Text('Lihat koleksi kucing lucu hari ini.'),
                  trailing: Text('5 jam lalu', style: TextStyle(fontSize: 11)),
                ),
              ),

              // Sudah dibaca: latar putih
              Card(
                color: Colors.white,
                elevation: 0,
                child: ListTile(
                  leading: CircleAvatar(
                    radius: 26,
                    backgroundColor: Color(0xFFFCE4EC),
                    child: Icon(Icons.person, color: Color(0xFFE60023)),
                  ),
                  title: Text('Selamat datang!'),
                  subtitle: Text('Mulai jelajahi ide yang kamu sukai.'),
                  trailing: Text('8 jam lalu', style: TextStyle(fontSize: 11)),
                ),
              ),

              SizedBox(height: 20),
              Text(
                'Kemarin',
                style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
              ),
              SizedBox(height: 12),

              Card(
                color: Colors.white,
                elevation: 0,
                child: ListTile(
                  leading: CircleAvatar(
                    radius: 26,
                    backgroundImage: AssetImage('assets/images/baju.jpg'),
                  ),
                  title: Text('Ide fashion untuk kamu'),
                  subtitle: Text('Temukan fashion yang lagi tren'),
                  trailing: Text('Kemarin', style: TextStyle(fontSize: 11)),
                ),
              ),
              Card(
                color: Colors.white,
                elevation: 0,
                child: ListTile(
                  leading: CircleAvatar(
                    radius: 26,
                    backgroundColor: Color(0xFFFCE4EC),
                    child: Icon(Icons.bookmark, color: Color(0xFFE60023)),
                  ),
                  title: Text('Simpan inspirasi favoritmu'),
                  subtitle: Text('Kumpulkan gambar yang menarik untukmu.'),
                  trailing: Text('Kemarin', style: TextStyle(fontSize: 11)),
                ),
              ),
              Card(
                color: Colors.white,
                elevation: 0,
                child: ListTile(
                  leading: CircleAvatar(
                    radius: 26,
                    backgroundImage: AssetImage(
                      'assets/images/pemandangan.jpg',
                    ),
                  ),
                  title: Text('Pemandangan indah untukmu'),
                  subtitle: Text('Jelajahi tempat-tempat yang menarik.'),
                  trailing: Text('Kemarin', style: TextStyle(fontSize: 11)),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
