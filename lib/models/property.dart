class Property {
  final int adId;
  final String propertyTitle;
  final String city;
  final String adPurpose;
  final String propertyType;
  final int price;
  final List<String> images;
  final int bedrooms;
  final int bathrooms;
  final String area;
  final String location;
  final String description;
  final String sellerName;
  final String sellerPhone;
  final double trustScore;
  final bool verifiedStatus;
  final DateTime adExpiry;

  Property({
    required this.adId,
    required this.propertyTitle,
    required this.city,
    required this.adPurpose,
    required this.propertyType,
    required this.price,
    required this.bedrooms,
    required this.bathrooms,
    required this.images,
    required this.area,
    required this.location,
    required this.description,
    required this.sellerName,
    required this.sellerPhone,
    required this.trustScore,
    required this.verifiedStatus,
    required this.adExpiry,
  });

  factory Property.fromJson(Map<String, dynamic> json) {
    return Property(
      adId: json["adId"],
      propertyTitle: json["propertyTitle"],
      city: json["city"],
      adPurpose: json["adPurpose"],
      propertyType: json["propertyType"],
      price: json["price"],
      images: (json["images"] as List).map((item) => item as String).toList(),
      bedrooms: json["bedrooms"],
      bathrooms: json["bathrooms"],
      area: json["area"],
      location: json["location"],
      description: json["description"],
      sellerName: json["sellerName"],
      sellerPhone: json["sellerPhone"],
      trustScore: json["trustScore"],
      verifiedStatus: json["verifiedStatus"],
      adExpiry: json["adExpiry"],
    );
  }
}
