import 'package:flutter/material.dart';
import '../models/journal_entry.dart';
import '../theme/app_theme.dart';
import 'package:intl/intl.dart';

class JournalDetailScreen extends StatelessWidget {
  final JournalEntry entry;

  const JournalDetailScreen({super.key, required this.entry});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppTheme.backgroundColor,
      appBar: AppBar(
        backgroundColor: Colors.transparent,
        elevation: 0,
        leading: IconButton(
          icon: const Icon(Icons.arrow_back, color: AppTheme.primaryColor),
          onPressed: () => Navigator.pop(context),
        ),
        title: Text(
          DateFormat('MMMM d, yyyy').format(entry.date),
          style: const TextStyle(
            color: AppTheme.primaryColor,
            fontWeight: FontWeight.bold,
            fontSize: 18,
          ),
        ),
        actions: [
          TextButton.icon(
            onPressed: () {},
            icon: const Icon(Icons.edit_outlined, color: AppTheme.primaryColor, size: 20),
            label: const Text('Edit', style: TextStyle(color: AppTheme.primaryColor)),
          ),
          TextButton.icon(
            onPressed: () {},
            icon: const Icon(Icons.delete_outline, color: Colors.redAccent, size: 20),
            label: const Text('Hapus', style: TextStyle(color: Colors.redAccent)),
          ),
          const SizedBox(width: 8),
        ],
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 20),
        child: Column(
          children: [
            Center(
              child: Container(
                width: 100,
                height: 100,
                decoration: const BoxDecoration(
                  color: Color(0xFFE8F3EF),
                  shape: BoxShape.circle,
                ),
                child: Center(
                  child: Text(
                    entry.emoji,
                    style: const TextStyle(fontSize: 48),
                  ),
                ),
              ),
            ),
            const SizedBox(height: 24),
            Text(
              DateFormat('EEEE MORNING').format(entry.date).toUpperCase(),
              style: const TextStyle(
                color: Colors.blueGrey,
                letterSpacing: 1.5,
                fontWeight: FontWeight.bold,
                fontSize: 12,
              ),
            ),
            const SizedBox(height: 12),
            Text(
              entry.title,
              textAlign: TextAlign.center,
              style: Theme.of(context).textTheme.displayLarge?.copyWith(
                    fontSize: 28,
                    fontWeight: FontWeight.bold,
                  ),
            ),
            const SizedBox(height: 32),
            Container(
              padding: const EdgeInsets.all(24),
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.circular(24),
                boxShadow: [
                  BoxShadow(
                    color: Colors.black.withOpacity(0.02),
                    blurRadius: 20,
                    offset: const Offset(0, 10),
                  ),
                ],
              ),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Wrap(
                    spacing: 8,
                    children: [
                      _buildTag(entry.category),
                      _buildTag('mindfulness'),
                    ],
                  ),
                  const SizedBox(height: 20),
                  Text(
                    entry.content,
                    style: TextStyle(
                      fontSize: 16,
                      height: 1.6,
                      color: Colors.blueGrey[800],
                    ),
                  ),
                  const SizedBox(height: 16),
                  Text(
                    "It's funny how we often chase big moments of clarity when they're usually found in the quietest corners of our routine. I felt a profound sense of gratitude for the simple ability to breathe, to exist, and to observe.\n\nWork has been demanding lately, but this morning reminded me that I am more than my productivity. The projects will finish, the emails will be answered, but this specific moment—the steam rising from the mug, the first bird chirping—is singular and fleeting.",
                    style: TextStyle(
                      fontSize: 16,
                      height: 1.6,
                      color: Colors.blueGrey[800],
                    ),
                  ),
                ],
              ),
            ),
            const SizedBox(height: 24),
            Row(
              children: [
                Expanded(
                  child: _buildMetaCard(
                    Icons.location_on_outlined,
                    'Location',
                    'The Coffee Sanctuary, Ubud',
                  ),
                ),
                const SizedBox(width: 16),
                Expanded(
                  child: _buildMetaCard(
                    Icons.access_time,
                    'Time',
                    DateFormat('hh:mm a').format(entry.date),
                  ),
                ),
              ],
            ),
            const SizedBox(height: 24),
            ClipRRect(
              borderRadius: BorderRadius.circular(20),
              child: Image.network(
                'https://images.unsplash.com/photo-1511920170033-f8396924c348?auto=format&fit=crop&q=80&w=1000',
                height: 300,
                width: double.infinity,
                fit: BoxFit.cover,
              ),
            ),
            const SizedBox(height: 40),
          ],
        ),
      ),
    );
  }

  Widget _buildTag(String tag) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 6),
      decoration: BoxDecoration(
        color: const Color(0xFFEFF4F2),
        borderRadius: BorderRadius.circular(12),
      ),
      child: Text(
        '#$tag',
        style: const TextStyle(
          color: Colors.blueGrey,
          fontSize: 13,
          fontWeight: FontWeight.w500,
        ),
      ),
    );
  }

  Widget _buildMetaCard(IconData icon, String label, String value) {
    return Container(
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: const Color(0xFFF0F4F7),
        borderRadius: BorderRadius.circular(16),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: [
              Icon(icon, size: 16, color: Colors.blueGrey),
              const SizedBox(width: 8),
              Text(
                label,
                style: const TextStyle(color: Colors.blueGrey, fontSize: 12),
              ),
            ],
          ),
          const SizedBox(height: 8),
          Text(
            value,
            style: const TextStyle(
              fontWeight: FontWeight.bold,
              fontSize: 14,
              color: Colors.black87,
            ),
          ),
        ],
      ),
    );
  }
}
