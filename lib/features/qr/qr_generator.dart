import 'package:flutter/material.dart';
import 'package:qr_flutter/qr_flutter.dart';

class QRGeneratorPage extends StatelessWidget {
  final String machineID;

  const QRGeneratorPage({
    super.key,
    required this.machineID,
  });

  @override
  Widget build(BuildContext context) {

    return Scaffold(
      appBar: AppBar(
        title: Text('Machine QR Code'),
        centerTitle: true,
        backgroundColor: Colors.deepOrange,
        foregroundColor: Colors.white,
        elevation: 0,
        leadingWidth: 90,
      ),
      body: Center(
        child: QrImageView(
          data: machineID,
          version: QrVersions.auto,
          size: 200.0,
        ),
      ),
    );
  }
}