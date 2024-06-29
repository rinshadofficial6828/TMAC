extension AssetImageExtension on String {
  String get imagePath => 'assets/images/$this';
  String get rupee => '₹ $this';
}