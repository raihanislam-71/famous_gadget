import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:get/get.dart';

import '../../models/saved_address.dart';
import '../utils/app_colors.dart';
import '../utils/app_text_styles.dart';
import '../widgets/app_buttons.dart';

class AddAddressScreen extends StatefulWidget {
  const AddAddressScreen({super.key, this.address});

  final SavedAddress? address;

  @override
  State<AddAddressScreen> createState() => _AddAddressScreenState();
}

class _AddAddressScreenState extends State<AddAddressScreen> {
  final _formKey = GlobalKey<FormState>();
  late final TextEditingController _nameController;
  late final TextEditingController _phoneController;
  late final TextEditingController _emailController;
  late final TextEditingController _streetController;
  late final TextEditingController _cityController;
  late final TextEditingController _postCodeController;
  late final TextEditingController _districtController;
  late bool _isDefault;

  @override
  void initState() {
    super.initState();
    final address = widget.address;
    _nameController = TextEditingController(text: address?.name ?? '');
    _phoneController = TextEditingController(text: address?.phone ?? '');
    _emailController = TextEditingController(text: address?.email ?? '');
    _streetController = TextEditingController(
      text: address?.streetAddress ?? '',
    );
    _cityController = TextEditingController(text: address?.city ?? '');
    _postCodeController = TextEditingController(text: address?.postCode ?? '');
    _districtController = TextEditingController(text: address?.district ?? '');
    _isDefault = address?.isDefault ?? false;
  }

  @override
  Widget build(BuildContext context) {
    final isDarkMode = Theme.of(context).brightness == Brightness.dark;
    return AnnotatedRegion<SystemUiOverlayStyle>(
      value: SystemUiOverlayStyle(
        statusBarColor: Colors.transparent,
        statusBarIconBrightness: isDarkMode
            ? Brightness.light
            : Brightness.dark,
        statusBarBrightness: isDarkMode ? Brightness.dark : Brightness.light,
      ),
      child: Scaffold(
        // backgroundColor: Theme.of(context).scaffoldBackgroundColor,
        // appBar: AppBar(
        //   backgroundColor: Theme.of(context).colorScheme.surface,
        //   foregroundColor: Theme.of(context).colorScheme.onSurface,
        //   elevation: 0,
        //   scrolledUnderElevation: 0,
        //   surfaceTintColor: Theme.of(context).colorScheme.surface,
        //   shape: const Border(bottom: BorderSide(color: AppColors.border)),
        //   toolbarHeight: 60,
        //   automaticallyImplyLeading: false,
        //   titleSpacing: 0,
        //   title: Text(
        //     widget.address == null ? 'Add New Address' : 'Edit Address',
        //     style: AppTextStyles.h2.copyWith(
        //       fontSize: 18,
        //       fontWeight: FontWeight.w700,
        //     ),
        //   ),
        // ),
        body: SafeArea(
          top: false,
          child: Center(
            child: ConstrainedBox(
              constraints: const BoxConstraints(maxWidth: 920),
              child: Column(
                children: [
                  Expanded(
                    child: Center(
                      child: ConstrainedBox(
                        constraints: const BoxConstraints(maxWidth: 760),
                        child: Container(
                          margin: const EdgeInsets.all(kIsWeb ? 20 : 0),
                          decoration: kIsWeb
                              ? BoxDecoration(
                                  color: Theme.of(context).colorScheme.surface,
                                  borderRadius: BorderRadius.circular(16),
                                  border: Border.all(
                                    color: Theme.of(context).dividerColor,
                                  ),
                                )
                              : null,
                          child: Padding(
                            padding: const EdgeInsets.all(kIsWeb ? 24 : 0),
                            child: _buildAddressForm(context),
                          ),
                        ),
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }

  Widget _buildAddressForm(BuildContext context) {
    return Form(
      key: _formKey,
      child: Column(
        children: [
          Expanded(
            child: SingleChildScrollView(
              padding: const EdgeInsets.fromLTRB(16, 16, 16, 16),
              child: Column(
                children: [
                  _buildTextField(
                    label: 'Full Name',
                    controller: _nameController,
                    capitalization: TextCapitalization.words,
                  ),
                  const SizedBox(height: 12),
                  _buildTextField(
                    label: 'Phone Number',
                    controller: _phoneController,
                    keyboardType: TextInputType.phone,
                  ),
                  const SizedBox(height: 12),
                  _buildTextField(
                    label: 'Email (Optional)',
                    controller: _emailController,
                    hintText: 'e.g. arif@gmail.com',
                    keyboardType: TextInputType.emailAddress,
                    validator: _validateEmail,
                  ),
                  const SizedBox(height: 12),
                  _buildTextField(
                    label: 'Street Address',
                    controller: _streetController,
                    hintText: 'House, road, area',
                    capitalization: TextCapitalization.sentences,
                    maxLines: 2,
                    minLines: 2,
                  ),
                  const SizedBox(height: 12),
                  Row(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Expanded(
                        child: _buildTextField(
                          label: 'City',
                          controller: _cityController,
                          capitalization: TextCapitalization.words,
                        ),
                      ),
                      const SizedBox(width: 12),
                      Expanded(
                        child: _buildTextField(
                          label: 'Postcode',
                          controller: _postCodeController,
                          keyboardType: TextInputType.number,
                        ),
                      ),
                    ],
                  ),
                  const SizedBox(height: 12),
                  _buildTextField(
                    label: 'District / Zone',
                    controller: _districtController,
                    hintText: 'e.g. Uttara, Mirpur',
                    capitalization: TextCapitalization.words,
                  ),
                  const SizedBox(height: 8),
                  _buildDefaultSwitch(),
                ],
              ),
            ),
          ),
          Padding(
            padding: const EdgeInsets.fromLTRB(16, 8, 16, 12),
            child: AppPrimaryButton(
              label: 'Save Address',
              height: 48,
              onPressed: _saveAddress,
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildTextField({
    required String label,
    required TextEditingController controller,
    String? hintText,
    TextInputType? keyboardType,
    TextCapitalization capitalization = TextCapitalization.none,
    int minLines = 1,
    int maxLines = 1,
    String? Function(String?)? validator,
  }) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.stretch,
      children: [
        Text(
          label,
          style: AppTextStyles.badge.copyWith(
            fontSize: 11,
            color: Theme.of(context).colorScheme.onSurface,
          ),
        ),
        const SizedBox(height: 5),
        TextFormField(
          controller: controller,
          keyboardType: keyboardType,
          textCapitalization: capitalization,
          minLines: minLines,
          maxLines: maxLines,
          validator: validator ?? _requiredValidator,
          style: AppTextStyles.body.copyWith(
            fontSize: 12,
            height: 1.2,
            color: Theme.of(context).colorScheme.onSurface,
          ),
          decoration: InputDecoration(
            hintText: hintText,
            hintStyle: AppTextStyles.caption.copyWith(fontSize: 11),
            filled: true,
            fillColor: Theme.of(context).colorScheme.surface,
            isDense: true,
            contentPadding: const EdgeInsets.symmetric(
              horizontal: 12,
              vertical: 12,
            ),
            border: _inputBorder(),
            enabledBorder: _inputBorder(),
            focusedBorder: _inputBorder(color: AppColors.primary),
            errorBorder: _inputBorder(color: AppColors.dangerRed),
            focusedErrorBorder: _inputBorder(color: AppColors.dangerRed),
            errorStyle: const TextStyle(fontSize: 10, height: 1),
          ),
        ),
      ],
    );
  }

  Widget _buildDefaultSwitch() {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Text(
          'Set as default address',
          style: AppTextStyles.badge.copyWith(
            fontSize: 11,
            color: Theme.of(context).colorScheme.onSurface,
          ),
        ),
        Switch(
          value: _isDefault,
          activeThumbColor: AppColors.surface,
          activeTrackColor: AppColors.primary,
          onChanged: (value) => setState(() => _isDefault = value),
        ),
      ],
    );
  }

  OutlineInputBorder _inputBorder({Color color = AppColors.border}) {
    return OutlineInputBorder(
      borderRadius: BorderRadius.circular(10),
      borderSide: BorderSide(color: color),
    );
  }

  String? _requiredValidator(String? value) {
    if (value == null || value.trim().isEmpty) return 'This field is required';
    return null;
  }

  String? _validateEmail(String? value) {
    if (value == null || value.trim().isEmpty) return null;
    if (!GetUtils.isEmail(value.trim())) return 'Enter a valid email';
    return null;
  }

  void _saveAddress() {
    if (!_formKey.currentState!.validate()) return;

    Get.back<SavedAddress>(
      result: SavedAddress(
        name: _nameController.text.trim(),
        phone: _phoneController.text.trim(),
        email: _emailController.text.trim(),
        streetAddress: _streetController.text.trim(),
        city: _cityController.text.trim(),
        postCode: _postCodeController.text.trim(),
        district: _districtController.text.trim(),
        isDefault: _isDefault,
        type: widget.address?.type ?? 'Home',
      ),
    );
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
}
