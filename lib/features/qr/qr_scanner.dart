import 'package:flutter/material.dart';
import 'package:mobile_scanner/mobile_scanner.dart';
import 'package:s_factory/features/machine/machine_detail_page.dart';

import '../../dataconnect_generated/generated.dart';
import '../../shared/services/secure_storage_service.dart';

class QRScannerPage extends StatefulWidget {
  const QRScannerPage({super.key});

  @override
  State<QRScannerPage> createState() => _QRScannerPageState();
}

class _QRScannerPageState extends State<QRScannerPage> {

  String scannedCode = "Scan a QR code";
  String _currentRole = '';

  bool _isScanning = false;

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

                  setState(() {
                    scannedCode = code;
                  });

                  await onQRScanned(code);
                }
              },
            ),
          ),

          Expanded(
            flex: 1,
            child: Center(
              child: Text(
                'Scan a QR code',
                style: const TextStyle(fontSize: 20),
              ),
            ),
          ),

        ],
      ),
    );
  }

  Future<void> onQRScanned(String code) async {
    try {

      // stop scanner immediately
      await _controller.stop();

      final result = await ConnectorConnector
          .instance
          .getMachine(id: code)
          .execute();

      final machine = result.data.machine;

      if (machine != null) {

        final Map<String, String> machineMap =
        machine.toJson().map(
              (key, value) => MapEntry(
            key,
            value?.toString() ?? '',
          ),
        );

        if (!mounted) return;

        await Navigator.push(
          context,
          MaterialPageRoute(
            builder: (_) => MachineDetailPage(
              machineData: machineMap,
              role: _currentRole,
            ),
          ),
        );

        // resume scanner when back
        await _controller.start();

        _isScanning = false;

      } else {

        setState(() {
          scannedCode = "Machine not found";
        });

        await _controller.start();

        _isScanning = false;
      }

    } catch (e) {

      setState(() {
        scannedCode = "Error: $e";
      });

      await _controller.start();

      _isScanning = false;
    }
  }

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