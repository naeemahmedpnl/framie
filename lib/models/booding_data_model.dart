class BookingData {
  final String id;
  final DateTime bookingDate;
  final String practitionerName;
  final double amount;
  final String status;
  final double subtotal;
  final double discount;
  final double tax;
  final double totalPrice;
  final String cardholderName;
  final String cardNumber;
  final String cardType;

  BookingData({
    required this.id,
    required this.bookingDate,
    required this.practitionerName,
    required this.amount,
    required this.status,
    required this.subtotal,
    required this.discount,
    required this.tax,
    required this.totalPrice,
    required this.cardholderName,
    required this.cardNumber,
    required this.cardType,
  });
}
