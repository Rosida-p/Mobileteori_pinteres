import 'package:flutter/foundation.dart';

class SavedPin {
  final String image;
  final String title;
  final String description;
  final String category;

  const SavedPin({
    required this.image,
    required this.title,
    required this.description,
    required this.category,
  });
}

class SavedPins {
  // Daftar pin yang disimpan. Halaman yang mendengarkan akan otomatis refresh.
  static final ValueNotifier<List<SavedPin>> notifier =
      ValueNotifier<List<SavedPin>>([]);

  static bool isSaved(String image) {
    return notifier.value.any((p) => p.image == image);
  }

  // Kalau sudah tersimpan -> dihapus, kalau belum -> ditambahkan
  static void toggle(SavedPin pin) {
    final list = List<SavedPin>.from(notifier.value);
    final index = list.indexWhere((p) => p.image == pin.image);
    if (index >= 0) {
      list.removeAt(index);
    } else {
      list.insert(0, pin); // pin terbaru tampil paling atas
    }
    notifier.value = list;
  }
}
