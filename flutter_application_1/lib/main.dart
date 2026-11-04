import 'package:flutter/material.dart'; // widget Material Design

void main() => runApp(const CityTourApp()); // titik masuk aplikasi

// ===== DATA: ganti sesuai tempat wisata kamu =====
// 4 foto potret (berdiri) untuk deretan geser kiri-kanan
const List<String> tourImages = [
  'https://picsum.photos/id/1018/400/600',
  'https://picsum.photos/id/1015/400/600',
  'https://picsum.photos/id/1039/400/600',
  'https://picsum.photos/id/1043/400/600',
];
//
// 1 foto besar di bagian paling bawah
const String bigImage = 'https://picsum.photos/id/1036/900/600';

// Deskripsi tempat
const String placeDescription =
    'Jelajahi sudut-sudut kota bersama kami: dari bangunan bersejarah, '
    'pasar tradisional, hingga pemandangan alam yang menenangkan. '
    'Setiap titik perhentian punya cerita yang siap kamu temukan, '
    'lengkap dengan kuliner khas yang menggugah selera. '
    'Cocok untuk liburan keluarga, teman, maupun perjalanan sendiri.';

class CityTourApp extends StatelessWidget {
  const CityTourApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'City Tour',
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(seedColor: Colors.deepPurple),
        useMaterial3: true,
      ),
      home: const CityTourScreen(),
    );
  }
}

class CityTourScreen extends StatelessWidget {
  const CityTourScreen({super.key});

  @override
  Widget build(BuildContext context) {
    // Lebar satu foto = sepertiga layar, supaya dalam satu tampilan ada 3 foto.
    // 32 = padding kiri-kanan 16, 8 = jarak antar foto.
    final screenWidth = MediaQuery.of(context).size.width;
    final itemWidth = (screenWidth - 32) / 3 - 8;
    final itemHeight = itemWidth * 1.5; // tinggi 1,5x lebar = foto potret

    return Scaffold(
      body: SafeArea(
        child: SingleChildScrollView(
          // agar layar bisa digulir ke bawah dan tidak overflow
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              // 1. Judul di pojok kanan atas
              const Padding(
                padding: EdgeInsets.fromLTRB(16, 12, 16, 16),
                child: SizedBox(
                  width: double.infinity,
                  child: Text(
                    'CITY TOUR',
                    textAlign: TextAlign.right, // rata kanan
                    style: TextStyle(
                      fontSize: 22,
                      fontWeight: FontWeight.bold,
                      letterSpacing: 2,
                      color: Colors.deepPurple,
                    ),
                  ),
                ),
              ),

              // 2. Deretan 4 foto potret, bisa digeser kiri-kanan
              SizedBox(
                height:
                    itemHeight, // ListView horizontal wajib punya tinggi pasti
                child: ListView.builder(
                  scrollDirection: Axis.horizontal,
                  padding: const EdgeInsets.symmetric(horizontal: 16),
                  itemCount: tourImages.length,
                  itemBuilder: (context, index) {
                    return Padding(
                      padding: const EdgeInsets.only(right: 8),
                      child: ClipRRect(
                        borderRadius: BorderRadius.circular(12),
                        child: Image.network(
                          tourImages[index],
                          width: itemWidth,
                          height: itemHeight,
                          fit: BoxFit.cover,
                          errorBuilder: (context, error, stackTrace) =>
                              _errorBox(itemWidth, itemHeight),
                        ),
                      ),
                    );
                  },
                ),
              ),

              // 3. Tulisan "Enjoy Your Experience"
              const SizedBox(height: 24),
              const Padding(
                padding: EdgeInsets.symmetric(horizontal: 16),
                child: Text(
                  'Enjoy Your Experience',
                  style: TextStyle(fontSize: 22, fontWeight: FontWeight.bold),
                ),
              ),

              // 4. Deskripsi tempat
              const SizedBox(height: 8),
              const Padding(
                padding: EdgeInsets.symmetric(horizontal: 16),
                child: Text(
                  placeDescription,
                  style: TextStyle(
                    fontSize: 14,
                    height: 1.5,
                    color: Colors.black87,
                  ),
                ),
              ),

              // 5. Foto besar di bagian paling bawah
              const SizedBox(height: 24),
              Padding(
                padding: const EdgeInsets.fromLTRB(16, 0, 16, 24),
                child: ClipRRect(
                  borderRadius: BorderRadius.circular(16),
                  child: Image.network(
                    bigImage,
                    width: double.infinity,
                    height: 220,
                    fit: BoxFit.cover,
                    errorBuilder: (context, error, stackTrace) =>
                        _errorBox(double.infinity, 220),
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  // Kotak abu-abu pengganti gambar jika gagal dimuat (misalnya offline).
  Widget _errorBox(double width, double height) {
    return Container(
      width: width,
      height: height,
      color: Colors.grey[300],
      child: const Icon(Icons.broken_image),
    );
  }
}
