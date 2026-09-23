import 'package:flutter/material.dart';

import '../theme/app_theme.dart';
import '../widgets/saved_card.dart';

class HomeScreen extends StatelessWidget {
  const HomeScreen({
    super.key,
    this.onScanCard,
    this.onOpenCard,
  });

  final VoidCallback? onScanCard;
  final VoidCallback? onOpenCard;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              'Hendrix Card Saver',
              style: TextStyle(fontSize: 19, fontWeight: FontWeight.w700),
            ),
            Text(
              'Your cards, always available',
              style: TextStyle(fontSize: 12, fontWeight: FontWeight.w400),
            ),
          ],
        ),
      ),
      body: SafeArea(
        child: ListView(
          padding: const EdgeInsets.all(20),
          children: [
            Text(
              'Your card portfolio',
              style: Theme.of(context).textTheme.headlineSmall?.copyWith(
                    fontWeight: FontWeight.w800,
                    color: AppTheme.nearBlack,
                  ),
            ),
            const SizedBox(height: 6),
            Text(
              'Open your saved card or scan a new one.',
              style: Theme.of(context).textTheme.bodyLarge?.copyWith(
                    color: Colors.black54,
                  ),
            ),
            const SizedBox(height: 22),
            SavedCard(
              studentName: 'Sample Student',
              studentId: '000000000',
              onTap: onOpenCard ?? () {},
            ),
            const SizedBox(height: 26),
            FilledButton.icon(
              key: const Key('scanCardButton'),
              onPressed: onScanCard ?? () {},
              icon: const Icon(Icons.document_scanner_outlined),
              label: const Text('Scan a card'),
            ),
            const SizedBox(height: 12),
            OutlinedButton.icon(
              key: const Key('enterCardButton'),
              onPressed: () {},
              icon: const Icon(Icons.edit_outlined),
              label: const Text('Enter card information'),
            ),
            const SizedBox(height: 28),
            Container(
              padding: const EdgeInsets.all(16),
              decoration: BoxDecoration(
                color: AppTheme.hendrixOrange.withValues(alpha: 0.08),
                borderRadius: BorderRadius.circular(16),
              ),
              child: const Row(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Icon(Icons.lock_outline, color: AppTheme.hendrixOrange),
                  SizedBox(width: 12),
                  Expanded(
                    child: Text(
                      'Your card information stays on this device and is '
                      'available without an internet connection.',
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
