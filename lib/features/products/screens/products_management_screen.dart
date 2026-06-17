import 'dart:io';
import 'dart:async';
import 'package:flutter/material.dart';
import '../../../core/constants/app_colors.dart';
import 'package:lucide_icons/lucide_icons.dart';

class ProductsManagementScreen extends StatelessWidget {
  final String businessType;
  final List<Map<String, dynamic>> items;
  final Function(int index, bool status) onToggleStatus;
  final Function(int index) onDelete;
  final Function(int index, Map<String, dynamic> updatedItem) onEdit;
  final VoidCallback onAddNew;

  const ProductsManagementScreen({
    Key? key,
    required this.businessType,
    required this.items,
    required this.onToggleStatus,
    required this.onDelete,
    required this.onEdit,
    required this.onAddNew,
  }) : super(key: key);

  String get itemName {
    if (businessType == "restaurant") return "Menu Items";
    if (businessType == "medical") return "Medicines";
    return "Products";
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.kBackground,

      // ── App Bar ───────────────────────────────────────────────
      appBar: AppBar(
        backgroundColor: AppColors.kBackground,
        elevation: 0,
        surfaceTintColor: Colors.transparent,
        titleSpacing: 20,
        title: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              'Manage',
              style: TextStyle(
                fontSize: 12.5,
                fontWeight: FontWeight.w600,
                color: AppColors.kLightText,
                letterSpacing: 0.3,
              ),
            ),
            Text(
              itemName,
              style: const TextStyle(
                fontSize: 20,
                fontWeight: FontWeight.w800,
                color: AppColors.kDarkText,
                letterSpacing: -0.5,
              ),
            ),
          ],
        ),
        toolbarHeight: 64,
        actions: [
          Padding(
            padding: const EdgeInsets.only(right: 16),
            child: GestureDetector(
              onTap: onAddNew,
              child: Container(
                padding: const EdgeInsets.symmetric(horizontal: 14, vertical: 9),
                decoration: BoxDecoration(
                  color: AppColors.kPrimary,
                  borderRadius: BorderRadius.circular(22),
                  boxShadow: [
                    BoxShadow(
                      color: AppColors.kPrimary.withOpacity(0.30),
                      blurRadius: 12,
                      offset: const Offset(0, 4),
                    ),
                  ],
                ),
                child: const Row(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    Icon(LucideIcons.plus, color: Colors.white, size: 15),
                    SizedBox(width: 6),
                    Text(
                      'Add New',
                      style: TextStyle(
                        color: Colors.white,
                        fontSize: 13,
                        fontWeight: FontWeight.w700,
                        letterSpacing: 0.1,
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ),
        ],
      ),

      body: items.isEmpty
          ? _buildEmptyState(context)
          : Column(
              children: [
                // ── Summary strip ─────────────────────────────
                _buildSummaryStrip(),
                // ── List ─────────────────────────────────────
                Expanded(
                  child: ListView.builder(
                    padding: const EdgeInsets.fromLTRB(16, 8, 16, 24),
                    physics: const BouncingScrollPhysics(),
                    itemCount: items.length,
                    itemBuilder: (context, index) {
                      final item = items[index];
                      return _ProductCard(
                        item: item,
                        index: index,
                        onToggleStatus: onToggleStatus,
                        onDelete: onDelete,
                        onEdit: onEdit,
                      );
                    },
                  ),
                ),
              ],
            ),
    );
  }

  // ── Summary strip: active vs inactive count ───────────────────
  Widget _buildSummaryStrip() {
    final activeCount = items.where((i) => i['isActive'] == true).length;
    final inactiveCount = items.length - activeCount;

    return Container(
      margin: const EdgeInsets.fromLTRB(16, 4, 16, 4),
      padding: const EdgeInsets.symmetric(horizontal: 18, vertical: 12),
      decoration: BoxDecoration(
        color: AppColors.kWhite,
        borderRadius: BorderRadius.circular(16),
        border: Border.all(color: AppColors.kBorder.withOpacity(0.5)),
      ),
      child: Row(
        children: [
          _summaryChip(
            label: 'Total',
            value: '${items.length}',
            color: AppColors.kPrimary,
            bgColor: AppColors.kPrimary.withOpacity(0.09),
          ),
          const SizedBox(width: 10),
          _summaryChip(
            label: 'Active',
            value: '$activeCount',
            color: const Color(0xFF16A34A),
            bgColor: const Color(0xFFDCFCE7),
          ),
          const SizedBox(width: 10),
          _summaryChip(
            label: 'Inactive',
            value: '$inactiveCount',
            color: const Color(0xFF9CA3AF),
            bgColor: const Color(0xFFF3F4F6),
          ),
          const Spacer(),
         
        ],
      ),
    );
  }

  Widget _summaryChip({
    required String label,
    required String value,
    required Color color,
    required Color bgColor,
  }) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 5),
      decoration: BoxDecoration(
        color: bgColor,
        borderRadius: BorderRadius.circular(20),
      ),
      child: Row(
        mainAxisSize: MainAxisSize.min,
        children: [
          Text(
            value,
            style: TextStyle(
              fontSize: 13,
              fontWeight: FontWeight.w800,
              color: color,
              letterSpacing: -0.3,
            ),
          ),
          const SizedBox(width: 4),
          Text(
            label,
            style: TextStyle(
              fontSize: 11,
              fontWeight: FontWeight.w600,
              color: color.withOpacity(0.75),
            ),
          ),
        ],
      ),
    );
  }

  // ── Empty state ───────────────────────────────────────────────
  Widget _buildEmptyState(BuildContext context) {
    return Center(
      child: Padding(
        padding: const EdgeInsets.all(40),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            Container(
              width: 80,
              height: 80,
              decoration: BoxDecoration(
                color: AppColors.kPrimary.withOpacity(0.08),
                shape: BoxShape.circle,
              ),
              child: Icon(
                LucideIcons.package,
                size: 34,
                color: AppColors.kPrimary.withOpacity(0.7),
              ),
            ),
            const SizedBox(height: 20),
            Text(
              'No $itemName yet',
              style: const TextStyle(
                fontSize: 18,
                fontWeight: FontWeight.w800,
                color: AppColors.kDarkText,
                letterSpacing: -0.3,
              ),
            ),
            const SizedBox(height: 8),
            Text(
              'Add your first item to start\nreceiving orders.',
              textAlign: TextAlign.center,
              style: TextStyle(
                fontSize: 14,
                color: AppColors.kLightText,
                height: 1.5,
              ),
            ),
            const SizedBox(height: 28),
            GestureDetector(
              onTap: onAddNew,
              child: Container(
                padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 13),
                decoration: BoxDecoration(
                  color: AppColors.kPrimary,
                  borderRadius: BorderRadius.circular(24),
                  boxShadow: [
                    BoxShadow(
                      color: AppColors.kPrimary.withOpacity(0.28),
                      blurRadius: 16,
                      offset: const Offset(0, 6),
                    ),
                  ],
                ),
                child: const Row(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    Icon(LucideIcons.plus, color: Colors.white, size: 16),
                    SizedBox(width: 8),
                    Text(
                      'Add First Item',
                      style: TextStyle(
                        color: Colors.white,
                        fontSize: 14.5,
                        fontWeight: FontWeight.w700,
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}

// ══════════════════════════════════════════════════════════════════
// _ProductCard — StatefulWidget (logic untouched, UI fully rebuilt)
// ══════════════════════════════════════════════════════════════════
class _ProductCard extends StatefulWidget {
  final Map<String, dynamic> item;
  final int index;
  final Function(int, bool) onToggleStatus;
  final Function(int) onDelete;
  final Function(int, Map<String, dynamic>) onEdit;

  const _ProductCard({
    required this.item,
    required this.index,
    required this.onToggleStatus,
    required this.onDelete,
    required this.onEdit,
  });

  @override
  State<_ProductCard> createState() => _ProductCardState();
}

class _ProductCardState extends State<_ProductCard> {
  int _currentImageIndex = 0;
  Timer? _timer;
  List<String> _images = [];

  // ── Logic: untouched ─────────────────────────────────────────
  @override
  void initState() {
    super.initState();
    _startTimerIfNeeded();
  }

  @override
  void didUpdateWidget(covariant _ProductCard oldWidget) {
    super.didUpdateWidget(oldWidget);
    _startTimerIfNeeded();
  }

  void _startTimerIfNeeded() {
    _timer?.cancel();
    _images = List<String>.from(widget.item['images'] ?? []);
    _currentImageIndex = 0;
    if (_images.length > 1) {
      _timer = Timer.periodic(const Duration(seconds: 5), (timer) {
        if (mounted) {
          setState(() {
            _currentImageIndex = (_currentImageIndex + 1) % _images.length;
          });
        }
      });
    }
  }

  @override
  void dispose() {
    _timer?.cancel();
    super.dispose();
  }

  void _showDeleteDialog(BuildContext context, int index, String name) {
    showDialog(
      context: context,
      builder: (ctx) => AlertDialog(
        title: const Text("Delete Item"),
        content: Text("Are you sure you want to delete '$name'?"),
        actions: [
          TextButton(
              onPressed: () => Navigator.pop(ctx),
              child: const Text("Cancel")),
          ElevatedButton(
            style: ElevatedButton.styleFrom(backgroundColor: Colors.red),
            onPressed: () {
              Navigator.pop(ctx);
              widget.onDelete(index);
            },
            child:
                const Text("Delete", style: TextStyle(color: Colors.white)),
          ),
        ],
      ),
    );
  }

  // ── Build ─────────────────────────────────────────────────────
  @override
  Widget build(BuildContext context) {
    final bool hasImage = _images.isNotEmpty;
    final bool isActive = widget.item['isActive'] == true;
    final double price = widget.item['price']?.toDouble() ?? 0;
    final double? origPrice = widget.item['originalPrice']?.toDouble();
    final bool hasDiscount = origPrice != null && origPrice > price;
    final double discountPct =
        hasDiscount ? ((origPrice! - price) / origPrice * 100) : 0;

    return Container(
      margin: const EdgeInsets.only(bottom: 14),
      decoration: BoxDecoration(
        color: AppColors.kWhite,
        borderRadius: BorderRadius.circular(20),
        border: Border.all(
          color: isActive
              ? AppColors.kBorder.withOpacity(0.5)
              : AppColors.kBorder.withOpacity(0.8),
        ),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(0.04),
            blurRadius: 12,
            offset: const Offset(0, 3),
          ),
        ],
      ),
      child: Column(
        children: [
          // ── Main row ────────────────────────────────────────
          Padding(
            padding: const EdgeInsets.all(14),
            child: Row(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                // ── Image with dot indicator ─────────────────
                _buildImageStack(hasImage),

                const SizedBox(width: 14),

                // ── Info ─────────────────────────────────────
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      // Name + status badge
                      Row(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Expanded(
                            child: Text(
                              widget.item['name'] ?? '',
                              style: const TextStyle(
                                fontSize: 15.5,
                                fontWeight: FontWeight.w800,
                                color: AppColors.kDarkText,
                                letterSpacing: -0.3,
                                height: 1.2,
                              ),
                            ),
                          ),
                          const SizedBox(width: 8),
                          // Active / Inactive badge
                          Container(
                            padding: const EdgeInsets.symmetric(
                                horizontal: 9, vertical: 4),
                            decoration: BoxDecoration(
                              color: isActive
                                  ? const Color(0xFFDCFCE7)
                                  : const Color(0xFFF3F4F6),
                              borderRadius: BorderRadius.circular(20),
                            ),
                            child: Row(
                              mainAxisSize: MainAxisSize.min,
                              children: [
                                Container(
                                  width: 5,
                                  height: 5,
                                  decoration: BoxDecoration(
                                    color: isActive
                                        ? const Color(0xFF16A34A)
                                        : const Color(0xFF9CA3AF),
                                    shape: BoxShape.circle,
                                  ),
                                ),
                                const SizedBox(width: 4),
                                Text(
                                  isActive ? 'Active' : 'Off',
                                  style: TextStyle(
                                    fontSize: 10.5,
                                    fontWeight: FontWeight.w700,
                                    color: isActive
                                        ? const Color(0xFF16A34A)
                                        : const Color(0xFF9CA3AF),
                                  ),
                                ),
                              ],
                            ),
                          ),
                        ],
                      ),

                      const SizedBox(height: 8),

                      // Price row
                      Row(
                        crossAxisAlignment: CrossAxisAlignment.center,
                        children: [
                          Text(
                            '₹${price.toStringAsFixed(2)}',
                            style: TextStyle(
                              fontSize: 17,
                              fontWeight: FontWeight.w800,
                              color: AppColors.kPrimary,
                              letterSpacing: -0.4,
                            ),
                          ),
                          if (hasDiscount) ...[
                            const SizedBox(width: 8),
                            Text(
                              '₹${origPrice!.toStringAsFixed(2)}',
                              style: const TextStyle(
                                fontSize: 12,
                                decoration: TextDecoration.lineThrough,
                                color: AppColors.kLightText,
                                fontWeight: FontWeight.w500,
                              ),
                            ),
                            const SizedBox(width: 6),
                            Container(
                              padding: const EdgeInsets.symmetric(
                                  horizontal: 7, vertical: 3),
                              decoration: BoxDecoration(
                                color: const Color(0xFFFFF7ED),
                                borderRadius: BorderRadius.circular(8),
                              ),
                              child: Text(
                                '${discountPct.toStringAsFixed(0)}% off',
                                style: const TextStyle(
                                  fontSize: 10,
                                  fontWeight: FontWeight.w700,
                                  color: Color(0xFFEA580C),
                                ),
                              ),
                            ),
                          ],
                        ],
                      ),

                      const SizedBox(height: 10),

                      // Toggle row
                      Row(
                        children: [
                          Text(
                            isActive ? 'Visible to customers' : 'Hidden from listing',
                            style: TextStyle(
                              fontSize: 11.5,
                              color: isActive
                                  ? const Color(0xFF16A34A)
                                  : AppColors.kLightText,
                              fontWeight: FontWeight.w600,
                            ),
                          ),
                          const Spacer(),
                          Transform.scale(
                            scale: 0.82,
                            alignment: Alignment.centerRight,
                            child: Switch(
                              value: isActive,
                              onChanged: (val) =>
                                  widget.onToggleStatus(widget.index, val),
                              activeColor: Colors.white,
                              activeTrackColor: const Color(0xFF16A34A),
                              inactiveTrackColor: Colors.grey.shade300,
                              inactiveThumbColor: Colors.white,
                              materialTapTargetSize:
                                  MaterialTapTargetSize.shrinkWrap,
                            ),
                          ),
                        ],
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ),

          // ── Action bar ───────────────────────────────────────
          Container(
            decoration: BoxDecoration(
              color: AppColors.kBackground,
              borderRadius: const BorderRadius.only(
                bottomLeft: Radius.circular(20),
                bottomRight: Radius.circular(20),
              ),
            ),
            padding: const EdgeInsets.symmetric(horizontal: 14, vertical: 8),
            child: Row(
              children: [
                // Image count hint
                if (_images.length > 1)
                  Row(
                    children: [
                      Icon(LucideIcons.image,
                          size: 13, color: AppColors.kLightText),
                      const SizedBox(width: 4),
                      Text(
                        '${_images.length} photos',
                        style: TextStyle(
                          fontSize: 11.5,
                          color: AppColors.kLightText,
                          fontWeight: FontWeight.w500,
                        ),
                      ),
                    ],
                  ),
                const Spacer(),
                // Delete button
                _ActionBtn(
                  icon: LucideIcons.trash2,
                  label: 'Delete',
                  color: const Color(0xFFEF4444),
                  bgColor: const Color(0xFFFEF2F2),
                  onTap: () => _showDeleteDialog(
                      context, widget.index, widget.item['name'] ?? ''),
                ),
                const SizedBox(width: 8),
                // Edit button
                _ActionBtn(
                  icon: LucideIcons.pencil,
                  label: 'Edit',
                  color: AppColors.kPrimary,
                  bgColor: AppColors.kPrimary.withOpacity(0.09),
                  onTap: () => widget.onEdit(widget.index, widget.item),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  // ── Image with dot indicator ──────────────────────────────────
  Widget _buildImageStack(bool hasImage) {
    return Stack(
      children: [
        Container(
          width: 84,
          height: 84,
          decoration: BoxDecoration(
            color: AppColors.kPrimary.withOpacity(0.07),
            borderRadius: BorderRadius.circular(16),
          ),
          child: ClipRRect(
            borderRadius: BorderRadius.circular(16),
            child: hasImage
                ? AnimatedSwitcher(
                    duration: const Duration(milliseconds: 600),
                    child: Image.file(
                      File(_images[_currentImageIndex]),
                      key: ValueKey<String>(_images[_currentImageIndex]),
                      fit: BoxFit.cover,
                      width: 84,
                      height: 84,
                    ),
                  )
                : Icon(
                    LucideIcons.image,
                    color: AppColors.kPrimary.withOpacity(0.4),
                    size: 28,
                  ),
          ),
        ),
        // Dot indicators (only when > 1 image)
        if (_images.length > 1)
          Positioned(
            bottom: 7,
            left: 0,
            right: 0,
            child: Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: List.generate(
                _images.length,
                (i) => AnimatedContainer(
                  duration: const Duration(milliseconds: 300),
                  width: i == _currentImageIndex ? 12 : 5,
                  height: 5,
                  margin: const EdgeInsets.symmetric(horizontal: 2),
                  decoration: BoxDecoration(
                    color: i == _currentImageIndex
                        ? Colors.white
                        : Colors.white.withOpacity(0.5),
                    borderRadius: BorderRadius.circular(3),
                    boxShadow: [
                      BoxShadow(
                        color: Colors.black.withOpacity(0.25),
                        blurRadius: 3,
                      )
                    ],
                  ),
                ),
              ),
            ),
          ),
      ],
    );
  }
}

// ── Reusable action button ─────────────────────────────────────────
class _ActionBtn extends StatelessWidget {
  final IconData icon;
  final String label;
  final Color color;
  final Color bgColor;
  final VoidCallback onTap;

  const _ActionBtn({
    required this.icon,
    required this.label,
    required this.color,
    required this.bgColor,
    required this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        padding: const EdgeInsets.symmetric(horizontal: 13, vertical: 8),
        decoration: BoxDecoration(
          color: bgColor,
          borderRadius: BorderRadius.circular(22),
        ),
        child: Row(
          mainAxisSize: MainAxisSize.min,
          children: [
            Icon(icon, size: 14, color: color),
            const SizedBox(width: 5),
            Text(
              label,
              style: TextStyle(
                fontSize: 12.5,
                fontWeight: FontWeight.w700,
                color: color,
                letterSpacing: 0.1,
              ),
            ),
          ],
        ),
      ),
    );
  }
}