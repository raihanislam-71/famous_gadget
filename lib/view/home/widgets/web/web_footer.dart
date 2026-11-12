import 'package:famous_gadget/view/utils/app_colors.dart';
import 'package:famous_gadget/view/utils/assets_path.dart';
import 'package:flutter/material.dart';

class WebFooter extends StatelessWidget {
  final ValueChanged<String>? onAccountLinkTap;

  const WebFooter({super.key, this.onAccountLinkTap});

  @override
  Widget build(BuildContext context) {
    return Container(
      color: const Color(0xFF0B1220),
      width: double.infinity,
      padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 48),
      child: Center(
        child: ConstrainedBox(
          constraints: const BoxConstraints(maxWidth: 1280),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Wrap(
                spacing: 48,
                runSpacing: 32,
                alignment: WrapAlignment.spaceBetween,
                children: [
                  SizedBox(
                    width: 250,
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Row(
                          children: [
                            Image.asset(AssetsPath.appLogo, width: 40),
                            const SizedBox(width: 8),
                            Image.asset(AssetsPath.appName, width: 112, color: Colors.white),
                          ],
                        ),
                        const SizedBox(height: 16),
                        const Text('Shop 363 #Level 3, Computer City Center, (Multiplan) New Elephant Road, Dhaka-1205, Bangladesh.', style: TextStyle(color: Colors.white70, height: 1.5)),
                        const SizedBox(height: 14),
                        const Text('Download App', style: TextStyle(color: AppColors.primary, fontWeight: FontWeight.w700)),
                      ],
                    ),
                  ),
                  const _FooterLinks(title: 'Contact', links: ['+8801934777923', '+8801934777924', '+8801934777925', 'famousgadget2022@gmail.com'], textColor: Colors.white70),
                  _FooterLinks(
                    title: 'My Account',
                    links: const ['My Account', 'Order History'],
                    textColor: Colors.white70,
                    onTap: onAccountLinkTap,
                  ),
                  const _FooterLinks(
                    title: 'Useful Links',
                    links: ['Brands', 'Privacy Policy', 'Refund and Return Policy', 'Terms & Conditions', 'EMI Information', 'Contact Us'],
                    textColor: Colors.white70,
                  ),
                ],
              ),
              const SizedBox(height: 36),
              Divider(color: Colors.white.withValues(alpha: 0.16)),
              const SizedBox(height: 14),
              const Text('© 2026 Famous Gadget Bangladesh. All rights reserved.', style: TextStyle(color: Colors.white70, fontSize: 12)),
            ],
          ),
        ),
      ),
    );
  }
}

class _FooterLinks extends StatelessWidget {
  const _FooterLinks({required this.title, required this.links, required this.textColor, this.onTap});
  final String title; final List<String> links; final Color textColor; final ValueChanged<String>? onTap;
  @override
  Widget build(BuildContext context) => SizedBox(
      width: 190,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(title, style: const TextStyle(color: Colors.white, fontWeight: FontWeight.w700)),
          const SizedBox(height: 14),
          for (final link in links)
            Padding(
              padding: const EdgeInsets.only(bottom: 10),
              child: InkWell(
                onTap: onTap == null ? null : () => onTap!(link),
                child: Text(link, style: TextStyle(color: textColor, fontSize: 12)),
              ),
            ),
        ],
      ),
    );
}
