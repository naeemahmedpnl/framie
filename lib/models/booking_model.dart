class Booking {
  final String id;
  final String practitionerName;
  final double amount;
  final DateTime bookingDate;
  final String status;

  Booking({
    required this.id,
    required this.practitionerName,
    required this.amount,
    required this.bookingDate,
    required this.status,
  });
}