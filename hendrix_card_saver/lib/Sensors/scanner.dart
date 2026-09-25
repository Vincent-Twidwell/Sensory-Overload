import 'dart:async';

import 'package:flutter/material.dart';
import 'package:ai_barcode_scanner/ai_barcode_scanner.dart';

class scanner
{
  const scanner();

  ///
  ///Returns record containing the (String) barcode data and (String) barcode type
  ///If scan is cancelled returns two empty strings
  ///Add async modifier to whichever method calls this one
  ///
  static Future<(String data, String type)> getBarcodeInfoFromScan(BuildContext context)
  async {
    final capture = await showAiBarcodeScanner(context);

    if(capture == null)
    {
      return ("", "");
    }

    return (capture.firstBarcode?.rawValue ?? "", capture.firstBarcode?.type.name ?? "");

  }

}