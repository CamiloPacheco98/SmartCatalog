/// Extension for formatting integers as prices
extension PriceFormatter on int {
  /// Formats a price number with dot separators for thousands
  /// Example: 1234 -> "1.234", 1234567 -> "1.234.567"
  String get formattedPrice {
    return toString().replaceAllMapped(
      RegExp(r'(\d{1,3})(?=(\d{3})+(?!\d))'),
      (Match m) => '${m[1]}.',
    );
  }

  /// Formats a price with dollar sign prefix
  /// Example: 1234 -> "$1.234"
  String get formattedPriceWithCurrency {
    return '\$$formattedPrice';
  }
}

/// Extension for formatting strings as prices (for cases where price is stored as string)
extension StringPriceFormatter on String {
  /// Formats a price string with dot separators for thousands
  /// Example: "1234" -> "1.234", "1234567" -> "1.234.567"
  String get formattedPrice {
    return replaceAllMapped(
      RegExp(r'(\d{1,3})(?=(\d{3})+(?!\d))'),
      (Match m) => '${m[1]}.',
    );
  }

  /// Formats a price string with dollar sign prefix
  /// Example: "1234" -> "$1.234"
  String get formattedPriceWithCurrency {
    return '\$$formattedPrice';
  }
}
