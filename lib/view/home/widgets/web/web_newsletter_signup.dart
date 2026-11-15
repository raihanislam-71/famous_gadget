import 'package:flutter/material.dart';
import 'package:get/get.dart';


class WebNewsletterSignup extends StatefulWidget {
  const WebNewsletterSignup({super.key});

  @override
  State<WebNewsletterSignup> createState() => _WebNewsletterSignupState();
}

class _WebNewsletterSignupState extends State<WebNewsletterSignup> {
  final _emailController = TextEditingController();

  @override
  void dispose() {
    _emailController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(28),
      decoration: BoxDecoration(
        color: Theme.of(context).cardColor,
        borderRadius: BorderRadius.circular(20),
        border: Border.all(color: Theme.of(context).dividerColor),
      ),
      child: LayoutBuilder(
        builder: (context, constraints) {
          final compact = constraints.maxWidth < 700;
          final content = Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                "Don't Miss Latest Tech Trends",
                style: Theme.of(context).textTheme.headlineSmall
                    ?.copyWith(fontWeight: FontWeight.w800),
              ),
              const SizedBox(height: 8),
              Text(
                'Subscribe to get special discount vouchers, flash sale alerts, '
                'and reviews of the latest gadgets.',
                style: Theme.of(context).textTheme.bodySmall,
              ),
            ],
          );
          final form = Row(
            children: [
              Expanded(
                child: TextField(
                  controller: _emailController,
                  keyboardType: TextInputType.emailAddress,
                  decoration: const InputDecoration(
                    hintText: 'Enter your email address',
                    border: OutlineInputBorder(),
                  ),
                ),
              ),
              const SizedBox(width: 8),
              FilledButton(
                onPressed: _subscribe,
                child: const Text('Subscribe'),
              ),
            ],
          );
          if (compact) {
            return Column(
              crossAxisAlignment: CrossAxisAlignment.stretch,
              children: [content, const SizedBox(height: 20), form],
            );
          }
          return Row(
            children: [
              Expanded(child: content),
              const SizedBox(width: 28),
              SizedBox(width: 456, child: form),
            ],
          );
        },
      ),
    );
  }

  void _subscribe() {
    final email = _emailController.text.trim();
    if (!email.contains('@') || !email.contains('.')) {
      Get.snackbar('Invalid email', 'Enter a valid email address.');
      return;
    }
    Get.snackbar(
      'Thanks for subscribing',
      'Newsletter subscriptions are demo-only.',
    );
  }
}
