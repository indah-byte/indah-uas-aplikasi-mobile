import 'dart:io';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'profile_screen.dart';
import '../widgets/app_drawer.dart';
import '../theme/app_theme.dart';

class JournalListScreen extends StatefulWidget {
  const JournalListScreen({super.key});

  @override
  State<JournalListScreen> createState() => _JournalListScreenState();
}

class _JournalListScreenState extends State<JournalListScreen> {
  int _selectedIndex = 0;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFF0F0F0F),
      drawer: const AppDrawer(currentRoute: 'home'),
      body: SafeArea(
        child: SingleChildScrollView(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              _buildHeader(),
              _buildActiveGarage(),
              _buildRecentServices(),
              const SizedBox(height: 100), // Space for bottom nav
            ],
          ),
        ),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {},
        backgroundColor: const Color(0xFFE53935),
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(30)),
        child: const Icon(Icons.add, color: Colors.white, size: 32),
      ),
      bottomNavigationBar: _buildBottomNav(),
    );
  }

  Widget _buildHeader() {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 20.0, vertical: 16.0),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Builder(
            builder: (context) => IconButton(
              icon: const Icon(Icons.menu, color: Colors.white, size: 28),
              onPressed: () => Scaffold.of(context).openDrawer(),
            ),
          ),
          Text(
            'GEARHEAD',
            style: GoogleFonts.outfit(
              fontSize: 24,
              fontWeight: FontWeight.bold,
              color: const Color(0xFFE53935),
              letterSpacing: 2,
            ),
          ),
          GestureDetector(
            onTap: () {
              Navigator.push(
                context,
                MaterialPageRoute(builder: (context) => const ProfileScreen()),
              );
            },
            child: Container(
              width: 45,
              height: 45,
              decoration: BoxDecoration(
                shape: BoxShape.circle,
                border: Border.all(color: const Color(0xFFE53935), width: 1.5),
                boxShadow: [
                  BoxShadow(
                    color: const Color(0xFFE53935).withOpacity(0.3),
                    blurRadius: 10,
                  ),
                ],
              ),
              child: ClipOval(
                child: Image.file(
                  File(r'C:\Users\DELL\.gemini\antigravity\brain\a1ad88cd-e380-40ab-96eb-7991a69e426d\gearhead_profile_avatar_1778818045664.png'),
                  fit: BoxFit.cover,
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildActiveGarage() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Padding(
          padding: const EdgeInsets.symmetric(horizontal: 20.0, vertical: 16.0),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(
                'ACTIVE GARAGE',
                style: GoogleFonts.outfit(
                  fontSize: 18,
                  fontWeight: FontWeight.bold,
                  color: Colors.white,
                  letterSpacing: 1,
                ),
              ),
              Text(
                'VIEW ALL',
                style: GoogleFonts.outfit(
                  fontSize: 14,
                  fontWeight: FontWeight.bold,
                  color: const Color(0xFFE53935),
                ),
              ),
            ],
          ),
        ),
        SizedBox(
          height: 380,
          child: ListView(
            scrollDirection: Axis.horizontal,
            padding: const EdgeInsets.only(left: 20, right: 20),
            children: [
              _buildCarCard(
                'NISSAN',
                'GTR R35',
                '12,500',
                82,
                r'C:\Users\DELL\.gemini\antigravity\brain\a1ad88cd-e380-40ab-96eb-7991a69e426d\nissan_gtr_dashboard_card_1778817803772.png',
              ),
              const SizedBox(width: 20),
              _buildCarCard(
                'PORSCHE',
                '911 GT3',
                '5,200',
                95,
                '', // placeholder or another generated image
              ),
            ],
          ),
        ),
      ],
    );
  }

  Widget _buildCarCard(String make, String model, String km, int oilLife, String imagePath) {
    return Container(
      width: 320,
      decoration: BoxDecoration(
        color: const Color(0xFF1A1A1A),
        borderRadius: BorderRadius.circular(24),
        border: Border.all(color: Colors.white.withOpacity(0.05)),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Stack(
            children: [
              ClipRRect(
                borderRadius: const BorderRadius.vertical(top: Radius.circular(24)),
                child: imagePath.isNotEmpty
                    ? Image.file(
                        File(imagePath),
                        height: 200,
                        width: double.infinity,
                        fit: BoxFit.cover,
                      )
                    : Container(
                        height: 200,
                        color: Colors.grey[900],
                        child: const Icon(Icons.car_repair, color: Colors.white24, size: 60),
                      ),
              ),
              Positioned(
                top: 16,
                right: 16,
                child: Container(
                  padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 6),
                  decoration: BoxDecoration(
                    color: const Color(0xFFE53935),
                    borderRadius: BorderRadius.circular(8),
                  ),
                  child: Text(
                    'IN SERVICE',
                    style: GoogleFonts.outfit(
                      fontSize: 10,
                      fontWeight: FontWeight.bold,
                      color: Colors.white,
                    ),
                  ),
                ),
              ),
            ],
          ),
          Padding(
            padding: const EdgeInsets.all(20.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  crossAxisAlignment: CrossAxisAlignment.end,
                  children: [
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          make,
                          style: GoogleFonts.outfit(
                            fontSize: 14,
                            color: Colors.white.withOpacity(0.5),
                            letterSpacing: 1,
                          ),
                        ),
                        Text(
                          model,
                          style: GoogleFonts.outfit(
                            fontSize: 24,
                            fontWeight: FontWeight.bold,
                            color: Colors.white,
                          ),
                        ),
                      ],
                    ),
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.end,
                      children: [
                        Text(
                          km,
                          style: GoogleFonts.outfit(
                            fontSize: 32,
                            fontWeight: FontWeight.bold,
                            color: Colors.white,
                          ),
                        ),
                        Text(
                          'KILOMETERS',
                          style: GoogleFonts.outfit(
                            fontSize: 12,
                            color: Colors.white.withOpacity(0.5),
                            letterSpacing: 1,
                          ),
                        ),
                      ],
                    ),
                  ],
                ),
                const SizedBox(height: 24),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text(
                      'OIL LIFE',
                      style: GoogleFonts.outfit(
                        fontSize: 10,
                        color: Colors.white.withOpacity(0.5),
                        letterSpacing: 1,
                      ),
                    ),
                    Text(
                      '$oilLife%',
                      style: GoogleFonts.outfit(
                        fontSize: 10,
                        color: Colors.white.withOpacity(0.5),
                      ),
                    ),
                  ],
                ),
                const SizedBox(height: 8),
                _buildSegmentedProgressBar(oilLife / 100),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildSegmentedProgressBar(double value) {
    return Row(
      children: List.generate(10, (index) {
        bool isActive = (index + 1) / 10 <= value;
        return Expanded(
          child: Container(
            margin: EdgeInsets.only(right: index == 9 ? 0 : 4),
            height: 4,
            decoration: BoxDecoration(
              color: isActive ? const Color(0xFFE53935) : Colors.white.withOpacity(0.1),
              borderRadius: BorderRadius.circular(2),
            ),
          ),
        );
      }),
    );
  }

  Widget _buildRecentServices() {
    return Padding(
      padding: const EdgeInsets.all(20.0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(
                'RECENT SERVICES',
                style: GoogleFonts.outfit(
                  fontSize: 18,
                  fontWeight: FontWeight.bold,
                  color: Colors.white,
                  letterSpacing: 1,
                ),
              ),
              const Icon(Icons.tune, color: Colors.white, size: 20),
            ],
          ),
          const SizedBox(height: 16),
          _buildServiceItem(
            'Shell Helix Oil Change',
            'OCT 24, 2023 • MAINTENANCE',
            '\$185.00',
            Icons.oil_barrel,
          ),
          _buildServiceItem(
            'Brake Pad Replacement',
            'SEP 12, 2023 • REPAIR',
            '\$420.50',
            Icons.settings_input_component,
            isAlert: true,
          ),
          _buildServiceItem(
            'Wheel Alignment',
            'AUG 05, 2023 • MAINTENANCE',
            '\$120.00',
            Icons.straighten,
          ),
          _buildServiceItem(
            'ECU Diagnostics',
            'JUL 18, 2023 • INSPECTION',
            '\$85.00',
            Icons.analytics,
          ),
        ],
      ),
    );
  }

  Widget _buildServiceItem(String title, String subtitle, String price, IconData icon, {bool isAlert = false}) {
    return Container(
      margin: const EdgeInsets.only(bottom: 12),
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: const Color(0xFF1A1A1A),
        borderRadius: BorderRadius.circular(16),
        border: Border.all(
          color: isAlert ? const Color(0xFFE53935).withOpacity(0.3) : Colors.white.withOpacity(0.05),
        ),
      ),
      child: Row(
        children: [
          Container(
            width: 50,
            height: 50,
            decoration: BoxDecoration(
              color: Colors.white.withOpacity(0.05),
              borderRadius: BorderRadius.circular(12),
            ),
            child: Icon(icon, color: isAlert ? const Color(0xFFE53935) : Colors.white.withOpacity(0.3), size: 24),
          ),
          const SizedBox(width: 16),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  title,
                  style: GoogleFonts.outfit(
                    fontSize: 16,
                    fontWeight: FontWeight.bold,
                    color: Colors.white,
                  ),
                ),
                Text(
                  subtitle,
                  style: GoogleFonts.outfit(
                    fontSize: 12,
                    color: Colors.white.withOpacity(0.4),
                  ),
                ),
              ],
            ),
          ),
          Column(
            crossAxisAlignment: CrossAxisAlignment.end,
            children: [
              Text(
                price,
                style: GoogleFonts.outfit(
                  fontSize: 16,
                  fontWeight: FontWeight.bold,
                  color: const Color(0xFFE53935),
                ),
              ),
              const Icon(Icons.chevron_right, color: Colors.white24, size: 16),
            ],
          ),
        ],
      ),
    );
  }

  Widget _buildBottomNav() {
    return Container(
      height: 80,
      decoration: BoxDecoration(
        color: const Color(0xFF0F0F0F),
        border: Border(top: BorderSide(color: Colors.white.withOpacity(0.05))),
      ),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceAround,
        children: [
          _buildNavItem(0, Icons.directions_car_filled_outlined, 'Garage'),
          _buildNavItem(1, Icons.build_outlined, 'Service'),
          _buildNavItem(2, Icons.analytics_outlined, 'Stats'),
          _buildNavItem(3, Icons.settings_outlined, 'Settings'),
        ],
      ),
    );
  }

  Widget _buildNavItem(int index, IconData icon, String label) {
    bool isSelected = _selectedIndex == index;
    return GestureDetector(
      onTap: () => setState(() => _selectedIndex = index),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Icon(
            icon,
            color: isSelected ? const Color(0xFFE53935) : Colors.white.withOpacity(0.3),
            size: 24,
          ),
          const SizedBox(height: 4),
          Text(
            label,
            style: GoogleFonts.outfit(
              fontSize: 10,
              color: isSelected ? const Color(0xFFE53935) : Colors.white.withOpacity(0.3),
              fontWeight: isSelected ? FontWeight.bold : FontWeight.normal,
            ),
          ),
        ],
      ),
    );
  }
}
