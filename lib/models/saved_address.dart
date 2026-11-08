class SavedAddress {
  const SavedAddress({
    required this.name,
    required this.phone,
    required this.streetAddress,
    required this.city,
    required this.postCode,
    required this.district,
    this.email = '',
    this.isDefault = false,
    this.type = 'Home',
  });

  final String name;
  final String phone;
  final String email;
  final String streetAddress;
  final String city;
  final String postCode;
  final String district;
  final bool isDefault;
  final String type;

  String get formattedAddress => [
    streetAddress,
    district,
    city,
  ].where((part) => part.isNotEmpty).join(', ');

  SavedAddress copyWith({bool? isDefault}) {
    return SavedAddress(
      name: name,
      phone: phone,
      email: email,
      streetAddress: streetAddress,
      city: city,
      postCode: postCode,
      district: district,
      isDefault: isDefault ?? this.isDefault,
      type: type,
    );
  }
}
