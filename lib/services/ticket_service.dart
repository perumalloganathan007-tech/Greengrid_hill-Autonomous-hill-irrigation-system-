import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/foundation.dart';
import '../models/ticket_model.dart';
import 'package:uuid/uuid.dart';

class TicketService {
  final FirebaseFirestore _firestore = FirebaseFirestore.instance;
  final String _collectionName = 'feedback_tickets';
  final _uuid = const Uuid();

  // Create a new ticket (for user)
  Future<void> createTicket({
    required String userId,
    required String userEmail,
    required String type,
    required String description,
  }) async {
    try {
      final String id = _uuid.v4();
      final ticket = TicketModel(
        id: id,
        userId: userId,
        userEmail: userEmail,
        type: type,
        description: description,
        createdAt: DateTime.now(),
        status: 'Open',
      );

      await _firestore.collection(_collectionName).doc(id).set(ticket.toMap());
    } catch (e) {
      debugPrint('Error creating ticket: $e');
      rethrow;
    }
  }

  // Stream of tickets for a specific user
  Stream<List<TicketModel>> getUserTicketsStream(String userId) {
    return _firestore
        .collection(_collectionName)
        .where('userId', isEqualTo: userId)
        .snapshots()
        .map((snapshot) {
      final tickets = snapshot.docs
          .map((doc) => TicketModel.fromMap(doc.data()))
          .toList();
      // Sort locally to bypass Firebase composite index requirement
      tickets.sort((a, b) => b.createdAt.compareTo(a.createdAt));
      return tickets;
    });
  }

  // Stream of all tickets for admins
  Stream<List<TicketModel>> getAllTicketsStream() {
    return _firestore
        .collection(_collectionName)
        .orderBy('createdAt', descending: true)
        .snapshots()
        .map((snapshot) => snapshot.docs
            .map((doc) => TicketModel.fromMap(doc.data()))
            .toList());
  }

  // Update ticket status
  Future<void> updateTicketStatus(String ticketId, String newStatus) async {
    try {
      await _firestore.collection(_collectionName).doc(ticketId).update({
        'status': newStatus,
      });
    } catch (e) {
      debugPrint('Error updating ticket status: $e');
      rethrow;
    }
  }

  // Reply and resolve ticket
  Future<void> replyAndResolveTicket(String ticketId, String reply) async {
    try {
      await _firestore.collection(_collectionName).doc(ticketId).update({
        'status': 'Resolved',
        'adminReply': reply,
        'resolvedAt': FieldValue.serverTimestamp(),
      });
    } catch (e) {
      debugPrint('Error replying and resolving ticket: $e');
      rethrow;
    }
  }
}
