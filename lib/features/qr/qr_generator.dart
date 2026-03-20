/// QR code generation and saving functionality for the s_factory application.
///
/// This page takes a machine ID and generates a QR code image.
/// It also provides functionality to download/save the generated QR code 
/// to the device's gallery using the [Gal] package.
///
/// @author Jinnawat Janngam
import 'package:flutter/material.dart';
import 'package:qr_flutter/qr_flutter.dart';
import 'dart:ui' as ui;
import 'dart:typed_data';
import 'package:flutter/rendering.dart';
import 'package:gal/gal.dart';
import 'package:permission_handler/permission_handler.dart';

import '../../shared/utils/snackbar_utils.dart';

/// A stateful widget that generates a machine-specific QR code.
class QRGeneratorPage extends StatefulWidget {
  /// The machine ID to be encoded into the QR code.
  final String machineID;

  /// Creates a [QRGeneratorPage].
  const QRGeneratorPage({
    super.key,
    required this.machineID,
  });

  @override
  State<QRGeneratorPage> createState() => _QRGeneratorPageState();
}

class _QRGeneratorPageState extends State<QRGeneratorPage> {
  /// Key used to capture the [RepaintBoundary] as an image.
  final GlobalKey _qrKey = GlobalKey();
  
  /// Tracks the state of the download process.
  bool _isDownloading = false;

  /// Captures the QR code widget as an image and saves it to the gallery.
  /// 
  /// 1. Checks and requests gallery access permissions.
  /// 2. Uses [RenderRepaintBoundary] to convert the widget to a [ui.Image].
  /// 3. Converts the image to PNG bytes.
  /// 4. Saves the bytes to the device gallery using [Gal].
  Future<void> _downloadQRCode() async {
    setState(() => _isDownloading = true);

    try {
      // Request gallery permission
      bool hasAccess = await Gal.hasAccess();

      if (!hasAccess) {
        hasAccess = await Gal.requestAccess();
      }

      if (!hasAccess) {
        if (!mounted) return;
        // Show snackbar with a link to app settings if permission is denied.
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(
            content: const Text('Please enable storage permission in Settings'),
            action: SnackBarAction(
              label: 'Settings',
              onPressed: () => openAppSettings(),
            ),
          ),
        );
        setState(() => _isDownloading = false);
        return;
      }

      // Capture the widget subtree as an image
      RenderRepaintBoundary boundary =
      _qrKey.currentContext!.findRenderObject() as RenderRepaintBoundary;
      ui.Image image = await boundary.toImage(pixelRatio: 3.0);
      ByteData? byteData = await image.toByteData(format: ui.ImageByteFormat.png);
      Uint8List pngBytes = byteData!.buffer.asUint8List();

      // Save the generated image bytes
      await Gal.putImageBytes(pngBytes);

      if (!mounted) return;
      SnackBarUtils.showSuccess(context, 'QR Code saved to Gallery successfully!');
    } catch (e) {
      if (!mounted) return;
      SnackBarUtils.showError(context, 'Error saving QR code: $e');
    } finally {
      if (mounted) {
        setState(() => _isDownloading = false);
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Machine QR Code'),
        centerTitle: true,
        backgroundColor: Colors.deepOrange,
        foregroundColor: Colors.white,
        elevation: 0,
        leadingWidth: 90,
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            // Wrap QR code in RepaintBoundary for image capture
            RepaintBoundary(
              key: _qrKey,
              child: Container(
                padding: const EdgeInsets.all(20),
                color: Colors.white,
                child: QrImageView(
                  data: widget.machineID,
                  version: QrVersions.auto,
                  size: 200.0,
                ),
              ),
            ),
            const SizedBox(height: 40),
            ElevatedButton.icon(
              onPressed: _isDownloading ? null : _downloadQRCode,
              icon: _isDownloading
                  ? const SizedBox(
                width: 20,
                height: 20,
                child: CircularProgressIndicator(
                  color: Colors.white,
                  strokeWidth: 2,
                ),
              )
                  : const Icon(Icons.download),
              label: Text(_isDownloading ? 'Downloading...' : 'Download QR Code'),
              style: ElevatedButton.styleFrom(
                backgroundColor: Colors.deepOrange,
                foregroundColor: Colors.white,
                padding: const EdgeInsets.symmetric(
                  horizontal: 32,
                  vertical: 16,
                ),
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(12),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
