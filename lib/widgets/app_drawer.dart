import 'dart:io';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import '../theme/app_theme.dart';
import '../screens/profile_screen.dart';

class AppDrawer extends StatelessWidget {
  final String currentRoute;
  
  const AppDrawer({super.key, required this.currentRoute});

  @override
  Widget build(BuildContext context) {
    return Drawer(
      backgroundColor: const Color(0xFF0F0F0F),
      child: Column(
        children: [
          _buildHeader(context),
          const SizedBox(height: 10),
          Expanded(
            child: ListView(
              padding: EdgeInsets.zero,
              children: [
                _buildDrawerItem(
                  icon: Icons.directions_car_outlined,
                  title: 'GARAGE',
                  onTap: () {
                    Navigator.pop(context);
                    if (currentRoute != 'home') {
                      Navigator.pushNamedAndRemoveUntil(context, '/', (route) => false);
                    }
                  },
                  isSelected: currentRoute == 'home',
                ),
                _buildDrawerItem(
                  icon: Icons.person_outline,
                  title: 'OPERATOR PROFILE',
                  onTap: () {
                    Navigator.pop(context);
                    if (currentRoute != 'profile') {
                      Navigator.push(
                        context,
                        MaterialPageRoute(builder: (context) => const ProfileScreen()),
                      );
                    }
                  },
                  isSelected: currentRoute == 'profile',
                ),
                _buildDrawerItem(
                  icon: Icons.settings_outlined,
                  title: 'SYSTEM SETTINGS',
                  onTap: () {
                    Navigator.pop(context);
                  },
                  isSelected: false,
                ),
              ],
            ),
          ),
          const Divider(height: 1, color: Colors.white10),
          _buildLogoutButton(context),
        ],
      ),
    );
  }

  Widget _buildLogoutButton(BuildContext context) {
    return InkWell(
      onTap: () {
        Navigator.pop(context);
        showDialog(
          context: context,
          builder: (context) => AlertDialog(
            backgroundColor: const Color(0xFF1A1A1A),
            title: Text('TERMINATE SESSION', style: GoogleFonts.outfit(color: Colors.red, fontWeight: FontWeight.bold)),
            content: Text('Are you sure you want to disconnect from Gearhead?', style: GoogleFonts.outfit(color: Colors.white70)),
            actions: [
              TextButton(
                onPressed: () => Navigator.pop(context),
                child: Text('CANCEL', style: GoogleFonts.outfit(color: Colors.white54)),
              ),
              TextButton(
                onPressed: () {
                  Navigator.pop(context);
                  ScaffoldMessenger.of(context).showSnackBar(
                    const SnackBar(content: Text('Session terminated.')),
                  );
                },
                child: Text('LOGOUT', style: GoogleFonts.outfit(color: Colors.red, fontWeight: FontWeight.bold)),
              ),
            ],
          ),
        );
      },
      child: Padding(
        padding: const EdgeInsets.all(24.0),
        child: Row(
          children: [
            const Icon(Icons.logout, color: Colors.red, size: 20),
            const SizedBox(width: 12),
            Text(
              'LOGOUT',
              style: GoogleFonts.outfit(
                color: Colors.red,
                fontWeight: FontWeight.bold,
                letterSpacing: 1,
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildHeader(BuildContext context) {
    return Container(
      padding: const EdgeInsets.only(top: 60, left: 24, right: 24, bottom: 24),
      decoration: BoxDecoration(
        color: Colors.red.withOpacity(0.05),
        border: const Border(bottom: BorderSide(color: Colors.white10)),
      ),
      child: Row(
        children: [
          Container(
            padding: const EdgeInsets.all(2),
            decoration: BoxDecoration(
              shape: BoxShape.circle,
              border: Border.all(color: Colors.red, width: 2),
            ),
            child: CircleAvatar(
              radius: 30,
              backgroundColor: Colors.black,
              backgroundImage: FileImage(File(r'C:\Users\DELL\.gemini\antigravity\brain\a1ad88cd-e380-40ab-96eb-7991a69e426d\gearhead_profile_avatar_1778818045664.png')),
            ),
          ),
          const SizedBox(width: 16),
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                'MAYA ARISANTI',
                style: GoogleFonts.outfit(
                  fontSize: 18,
                  fontWeight: FontWeight.bold,
                  color: Colors.white,
                  letterSpacing: 1,
                ),
              ),
              Text(
                'MASTER MECHANIC',
                style: GoogleFonts.outfit(
                  fontSize: 10,
                  color: Colors.red,
                  fontWeight: FontWeight.bold,
                  letterSpacing: 2,
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }

  Widget _buildDrawerItem({
    required IconData icon,
    required String title,
    required VoidCallback onTap,
    bool isSelected = false,
  }) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 4),
      child: ListTile(
        leading: Icon(
          icon,
          color: isSelected ? Colors.red : Colors.white24,
        ),
        title: Text(
          title,
          style: GoogleFonts.outfit(
            color: isSelected ? Colors.white : Colors.white54,
            fontWeight: isSelected ? FontWeight.bold : FontWeight.normal,
            fontSize: 14,
            letterSpacing: 1,
          ),
        ),
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
        tileColor: isSelected ? Colors.red.withOpacity(0.1) : null,
        onTap: onTap,
      ),
    );
  }
}
