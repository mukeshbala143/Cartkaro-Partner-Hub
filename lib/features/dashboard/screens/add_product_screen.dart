import 'dart:io';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import '../../../core/constants/app_colors.dart';
import 'package:lucide_icons/lucide_icons.dart';

class AddProductScreen extends StatefulWidget {
  final String businessType;
  final Map<String, dynamic>? existingProduct; 

  const AddProductScreen({
    Key? key,
    required this.businessType,
    this.existingProduct,
  }) : super(key: key);

  @override
  State<AddProductScreen> createState() => _AddProductScreenState();
}

class _AddProductScreenState extends State<AddProductScreen> {
  final TextEditingController _nameController = TextEditingController();
  final TextEditingController _originalPriceController = TextEditingController();
  final TextEditingController _discountController = TextEditingController();
  final TextEditingController _descriptionController = TextEditingController();
  
  bool _isActive = true;
  double _finalPrice = 0.0;
  List<XFile> _images = [];
  final ImagePicker _picker = ImagePicker();

  String get itemName {
    if (widget.businessType == "restaurant") return "Menu Item";
    if (widget.businessType == "medical") return "Medicine";
    return "Product";
  }

  @override
  void initState() {
    super.initState();
    if (widget.existingProduct != null) {
      _nameController.text = widget.existingProduct!['name'];
      _originalPriceController.text = widget.existingProduct!['originalPrice'].toString();
      _discountController.text = widget.existingProduct!['discountPercent'].toString();
      _descriptionController.text = widget.existingProduct!['description'] ?? '';
      _isActive = widget.existingProduct!['isActive'];
      _finalPrice = widget.existingProduct!['price']; 

      // NAYA CODE: Yahan hum saved string paths ko wapas XFile me badal kar _images me daal rahe hain
      if (widget.existingProduct!['images'] != null) {
        List<String> savedPaths = List<String>.from(widget.existingProduct!['images']);
        _images = savedPaths.map((path) => XFile(path)).toList();
      }
    }

    _originalPriceController.addListener(_calculateDiscount);
    _discountController.addListener(_calculateDiscount);
  }

  void _calculateDiscount() {
    double original = double.tryParse(_originalPriceController.text) ?? 0.0;
    double discount = double.tryParse(_discountController.text) ?? 0.0;
    
    if (original > 0) {
      setState(() {
        _finalPrice = original - (original * (discount / 100));
      });
    } else {
      setState(() {
        _finalPrice = 0.0;
      });
    }
  }

  Future<void> _pickImage(ImageSource source) async {
    try {
      if (source == ImageSource.gallery) {
        final List<XFile> selectedImages = await _picker.pickMultiImage();
        if (selectedImages.isNotEmpty) {
          setState(() { _images.addAll(selectedImages); });
        }
      } else {
        final XFile? photo = await _picker.pickImage(source: ImageSource.camera);
        if (photo != null) {
          setState(() { _images.add(photo); });
        }
      }
    } catch (e) {
      debugPrint("Image picking failed: $e");
    }
  }

  void _showImageSourceActionSheet() {
    showModalBottomSheet(
      context: context,
      shape: const RoundedRectangleBorder(borderRadius: BorderRadius.vertical(top: Radius.circular(20))),
      builder: (context) => SafeArea(
        child: Wrap(
          children: [
            ListTile(
              leading: const Icon(LucideIcons.camera, color: AppColors.kPrimary),
              title: const Text('Take a Photo'),
              onTap: () { Navigator.pop(context); _pickImage(ImageSource.camera); },
            ),
            ListTile(
              leading: const Icon(LucideIcons.image, color: AppColors.kPrimary),
              title: const Text('Choose from Gallery'),
              onTap: () { Navigator.pop(context); _pickImage(ImageSource.gallery); },
            ),
          ],
        ),
      ),
    );
  }

  void _saveProduct() {
    if (_nameController.text.isEmpty || _originalPriceController.text.isEmpty) {
      ScaffoldMessenger.of(context).showSnackBar(const SnackBar(content: Text("Name & Price are required!")));
      return;
    }

    final savedProduct = {
      'name': _nameController.text,
      'originalPrice': double.tryParse(_originalPriceController.text) ?? 0.0,
      'discountPercent': double.tryParse(_discountController.text) ?? 0.0,
      'price': _finalPrice, 
      'description': _descriptionController.text,
      'isActive': _isActive,
      'images': _images.map((e) => e.path).toList(), // Save paths
    };

    Navigator.pop(context, savedProduct); 
  }

  @override
  void dispose() {
    _nameController.dispose();
    _originalPriceController.dispose();
    _discountController.dispose();
    _descriptionController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    bool isEditing = widget.existingProduct != null;

    return Scaffold(
      backgroundColor: AppColors.kBackground,
      appBar: AppBar(
        backgroundColor: AppColors.kBackground,
        elevation: 0,
        iconTheme: const IconThemeData(color: AppColors.kDarkText),
        title: Text(
          isEditing ? 'Edit $itemName' : 'Add New $itemName',
          style: const TextStyle(fontSize: 20, fontWeight: FontWeight.w800, color: AppColors.kDarkText),
        ),
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(20),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const Text('Upload Images', style: TextStyle(fontSize: 14, fontWeight: FontWeight.w700)),
            const SizedBox(height: 12),
            SizedBox(
              height: 100,
              child: ListView(
                scrollDirection: Axis.horizontal,
                children: [
                  GestureDetector(
                    onTap: _showImageSourceActionSheet,
                    child: Container(
                      width: 100,
                      decoration: BoxDecoration(
                        color: AppColors.kPrimary.withOpacity(0.1),
                        borderRadius: BorderRadius.circular(12),
                        border: Border.all(color: AppColors.kPrimary.withOpacity(0.5), style: BorderStyle.solid),
                      ),
                      child: const Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Icon(LucideIcons.plus, color: AppColors.kPrimary),
                          SizedBox(height: 4),
                          Text('Add Photo', style: TextStyle(fontSize: 12, color: AppColors.kPrimary)),
                        ],
                      ),
                    ),
                  ),
                  const SizedBox(width: 12),
                  ..._images.asMap().entries.map((entry) {
                    return Stack(
                      children: [
                        Container(
                          width: 100,
                          margin: const EdgeInsets.only(right: 12),
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(12),
                            image: DecorationImage(
                              image: FileImage(File(entry.value.path)),
                              fit: BoxFit.cover,
                            ),
                          ),
                        ),
                        Positioned(
                          right: 16,
                          top: 4,
                          child: GestureDetector(
                            onTap: () { setState(() { _images.removeAt(entry.key); }); },
                            child: Container(
                              padding: const EdgeInsets.all(4),
                              decoration: const BoxDecoration(color: Colors.red, shape: BoxShape.circle),
                              child: const Icon(Icons.close, size: 14, color: Colors.white),
                            ),
                          ),
                        ),
                      ],
                    );
                  }).toList(),
                ],
              ),
            ),
            const SizedBox(height: 24),
            _buildTextField("Name", _nameController, LucideIcons.tag),
            const SizedBox(height: 16),
            Row(
              children: [
                Expanded(child: _buildTextField("Original Price (₹)", _originalPriceController, LucideIcons.indianRupee, isNumber: true)),
                const SizedBox(width: 16),
                Expanded(child: _buildTextField("Discount (%)", _discountController, LucideIcons.percent, isNumber: true)),
              ],
            ),
            const SizedBox(height: 16),
            Container(
              padding: const EdgeInsets.all(16),
              decoration: BoxDecoration(color: const Color(0xFFEEF2FF), borderRadius: BorderRadius.circular(12)),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  const Text('Final Selling Price:', style: TextStyle(fontWeight: FontWeight.w600, color: AppColors.kDarkText)),
                  Text('₹${_finalPrice.toStringAsFixed(2)}', style: const TextStyle(fontSize: 20, fontWeight: FontWeight.w800, color: AppColors.kPrimary)),
                ],
              ),
            ),
            const SizedBox(height: 16),
            _buildTextField("Description", _descriptionController, LucideIcons.alignLeft, maxLines: 3),
            const SizedBox(height: 24),
            SwitchListTile(
              title: const Text('Mark as Active', style: TextStyle(fontWeight: FontWeight.w700)),
              subtitle: const Text('Visible to customers'),
              value: _isActive,
              activeColor: AppColors.kPrimary,
              contentPadding: EdgeInsets.zero,
              onChanged: (val) { setState(() => _isActive = val); },
            ),
            const SizedBox(height: 40),
            SizedBox(
              width: double.infinity,
              child: ElevatedButton(
                onPressed: _saveProduct,
                style: ElevatedButton.styleFrom(
                  backgroundColor: AppColors.kPrimary,
                  padding: const EdgeInsets.symmetric(vertical: 16),
                  shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
                ),
                child: Text(isEditing ? "Update $itemName" : "Save $itemName", style: const TextStyle(fontSize: 16, fontWeight: FontWeight.bold, color: Colors.white)),
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildTextField(String label, TextEditingController controller, IconData icon, {bool isNumber = false, int maxLines = 1}) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(label, style: const TextStyle(fontSize: 14, fontWeight: FontWeight.w700, color: AppColors.kDarkText)),
        const SizedBox(height: 8),
        TextField(
          controller: controller,
          keyboardType: isNumber ? TextInputType.number : TextInputType.text,
          maxLines: maxLines,
          decoration: InputDecoration(
            filled: true,
            fillColor: AppColors.kWhite,
            prefixIcon: maxLines == 1 ? Icon(icon, color: AppColors.kLightText) : null,
            border: OutlineInputBorder(borderRadius: BorderRadius.circular(12), borderSide: BorderSide(color: AppColors.kBorder.withOpacity(0.5))),
            enabledBorder: OutlineInputBorder(borderRadius: BorderRadius.circular(12), borderSide: BorderSide(color: AppColors.kBorder.withOpacity(0.5))),
            focusedBorder: OutlineInputBorder(borderRadius: BorderRadius.circular(12), borderSide: const BorderSide(color: AppColors.kPrimary, width: 2)),
          ),
        ),
      ],
    );
  }
}