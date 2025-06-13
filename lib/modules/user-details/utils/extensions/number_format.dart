extension NumberFormatter on num {
  String formatCompact() {
    if (this >= 1e12) {
      return '${(this / 1e12).toStringAsFixed(1)} tri';
    } else if (this >= 1e9) {
      return '${(this / 1e9).toStringAsFixed(1)} bi';
    } else if (this >= 1e6) {
      return '${(this / 1e6).toStringAsFixed(1)} mi';
    } else if (this >= 1e3) {
      return '${(this / 1e3).toStringAsFixed(1)} mil';
    } else {
      return toString();
    }
  }
}
