import 'package:flutter/material.dart';

class HomePage extends StatelessWidget {
  const HomePage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFFF1F4FF),
      body: SafeArea(
        child: SingleChildScrollView(
          child: Column(
            children: [
              // Bagian atas
              Stack(
                children: [
                  Container(
                    margin: EdgeInsets.all(10),
                    padding: EdgeInsets.only(
                        left: 24, top: 70, right: 24, bottom: 24),
                    width: double.infinity,
                    decoration: BoxDecoration(
                      color: Color(0xFF3567F6),
                      borderRadius: BorderRadius.circular(16),
                    ),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        // Row Foto dan Teks
                        Row(
                          crossAxisAlignment: CrossAxisAlignment.center,
                          children: [
                            Stack(
                              children: [
                                CircleAvatar(
                                  radius: 40,
                                  backgroundImage: AssetImage('images/ccp.JPG'),
                                ),
                                Positioned(
                                  bottom: 0,
                                  right: 4,
                                  child: Container(
                                    padding: EdgeInsets.all(4),
                                    decoration: BoxDecoration(
                                      color: Colors.white,
                                      shape: BoxShape.circle,
                                    ),
                                    child: Icon(Icons.edit, size: 18),
                                  ),
                                ),
                              ],
                            ),
                            SizedBox(width: 12),
                            Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Text(
                                  'Cecep Saepul Barkah',
                                  style: TextStyle(
                                    fontWeight: FontWeight.bold,
                                    fontFamily: "Poppins",
                                    fontSize: 18,
                                    color: Colors.white,
                                  ),
                                ),
                                Text(
                                  'cecepsaepul094@gmail.com',
                                  style: TextStyle(
                                    color: Colors.white,
                                    fontFamily: "Poppins",
                                  ),
                                ),
                                Text(
                                  '+8801959867406',
                                  style: TextStyle(
                                    color: Colors.white,
                                    fontFamily: "Poppins",
                                  ),
                                ),
                              ],
                            ),
                          ],
                        ),

                        SizedBox(height: 20),

                        // Dua Kotak di bawah teks profil
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Expanded(
                              child: Container(
                                padding: EdgeInsets.all(12),
                                margin: EdgeInsets.only(right: 8),
                                decoration: BoxDecoration(
                                  color: Colors.white,
                                  borderRadius: BorderRadius.circular(12),
                                ),
                                child: Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    Icon(Icons.pets, color: Colors.blue),
                                    SizedBox(height: 4),
                                    Text("Jumlah Kambing",
                                        style: TextStyle(fontSize: 12)),
                                    Text("24 ekor",
                                        style: TextStyle(fontSize: 12)),
                                  ],
                                ),
                              ),
                            ),
                            Expanded(
                              child: Container(
                                padding: EdgeInsets.all(12),
                                margin: EdgeInsets.only(left: 8),
                                decoration: BoxDecoration(
                                  color: Colors.white,
                                  borderRadius: BorderRadius.circular(12),
                                ),
                                child: Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    Icon(Icons.bar_chart, color: Colors.green),
                                    SizedBox(height: 4),
                                    Text("Bagi hasil terakhir",
                                        style: TextStyle(fontSize: 12)),
                                    Text("12 ekor",
                                        style: TextStyle(fontSize: 12)),
                                  ],
                                ),
                              ),
                            ),
                          ],
                        ),
                      ],
                    ),
                  ),

                  // Icon notifikasi & pengaturan
                  Positioned(
                    top: 30,
                    left: 30,
                    child: PopupMenuButton<String>(
                      icon: Icon(Icons.notifications,
                          color: Colors.white, size: 32),
                      onSelected: (value) {
                        // Aksi ketika item dipilih
                        print("Kamu memilih: $value");
                      },
                      itemBuilder: (BuildContext context) => [
                        PopupMenuItem(
                          value: 'Pesan 1',
                          child: Text('Pesan Notifikasi 1'),
                        ),
                        PopupMenuItem(
                          value: 'Pesan 2',
                          child: Text('Pesan Notifikasi 2'),
                        ),
                        PopupMenuItem(
                          value: 'Pesan 3',
                          child: Text('Pesan Notifikasi 3'),
                        ),
                      ],
                    ),
                  ),

                  Positioned(
                    top: 30,
                    right: 30,
                    child: PopupMenuButton<String>(
                      icon: Icon(Icons.menu, color: Colors.white, size: 32),
                      onSelected: (value) {
                        // Aksi ketika item dipilih
                        print("Kamu memilih: $value");
                      },
                      itemBuilder: (BuildContext context) => [
                        PopupMenuItem(
                          value: 'logout',
                          child: Row(
                            children: [
                              Icon(Icons.settings, color: Colors.black),
                              SizedBox(width: 8), // Jarak antara ikon dan teks
                              Text('Pengaturan'),
                            ],
                          ),
                        ),
                        PopupMenuItem(
                          value: 'logout',
                          child: Row(
                            children: [
                              Icon(Icons.logout, color: Colors.black),
                              SizedBox(width: 8), // Jarak antara ikon dan teks
                              Text('Logout'),
                            ],
                          ),
                        ),
                      ],
                    ),
                  ),
                ],
              ),

              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 12),
                child: Container(
                  padding: const EdgeInsets.all(15),
                  decoration: BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.circular(12),
                  ),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        "Informasi Penting",
                        style: TextStyle(
                          fontSize: 18,
                          fontWeight: FontWeight.bold,
                          fontFamily: "Poppins",
                        ),
                      ),
                      SizedBox(height: 8),
                      Text(
                        "Berikut adalah kegiatan-kegiatan yang akan dilaksanakan di Desa Cimanggu. Dimohon untuk kehadirannya kepada semua pengelola agar tidak ketinggalan informasi penting.",
                        style: TextStyle(
                          fontSize: 10,
                          fontWeight: FontWeight.bold,
                          fontFamily: "Poppins",
                        ),
                      ),
                      SizedBox(height: 16),
                      // Scroll horizontal untuk kegiatan
                      SingleChildScrollView(
                        scrollDirection: Axis.horizontal,
                        child: Row(
                          children: [
                            _buildKegiatanCard(
                              title: "Kegiatan Penyuluhan Desa",
                              date: "Senin. 20 Juni 2025",
                              time: "08.00",
                              location: "Balai Desa Cimanggu",
                            ),
                            _buildKegiatanCard(
                              title: "Kegiatan Sosialisasi ",
                              date: "Selasa. 14 Juni 2025",
                              time: "08.00",
                              location: "Kantor Desa Cimanggu",
                            ),
                          ],
                        ),
                      ),
                      SizedBox(
                        height: 12,
                      ),
                      Text(
                        "lihat selengkapnya ",
                        style: TextStyle(
                            fontFamily: "poppins",
                            color: const Color.fromARGB(255, 34, 45, 211)),
                      )
                    ],
                  ),
                ),
              ),

              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 12),
                child: Container(
                  margin:
                      EdgeInsets.only(left: 0, top: 12, right: 0, bottom: 0),
                  padding: const EdgeInsets.all(15),
                  decoration: BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.circular(12),
                  ),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        "berita hangat lokal",
                        style: TextStyle(
                          fontSize: 18,
                          fontWeight: FontWeight.bold,
                          fontFamily: "Poppins",
                        ),
                      ),
                      SizedBox(height: 8),
                      Text(
                        "Berikut adalah berita berita lokal yang ada di cimanggu ",
                        style: TextStyle(
                          fontSize: 10,
                          fontWeight: FontWeight.bold,
                          fontFamily: "Poppins",
                        ),
                      ),
                      SizedBox(height: 16),
                      // Scroll horizontal untuk kegiatan
                      SingleChildScrollView(
                        scrollDirection: Axis.horizontal,
                        child: Row(
                          children: [
                            _buildKegiatanCard(
                              title: "Kegiatan Penyuluhan Desa",
                              date: "Senin. 20 Juni 2025",
                              time: "08.00",
                              location: "Balai Desa Cimanggu",
                            ),
                            _buildKegiatanCard(
                              title: "Kegiatan Sosialisasi ",
                              date: "Selasa. 14 Juni 2025",
                              time: "08.00",
                              location: "Kantor Desa Cimanggu",
                            ),
                          ],
                        ),
                      ),
                      Text(
                        "lihat selengkapnya ",
                        style: TextStyle(
                            fontFamily: "poppins",
                            color: const Color.fromARGB(255, 34, 45, 211)),
                      )
                    ],
                  ),
                ),
              ),

              // Bisa tambah konten lain di sini
            ],
          ),
        ),
      ),
    );
  }
}

Widget _buildKegiatanCard({
  required String title,
  required String date,
  required String time,
  required String location,
}) {
  return Container(
    width: 250,
    margin: const EdgeInsets.only(right: 12),
    padding: const EdgeInsets.all(15),
    decoration: BoxDecoration(
      color: Colors.white,
      borderRadius: BorderRadius.circular(12),
      border: Border.all(color: Colors.grey.shade300),
      boxShadow: [
        BoxShadow(
          color: Colors.black12,
          blurRadius: 4,
          offset: Offset(0, 2),
        ),
      ],
    ),
    child: Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          title,
          style: TextStyle(
            fontSize: 13,
            fontWeight: FontWeight.w800,
            fontFamily: "Poppins",
          ),
        ),
        SizedBox(height: 10),
        Row(
          children: [
            Icon(Icons.calendar_today, color: Colors.green, size: 20),
            SizedBox(width: 6),
            Text(
              date,
              style: TextStyle(
                fontFamily: "Poppins",
                fontWeight: FontWeight.w700,
                fontSize: 11,
              ),
            ),
          ],
        ),
        SizedBox(height: 2),
        Row(
          children: [
            Icon(Icons.access_time, color: Colors.blue, size: 20),
            SizedBox(width: 6),
            Text(
              time,
              style: TextStyle(
                fontFamily: "Poppins",
                fontWeight: FontWeight.w700,
                fontSize: 11,
              ),
            ),
          ],
        ),
        SizedBox(height: 2),
        Row(
          children: [
            Icon(Icons.location_on, color: Colors.green, size: 20),
            SizedBox(width: 6),
            Text(
              location,
              style: TextStyle(
                fontFamily: "Poppins",
                fontWeight: FontWeight.w700,
                fontSize: 11,
              ),
            ),
          ],
        ),
      ],
    ),
  );
}
