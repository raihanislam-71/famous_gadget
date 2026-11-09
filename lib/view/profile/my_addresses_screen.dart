import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

import '../../models/saved_address.dart';
import '../utils/app_colors.dart';
import '../utils/app_text_styles.dart';
import 'add_address_screen.dart';
import '../navigation/app_navigation.dart';

class MyAddressesScreen extends StatefulWidget {
  const MyAddressesScreen({super.key});

  @override
  State<MyAddressesScreen> createState() => _MyAddressesScreenState();
}

class _MyAddressesScreenState extends State<MyAddressesScreen> {
  final List<SavedAddress> _addresses = [
    const SavedAddress(
      name: 'Arif Rahman',
      type: 'Home',
      phone: '+880 1712 345678',
      streetAddress: 'House 24, Road 5, Sector 3',
      city: 'Dhaka',
      postCode: '1230',
      district: 'Uttara',
      isDefault: true,
    ),
    const SavedAddress(
      name: 'Arif Rahman',
      type: 'Office',
      phone: '+880 1712 345678',
      streetAddress: 'Level 12, Tower B, Bashundhara City, Panthapath',
      city: 'Dhaka',
      postCode: '',
      district: 'Bashundhara',
    ),
  ];

  @override
  Widget build(BuildContext context) {
    return AnnotatedRegion<SystemUiOverlayStyle>(
      value: const SystemUiOverlayStyle(
        statusBarColor: AppColors.pageBackground,
        statusBarIconBrightness: Brightness.dark,
        statusBarBrightness: Brightness.light,
      ),
      child: Scaffold(
        backgroundColor: AppColors.pageBackground,
        appBar: AppBar(
          backgroundColor: AppColors.surface,
          foregroundColor: AppColors.navyDark,
          elevation: 0,
          scrolledUnderElevation: 0,
          surfaceTintColor: AppColors.surface,
          shape: const Border(bottom: BorderSide(color: AppColors.border)),
          toolbarHeight: 60,
          titleSpacing: 0,
          title: Text(
            'My Addresses',
            style: AppTextStyles.h2.copyWith(
              fontSize: 18,
              fontWeight: FontWeight.w700,
            ),
          ),
        ),
        body: ListView(
          padding: const EdgeInsets.fromLTRB(16, 16, 16, 24),
          children: [
            for (var index = 0; index < _addresses.length; index++) ...[
              _AddressCard(
                address: _addresses[index],
                onEdit: () => _openAddressForm(_addresses[index]),
              ),
              if (index < _addresses.length - 1) const SizedBox(height: 12),
            ],
            const SizedBox(height: 28),
            OutlinedButton.icon(
              onPressed: () => _openAddressForm(),
              icon: const Icon(Icons.add, size: 16),
              label: const Text('Add New Address'),
              style: OutlinedButton.styleFrom(
                foregroundColor: AppColors.primary,
                side: const BorderSide(color: AppColors.primary),
                minimumSize: const Size.fromHeight(42),
                shape: const StadiumBorder(),
                textStyle: AppTextStyles.button.copyWith(
                  fontSize: 13,
                  fontWeight: FontWeight.w600,
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  Future<void> _openAddressForm([SavedAddress? address]) async {
    final updatedAddress = await AppRoutes.to<SavedAddress>(
      route: AppRoutes.addressForm,
      arguments: {'address': address},
      mobileBuilder: () => AddAddressScreen(address: address),
    );
    if (!mounted || updatedAddress == null) return;

    setState(() {
      final existingIndex = address == null ? -1 : _addresses.indexOf(address);
      if (updatedAddress.isDefault) {
        for (var index = 0; index < _addresses.length; index++) {
          _addresses[index] = _addresses[index].copyWith(isDefault: false);
        }
      }

      if (address == null) {
        _addresses.add(updatedAddress);
      } else if (existingIndex != -1) {
        _addresses[existingIndex] = updatedAddress;
      }
    });
  }
}

class _AddressCard extends StatelessWidget {
  const _AddressCard({required this.address, required this.onEdit});

  final SavedAddress address;
  final VoidCallback onEdit;

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.fromLTRB(14, 12, 8, 12),
      decoration: BoxDecoration(
        color: AppColors.surface,
        borderRadius: BorderRadius.circular(14),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: [
              Flexible(
                child: Text(
                  '${address.name} (${address.type})',
                  maxLines: 1,
                  overflow: TextOverflow.ellipsis,
                  style: AppTextStyles.badge.copyWith(
                    fontSize: 12,
                    color: AppColors.navyDark,
                  ),
                ),
              ),
              if (address.isDefault) ...[
                const SizedBox(width: 6),
                Container(
                  padding: const EdgeInsets.symmetric(
                    horizontal: 5,
                    vertical: 2,
                  ),
                  decoration: BoxDecoration(
                    color: AppColors.softPeach,
                    borderRadius: BorderRadius.circular(3),
                  ),
                  child: Text(
                    'DEFAULT',
                    style: AppTextStyles.badge.copyWith(
                      fontSize: 7,
                      color: AppColors.primary,
                    ),
                  ),
                ),
              ],
              const Spacer(),
              IconButton(
                onPressed: onEdit,
                tooltip: 'Edit address',
                visualDensity: VisualDensity.compact,
                constraints: const BoxConstraints.tightFor(
                  width: 32,
                  height: 32,
                ),
                icon: const Icon(
                  Icons.edit_outlined,
                  size: 14,
                  color: AppColors.secondaryText,
                ),
              ),
            ],
          ),
          const SizedBox(height: 4),
          Text(
            address.phone,
            style: AppTextStyles.caption.copyWith(fontSize: 11),
          ),
          const SizedBox(height: 2),
          Text(
            address.formattedAddress,
            maxLines: 2,
            overflow: TextOverflow.ellipsis,
            style: AppTextStyles.caption.copyWith(fontSize: 11, height: 1.25),
          ),
        ],
      ),
    );
  }
}
