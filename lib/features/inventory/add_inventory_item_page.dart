import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import '../../shared/widgets/nav_bar.dart';
import '../../dataconnect_generated/generated.dart';

class AddInventoryItemPage extends StatefulWidget {
  const AddInventoryItemPage({super.key});

  @override
  State<AddInventoryItemPage> createState() => _AddInventoryItemPageState();
}

class _AddInventoryItemPageState extends State<AddInventoryItemPage> {
  final _formKey = GlobalKey<FormState>();

  String _name = '';
  String _description = '';
  bool _isLoading = false;
  bool _hasPicture = false;

  final TextEditingController _stockController = TextEditingController(
    text: '0',
  );

  @override
  void dispose() {
    _stockController.dispose();
    super.dispose();
  }

  Future<void> _submit() async {
    if (!_formKey.currentState!.validate()) return;

    final quantity = int.tryParse(_stockController.text) ?? 0;

    setState(() => _isLoading = true);

    try {
      await ConnectorConnector.instance
          .createItem(
            name: _name,
            quantity: quantity,
            description: _description,
          )
          .execute();

      if (mounted) {
        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(
            content: Text('เพิ่มรายการวัสดุ-อุปกรณ์เรียบร้อยแล้ว'),
          ),
        );
        Navigator.pop(context, true); // true = item was created
      }
    } catch (e) {
      if (mounted) {
        ScaffoldMessenger.of(
          context,
        ).showSnackBar(SnackBar(content: Text('เกิดข้อผิดพลาด: $e')));
      }
    } finally {
      if (mounted) setState(() => _isLoading = false);
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: const NavBar(
        title: 'เพิ่มรายการวัสดุ-อุปกรณ์',
        leadingText: 'Cancel',
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(20),
        child: Form(
          key: _formKey,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Center(
                child: GestureDetector(
                  onTap: () {
                    setState(() {
                      _hasPicture = !_hasPicture;
                    });
                  },
                  child: Container(
                    width: 120,
                    height: 120,
                    decoration: BoxDecoration(
                      color: Colors.grey[200],
                      borderRadius: BorderRadius.circular(12),
                      border: Border.all(color: Colors.grey[400]!),
                    ),
                    child: _hasPicture
                        ? ClipRRect(
                            borderRadius: BorderRadius.circular(12),
                            child: const Icon(
                              Icons.image,
                              size: 80,
                              color: Colors.grey,
                            ),
                          )
                        : const Column(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              Icon(
                                Icons.add_a_photo,
                                size: 40,
                                color: Colors.grey,
                              ),
                              SizedBox(height: 8),
                              Text(
                                'เพิ่มรูปภาพ',
                                style: TextStyle(
                                  color: Colors.grey,
                                  fontSize: 12,
                                ),
                              ),
                            ],
                          ),
                  ),
                ),
              ),
              const SizedBox(height: 20),

              const Text('NAME', style: TextStyle(fontWeight: FontWeight.bold)),
              const SizedBox(height: 8),
              TextFormField(
                decoration: InputDecoration(
                  hintText: '',
                  focusedBorder: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(4),
                    borderSide: const BorderSide(
                      color: Colors.deepPurpleAccent,
                      width: 2,
                    ),
                  ),
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(4),
                    borderSide: const BorderSide(color: Colors.black, width: 2),
                  ),
                  enabledBorder: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(4),
                    borderSide: const BorderSide(color: Colors.black, width: 2),
                  ),
                ),
                validator: (value) =>
                    value == null || value.isEmpty ? 'กรุณากรอกชื่อ' : null,
                onChanged: (value) => _name = value,
              ),
              const SizedBox(height: 24),

              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  const Text(
                    'QUANTITY',
                    style: TextStyle(fontWeight: FontWeight.bold),
                  ),
                  Row(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      IconButton(
                        icon: const Icon(Icons.remove),
                        onPressed: () {
                          int current =
                              int.tryParse(_stockController.text) ?? 0;
                          if (current > 0) {
                            _stockController.text = (current - 1).toString();
                          }
                        },
                      ),
                      Container(
                        width: 48,
                        height: 36,
                        decoration: BoxDecoration(
                          color: Colors.grey[300],
                          borderRadius: BorderRadius.circular(4),
                        ),
                        child: TextFormField(
                          controller: _stockController,
                          keyboardType: TextInputType.number,
                          textAlign: TextAlign.center,
                          style: const TextStyle(fontWeight: FontWeight.bold),
                          inputFormatters: [
                            FilteringTextInputFormatter.digitsOnly,
                          ],
                          decoration: const InputDecoration(
                            border: InputBorder.none,
                            contentPadding: EdgeInsets.only(bottom: 15),
                          ),
                        ),
                      ),
                      IconButton(
                        icon: const Icon(Icons.add),
                        onPressed: () {
                          int current =
                              int.tryParse(_stockController.text) ?? 0;
                          _stockController.text = (current + 1).toString();
                        },
                      ),
                      IconButton(
                        icon: const Icon(Icons.delete_outline),
                        onPressed: () {
                          _stockController.text = '0';
                        },
                      ),
                    ],
                  ),
                ],
              ),
              const SizedBox(height: 24),

              TextFormField(
                maxLines: 4,
                decoration: InputDecoration(
                  hintText: 'Item Description/ Detail',
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(8),
                    borderSide: const BorderSide(color: Colors.black, width: 2),
                  ),
                  enabledBorder: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(8),
                    borderSide: const BorderSide(color: Colors.black, width: 2),
                  ),
                ),
                onChanged: (value) => _description = value,
              ),
              const SizedBox(height: 40),

              Center(
                child: SizedBox(
                  width: 200,
                  height: 50,
                  child: ElevatedButton(
                    onPressed: _isLoading ? null : _submit,
                    style: ElevatedButton.styleFrom(
                      backgroundColor: Colors.deepOrange,
                      foregroundColor: Colors.white,
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(12),
                      ),
                    ),
                    child: _isLoading
                        ? const SizedBox(
                            width: 22,
                            height: 22,
                            child: CircularProgressIndicator(
                              strokeWidth: 2.5,
                              color: Colors.white,
                            ),
                          )
                        : const Text('บันทึก', style: TextStyle(fontSize: 16)),
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
