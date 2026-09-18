import 'package:flutter/material.dart';

import '../models/member.dart';
import '../theme.dart';
import 'detail_screen.dart';

class RegistrationScreen extends StatefulWidget {
  const RegistrationScreen({super.key});

  static const route = '/register';

  @override
  State<RegistrationScreen> createState() => _RegistrationScreenState();
}

class _RegistrationScreenState extends State<RegistrationScreen> {
  final _form = GlobalKey<FormState>();
  final _name = TextEditingController();
  final _email = TextEditingController();
  final _password = TextEditingController();
  String _circle = 'Reader';
  bool _hidden = true;
  bool _accepted = false;
  bool _attempted = false;

  static const _circles = ['Reader', 'Host', 'Keeper'];

  @override
  void dispose() {
    _name.dispose();
    _email.dispose();
    _password.dispose();
    super.dispose();
  }

  void _submit() {
    setState(() => _attempted = true);
    final valid = _form.currentState!.validate();
    if (valid && _accepted) {
      Navigator.pushNamed(
        context,
        DetailScreen.route,
        arguments: Member(
          name: _name.text.trim(),
          email: _email.text.trim(),
          circle: _circle,
        ),
      );
    }
  }

  String? _nameValidator(String? value) {
    if (value == null || value.trim().isEmpty) {
      return 'Name is required';
    }
    if (value.trim().length < 2) {
      return 'Please enter your full name';
    }
    return null;
  }

  String? _emailValidator(String? value) {
    if (value == null || value.trim().isEmpty) {
      return 'Email is required';
    }
    final email = value.trim();
    final pattern = RegExp(r'^[^\s@]+@[^\s@]+\.[^\s@]+$');
    if (!pattern.hasMatch(email)) {
      return 'Enter a valid email address';
    }
    return null;
  }

  String? _passwordValidator(String? value) {
    if (value == null || value.isEmpty) {
      return 'Password is required';
    }
    if (value.length < 8) {
      return 'Use at least 8 characters';
    }
    if (!RegExp(r'[A-Za-z]').hasMatch(value) ||
        !RegExp(r'\d').hasMatch(value)) {
      return 'Include a letter and a number';
    }
    return null;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        leading: IconButton(
          icon: const Icon(Icons.arrow_back),
          onPressed: () => Navigator.pop(context),
        ),
        title: const Text('Membership'),
        centerTitle: false,
      ),
      body: Center(
        child: ConstrainedBox(
          constraints: const BoxConstraints(maxWidth: 560),
          child: Form(
            key: _form,
            autovalidateMode: _attempted
                ? AutovalidateMode.always
                : AutovalidateMode.disabled,
            child: ListView(
              key: const Key('registration-form'),
              padding: const EdgeInsets.fromLTRB(24, 8, 24, 36),
              children: [
                const _ProgressRail(step: 2),
                const SizedBox(height: 28),
                Text(
                  'Leave your name\nat the desk.',
                  style: Theme.of(context).textTheme.headlineMedium?.copyWith(
                    fontWeight: FontWeight.w700,
                    height: 1.15,
                    color: KindredTheme.ink,
                  ),
                ),
                const SizedBox(height: 8),
                Text(
                  'Required fields first. We only keep what the circle needs.',
                  style: Theme.of(context).textTheme.bodyLarge?.copyWith(
                    color: KindredTheme.moss,
                  ),
                ),
                const SizedBox(height: 28),
                _SectionLabel('Identity'),
                const SizedBox(height: 12),
                TextFormField(
                  controller: _name,
                  textInputAction: TextInputAction.next,
                  textCapitalization: TextCapitalization.words,
                  decoration: const InputDecoration(
                    labelText: 'Full name',
                    prefixIcon: Icon(Icons.badge_outlined),
                  ),
                  validator: _nameValidator,
                ),
                const SizedBox(height: 14),
                TextFormField(
                  controller: _email,
                  keyboardType: TextInputType.emailAddress,
                  textInputAction: TextInputAction.next,
                  autocorrect: false,
                  decoration: const InputDecoration(
                    labelText: 'Email address',
                    prefixIcon: Icon(Icons.alternate_email),
                  ),
                  validator: _emailValidator,
                ),
                const SizedBox(height: 14),
                TextFormField(
                  controller: _password,
                  obscureText: _hidden,
                  textInputAction: TextInputAction.done,
                  onFieldSubmitted: (_) => _submit(),
                  decoration: InputDecoration(
                    labelText: 'Password',
                    helperText: 'At least 8 characters, with a letter and a number',
                    prefixIcon: const Icon(Icons.key_outlined),
                    suffixIcon: IconButton(
                      onPressed: () => setState(() => _hidden = !_hidden),
                      icon: Icon(
                        _hidden
                            ? Icons.visibility_outlined
                            : Icons.visibility_off_outlined,
                      ),
                    ),
                  ),
                  validator: _passwordValidator,
                ),
                const SizedBox(height: 32),
                _SectionLabel('Your seat in the circle'),
                const SizedBox(height: 12),
                ..._circles.map(
                  (circle) => _CircleTile(
                    label: circle,
                    selected: _circle == circle,
                    onTap: () => setState(() => _circle = circle),
                  ),
                ),
                const SizedBox(height: 18),
                CheckboxListTile(
                  value: _accepted,
                  onChanged: (value) =>
                      setState(() => _accepted = value ?? false),
                  contentPadding: EdgeInsets.zero,
                  controlAffinity: ListTileControlAffinity.leading,
                  activeColor: KindredTheme.forest,
                  title: const Text(
                    'I agree to the house rules and privacy note',
                    style: TextStyle(fontSize: 14),
                  ),
                  subtitle: _attempted && !_accepted
                      ? const Text(
                          'Required to continue',
                          style: TextStyle(
                            color: KindredTheme.clay,
                            fontSize: 12,
                          ),
                        )
                      : null,
                ),
                const SizedBox(height: 18),
                FilledButton(
                  onPressed: _submit,
                  child: const Text('Request membership'),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}

class _SectionLabel extends StatelessWidget {
  const _SectionLabel(this.text);
  final String text;

  @override
  Widget build(BuildContext context) {
    return Text(
      text.toUpperCase(),
      style: Theme.of(context).textTheme.labelLarge?.copyWith(
        letterSpacing: 2,
        color: KindredTheme.clay,
        fontWeight: FontWeight.w700,
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

class _CircleTile extends StatelessWidget {
  const _CircleTile({
    required this.label,
    required this.selected,
    required this.onTap,
  });

  final String label;
  final bool selected;
  final VoidCallback onTap;

  String get _blurb {
    switch (label) {
      case 'Host':
        return 'Opens the room and keeps time.';
      case 'Keeper':
        return 'Tracks the shelves and returns.';
      default:
        return 'Shows up with a book and a note.';
    }
  }

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 8),
      child: InkWell(
        onTap: onTap,
        child: Container(
          padding: const EdgeInsets.symmetric(horizontal: 14, vertical: 14),
          decoration: BoxDecoration(
            color: selected ? KindredTheme.forest : KindredTheme.cream,
            border: Border.all(
              color: selected ? KindredTheme.forest : KindredTheme.line,
            ),
          ),
          child: Row(
            children: [
              Icon(
                selected ? Icons.radio_button_checked : Icons.radio_button_off,
                color: selected ? KindredTheme.cream : KindredTheme.moss,
                size: 22,
              ),
              const SizedBox(width: 12),
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      label,
                      style: TextStyle(
                        fontWeight: FontWeight.w700,
                        color: selected
                            ? KindredTheme.cream
                            : KindredTheme.ink,
                      ),
                    ),
                    Text(
                      _blurb,
                      style: TextStyle(
                        fontSize: 13,
                        color: selected
                            ? KindredTheme.cream.withValues(alpha: 0.8)
                            : KindredTheme.moss,
                      ),
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
