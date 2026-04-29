import 'package:cloud_firestore/cloud_firestore.dart';

class TicketModel {
  final String id;
  final String userId;
  final String userEmail;
  final String type; // Bug, Suggestion, Other
  final String description;
  final DateTime createdAt;
  final String status; // Open, Processing, Resolved, Closed
  final String? adminReply;
  final DateTime? resolvedAt;

  TicketModel({
    required this.id,
    required this.userId,
    required this.userEmail,
    required this.type,
    required this.description,
    required this.createdAt,
    this.status = 'Open',
    this.adminReply,
    this.resolvedAt,
  });

  Map<String, dynamic> toMap() {
    return {
      'id': id,
      'userId': userId,
      'userEmail': userEmail,
      'type': type,
      'description': description,
      'createdAt': Timestamp.fromDate(createdAt),
      'status': status,
      'adminReply': adminReply,
      'resolvedAt': resolvedAt != null ? Timestamp.fromDate(resolvedAt!) : null,
    };
  }

  factory TicketModel.fromMap(Map<String, dynamic> map) {
    return TicketModel(
      id: map['id'] ?? '',
      userId: map['userId'] ?? '',
      userEmail: map['userEmail'] ?? '',
      type: map['type'] ?? 'Other',
      description: map['description'] ?? '',
      createdAt: (map['createdAt'] as Timestamp?)?.toDate() ?? DateTime.now(),
      status: map['status'] ?? 'Open',
      adminReply: map['adminReply'],
      resolvedAt: (map['resolvedAt'] as Timestamp?)?.toDate(),
    );
  }

  TicketModel copyWith({
    String? id,
    String? userId,
    String? userEmail,
    String? type,
    String? description,
    DateTime? createdAt,
    String? status,
    String? adminReply,
    DateTime? resolvedAt,
  }) {
    return TicketModel(
      id: id ?? this.id,
      userId: userId ?? this.userId,
      userEmail: userEmail ?? this.userEmail,
      type: type ?? this.type,
      description: description ?? this.description,
      createdAt: createdAt ?? this.createdAt,
      status: status ?? this.status,
      adminReply: adminReply ?? this.adminReply,
      resolvedAt: resolvedAt ?? this.resolvedAt,
    );
  }
}
