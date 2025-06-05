import 'package:flutter/material.dart';

class ProfileScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Color(0xFFF8F8F8),
      appBar: AppBar(
        backgroundColor: Colors.white,
        elevation: 0,
        centerTitle: true,
        title: Text(
          'My Profile',
          style: TextStyle(color: Colors.black, 
          fontWeight: FontWeight.w800,
          fontFamily: "Poppins"),
        ),
        leading: IconButton(
          icon: Icon(Icons.arrow_back, color: Colors.black),
          onPressed: () {},
        ),
      ),
      body: SingleChildScrollView(
        padding: EdgeInsets.all(16),
        child: Column(
          children: [
            // Profile Card
            Container(
              height: 280,
              padding: EdgeInsets.symmetric(vertical: 16),
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.circular(16),
              ),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  
                  Center(
                    child: Stack(
                      children: [
                        CircleAvatar(
                          radius: 40,
                          backgroundImage: AssetImage('images/user.png'),
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
                  ),
                  SizedBox(height: 12),
                  Text(
                    'Mehedi Hasan',
                    style: TextStyle(fontWeight: FontWeight.bold,fontFamily: "Poppins", fontSize: 18),
                  ),
                  Text(
                    'helloyouthmind@gmail.com',
                    style: TextStyle(color: Colors.grey[600],fontFamily: "Poppins"),
                  ),
                  Text(
                    '+8801959867406',
                    style: TextStyle(color: Colors.grey[600],fontFamily: "Poppins"),
                  ),
                ],
              ),
            ),
            SizedBox(height: 24),
            _buildOptionTile(Icons.person, 'Personal Info'),
            _buildOptionTile(Icons.account_balance, 'Bank & Cards'),
            _buildOptionTile(Icons.sync_alt, 'Transaction'),
            _buildOptionTile(Icons.settings, 'Settings'),
            _buildOptionTile(Icons.lock, 'Data Privacy'),
          ],
        ),
      ),
    );
  }

  Widget _buildOptionTile(IconData icon, String title, {Widget? trailing}) {
    return Container(
      margin: EdgeInsets.only(bottom: 12),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(16),
      ),
      child: ListTile(
        leading: CircleAvatar(
          backgroundColor: Colors.grey[200],
          child: Icon(icon, color: Colors.black87),
        ),
        title: Text(title),
        trailing: trailing ?? Icon(Icons.arrow_forward_ios, size: 16),
        onTap: () {},
      ),
    );
  }
}
