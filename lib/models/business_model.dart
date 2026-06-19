// ═══════════════════════════════════════════════════════
// business_model.dart
// CartKaro Partner Hub
// ═══════════════════════════════════════════════════════

enum BusinessStatus { approved, pending, rejected }

enum BusinessType { grocery, restaurant, medical }

// ─────────────────────────────
// DOCUMENT MODEL
// ─────────────────────────────
class BusinessDocument {
  final String name;
  final String number;
  final String status;
  final String? filePath;
  final String? expiryDate;

  const BusinessDocument({
    required this.name,
    required this.number,
    required this.status,
    this.filePath,
    this.expiryDate,
  });

  // NEW: needed to update status/filePath after re-upload
  BusinessDocument copyWith({
    String? status,
    String? filePath,
  }) {
    return BusinessDocument(
      name: name,
      number: number,
      status: status ?? this.status,
      filePath: filePath ?? this.filePath,
      expiryDate: expiryDate,
    );
  }
}

// ─────────────────────────────
// BANK MODEL
// ─────────────────────────────
class BankAccount {
  final String bankName;
  final String accountNumberMasked;
  final String ifsc;
  final bool verified;

  const BankAccount({
    required this.bankName,
    required this.accountNumberMasked,
    required this.ifsc,
    required this.verified,
  });
}

// ─────────────────────────────
// BUSINESS MODEL
// ─────────────────────────────
class BusinessModel {
  final String id;
  final String name;

  final BusinessType type;
  final BusinessStatus status;

  final String logoUrl;
  final String bannerUrl;

  final String ownerName;
  final String mobileNumber;
  final String email;

  final String address;
  final double latitude;
  final double longitude;

  final List<String> sellingCategories;

  final bool isLive;

  final double todayRevenue;
  final double revenueGrowthPct;

  final int totalOrders;
  final int completedOrders;
  final int pendingOrders;

  final int activeItemCount;
  final double avgRating;

  final double availableBalance;
  final double pendingSettlement;
  final double totalEarnings;

  final BankAccount bank;

  final List<BusinessDocument> documents;

  const BusinessModel({
    required this.id,
    required this.name,
    required this.type,
    required this.status,
    required this.logoUrl,
    required this.bannerUrl,
    required this.ownerName,
    required this.mobileNumber,
    required this.email,
    required this.address,
    required this.latitude,
    required this.longitude,
    required this.sellingCategories,
    required this.isLive,
    required this.todayRevenue,
    required this.revenueGrowthPct,
    required this.totalOrders,
    required this.completedOrders,
    required this.pendingOrders,
    required this.activeItemCount,
    required this.avgRating,
    required this.availableBalance,
    required this.pendingSettlement,
    required this.totalEarnings,
    required this.bank,
    required this.documents,
  });

  String get businessType {
    switch (type) {
      case BusinessType.restaurant:
        return "restaurant";
      case BusinessType.medical:
        return "medical";
      case BusinessType.grocery:
        return "grocery";
    }
  }

  String get businessTypeLabel {
    switch (type) {
      case BusinessType.restaurant:
        return "Restaurant";
      case BusinessType.medical:
        return "Medical Store";
      case BusinessType.grocery:
        return "Grocery Store";
    }
  }

  String get itemName {
    switch (type) {
      case BusinessType.restaurant:
        return "Menu Items";
      case BusinessType.medical:
        return "Medicines";
      case BusinessType.grocery:
        return "Products";
    }
  }

  String get displayName => name;

  BusinessModel copyWith({
    bool? isLive,
    List<String>? sellingCategories,
    List<BusinessDocument>? documents, // NEW
  }) {
    return BusinessModel(
      id: id,
      name: name,
      type: type,
      status: status,
      logoUrl: logoUrl,
      bannerUrl: bannerUrl,
      ownerName: ownerName,
      mobileNumber: mobileNumber,
      email: email,
      address: address,
      latitude: latitude,
      longitude: longitude,
      sellingCategories: sellingCategories ?? this.sellingCategories,
      isLive: isLive ?? this.isLive,
      todayRevenue: todayRevenue,
      revenueGrowthPct: revenueGrowthPct,
      totalOrders: totalOrders,
      completedOrders: completedOrders,
      pendingOrders: pendingOrders,
      activeItemCount: activeItemCount,
      avgRating: avgRating,
      availableBalance: availableBalance,
      pendingSettlement: pendingSettlement,
      totalEarnings: totalEarnings,
      bank: bank,
      documents: documents ?? this.documents, // NEW
    );
  }
}

// ═════════════════════════════════════════════
// MOCK DATA
// ═════════════════════════════════════════════
class MockData {
  static const String ownerName = "Mukesh Bala";

  static final List<BusinessModel> businesses = [
    // ─────────────────────────────
    // GROCERY STORE
    // ─────────────────────────────
    BusinessModel(
      id: "grocery_001",
      name: "Mukesh Grocery Store",
      type: BusinessType.grocery,
      status: BusinessStatus.approved,
      logoUrl: "",
      bannerUrl: "",
      ownerName: ownerName,
      mobileNumber: "+91 9876543210",
      email: "grocery@gmail.com",
      address: "Odisha",
      latitude: 0,
      longitude: 0,
      sellingCategories: ["fruits_veg", "dairy", "rice_grains", "snacks", "beverages"],
      isLive: true,
      todayRevenue: 5000,
      revenueGrowthPct: 12.5,
      totalOrders: 40,
      completedOrders: 35,
      pendingOrders: 5,
      activeItemCount: 120,
      avgRating: 4.8,
      availableBalance: 12000,
      pendingSettlement: 3000,
      totalEarnings: 150000,
      bank: const BankAccount(
        bankName: "HDFC Bank",
        accountNumberMasked: "XXXXXX1234",
        ifsc: "HDFC000123",
        verified: true,
      ),
      documents: const [
        BusinessDocument(name: "FSSAI Certificate", number: "12345678901234", status: "verified", expiryDate: "Dec 2026"),
        BusinessDocument(name: "GST Certificate", number: "21ABCDE1234F1Z5", status: "verified"),
        BusinessDocument(name: "Trade License Document", number: "TL2024001", status: "verified"),
        BusinessDocument(name: "PAN Card", number: "ABCDE1234F", status: "verified"),
        BusinessDocument(name: "Aadhaar Card", number: "XXXX XXXX 3456", status: "verified"),
      ],
    ),

    // ─────────────────────────────
    // RESTAURANT
    // ─────────────────────────────
    BusinessModel(
      id: "restaurant_001",
      name: "Bala Restaurant",
      type: BusinessType.restaurant,
      status: BusinessStatus.approved,
      logoUrl: "",
      bannerUrl: "",
      ownerName: ownerName,
      mobileNumber: "+91 9876543210",
      email: "restaurant@gmail.com",
      address: "Odisha",
      latitude: 0,
      longitude: 0,
      sellingCategories: ["pure_veg", "non_veg", "pizza", "fast_food", "biryani", "beverages"],
      isLive: true,
      todayRevenue: 3500,
      revenueGrowthPct: 8.5,
      totalOrders: 25,
      completedOrders: 20,
      pendingOrders: 5,
      activeItemCount: 60,
      avgRating: 4.7,
      availableBalance: 8000,
      pendingSettlement: 1500,
      totalEarnings: 90000,
      bank: const BankAccount(
        bankName: "HDFC Bank",
        accountNumberMasked: "XXXXXX5678",
        ifsc: "HDFC000123",
        verified: true,
      ),
      documents: const [
        BusinessDocument(name: "FSSAI Certificate", number: "99887766554433", status: "verified", expiryDate: "Dec 2026"),
        BusinessDocument(name: "GST Certificate", number: "21XYZAB9876C1Z5", status: "verified"),
        BusinessDocument(name: "Trade License Document", number: "RESTTL2024", status: "verified"),
        BusinessDocument(name: "PAN Card", number: "ABCDE1234F", status: "verified"),
        BusinessDocument(name: "Aadhaar Card", number: "XXXX XXXX 3456", status: "verified"),
      ],
    ),

    // ─────────────────────────────
    // MEDICAL STORE
    // ─────────────────────────────
    BusinessModel(
      id: "medical_001",
      name: "City Medical Store",
      type: BusinessType.medical,
      status: BusinessStatus.approved,
      logoUrl: "",
      bannerUrl: "",
      ownerName: ownerName,
      mobileNumber: "+91 9876543210",
      email: "medical@gmail.com",
      address: "Odisha",
      latitude: 0,
      longitude: 0,
      sellingCategories: ["rx_medicines", "health_devices", "diabetes", "first_aid", "personal_care"],
      isLive: false,
      todayRevenue: 2000,
      revenueGrowthPct: 5,
      totalOrders: 15,
      completedOrders: 12,
      pendingOrders: 3,
      activeItemCount: 80,
      avgRating: 4.6,
      availableBalance: 6000,
      pendingSettlement: 1000,
      totalEarnings: 75000,
      bank: const BankAccount(
        bankName: "SBI Bank",
        accountNumberMasked: "XXXXXX9999",
        ifsc: "SBIN000123",
        verified: true,
      ),
      documents: const [
        BusinessDocument(name: "Drug License Certificate", number: "DL123456789", status: "verified", expiryDate: "Dec 2026"),
        BusinessDocument(name: "Pharmacist Registration Certificate", number: "PHARM987654", status: "verified", expiryDate: "Dec 2026"),
        BusinessDocument(name: "GST Certificate", number: "21MEDIC1234F1Z5", status: "verified"),
        BusinessDocument(name: "PAN Card", number: "ABCDE1234F", status: "verified"),
        BusinessDocument(name: "Aadhaar Card", number: "XXXX XXXX 3456", status: "verified"),
      ],
    ),
  ];

  static BusinessModel get currentBusiness => businesses.first;

  static List<BusinessModel> get approvedBusinesses =>
      businesses.where((b) => b.status == BusinessStatus.approved).toList();

  static Future<bool> updateLiveStatus(String businessId, bool value) async {
    await Future.delayed(const Duration(milliseconds: 500));
    final index = businesses.indexWhere((b) => b.id == businessId);
    if (index == -1) return false;
    businesses[index] = businesses[index].copyWith(isLive: value);
    return true;
  }

  // NEW: re-upload / status update for a single document
  static Future<bool> updateDocumentStatus({
    required String businessId,
    required String documentName,
    required String newStatus,
    String? filePath,
  }) async {
    await Future.delayed(const Duration(milliseconds: 600)); // simulate API call

    final bIndex = businesses.indexWhere((b) => b.id == businessId);
    if (bIndex == -1) return false;

    final business = businesses[bIndex];
    final dIndex = business.documents.indexWhere((d) => d.name == documentName);
    if (dIndex == -1) return false;

    final updatedDocs = List<BusinessDocument>.from(business.documents);
    updatedDocs[dIndex] = updatedDocs[dIndex].copyWith(
      status: newStatus,
      filePath: filePath,
    );

    businesses[bIndex] = business.copyWith(documents: updatedDocs);
    return true;
  }
}