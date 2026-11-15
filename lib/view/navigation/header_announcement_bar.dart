import 'package:flutter/material.dart';

import '../utils/app_colors.dart';

class HeaderAnnouncementBar extends StatelessWidget {
  const HeaderAnnouncementBar({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.infinity,
      color: AppColors.primary,
      padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 8),
      child: Center(
        child: ConstrainedBox(
          constraints: const BoxConstraints(maxWidth: 1280),
          child: Row(
            children: [
              const Expanded(
                child: Text(
                  'Gadgets you love. Cash on Delivery BD.',
                  style: TextStyle(color: Colors.white, fontSize: 12),
                ),
              ),
              if (MediaQuery.sizeOf(context).width > 650)
                const Text(
                  'Track Order     Store Locator     Support: 09612-FAMOUS',
                  style: TextStyle(color: Colors.white, fontSize: 12),
                ),
            ],
          ),
        ),
      ),
    );
  }
}
