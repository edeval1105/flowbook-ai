// Modelo de dados para Agendamentos
class Appointment {
  final int id;
  final int professionalId;
  final int serviceId;
  final DateTime startAt;
  final DateTime endAt;
  final double price;
  final String status;
  final String? customerName;
  final String? customerPhone;
  final String? notes;

  Appointment({
    required this.id,
    required this.professionalId,
    required this.serviceId,
    required this.startAt,
    required this.endAt,
    required this.price,
    required this.status,
    this.customerName,
    this.customerPhone,
    this.notes,
  });

  // Converte JSON para o objeto Appointment
  factory Appointment.fromJson(Map<String, dynamic> json) {
    return Appointment(
      id: json['id'],
      professionalId: json['professional_id'] ?? json['professionalId'],
      serviceId: json['service_id'] ?? json['serviceId'],
      startAt: DateTime.parse(json['start_at'] ?? json['startAt']),
      endAt: DateTime.parse(json['end_at'] ?? json['endAt']),
      price: double.parse(json['price'].toString()),
      status: json['status'],
      customerName: json['customer_name'] ?? json['customerName'],
      customerPhone: json['customer_phone'] ?? json['customerPhone'],
      notes: json['notes'],
    );
  }

  // Converte o objeto para JSON
  Map<String, dynamic> toJson() {
    return {
      'professionalId': professionalId,
      'serviceId': serviceId,
      'startAt': startAt.toIso8601String(),
      'endAt': endAt.toIso8601String(),
      'price': price,
      'customerName': customerName,
      'customerPhone': customerPhone,
      'notes': notes,
    };
  }
}

