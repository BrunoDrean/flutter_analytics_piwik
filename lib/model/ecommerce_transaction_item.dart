class EcommerceTransactionItem {
  final String sku;
  final String? name;
  final String? category;
  final int price;
  final int quantity;

  EcommerceTransactionItem({
    required this.sku,
    required this.price,
    required this.quantity,
    this.name,
    this.category,
  });
}
