import 'package:flutter/material.dart';

import '../utils/app_colors.dart';
import 'header_actions.dart';
import 'header_announcement_bar.dart';
import 'header_logo.dart';
import 'header_nav_links.dart';
import 'header_search_box.dart';

class WebSiteHeader extends StatefulWidget {
  const WebSiteHeader({super.key, this.isHome = true});

  final bool isHome;

  @override
  State<WebSiteHeader> createState() => _WebSiteHeaderState();
}

class _WebSiteHeaderState extends State<WebSiteHeader> {
  final TextEditingController _searchController = TextEditingController();

  @override
  void dispose() {
    _searchController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final isDark = theme.brightness == Brightness.dark;
    final foreground = theme.colorScheme.onSurface;

    if (!widget.isHome && MediaQuery.sizeOf(context).width < 768) {
      return const SizedBox.shrink();
    }

    return Column(
      children: [
        if (widget.isHome) const HeaderAnnouncementBar(),
        HeaderNavBar(
          isHome: widget.isHome,
          searchController: _searchController,
          foreground: foreground,
        ),
        Divider(
          height: 1,
          color: isDark ? AppColors.border : theme.dividerColor,
        ),
      ],
    );
  }
}

class HeaderNavBar extends StatelessWidget {
  const HeaderNavBar({
    super.key,
    required this.isHome,
    required this.searchController,
    required this.foreground,
  });

  final bool isHome;
  final TextEditingController searchController;
  final Color foreground;

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    return Container(
      color: theme.colorScheme.surface,
      padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 12),
      child: Center(
        child: ConstrainedBox(
          constraints: const BoxConstraints(maxWidth: 1280),
          child: isHome
              ? LayoutBuilder(
                  builder: (context, constraints) {
                    final compact = constraints.maxWidth < 850;
                    final veryCompact = constraints.maxWidth < 440;
                    final logo = HeaderLogo(width: veryCompact ? 112 : 156);
                    final search = HeaderSearchBox(controller: searchController);
                    final actions = HeaderActions(
                      foreground: foreground,
                      showWishlist: !veryCompact,
                    );

                    if (compact) {
                      return Column(
                        children: [
                          Row(children: [logo, const Spacer(), actions]),
                          const SizedBox(height: 10),
                          search,
                          const SizedBox(height: 10),
                          const HeaderNavLinks(),
                        ],
                      );
                    }

                    return Row(
                      children: [
                        logo,
                        const SizedBox(width: 32),
                        Expanded(child: search),
                        const SizedBox(width: 24),
                        const HeaderNavLinks(),
                        const SizedBox(width: 12),
                        actions,
                      ],
                    );
                  },
                )
              : Row(
                  children: [
                    const HeaderLogo(width: 156),
                    const Spacer(),
                    HeaderActions(foreground: foreground, showWishlist: true),
                  ],
                ),
        ),
      ),
    );
  }
}
