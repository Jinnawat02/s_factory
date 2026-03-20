/// QR code scanning functionality for the s_factory application.
///
/// This page provides a scanner interface to capture machine QR codes.
/// Upon detection, it fetches machine details from the database and
/// redirects the user to the machine's detail page.
///
/// @author Jinnawat Janngam
import 'package:flutter/material.dart';
import 'package:mobile_scanner/mobile_scanner.dart';
import 'package:s_factory/features/machine/machine_detail_page.dart';

import '../../dataconnect_generated/generated.dart';
import '../../shared/services/secure_storage_service.dart';

/// A stateful widget that implements QR code scanning using [MobileScanner].
class QRScannerPage extends StatefulWidget {
  /// Creates a [QRScannerPage].
  const QRScannerPage({super.key});

  @override
  State<QRScannerPage> createState() => _QRScannerPageState();
}

class _QRScannerPageState extends State<QRScannerPage> {
  /// Feedback message displayed below the scanner.
  String scannedCode = "Scan a QR code";
  
  /// The role of the current user, used when navigating to the detail page.
  String _currentRole = '';

  /// Tracks if a scan is currently being processed to prevent multiple triggers.
  bool _isScanning = false;

  /// Controller for managing the camera and scanning process.
  final MobileScannerController _controller = MobileScannerController();

  @override
  void initState() {
    super.initState();
    _loadUserRole();
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Column(
        children: [
          // Scanner Section
          Expanded(
            flex: 4,
            child: MobileScanner(
              controller: _controller,
              onDetect: (barcodeCapture) async {
                if (_isScanning) return;

                final barcode = barcodeCapture.barcodes.first;
                final code = barcode.rawValue;

                if (code != null) {
                  _isScanning = true;
                  await onQRScanned(code);
                }
              },
            ),
          ),

          // Status/Feedback Section
          Expanded(
            flex: 1,
            child: Center(
              child: Text(
                scannedCode,
                style: const TextStyle(
                  color: Colors.white,
                  fontSize: 20
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }

  /// Handles logic after a QR code is detected.
  /// 
  /// 1. Stops the scanner.
  /// 2. Fetches machine data using the scanned ID.
  /// 3. Navigates to [MachineDetailPage] if data exists.
  /// 4. Restarts the scanner and resets scanning state.
  Future<void> onQRScanned(String code) async {
    try {
      await _controller.stop();

      final result = await ConnectorConnector
          .instance
          .getMachine(id: code)
          .execute();

      final machine = result.data.machine;

      if (machine != null) {
        final Map<String, String> machineMap = machine.toJson().map(
              (key, value) => MapEntry(key, value?.toString() ?? ''),
        );

        if (!mounted) return;

        // Navigate to the machine details.
        await Navigator.push(
          context,
          MaterialPageRoute(
            builder: (_) => MachineDetailPage(
              machineData: machineMap,
              role: _currentRole,
            ),
          ),
        );

        setState(() {
          scannedCode = "Scan a QR code";
        });
      }
    } catch (e) {
      if (mounted) {
        setState(() {
          scannedCode = "Machine not found";
        });
      }
    } finally {
      // Always restart scanner and reset flag.
      await _controller.start();
      _isScanning = false;
    }
  }

  /// Loads the user's role from local storage.
  Future<void> _loadUserRole() async {
    final role = await SecureStorageService().getRole();
    if (mounted) {
      if (role == null || role.isEmpty) {
        throw Exception('Role not found in secure storage');
      }
      setState(() {
        _currentRole = role;
      });
    }
  }
}
