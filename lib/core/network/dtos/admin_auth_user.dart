/// Row from [admin_users] returned by the verify-otp Edge Function.
class AdminAuthUser {
  const AdminAuthUser({
    required this.id,
    required this.name,
    required this.email,
    this.phone,
    this.role,
    this.isActive,
  });

  factory AdminAuthUser.fromJson(Map<String, dynamic> json) {
    return AdminAuthUser(
      id: json['id'] as String? ?? '',
      name: json['name'] as String? ?? '',
      email: json['email'] as String? ?? '',
      phone: json['phone'] as String?,
      role: json['role'] as String?,
      isActive: json['is_active'] as bool?,
    );
  }

  final String id;
  final String name;
  final String email;
  final String? phone;
  final String? role;
  final bool? isActive;
}
