import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import '../../models/ticket_model.dart';
import '../../services/ticket_service.dart';
import '../../l10n/app_localizations.dart';

class AdminTicketsScreen extends StatefulWidget {
  const AdminTicketsScreen({super.key});

  @override
  State<AdminTicketsScreen> createState() => _AdminTicketsScreenState();
}

class _AdminTicketsScreenState extends State<AdminTicketsScreen> {
  final TicketService _ticketService = TicketService();
  String _filterStatus = 'All'; // All, Open, Processing, Resolved

  Color _getStatusColor(String status) {
    switch (status) {
      case 'Open':
        return Colors.orange;
      case 'Processing':
        return Colors.blue;
      case 'Resolved':
      case 'Closed':
        return Colors.green;
      default:
        return Colors.grey;
    }
  }

  String _getStatusText(String status, AppLocalizations l10n) {
    switch (status) {
      case 'Open':
        return l10n.open;
      case 'Processing':
        return l10n.processing;
      case 'Resolved':
        return l10n.resolved;
      case 'Closed':
        return l10n.closed;
      default:
        return status;
    }
  }

  String _getTypeText(String type, AppLocalizations l10n) {
    switch (type) {
      case 'Bug':
        return l10n.bug;
      case 'Suggestion':
        return l10n.suggestion;
      default:
        return l10n.other;
    }
  }

  void _showTicketDialog(TicketModel ticket) {
    final replyController = TextEditingController();
    bool isSubmitting = false;

    final l10n = AppLocalizations.of(context)!;
    showDialog(
      context: context,
      builder: (context) {
        return StatefulBuilder(
          builder: (context, setState) {
            return AlertDialog(
              title: Text(l10n.manageSupportTicket),
              content: SingleChildScrollView(
                child: Column(
                  mainAxisSize: MainAxisSize.min,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text('${l10n.user}: ${ticket.userEmail}', style: const TextStyle(fontWeight: FontWeight.bold)),
                    const SizedBox(height: 8),
                    Text('${l10n.issueType}: ${_getTypeText(ticket.type, l10n)}'),
                    const SizedBox(height: 8),
                    Text('${l10n.description}:', style: const TextStyle(fontWeight: FontWeight.bold)),
                    Container(
                      width: double.infinity,
                      padding: const EdgeInsets.all(8),
                      margin: const EdgeInsets.only(top: 4, bottom: 16),
                      decoration: BoxDecoration(
                        color: Colors.grey[200],
                        borderRadius: BorderRadius.circular(8),
                      ),
                      child: Text(ticket.description),
                    ),
                    if (ticket.status == 'Open') ...[
                      ElevatedButton.icon(
                        icon: const Icon(Icons.sync),
                        label: Text(l10n.markAsProcessing),
                        onPressed: isSubmitting ? null : () async {
                          final nav = Navigator.of(context);
                          setState(() => isSubmitting = true);
                          await _ticketService.updateTicketStatus(ticket.id, 'Processing');
                          nav.pop();
                        },
                      ),
                      const SizedBox(height: 16),
                    ],
                    if (ticket.status == 'Resolved' && ticket.adminReply != null) ...[
                      Text('${l10n.adminReply}:', style: const TextStyle(fontWeight: FontWeight.bold, color: Colors.green)),
                      const SizedBox(height: 4),
                      Text(ticket.adminReply!),
                    ] else ...[
                      TextField(
                        controller: replyController,
                        maxLines: 3,
                        decoration: InputDecoration(
                          labelText: l10n.adminReply,
                          hintText: l10n.enterDescription,
                          border: const OutlineInputBorder(),
                        ),
                      ),
                    ],
                  ],
                ),
              ),
              actions: [
                TextButton(
                  onPressed: () => Navigator.pop(context),
                  child: Text(l10n.cancel),
                ),
                if (ticket.status != 'Resolved')
                  ElevatedButton(
                    onPressed: isSubmitting
                        ? null
                        : () async {
                            if (replyController.text.trim().isEmpty) {
                              ScaffoldMessenger.of(context).showSnackBar(
                                SnackBar(content: Text(l10n.replyCannotBeEmpty)),
                              );
                              return;
                            }
                            final nav = Navigator.of(context);
                            setState(() => isSubmitting = true);
                            await _ticketService.replyAndResolveTicket(
                              ticket.id,
                              replyController.text.trim(),
                            );
                            nav.pop();
                          },
                    style: ElevatedButton.styleFrom(backgroundColor: Colors.green),
                    child: isSubmitting
                        ? const SizedBox(width: 20, height: 20, child: CircularProgressIndicator(color: Colors.white))
                        : Text(l10n.resolveAndSendReply, style: const TextStyle(color: Colors.white)),
                  ),
              ],
            );
          },
        );
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    final l10n = AppLocalizations.of(context)!;
    return Scaffold(
      body: Column(
        children: [
          Padding(
            padding: const EdgeInsets.all(16.0),
            child: SegmentedButton<String>(
              segments: [
                ButtonSegment(value: 'All', label: Text(l10n.all)),
                ButtonSegment(value: 'Open', label: Text(l10n.open)),
                ButtonSegment(value: 'Processing', label: Text(l10n.active)),
                ButtonSegment(value: 'Resolved', label: Text(l10n.closed)),
              ],
              selected: {_filterStatus},
              onSelectionChanged: (Set<String> newSelection) {
                setState(() {
                  _filterStatus = newSelection.first;
                });
              },
            ),
          ),
          Expanded(
            child: StreamBuilder<List<TicketModel>>(
              stream: _ticketService.getAllTicketsStream(),
              builder: (context, snapshot) {
                if (snapshot.connectionState == ConnectionState.waiting) {
                  return const Center(child: CircularProgressIndicator());
                }

                if (snapshot.hasError) {
                  return Center(child: Text('${l10n.error}: ${snapshot.error}'));
                }

                var tickets = snapshot.data ?? [];

                if (_filterStatus != 'All') {
                  tickets = tickets.where((t) => t.status == _filterStatus).toList();
                }

                if (tickets.isEmpty) {
                  return Center(
                    child: Text(
                      l10n.noTicketsFound(_filterStatus == 'All' ? '' : _getStatusText(_filterStatus, l10n).toLowerCase()),
                      style: const TextStyle(color: Colors.grey),
                    ),
                  );
                }

                return ListView.builder(
                  padding: const EdgeInsets.symmetric(horizontal: 16),
                  itemCount: tickets.length,
                  itemBuilder: (context, index) {
                    final ticket = tickets[index];
                    return Card(
                      margin: const EdgeInsets.only(bottom: 12),
                      elevation: 4,
                      child: ListTile(
                        onTap: () => _showTicketDialog(ticket),
                        leading: CircleAvatar(
                          backgroundColor: _getStatusColor(ticket.status).withValues(alpha: 0.2),
                          child: Icon(
                            ticket.type == 'Bug' ? Icons.bug_report : Icons.feedback,
                            color: _getStatusColor(ticket.status),
                          ),
                        ),
                        title: Text(
                          ticket.userEmail,
                          style: const TextStyle(fontWeight: FontWeight.bold, fontSize: 14),
                          maxLines: 1,
                          overflow: TextOverflow.ellipsis,
                        ),
                        subtitle: Text(
                          ticket.description,
                          maxLines: 2,
                          overflow: TextOverflow.ellipsis,
                        ),
                        trailing: Column(
                          mainAxisAlignment: MainAxisAlignment.center,
                          crossAxisAlignment: CrossAxisAlignment.end,
                          children: [
                            Text(
                              _getStatusText(ticket.status, l10n),
                              style: TextStyle(
                                color: _getStatusColor(ticket.status),
                                fontWeight: FontWeight.bold,
                                fontSize: 12,
                              ),
                            ),
                            const SizedBox(height: 4),
                            Text(
                              DateFormat('MMM d').format(ticket.createdAt),
                              style: const TextStyle(fontSize: 10, color: Colors.grey),
                            ),
                          ],
                        ),
                      ),
                    );
                  },
                );
              },
            ),
          ),
        ],
      ),
    );
  }
}
