import 'package:barcode_widget/barcode_widget.dart';
import 'package:flutter/material.dart';

class barcodeCreater extends StatelessWidget
{
  const barcodeCreater(
    {required this.barcodeInfo, super.key}
  );

  final (String data, String type) barcodeInfo;

  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    return Dialog(
      child: SizedBox(
        width: 250,
        height: 100,
        child: Padding(
          padding: EdgeInsets.all(16.0),
          child: BarcodeWidget(
            data: barcodeInfo.$1,
            barcode: _getBarcodeType(barcodeInfo.$2),
            height: 50,
            width: 200
          )
        )
      )
    );
  }


  Barcode _getBarcodeType(String type)
  {
    BarcodeType Bartype = BarcodeType.Code39;
    //add switch statements for more card type support
    return Barcode.fromType(Bartype);
  }
}