import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:get/get.dart';

import '../../models/saved_address.dart';
import '../utils/app_colors.dart';
import '../utils/app_text_styles.dart';
import 'add_address_screen.dart';
import 'widgets/my_addresses/address_card.dart';

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
        backgroundColor: Theme.of(context).scaffoldBackgroundColor,
        appBar: _buildAppBar(context),
        body: ListView(
          padding: const EdgeInsets.fromLTRB(16, 16, 16, 24),
          children: [
            _buildAddressList(),
            const SizedBox(height: 28),
            _buildAddButton(),
          ],
        ),
      ),
    );
  }

  AppBar _buildAppBar(BuildContext context) {
    return AppBar(
      backgroundColor: Theme.of(context).colorScheme.surface,
      foregroundColor: Theme.of(context).colorScheme.onSurface,
      elevation: 0,
      scrolledUnderElevation: 0,
      surfaceTintColor: Theme.of(context).colorScheme.surface,
      shape: const Border(bottom: BorderSide(color: AppColors.border)),
      toolbarHeight: 60,
      automaticallyImplyLeading: false,
      titleSpacing: 16,
      title: Text(
        'My Addresses',
        style: AppTextStyles.h2.copyWith(
          fontSize: 18,
          fontWeight: FontWeight.w700,
        ),
      ),
    );
  }

  Widget _buildAddressList() {
    return Column(
      children: List.generate(_addresses.length, (index) {
        final address = _addresses[index];
        return Padding(
          padding: EdgeInsets.only(bottom: index < _addresses.length - 1 ? 12 : 0),
          child: AddressCard(
            address: address,
            onEdit: () => _openAddressForm(address),
          ),
        );
      }),
    );
  }

  Widget _buildAddButton() {
    return OutlinedButton.icon(
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
    );
  }

  Future<void> _openAddressForm([SavedAddress? address]) async {
    final updatedAddress = await Get.to<SavedAddress>(
      () => AddAddressScreen(address: address),
      preventDuplicates: false,
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
