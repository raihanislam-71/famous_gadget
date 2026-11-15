import 'package:flutter/cupertino.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:get/get.dart';

import '../utils/app_colors.dart';
import '../utils/app_text_styles.dart';
import '../widgets/app_buttons.dart';
import 'widgets/checkout_step_indicator.dart';
import 'widgets/delivery/address_form.dart';
import 'widgets/delivery/dashed_border_button.dart';
import 'widgets/delivery/saved_address_card.dart';
import 'checkout_confirmation_screen.dart';
import '../navigation/app_navigation.dart';

class CheckoutDeliveryScreen extends StatefulWidget {
  const CheckoutDeliveryScreen({super.key});

  @override
  State<CheckoutDeliveryScreen> createState() => _CheckoutDeliveryScreenState();
}

class _CheckoutDeliveryScreenState extends State<CheckoutDeliveryScreen> {
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();
  final TextEditingController _nameController = TextEditingController(
    text: 'Arif Rahman',
  );
  final TextEditingController _phoneController = TextEditingController(
    text: '+880 1712 345678',
  );
  final TextEditingController _emailController = TextEditingController(
    text: 'arif@gmail.com',
  );
  final TextEditingController _streetController = TextEditingController(
    text: 'House 24, Road 5, Sector 3',
  );
  final TextEditingController _cityController = TextEditingController(
    text: 'Dhaka',
  );
  String _district = 'Uttara';
  bool _isSavedAddressSelected = true;

  @override
  void dispose() {
    _nameController.dispose();
    _phoneController.dispose();
    _emailController.dispose();
    _streetController.dispose();
    _cityController.dispose();
    super.dispose();
  }

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
        body: SafeArea(
          bottom: false,
          child: Column(
            children: [
              _buildAppBar(),
              const CheckoutStepIndicator(activeStep: 1),
              Expanded(
                child: ListView(
                  padding: const EdgeInsets.fromLTRB(16, 16, 16, 32),
                  children: [
                    Text(
                      'DELIVER TO',
                      style: AppTextStyles.badge.copyWith(
                        fontSize: 14,
                        color: Theme.of(context).colorScheme.onSurface,
                      ),
                    ),
                    const SizedBox(height: 16),
                    SavedAddressCard(
                      isSelected: _isSavedAddressSelected,
                      onTap: () => setState(() => _isSavedAddressSelected = true),
                    ),
                    const SizedBox(height: 16),
                    DashedBorderButton(
                      label: 'Add New Address',
                      onTap: _selectNewAddress,
                    ),
                    const SizedBox(height: 16),
                    Text(
                      'NEW ADDRESS FORM',
                      style: AppTextStyles.badge.copyWith(
                        fontSize: 14,
                        color: Theme.of(context).colorScheme.onSurface,
                      ),
                    ),
                    const SizedBox(height: 16),
                    AddressForm(
                      formKey: _formKey,
                      nameController: _nameController,
                      phoneController: _phoneController,
                      emailController: _emailController,
                      streetController: _streetController,
                      cityController: _cityController,
                      district: _district,
                      onChooseDistrict: _chooseDistrict,
                      requiredValidator: _requiredValidator,
                      phoneValidator: _phoneValidator,
                      emailValidator: _emailValidator,
                    ),
                  ],
                ),
              ),
              _buildContinueButton(),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildAppBar() {
    return Container(
      height: 60,
      padding: const EdgeInsets.symmetric(horizontal: 16),
      decoration: BoxDecoration(
        color: Theme.of(context).colorScheme.surface,
        border: Border(
          bottom: BorderSide(color: Theme.of(context).dividerColor),
        ),
      ),
      child: Row(
        children: [
          InkWell(
            onTap: kIsWeb ? null : () => Get.back<void>(),
            borderRadius: BorderRadius.circular(20),
            child: Padding(
              padding: const EdgeInsets.symmetric(vertical: 8, horizontal: 4),
              child: Row(
                children: [
                  if (!kIsWeb) ...[
                    Icon(
                      CupertinoIcons.back,
                      color: Theme.of(context).colorScheme.onSurface,
                    ),
                    const SizedBox(width: 12),
                  ],
                  Text(
                    'Checkout',
                    style: AppTextStyles.h2.copyWith(fontSize: 18),
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildContinueButton() {
    return Container(
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: Theme.of(context).colorScheme.surface,
        border: Border(top: BorderSide(color: Theme.of(context).dividerColor)),
      ),
      child: SafeArea(
        top: false,
        child: AppPrimaryButton(
          label: 'Continue to Confirmation',
          onPressed: _continueToConfirmation,
        ),
      ),
    );
  }

  void _selectNewAddress() {
    setState(() {
      _isSavedAddressSelected = false;
      _nameController.clear();
      _phoneController.clear();
      _emailController.clear();
      _streetController.clear();
      _cityController.clear();
      _district = '';
    });
  }

  Future<void> _chooseDistrict() async {
    const districts = ['Uttara', 'Gulshan', 'Dhanmondi', 'Mirpur'];
    final selected = await showModalBottomSheet<String>(
      context: context,
      backgroundColor: Theme.of(context).colorScheme.surface,
      builder: (context) => SafeArea(
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: districts
              .map(
                (district) => ListTile(
                  title: Text(district, style: AppTextStyles.body),
                  onTap: () => Navigator.pop(context, district),
                ),
              )
              .toList(),
        ),
      ),
    );
    if (selected != null && mounted) {
      setState(() => _district = selected);
    }
  }

  void _continueToConfirmation() {
    if (!_isSavedAddressSelected &&
        !(_formKey.currentState?.validate() ?? false)) {
      return;
    }
    if (!_isSavedAddressSelected && _district.trim().isEmpty) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text('Select a district or zone.')),
      );
      return;
    }

    final address = _isSavedAddressSelected
        ? 'Arif Rahman (Home)\n'
              '+880 1712 345678\n'
              'House 24, Road 5, Sector 3, Uttara, Dhaka'
        : '${_nameController.text.trim()}\n'
              '${_phoneController.text.trim()}\n'
              '${_streetController.text.trim()}, '
              '${_district.trim()}, ${_cityController.text.trim()}';

    AppRoutes.to<void>(
      route: AppRoutes.checkoutConfirmation,
      arguments: {'deliveryAddress': address},
      mobileBuilder: () => CheckoutConfirmationScreen(deliveryAddress: address),
    );
  }

  String? _requiredValidator(String? value) =>
      value == null || value.trim().isEmpty ? 'Required' : null;

  String? _phoneValidator(String? value) {
    final digits = value?.replaceAll(RegExp(r'\D'), '') ?? '';
    return digits.length >= 10 ? null : 'Enter a valid phone number';
  }

  String? _emailValidator(String? value) {
    final email = value?.trim() ?? '';
    return email.contains('@') && email.contains('.')
        ? null
        : 'Enter a valid email address';
  }
}
