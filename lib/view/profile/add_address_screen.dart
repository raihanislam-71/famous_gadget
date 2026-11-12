import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:get/get.dart';

import '../../models/saved_address.dart';
import '../utils/app_colors.dart';
import '../utils/app_text_styles.dart';
import '../widgets/app_buttons.dart';
import 'widgets/add_address/address_text_field.dart';

class AddAddressScreen extends StatefulWidget {
  const AddAddressScreen({super.key, this.address});

  final SavedAddress? address;

  @override
  State<AddAddressScreen> createState() => _AddAddressScreenState();
}

class _AddAddressScreenState extends State<AddAddressScreen> {
  final _formKey = GlobalKey<FormState>();
  final _nameController = TextEditingController();
  final _phoneController = TextEditingController();
  final _emailController = TextEditingController();
  final _streetController = TextEditingController();
  final _cityController = TextEditingController();
  final _postCodeController = TextEditingController();
  final _districtController = TextEditingController();
  bool _isDefault = false;

  @override
  void initState() {
    super.initState();
    _nameController.text = widget.address?.name ?? '';
    _phoneController.text = widget.address?.phone ?? '';
    _emailController.text = widget.address?.email ?? '';
    _streetController.text = widget.address?.streetAddress ?? '';
    _cityController.text = widget.address?.city ?? '';
    _postCodeController.text = widget.address?.postCode ?? '';
    _districtController.text = widget.address?.district ?? '';
    _isDefault = widget.address?.isDefault ?? false;
  }

  @override
  void dispose() {
    _nameController.dispose();
    _phoneController.dispose();
    _emailController.dispose();
    _streetController.dispose();
    _cityController.dispose();
    _postCodeController.dispose();
    _districtController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return AnnotatedRegion<SystemUiOverlayStyle>(
      value: const SystemUiOverlayStyle(statusBarColor: Colors.transparent, statusBarIconBrightness: Brightness.dark, statusBarBrightness: Brightness.light),
      child: Scaffold(
        body: SafeArea(
          top: false,
          child: Center(
            child: ConstrainedBox(
              constraints: const BoxConstraints(maxWidth: 920),
              child: Container(
                margin: const EdgeInsets.all(kIsWeb ? 20 : 0),
                decoration: kIsWeb ? BoxDecoration(color: Theme.of(context).colorScheme.surface, borderRadius: BorderRadius.circular(16), border: Border.all(color: Theme.of(context).dividerColor)) : null,
                child: Padding(
                  padding: const EdgeInsets.all(kIsWeb ? 24 : 0),
                  child: _buildForm(),
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }

  Widget _buildForm() {
    return Form(
      key: _formKey,
      child: Column(
        children: [
          Expanded(
            child: SingleChildScrollView(
              padding: const EdgeInsets.fromLTRB(16, 16, 16, 16),
              child: Column(
                children: [
                  AddressTextField(label: 'Full Name', controller: _nameController, capitalization: TextCapitalization.words),
                  const SizedBox(height: 12),
                  AddressTextField(label: 'Phone Number', controller: _phoneController, keyboardType: TextInputType.phone),
                  const SizedBox(height: 12),
                  AddressTextField(label: 'Email (Optional)', controller: _emailController, hintText: 'e.g. arif@gmail.com', keyboardType: TextInputType.emailAddress, validator: _validateEmail),
                  const SizedBox(height: 12),
                  AddressTextField(label: 'Street Address', controller: _streetController, hintText: 'House, road, area', capitalization: TextCapitalization.sentences, minLines: 2, maxLines: 2),
                  const SizedBox(height: 12),
                  Row(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Expanded(child: AddressTextField(label: 'City', controller: _cityController, capitalization: TextCapitalization.words)),
                      const SizedBox(width: 12),
                      Expanded(child: AddressTextField(label: 'Postcode', controller: _postCodeController, keyboardType: TextInputType.number)),
                    ],
                  ),
                  const SizedBox(height: 12),
                  AddressTextField(label: 'District / Zone', controller: _districtController, hintText: 'e.g. Uttara, Mirpur', capitalization: TextCapitalization.words),
                  const SizedBox(height: 8),
                  _buildDefaultSwitch(),
                ],
              ),
            ),
          ),
          Padding(
            padding: const EdgeInsets.fromLTRB(16, 8, 16, 12),
            child: AppPrimaryButton(label: 'Save Address', height: 48, onPressed: _save),
          ),
        ],
      ),
    );
  }

  Widget _buildDefaultSwitch() => Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Text('Set as default address', style: AppTextStyles.badge.copyWith(fontSize: 11, color: Theme.of(context).colorScheme.onSurface)),
          Switch(value: _isDefault, activeThumbColor: AppColors.surface, activeTrackColor: AppColors.primary, onChanged: (v) => setState(() => _isDefault = v)),
        ],
      );

  String? _validateEmail(String? v) => (v == null || v.trim().isEmpty) ? null : (GetUtils.isEmail(v.trim()) ? null : 'Enter a valid email');

  void _save() {
    if (!_formKey.currentState!.validate()) return;
    Get.back<SavedAddress>(result: SavedAddress(
      name: _nameController.text.trim(),
      phone: _phoneController.text.trim(),
      email: _emailController.text.trim(),
      streetAddress: _streetController.text.trim(),
      city: _cityController.text.trim(),
      postCode: _postCodeController.text.trim(),
      district: _districtController.text.trim(),
      isDefault: _isDefault,
      type: widget.address?.type ?? 'Home',
    ));
  }
}
