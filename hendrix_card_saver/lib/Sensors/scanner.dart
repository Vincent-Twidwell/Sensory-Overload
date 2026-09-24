import 'dart:async';

import 'package:flutter/material.dart';
import 'package:ai_barcode_scanner/ai_barcode_scanner.dart';

class Scanner
{
  Scanner();

  ///
  ///Returns record containing the (String) barcode data and (String) barcode type
  ///If scan is cancelled returns two empty strings
  ///Add async modifier to whichever method calls this one
  ///
  Future<(String data, String type)> getBarcodeInfoFromScan(BuildContext context)
  async {
    final capture = await showAiBarcodeScanner(context);

    if(capture == null)
    {
      return ("", "");
    }

    //?? no idea what any of this means but quick fix quickly fixed it into this
    return Future((capture.firstBarcode?.rawValue, capture.firstBarcode?.type.name) as FutureOr<(String, String)> Function());

  }

}