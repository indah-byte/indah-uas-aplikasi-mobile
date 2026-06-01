
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:provider/provider.dart';
import '../providers/journal_provider.dart';
import '../theme/app_theme.dart';

class AppDrawer extends StatelessWidget {
  final String currentRoute;
  
  const AppDrawer({super.key, required this.currentRoute});

  void _showSettingsDialog(BuildContext context) {
    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        backgroundColor: Theme.of(context).scaffoldBackgroundColor,
        title: Text(
          'Pengaturan',
          style: GoogleFonts.outfit(
            fontWeight: FontWeight.bold,
            color: Theme.of(context).textTheme.displayLarge?.color,
          ),
        ),
        content: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            Consumer<JournalProvider>(
              builder: (context, provider, child) {
                return ListTile(
                  leading: Icon(
                    provider.isDarkMode ? Icons.dark_mode_outlined : Icons.brightness_6_outlined,
                    color: Theme.of(context).primaryColor,
                  ),
                  title: Text('Mode Gelap', style: GoogleFonts.outfit(color: Theme.of(context).textTheme.bodyLarge?.color)),
                  trailing: Switch(
                    value: provider.isDarkMode,
                    onChanged: (val) {
                      provider.toggleTheme();
                    },
                    activeColor: Theme.of(context).primaryColor,
                  ),
                  onTap: () {
                    provider.toggleTheme();
                  },
                );
              },
            ),
            ListTile(
              leading: Icon(Icons.info_outline, color: Theme.of(context).primaryColor),
              title: Text('Tentang Aplikasi', style: GoogleFonts.outfit(color: Theme.of(context).textTheme.bodyLarge?.color)),
              onTap: () {
                Navigator.pop(context);
                showAboutDialog(
                  context: context,
                  applicationName: 'Sanctuary',
                  applicationVersion: '1.0.0',
                  applicationLegalese: '© 2026 Sanctuary',
                  applicationIcon: Container(
                    width: 50,
                    height: 50,
                    decoration: BoxDecoration(
                      color: Theme.of(context).primaryColor,
                      shape: BoxShape.circle,
                    ),
                    child: const Icon(Icons.eco, color: Colors.white),
                  ),
                  children: [
                    const SizedBox(height: 16),
                    Text(
                      'Sanctuary adalah aplikasi jurnal minimalis untuk menuangkan pikiran Anda dan menemukan ketenangan dalam menulis.',
                      style: GoogleFonts.outfit(),
                    ),
                  ],
                );
              },
            ),
          ],
        ),
        actions: [
          TextButton(
            onPressed: () => Navigator.pop(context),
            child: Text('Tutup', style: TextStyle(color: Theme.of(context).primaryColor)),
          ),
        ],
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Drawer(
      backgroundColor: AppTheme.backgroundColor,
      child: Column(
        children: [
          _buildHeader(context),
          const SizedBox(height: 10),
          Expanded(
            child: ListView(
              padding: EdgeInsets.zero,
              children: [
                _buildDrawerItem(
                  icon: Icons.book_outlined,
                  title: 'Jurnal Saya',
                  onTap: () {
                    Navigator.pop(context);
                    if (currentRoute != 'home') {
                      Navigator.pushNamedAndRemoveUntil(context, '/home', (route) => false);
                    }
                  },
                  isSelected: currentRoute == 'home',
                ),
                _buildDrawerItem(
                  icon: Icons.settings_outlined,
                  title: 'Pengaturan',
                  onTap: () {
                    Navigator.pop(context);
                    _showSettingsDialog(context);
                  },
                  isSelected: false,
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
      decoration: const BoxDecoration(
        color: AppTheme.backgroundColor,
        border: Border(bottom: BorderSide(color: Color(0xFFE0E0E0))),
      ),
      child: Row(
        children: [
          Container(
            width: 60,
            height: 60,
            decoration: const BoxDecoration(
              color: AppTheme.primaryColor,
              shape: BoxShape.circle,
            ),
            child: const Icon(Icons.eco, color: Colors.white, size: 30),
          ),
          const SizedBox(width: 16),
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                'Sanctuary',
                style: GoogleFonts.outfit(
                  fontSize: 18,
                  fontWeight: FontWeight.bold,
                  color: AppTheme.textColor,
                ),
              ),
              Text(
                'Journaling App',
                style: GoogleFonts.outfit(
                  fontSize: 12,
                  color: AppTheme.subtitleColor,
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
          color: isSelected ? AppTheme.primaryColor : AppTheme.subtitleColor,
        ),
        title: Text(
          title,
          style: GoogleFonts.outfit(
            color: isSelected ? AppTheme.primaryColor : AppTheme.textColor,
            fontWeight: isSelected ? FontWeight.bold : FontWeight.normal,
            fontSize: 14,
          ),
        ),
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
        tileColor: isSelected ? AppTheme.primaryColor.withOpacity(0.1) : null,
        onTap: onTap,
      ),
    );
  }
}
