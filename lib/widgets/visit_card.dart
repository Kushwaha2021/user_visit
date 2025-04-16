import 'package:flutter/material.dart';
import 'package:user_visit/models/visit_model.dart';
import 'package:user_visit/providers/visits_provider.dart';
import 'package:intl/intl.dart';


class VisitCard extends StatelessWidget {
  final Visit visit;

  const VisitCard({required this.visit, super.key});

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: () {

      },
      child: Container(
        padding: const EdgeInsets.all(16.0),
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(12.0),
          boxShadow: [
            BoxShadow(
              color: Colors.grey.withOpacity(0.1),
              spreadRadius: 1,
              blurRadius: 4,
              offset: const Offset(0, 2),
            ),
          ],
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(
                  visit.id,
                  style: const TextStyle(
                      fontWeight: FontWeight.bold,
                      fontSize: 14,
                      color: Colors.black87
                  ),
                ),
                Container(
                  padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 4),
                  decoration: BoxDecoration(
                    color: visit.status.color, // Use extension getter
                    borderRadius: BorderRadius.circular(20),
                  ),
                  child: Text(
                    visit.status.displayTitle, // Use extension getter
                    style: TextStyle(
                      fontSize: 11,
                      fontWeight: FontWeight.w500,
                      color: visit.status.textColor, // Use extension getter
                    ),
                  ),
                ),
              ],
            ),
            const SizedBox(height: 4),
            Text(
              visit.dateTime.formatVisitDateTime(),
              style: TextStyle(color: Colors.grey.shade600, fontSize: 12),
            ),
            const Divider(height: 24, thickness: 0.5), // Adds a subtle divider
            Row(
              children: [
                Icon(Icons.person_outline, size: 18, color: Colors.grey.shade600),
                const SizedBox(width: 8),
                Expanded( // Ensure name doesn't overflow
                  child: Text(
                    visit.customerName,
                    style: const TextStyle(
                        fontSize: 14,
                        color: Colors.black87,
                        fontWeight: FontWeight.w500),
                    overflow: TextOverflow.ellipsis,
                  ),
                ),
                const SizedBox(width: 8),
                Icon(Icons.arrow_forward_ios, size: 14, color: Colors.grey.shade400),
              ],
            ),
          ],
        ),
      ),
    );
  }
}