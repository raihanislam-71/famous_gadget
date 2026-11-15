import 'package:famous_gadget/view/checkout/widgets/delivery/address_text_field.dart';
import 'package:famous_gadget/view/checkout/widgets/delivery/district_dropdown.dart';
import 'package:flutter/material.dart';

class AddressForm extends StatelessWidget {
  final GlobalKey<FormState> formKey;
  final TextEditingController nameController;
  final TextEditingController phoneController;
  final TextEditingController emailController;
  final TextEditingController streetController;
  final TextEditingController cityController;
  final String district;
  final VoidCallback onChooseDistrict;
  final String? Function(String?) requiredValidator;
  final String? Function(String?) phoneValidator;
  final String? Function(String?) emailValidator;

  const AddressForm({
    super.key,
    required this.formKey,
    required this.nameController,
    required this.phoneController,
    required this.emailController,
    required this.streetController,
    required this.cityController,
    required this.district,
    required this.onChooseDistrict,
    required this.requiredValidator,
    required this.phoneValidator,
    required this.emailValidator,
  });

  @override
  Widget build(BuildContext context) {
    return Form(
      key: formKey,
      child: Column(
        children: [
          _buildTextField(
            context,
            label: 'Full Name',
            controller: nameController,
            validator: requiredValidator,
            textCapitalization: TextCapitalization.words,
          ),
          const SizedBox(height: 12),
          _buildTextField(
            context,
            label: 'Phone Number',
            controller: phoneController,
            validator: phoneValidator,
            keyboardType: TextInputType.phone,
          ),
          const SizedBox(height: 12),
          _buildTextField(
            context,
            label: 'Email Address',
            controller: emailController,
            validator: emailValidator,
            keyboardType: TextInputType.emailAddress,
          ),
          const SizedBox(height: 12),
          _buildTextField(
            context,
            label: 'Street Address',
            controller: streetController,
            validator: requiredValidator,
          ),
          const SizedBox(height: 12),
          Row(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Expanded(
                child: _buildTextField(
                  context,
                  label: 'City',
                  controller: cityController,
                  validator: requiredValidator,
                ),
              ),
              const SizedBox(width: 12),
              Expanded(
                child: DistrictDropdown(
                  label: 'District/Zone',
                  value: district,
                  onTap: onChooseDistrict,
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }

  Widget _buildTextField(
    BuildContext context, {
    required String label,
    required TextEditingController controller,
    required String? Function(String?) validator,
    TextInputType? keyboardType,
    TextCapitalization textCapitalization = TextCapitalization.none,
  }) {
    return AddressTextField(
      label: label,
      controller: controller,
      validator: validator,
      keyboardType: keyboardType,
      textCapitalization: textCapitalization,
    );
  }
}
