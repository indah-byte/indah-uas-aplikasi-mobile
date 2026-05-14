import 'package:flutter/material.dart';
import '../theme/app_theme.dart';
import '../screens/profile_screen.dart';

class AppDrawer extends StatelessWidget {
  const AppDrawer({super.key});

  @override
  Widget build(BuildContext context) {
    return Drawer(
      backgroundColor: AppTheme.backgroundColor,
      child: Column(
        children: [
          _buildHeader(context),
          const SizedBox(height: 20),
          _buildDrawerItem(
            icon: Icons.home_outlined,
            title: 'Beranda',
            onTap: () => Navigator.pop(context),
            isSelected: true,
          ),
          const Divider(indent: 20, endIndent: 20, height: 40),
          _buildDrawerItem(
            icon: Icons.person_outline,
            title: 'Profil Saya',
            onTap: () {
              Navigator.pop(context);
              Navigator.push(
                context,
                MaterialPageRoute(builder: (context) => const ProfileScreen()),
              );
            },
          ),
          const Spacer(),
          Padding(
            padding: const EdgeInsets.all(24.0),
            child: Row(
              children: [
                const Icon(Icons.logout, color: Colors.redAccent, size: 20),
                const SizedBox(width: 12),
                Text(
                  'Keluar',
                  style: TextStyle(
                    color: Colors.redAccent.withOpacity(0.8),
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildHeader(BuildContext context) {
    return Container(
      padding: const EdgeInsets.only(top: 60, left: 24, right: 24, bottom: 24),
      color: AppTheme.primaryColor.withOpacity(0.05),
      child: Row(
        children: [
          CircleAvatar(
            radius: 30,
            backgroundColor: AppTheme.primaryColor.withOpacity(0.1),
            child: const Text('MA', style: TextStyle(color: AppTheme.primaryColor, fontWeight: FontWeight.bold)),
          ),
          const SizedBox(width: 16),
          const Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                'Maya Arisanti',
                style: TextStyle(
                  fontSize: 18,
                  fontWeight: FontWeight.bold,
                  color: AppTheme.primaryColor,
                ),
              ),
              Text(
                'Journal Member',
                style: TextStyle(
                  fontSize: 12,
                  color: Colors.grey,
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
          color: isSelected ? AppTheme.primaryColor : Colors.grey[600],
        ),
        title: Text(
          title,
          style: TextStyle(
            color: isSelected ? AppTheme.primaryColor : Colors.black87,
            fontWeight: isSelected ? FontWeight.bold : FontWeight.normal,
          ),
        ),
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
        tileColor: isSelected ? AppTheme.primaryColor.withOpacity(0.1) : null,
        onTap: onTap,
      ),
    );
  }
}
