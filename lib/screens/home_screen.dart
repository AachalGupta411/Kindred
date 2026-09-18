import 'package:flutter/material.dart';

import '../theme.dart';
import 'registration_screen.dart';

class HomeScreen extends StatelessWidget {
  const HomeScreen({super.key});

  static const route = '/';

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: LayoutBuilder(
        builder: (context, constraints) {
          final wide = constraints.maxWidth >= 720;
          if (wide) {
            return const Row(
              children: [
                Expanded(flex: 5, child: _Masthead()),
                Expanded(flex: 6, child: _StoryPanel()),
              ],
            );
          }
          return const Column(
            children: [
              Expanded(flex: 4, child: _Masthead()),
              Expanded(flex: 6, child: _StoryPanel()),
            ],
          );
        },
      ),
    );
  }
}

class _Masthead extends StatelessWidget {
  const _Masthead();

  @override
  Widget build(BuildContext context) {
    return ColoredBox(
      color: KindredTheme.forest,
      child: SafeArea(
        child: LayoutBuilder(
          builder: (context, constraints) {
            return SingleChildScrollView(
              padding: const EdgeInsets.fromLTRB(28, 28, 28, 24),
              child: ConstrainedBox(
                constraints: BoxConstraints(minHeight: constraints.maxHeight),
                child: IntrinsicHeight(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Row(
                        children: [
                          Container(
                            width: 12,
                            height: 12,
                            color: KindredTheme.clay,
                          ),
                          const SizedBox(width: 10),
                          Text(
                            'KINDRED',
                            style: Theme.of(context).textTheme.titleSmall
                                ?.copyWith(
                                  color: KindredTheme.cream,
                                  letterSpacing: 4,
                                  fontWeight: FontWeight.w700,
                                ),
                          ),
                        ],
                      ),
                      const Spacer(),
                      Text(
                        'A reading\ncircle for\nslow evenings.',
                        style: Theme.of(context).textTheme.displaySmall
                            ?.copyWith(
                              color: KindredTheme.cream,
                              height: 1.05,
                              fontWeight: FontWeight.w700,
                            ),
                      ),
                      const SizedBox(height: 16),
                      Text(
                        'Neighborhood members, borrowed books, and a quiet table once a month.',
                        style: Theme.of(context).textTheme.titleMedium
                            ?.copyWith(
                              color: KindredTheme.cream.withValues(alpha: 0.78),
                              height: 1.4,
                            ),
                      ),
                      const Spacer(),
                    ],
                  ),
                ),
              ),
            );
          },
        ),
      ),
    );
  }
}

class _StoryPanel extends StatelessWidget {
  const _StoryPanel();

  @override
  Widget build(BuildContext context) {
    return ColoredBox(
      color: KindredTheme.parchment,
      child: SafeArea(
        child: Padding(
          padding: const EdgeInsets.fromLTRB(28, 24, 28, 24),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                'This season',
                style: Theme.of(context).textTheme.labelLarge?.copyWith(
                  color: KindredTheme.clay,
                  letterSpacing: 1.6,
                  fontWeight: FontWeight.w700,
                ),
              ),
              const SizedBox(height: 8),
              Text(
                'Join the circle',
                style: Theme.of(context).textTheme.headlineMedium?.copyWith(
                  fontWeight: FontWeight.w700,
                  color: KindredTheme.ink,
                ),
              ),
              const SizedBox(height: 22),
              const Expanded(
                child: SingleChildScrollView(
                  child: Column(
                    children: [
                      _ShelfRow(
                        index: '01',
                        title: 'Pick a seat',
                        body: 'Reader, host, or keeper of the shelves.',
                      ),
                      Divider(color: KindredTheme.line, height: 28),
                      _ShelfRow(
                        index: '02',
                        title: 'Leave your name',
                        body: 'A short form. No fuss, just the essentials.',
                      ),
                      Divider(color: KindredTheme.line, height: 28),
                      _ShelfRow(
                        index: '03',
                        title: 'Collect your card',
                        body: 'Your membership details, ready to show.',
                      ),
                    ],
                  ),
                ),
              ),
              const SizedBox(height: 16),
              FilledButton(
                onPressed: () =>
                    Navigator.pushNamed(context, RegistrationScreen.route),
                child: const Text('Become a member'),
              ),
              const SizedBox(height: 10),
              Center(
                child: Text(
                  'Already in the circle? Ask a host.',
                  style: Theme.of(context).textTheme.bodyMedium?.copyWith(
                    color: KindredTheme.moss,
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

class _ShelfRow extends StatelessWidget {
  const _ShelfRow({
    required this.index,
    required this.title,
    required this.body,
  });

  final String index;
  final String title;
  final String body;

  @override
  Widget build(BuildContext context) {
    return Row(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        SizedBox(
          width: 42,
          child: Text(
            index,
            style: Theme.of(context).textTheme.titleMedium?.copyWith(
              color: KindredTheme.clay,
              fontWeight: FontWeight.w700,
            ),
          ),
        ),
        Expanded(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                title,
                style: Theme.of(context).textTheme.titleLarge?.copyWith(
                  fontWeight: FontWeight.w700,
                  color: KindredTheme.ink,
                ),
              ),
              const SizedBox(height: 4),
              Text(
                body,
                style: Theme.of(context).textTheme.bodyLarge?.copyWith(
                  color: KindredTheme.moss,
                  height: 1.4,
                ),
              ),
            ],
          ),
        ),
      ],
    );
  }
}
