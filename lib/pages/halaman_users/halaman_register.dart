import 'package:flutter/material.dart';
import 'package:sabar_/pages/halaman_users/halaman_login.dart';

class RegisterScreen extends StatelessWidget {
  final TextEditingController namaController = TextEditingController();
  final TextEditingController nikController = TextEditingController();
  final TextEditingController usernameController = TextEditingController();
  final TextEditingController alamatController = TextEditingController();
  final TextEditingController nohpController = TextEditingController();
  final TextEditingController emailController = TextEditingController();
  final TextEditingController passwordController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: SafeArea(
        child: Center(
          child: SingleChildScrollView(
            padding: const EdgeInsets.symmetric(horizontal: 24.0),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Text(
                  'Daftar.',
                  textAlign: TextAlign.center,
                  style: TextStyle(
                    fontSize: 50,
                    fontWeight: FontWeight.bold,
                    fontFamily: "Poppins",
                    color: Colors.black,
                  ),
                ),
                SizedBox(height: 16),
                Text(
                  "Lengkapi data di bawah untuk mengajukan pengelolaan dan untuk membuat akun",
                  textAlign: TextAlign.center,
                  style: TextStyle(
                    fontSize: 15,
                    fontFamily: "Poppins",
                    fontWeight: FontWeight.w700,
                    color: Colors.black87,
                  ),
                ),
                SizedBox(height: 24),

                // Nama Asli
                _buildInputField('Nama Lengkap', Icons.person, namaController),

                // NIK
                _buildInputField('NIK', Icons.badge, nikController,
                    keyboardType: TextInputType.number),

                // Username
                _buildInputField(
                    'Username', Icons.account_circle, usernameController),

                // Alamat
                _buildInputField('Alamat', Icons.home, alamatController),

                // No HP
                _buildInputField('No HP', Icons.phone, nohpController,
                    keyboardType: TextInputType.phone),

                // Email
                _buildInputField('Email', Icons.email, emailController,
                    keyboardType: TextInputType.emailAddress),

                // Password
                _buildInputField('Password', Icons.lock, passwordController,
                    isPassword: true),

                SizedBox(height: 24),
                SizedBox(
                  width: 350,
                  child: ElevatedButton(
                    style: ElevatedButton.styleFrom(
                      backgroundColor: Colors.blue,
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(10),
                      ),
                      padding: EdgeInsets.symmetric(vertical: 16),
                    ),
                    onPressed: () {
                      // TODO: validasi & kirim data
                      Navigator.push(
                        context,
                        MaterialPageRoute(builder: (context) => LoginScreen()),
                      );
                    },
                    child: Text(
                      'Daftar',
                      style: TextStyle(
                        fontSize: 18,
                        color: Colors.white,
                        fontWeight: FontWeight.w700,
                        fontFamily: "Poppins",
                      ),
                    ),
                  ),
                ),
                SizedBox(height: 16),
                TextButton(
                  onPressed: () {
                    Navigator.pop(context); // Kembali ke login
                  },
                  child: Text(
                    'Sudah punya akun? Masuk',
                    style: TextStyle(
                      color: Colors.blue,
                      fontFamily: 'Poppins',
                    ),
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }

  Widget _buildInputField(
      String label, IconData icon, TextEditingController controller,
      {bool isPassword = false,
      TextInputType keyboardType = TextInputType.text}) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 16.0),
      child: TextField(
        controller: controller,
        obscureText: isPassword,
        keyboardType: keyboardType,
        decoration: InputDecoration(
          labelText: label,
          labelStyle: TextStyle(fontFamily: 'Poppins', fontSize: 14),
          border: OutlineInputBorder(borderRadius: BorderRadius.circular(10)),
          prefixIcon: Padding(
            padding: const EdgeInsets.only(left: 18.0, right: 8.0),
            child: Icon(icon),
          ),
        ),
      ),
    );
  }
}
