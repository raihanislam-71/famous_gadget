import 'package:flutter/material.dart';

class WebHeroSection extends StatelessWidget {
  final VoidCallback onShopNow;
  final ValueChanged<String> onViewDeals;

  const WebHeroSection({
    super.key,
    required this.onShopNow,
    required this.onViewDeals,
  });

  @override
  Widget build(BuildContext context) {
    return LayoutBuilder(
      builder: (context, constraints) {
        final width = constraints.maxWidth;
        final compact = width < 720;
        final isDark = Theme.of(context).brightness == Brightness.dark;

        final hero = Container(
          width: double.infinity,
          constraints: BoxConstraints(minHeight: compact ? 410 : 420),
          padding: EdgeInsets.all(compact ? 24 : 48),
          decoration: BoxDecoration(
            gradient: LinearGradient(
              colors: isDark
                  ? const [Color(0xFF0B1220), Color(0xFF7C2D12)]
                  : const [Color(0xFFFFF8F2), Color(0xFFFFE7D2)],
            ),
            borderRadius: BorderRadius.circular(compact ? 20 : 32),
          ),
          child: Flex(
            direction: compact ? Axis.vertical : Axis.horizontal,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              Flexible(
                flex: compact ? 0 : 6,
                fit: compact ? FlexFit.loose : FlexFit.tight,
                child: Column(
                  mainAxisSize: MainAxisSize.min,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Container(
                      padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 6),
                      decoration: BoxDecoration(
                        color: isDark ? Colors.white : const Color(0xFFFF6A00),
                        borderRadius: BorderRadius.circular(8),
                      ),
                      child: Text(
                        'WINTER BLOCKBUSTER DEAL',
                        style: TextStyle(
                          color: isDark ? const Color(0xFFFF6A00) : Colors.white,
                          fontSize: 11,
                          fontWeight: FontWeight.w800,
                        ),
                      ),
                    ),
                    const SizedBox(height: 18),
                    Text(
                      'Up to 40% Off on Smart Watches',
                      style: Theme.of(context).textTheme.displaySmall?.copyWith(
                        fontSize: compact ? 34 : 48,
                        height: 1.12,
                        fontWeight: FontWeight.w800,
                        color: isDark ? Colors.white : const Color(0xFF0B1220),
                      ),
                    ),
                    const SizedBox(height: 12),
                    Text(
                      'Upgrade your lifestyle with original premium gadgets. Official brand warranty with fast cash on delivery across Bangladesh.',
                      style: TextStyle(
                        color: isDark ? Colors.white70 : Colors.black54,
                        height: 1.5,
                      ),
                    ),
                    const SizedBox(height: 22),
                    Wrap(
                      spacing: 12,
                      runSpacing: 10,
                      children: [
                        FilledButton(
                          onPressed: onShopNow,
                          child: const Text('Shop Collection Now'),
                        ),
                        OutlinedButton(
                          onPressed: () => onViewDeals('Hot Deals'),
                          style: OutlinedButton.styleFrom(
                            foregroundColor: isDark ? Colors.white : const Color(0xFF0B1220),
                            side: BorderSide(color: isDark ? Colors.white : const Color(0xFF0B1220)),
                          ),
                          child: const Text('View All Deals'),
                        ),
                      ],
                    ),
                  ],
                ),
              ),
              if (!compact) const SizedBox(width: 24),
              Flexible(
                flex: compact ? 0 : 4,
                fit: compact ? FlexFit.loose : FlexFit.tight,
                child: Padding(
                  padding: EdgeInsets.only(top: compact ? 20 : 0),
                  child: Image.asset(
                    'assets/images/figma_web/web_hero_watch.png',
                    height: compact ? 210 : 330,
                    fit: BoxFit.contain,
                    errorBuilder: (_, _, _) => const Icon(
                      Icons.watch_outlined,
                      size: 180,
                      color: Color(0xFFFF6A00),
                    ),
                  ),
                ),
              ),
            ],
          ),
        );

        return Padding(
          padding: EdgeInsets.fromLTRB(
            width > 1360 ? 80 : 24,
            32,
            width > 1360 ? 80 : 24,
            32,
          ),
          child: Center(
            child: ConstrainedBox(
              constraints: const BoxConstraints(maxWidth: 1280),
              child: hero,
            ),
          ),
        );
      },
    );
  }
}
