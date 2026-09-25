import 'package:flutter/material.dart';
import 'package:hendrix_card_saver/Sensors/scanner.dart';
import 'package:sqflite_common_ffi/sqflite_common_ffi.dart';

import '../theme/app_theme.dart';
import '../widgets/saved_card.dart';
import '../Storage/code_storage.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({
    super.key,
    this.onScanCard,
    this.onOpenCard,
  });

  final VoidCallback? onScanCard;
  final VoidCallback? onOpenCard;

  @override
  State<StatefulWidget> createState() => HomeScreenState();
}

class HomeScreenState extends State<HomeScreen>
{

  List<SavedCard> cards = List<SavedCard>.empty();
  @override
  void initState() {
    super.initState();
    CodeDatabase db = CodeDatabase();
    db.code().then((value) {
      setState(() {
        print("db.code has returned");
        for (var code in value) {
          cards.add(SavedCard(studentName: code.name, studentId: code.id.toString(), onTap: () {}));
        }

        if(cards.isEmpty)
        {
          cards.add(SavedCard(studentName: "Sample Name", studentId: "00000000",onTap: () {},));
        }
      });

    });
  }
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
            SizedBox(
              height: 350,
              child:
                ListView(
                  children: [
                    ...cards
                  ]
                )
            ),
            const SizedBox(height: 26),
            FilledButton.icon(
              key: const Key('scanCardButton'),
              onPressed:  () 
              async { 
                widget.onScanCard?.call();
                String data;
                String type;
                (data, type) = await scanner.getBarcodeInfoFromScan(context); 
                
                if (data.isEmpty){
                  return;
                }
                final newCard = CodeStorage(code: data, id: 000000, name: "Hendrix Card"); //ID = 000000 until we get the card info for it 
                final database = CodeDatabase();

                if((cards[0]).studentName == "Sample Student")
                {
                  cards.removeAt(0);
                }
                await database.insertCode(newCard);
                setState(() {
                  cards.add(SavedCard(studentName: newCard.name, studentId: newCard.id.toString(), onTap: () {}));
                });


                //insert into db however you want, name cannot be gotten from bar though
              },
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
