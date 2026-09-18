import 'package:flutter/material.dart';

import '../models/member.dart';
import '../theme.dart';
import 'home_screen.dart';

class DetailScreen extends StatelessWidget {
  const DetailScreen({super.key, required this.member});

  static const route = '/detail';

  final Member member;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Center(
          child: ConstrainedBox(
            constraints: const BoxConstraints(maxWidth: 480),
            child: Padding(
              padding: const EdgeInsets.fromLTRB(24, 20, 24, 24),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.stretch,
                children: [
                  const _ProgressRail(step: 3),
                  const SizedBox(height: 28),
                  Text(
                    'You’re in,\n${member.firstName}.',
                    style: Theme.of(context).textTheme.headlineMedium?.copyWith(
                      fontWeight: FontWeight.w700,
                      height: 1.12,
                      color: KindredTheme.ink,
                    ),
                  ),
                  const SizedBox(height: 8),
                  Text(
                    'Show this card at the next gathering.',
                    style: Theme.of(context).textTheme.bodyLarge?.copyWith(
                      color: KindredTheme.moss,
                    ),
                  ),
                  const Spacer(),
                  _MembershipPass(member: member),
                  const Spacer(),
                  FilledButton(
                    onPressed: () => Navigator.popUntil(
                      context,
                      ModalRoute.withName(HomeScreen.route),
                    ),
                    child: const Text('Return to the lobby'),
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}

class _ProgressRail extends StatelessWidget {
  const _ProgressRail({required this.step});
  final int step;

  @override
  Widget build(BuildContext context) {
    return Row(
      children: List.generate(3, (index) {
        final active = index < step;
        return Expanded(
          child: Container(
            height: 4,
            margin: EdgeInsets.only(right: index == 2 ? 0 : 8),
            color: active ? KindredTheme.clay : KindredTheme.line,
          ),
        );
      }),
    );
  }
}

class _MembershipPass extends StatelessWidget {
  const _MembershipPass({required this.member});
  final Member member;

  @override
  Widget build(BuildContext context) {
    return Container(
      color: KindredTheme.forest,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          Padding(
            padding: const EdgeInsets.fromLTRB(22, 22, 22, 18),
            child: Row(
              children: [
                Container(
                  width: 52,
                  height: 52,
                  alignment: Alignment.center,
                  color: KindredTheme.clay,
                  child: Text(
                    member.initials,
                    style: const TextStyle(
                      color: KindredTheme.cream,
                      fontWeight: FontWeight.w800,
                      fontSize: 18,
                    ),
                  ),
                ),
                const SizedBox(width: 14),
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        'KINDRED MEMBER',
                        style: Theme.of(context).textTheme.labelLarge?.copyWith(
                          color: KindredTheme.cream.withValues(alpha: 0.7),
                          letterSpacing: 1.8,
                        ),
                      ),
                      Text(
                        member.memberId,
                        style: Theme.of(context).textTheme.titleMedium?.copyWith(
                          color: KindredTheme.cream,
                          fontWeight: FontWeight.w700,
                        ),
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ),
          CustomPaint(
            painter: _DashPainter(),
            child: const SizedBox(height: 12),
          ),
          ColoredBox(
            color: KindredTheme.cream,
            child: Padding(
              padding: const EdgeInsets.fromLTRB(22, 18, 22, 22),
              child: Column(
                children: [
                  _PassRow(label: 'Name', value: member.name),
                  const SizedBox(height: 14),
                  _PassRow(label: 'Email', value: member.email),
                  const SizedBox(height: 14),
                  _PassRow(label: 'Seat', value: member.circle),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}

class _PassRow extends StatelessWidget {
  const _PassRow({required this.label, required this.value});
  final String label;
  final String value;

  @override
  Widget build(BuildContext context) {
    return Row(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        SizedBox(
          width: 72,
          child: Text(
            label.toUpperCase(),
            style: Theme.of(context).textTheme.labelMedium?.copyWith(
              color: KindredTheme.moss,
              letterSpacing: 1.1,
            ),
          ),
        ),
        Expanded(
          child: Text(
            value,
            style: const TextStyle(
              fontWeight: FontWeight.w700,
              color: KindredTheme.ink,
            ),
          ),
        ),
      ],
    );
  }
}

class _DashPainter extends CustomPainter {
  @override
  void paint(Canvas canvas, Size size) {
    final paint = Paint()
      ..color = KindredTheme.parchment
      ..strokeWidth = 2;
    const dash = 7.0;
    const gap = 6.0;
    var x = 0.0;
    final y = size.height / 2;
    while (x < size.width) {
      canvas.drawLine(Offset(x, y), Offset(x + dash, y), paint);
      x += dash + gap;
    }
  }

  @override
  bool shouldRepaint(covariant CustomPainter oldDelegate) => false;
}
