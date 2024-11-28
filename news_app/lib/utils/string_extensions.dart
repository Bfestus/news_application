// lib/utils/string_extensions.dart

extension StringCapitalization on String {
  String capitalize() {
    if (this.isEmpty) return this;
    return this[0].toUpperCase() + this.substring(1);
  }
}
