import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:get/get.dart';

import '../utils/app_colors.dart';
import '../utils/app_text_styles.dart';
import '../utils/assets_path.dart';
import '../widgets/app_buttons.dart';
import 'checkout_confirmation_screen.dart';

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
        backgroundColor: AppColors.pageBackground,
        body: SafeArea(
          bottom: false,
          child: Column(
            children: [
              _buildAppBar(),
              const CheckoutStepIndicator(activeStep: 1),
              Expanded(
                child: Form(
                  key: _formKey,
                  child: ListView(
                    padding: const EdgeInsets.fromLTRB(16, 16, 16, 32),
                    children: [
                      Text(
                        'DELIVER TO',
                        style: AppTextStyles.badge.copyWith(
                          fontSize: 14,
                          color: AppColors.navyDark,
                        ),
                      ),
                      const SizedBox(height: 16),
                      _buildSavedAddress(),
                      const SizedBox(height: 16),
                      _buildAddAddressButton(),
                      const SizedBox(height: 16),
                      Text(
                        'NEW ADDRESS FORM',
                        style: AppTextStyles.badge.copyWith(
                          fontSize: 14,
                          color: AppColors.navyDark,
                        ),
                      ),
                      const SizedBox(height: 16),
                      _buildAddressForm(),
                    ],
                  ),
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
      decoration: const BoxDecoration(
        color: AppColors.surface,
        border: Border(bottom: BorderSide(color: AppColors.border)),
      ),
      child: Row(
        children: [
          InkWell(
            onTap: () => Get.back<void>(),
            borderRadius: BorderRadius.circular(20),
            child: Padding(
              padding: const EdgeInsets.symmetric(vertical: 8, horizontal: 4),
              child: Row(
                children: [
                  SvgPicture.asset(
                    AssetsPath.checkoutBackArrow,
                    width: 24,
                    height: 24,
                  ),
                  const SizedBox(width: 12),
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

  Widget _buildSavedAddress() {
    return InkWell(
      onTap: () => setState(() => _isSavedAddressSelected = true),
      borderRadius: BorderRadius.circular(16),
      child: Container(
        padding: const EdgeInsets.all(14),
        decoration: BoxDecoration(
          color: AppColors.surface,
          border: Border.all(
            color: _isSavedAddressSelected
                ? AppColors.primary
                : AppColors.border,
            width: _isSavedAddressSelected ? 1.5 : 1,
          ),
          borderRadius: BorderRadius.circular(16),
        ),
        child: Row(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            _buildRadio(isSelected: _isSavedAddressSelected),
            const SizedBox(width: 12),
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Row(
                    children: [
                      Expanded(
                        child: Text(
                          'Arif Rahman (Home)',
                          style: AppTextStyles.badge.copyWith(fontSize: 14),
                        ),
                      ),
                      Container(
                        padding: const EdgeInsets.symmetric(
                          horizontal: 8,
                          vertical: 2,
                        ),
                        decoration: BoxDecoration(
                          color: AppColors.softPeach,
                          borderRadius: BorderRadius.circular(4),
                        ),
                        child: Text(
                          'DEFAULT',
                          style: AppTextStyles.body.copyWith(
                            fontSize: 10,
                            height: 1.3,
                            fontWeight: FontWeight.w700,
                            color: AppColors.primary,
                          ),
                        ),
                      ),
                    ],
                  ),
                  const SizedBox(height: 4),
                  Text(
                    '+880 1712 345678',
                    style: AppTextStyles.caption.copyWith(fontSize: 12),
                  ),
                  const SizedBox(height: 4),
                  Text(
                    'House 24, Road 5, Sector 3, Uttara, Dhaka',
                    style: AppTextStyles.caption.copyWith(fontSize: 12),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildRadio({required bool isSelected}) {
    return Container(
      width: 18,
      height: 18,
      decoration: BoxDecoration(
        shape: BoxShape.circle,
        border: Border.all(
          color: isSelected ? AppColors.primary : AppColors.border,
          width: isSelected ? 5 : 1.5,
        ),
      ),
    );
  }

  Widget _buildAddAddressButton() {
    return InkWell(
      onTap: _selectNewAddress,
      borderRadius: BorderRadius.circular(12),
      child: Container(
        height: 36,
        decoration: BoxDecoration(borderRadius: BorderRadius.circular(12)),
        child: CustomPaint(
          painter: const _DashedBorderPainter(
            color: AppColors.primary,
            radius: 12,
          ),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              SvgPicture.asset(AssetsPath.checkoutAdd, width: 16, height: 16),
              const SizedBox(width: 8),
              Text(
                'Add New Address',
                style: AppTextStyles.badge.copyWith(
                  fontSize: 13,
                  color: AppColors.primary,
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildAddressForm() {
    return Column(
      children: [
        _buildTextField(
          label: 'Full Name',
          controller: _nameController,
          validator: _requiredValidator,
          textCapitalization: TextCapitalization.words,
        ),
        const SizedBox(height: 12),
        _buildTextField(
          label: 'Phone Number',
          controller: _phoneController,
          validator: _phoneValidator,
          keyboardType: TextInputType.phone,
        ),
        const SizedBox(height: 12),
        _buildTextField(
          label: 'Email Address',
          controller: _emailController,
          validator: _emailValidator,
          keyboardType: TextInputType.emailAddress,
        ),
        const SizedBox(height: 12),
        _buildTextField(
          label: 'Street Address',
          controller: _streetController,
          validator: _requiredValidator,
        ),
        const SizedBox(height: 12),
        Row(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Expanded(
              child: _buildTextField(
                label: 'City',
                controller: _cityController,
                validator: _requiredValidator,
              ),
            ),
            const SizedBox(width: 12),
            Expanded(child: _buildDistrictDropdown()),
          ],
        ),
      ],
    );
  }

  Widget _buildTextField({
    required String label,
    required TextEditingController controller,
    required String? Function(String?) validator,
    TextInputType? keyboardType,
    TextCapitalization textCapitalization = TextCapitalization.none,
  }) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.stretch,
      children: [
        Text(
          label,
          style: AppTextStyles.badge.copyWith(
            fontSize: 13,
            color: AppColors.navyDark,
          ),
        ),
        const SizedBox(height: 6),
        SizedBox(
          height: 44,
          child: TextFormField(
            controller: controller,
            keyboardType: keyboardType,
            textCapitalization: textCapitalization,
            validator: validator,
            style: AppTextStyles.body.copyWith(
              fontSize: 14,
              height: 1,
              color: AppColors.navyDark,
            ),
            decoration: InputDecoration(
              filled: true,
              fillColor: AppColors.surface,
              contentPadding: const EdgeInsets.symmetric(horizontal: 16),
              border: _inputBorder(),
              enabledBorder: _inputBorder(),
              focusedBorder: _inputBorder(color: AppColors.primary),
              errorBorder: _inputBorder(color: AppColors.dangerRed),
              focusedErrorBorder: _inputBorder(color: AppColors.dangerRed),
              errorStyle: const TextStyle(fontSize: 10, height: 1),
            ),
          ),
        ),
      ],
    );
  }

  Widget _buildDistrictDropdown() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.stretch,
      children: [
        Text(
          'District/Zone',
          style: AppTextStyles.badge.copyWith(
            fontSize: 13,
            color: AppColors.navyDark,
          ),
        ),
        const SizedBox(height: 6),
        InkWell(
          onTap: _chooseDistrict,
          borderRadius: BorderRadius.circular(12),
          child: Container(
            height: 44,
            padding: const EdgeInsets.symmetric(horizontal: 16),
            decoration: BoxDecoration(
              color: AppColors.surface,
              border: Border.all(color: AppColors.border),
              borderRadius: BorderRadius.circular(12),
            ),
            child: Row(
              children: [
                Expanded(
                  child: Text(
                    _district,
                    style: AppTextStyles.body.copyWith(fontSize: 14, height: 1),
                  ),
                ),
                SvgPicture.asset(
                  AssetsPath.checkoutChevronDown,
                  width: 12,
                  height: 12,
                ),
              ],
            ),
          ),
        ),
      ],
    );
  }

  Widget _buildContinueButton() {
    return Container(
      padding: const EdgeInsets.all(16),
      decoration: const BoxDecoration(
        color: AppColors.surface,
        border: Border(top: BorderSide(color: AppColors.border)),
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
      backgroundColor: AppColors.surface,
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

    Get.to<void>(() => CheckoutConfirmationScreen(deliveryAddress: address));
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

  OutlineInputBorder _inputBorder({Color color = AppColors.border}) =>
      OutlineInputBorder(
        borderRadius: BorderRadius.circular(12),
        borderSide: BorderSide(color: color),
      );
}

class CheckoutStepIndicator extends StatelessWidget {
  const CheckoutStepIndicator({super.key, required this.activeStep});

  final int activeStep;

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 56,
      color: AppColors.surface,
      padding: const EdgeInsets.symmetric(horizontal: 16),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          _buildStep(1, 'Delivery'),
          _buildDivider(afterStep: 1),
          _buildStep(2, 'Confirm'),
          _buildDivider(afterStep: 2),
          _buildStep(3, 'Done'),
        ],
      ),
    );
  }

  Widget _buildDivider({required int afterStep}) => SvgPicture.asset(
    afterStep == 1
        ? AssetsPath.checkoutConfirmDividerActive
        : AssetsPath.checkoutStepDivider,
    width: 32,
    height: 2,
  );

  Widget _buildStep(int step, String label) {
    final active = step == activeStep;
    final completed = step < activeStep;
    return Row(
      mainAxisSize: MainAxisSize.min,
      children: [
        Container(
          width: 24,
          height: 24,
          alignment: Alignment.center,
          decoration: BoxDecoration(
            color: active || completed ? AppColors.primary : AppColors.border,
            shape: BoxShape.circle,
          ),
          child: Text(
            '$step',
            style: AppTextStyles.badge.copyWith(
              fontSize: 12,
              color: active || completed
                  ? AppColors.surface
                  : AppColors.secondaryText,
            ),
          ),
        ),
        const SizedBox(width: 6),
        Text(
          label,
          style: AppTextStyles.badge.copyWith(
            fontSize: 13,
            color: active ? AppColors.primary : AppColors.secondaryText,
            fontWeight: active ? FontWeight.w700 : FontWeight.w500,
          ),
        ),
      ],
    );
  }
}

class _DashedBorderPainter extends CustomPainter {
  const _DashedBorderPainter({required this.color, required this.radius});

  final Color color;
  final double radius;

  @override
  void paint(Canvas canvas, Size size) {
    final paint = Paint()
      ..color = color
      ..style = PaintingStyle.stroke
      ..strokeWidth = 1;
    final path = Path()
      ..addRRect(
        RRect.fromRectAndRadius(Offset.zero & size, Radius.circular(radius)),
      );
    for (final metric in path.computeMetrics()) {
      var distance = 0.0;
      while (distance < metric.length) {
        final next = (distance + 5).clamp(0.0, metric.length).toDouble();
        canvas.drawPath(metric.extractPath(distance, next), paint);
        distance = next + 4;
      }
    }
  }

  @override
  bool shouldRepaint(_DashedBorderPainter oldDelegate) =>
      color != oldDelegate.color || radius != oldDelegate.radius;
}
