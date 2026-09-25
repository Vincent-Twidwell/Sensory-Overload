import 'package:flutter/material.dart';
import 'package:hendrix_card_saver/Sensors/scanner.dart';
import 'package:sqflite_common_ffi/sqflite_common_ffi.dart';

import '../theme/app_theme.dart';
import '../widgets/saved_card.dart';
import '../Storage/code_storage.dart';

class HomeScreen extends StatelessWidget {
  const HomeScreen({super.key, this.onScanCard, this.onOpenCard});

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
              'The Plastic Destroyer Card Saver',
              style: TextStyle(fontSize: 19, fontWeight: FontWeight.w700),
            ),
            Text(
              'Your cards, always available',
              style: TextStyle(fontSize: 12, fontWeight: FontWeight.w400),
            ),
          ],
        ),
        actions: [
          Center(
            child: Transform.rotate(
              angle: 0.30,
              child: Container(
                margin: const EdgeInsets.only(right: 16),
                padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 5),
                color: const Color.fromARGB(255, 245, 54, 29),
                child: const Text(
                  'DEMO VERSION',
                  style: TextStyle(
                    color: Colors.white,
                    fontSize: 11,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ),
            ),
          ),
        ],
      ),
      body: SafeArea(
        child: ListView(
          padding: const EdgeInsets.all(100),
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
              style: Theme.of(context).textTheme.bodyLarge
                  ?.copyWith(color: Colors.black54),
            ),
            const SizedBox(height: 22),
            SavedCard(
              studentName: 'Sample Student',
              studentId: '000000000',
              onTap: onOpenCard ?? () {},
            ),
            Center(
              child: SizedBox(
                width: 1300,
                child: FilledButton.icon(
                  key: const Key('scanCardButton'),
                  onPressed: () async {
                    onScanCard?.call();
                    String data;
                    String type;
                    (data, type) = await scanner.getBarcodeInfoFromScan(
                      context,
                    );

                    if (data.isEmpty) return;

                    final newCard = CodeStorage(
                      code: data,
                      id: 000000,
                      name: "Hendrix Card",
                    );
                    final database = CodeDatabase();
                    await database.insertCode(newCard);
                  },
                  icon: const Icon(Icons.document_scanner_outlined),
                  label: const Text('Scan a card'),
                ),
              ),
            ),
            const SizedBox(height: 12),
            Center(
              child: SizedBox(
                width: 1300,
                child: OutlinedButton.icon(
                  key: const Key('enterCardButton'),
                  onPressed: () {},
                  icon: const Icon(Icons.edit_outlined),
                  label: const Text('Enter card information'),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
