class Member {
  const Member({
    required this.name,
    required this.email,
    required this.circle,
  });

  final String name;
  final String email;
  final String circle;

  String get firstName {
    final parts = name.trim().split(RegExp(r'\s+'));
    return parts.first;
  }

  String get initials {
    final parts = name.trim().split(RegExp(r'\s+'));
    if (parts.length == 1) {
      return parts.first.substring(0, 1).toUpperCase();
    }
    return (parts.first[0] + parts.last[0]).toUpperCase();
  }

  String get memberId {
    final seed = name.hashCode.abs() % 9000 + 1000;
    return 'KND-$seed';
  }
}
