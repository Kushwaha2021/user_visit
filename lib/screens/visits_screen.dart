import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:user_visit/models/visit_model.dart';
import 'package:user_visit/providers/visits_provider.dart';
import 'package:user_visit/screens/search_screen.dart';
import 'package:user_visit/widgets/filter_visits_sheet.dart';
import 'package:user_visit/widgets/visit_card.dart';


class VisitsScreen extends StatelessWidget {
  const VisitsScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final visitsProvider = context.watch<VisitsProvider>();
    final visitCount = visitsProvider.visitCount;

    return Scaffold(
      body: CustomScrollView(
        slivers: [
          _buildHeader(context),
          _buildControls(context, visitCount),
          _buildVisitList(context, visitsProvider.filteredVisits),
        ],
      ),
    );
  }

  Widget _buildHeader(BuildContext context) {
    return SliverAppBar(
      expandedHeight: 180.0,
      pinned: false,
      backgroundColor: Colors.transparent,
      elevation: 0,
      automaticallyImplyLeading: false,
      flexibleSpace: FlexibleSpaceBar(
        collapseMode: CollapseMode.pin,
        background: Container(
          padding: EdgeInsets.only(top: MediaQuery.of(context).padding.top + 10, left: 16, right: 16, bottom: 10),
          decoration: BoxDecoration(
            color: Colors.indigo.shade700,
            borderRadius: const BorderRadius.only(
              bottomLeft: Radius.circular(20),
              bottomRight: Radius.circular(20),
            ),
          ),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Row(
                children: [
                  IconButton(
                    icon: const Icon(Icons.menu, color: Colors.white),
                    onPressed: () {  },
                  ),
                  const SizedBox(width: 8),
                  const Text(
                    '10 MARK',
                    style: TextStyle(color: Colors.white, fontSize: 22,fontWeight: FontWeight.bold),
                  ),                  const Spacer(),
                  const Row(
                    children: [
                      Icon(Icons.wifi, color: Colors.white, size: 18),
                      SizedBox(width: 5),
                      Icon(Icons.signal_cellular_alt, color: Colors.white, size: 18),
                      SizedBox(width: 5),
                      Icon(Icons.battery_full, color: Colors.white, size: 18),
                    ],
                  )
                ],
              ),
              const Spacer(),
              const Text(
                'WELCOME BACK',
                style: TextStyle(color: Colors.white70, fontSize: 14),
              ),
              const SizedBox(height: 4),
              Row(
                crossAxisAlignment: CrossAxisAlignment.end,
                children: [
                  const Text(
                    'Manikanada Krishnan',
                    style: TextStyle(
                        color: Colors.white,
                        fontSize: 18,
                        fontWeight: FontWeight.bold),
                  ),
                  const Spacer(),
                  // Scooter Image
                  Image.asset('assets/scooter.png', height: 70,fit: BoxFit.fill,), // Adjust height as needed
                ],
              ),
              const SizedBox(height: 10),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildControls(BuildContext context, int visitCount) {
    return SliverPadding(
      padding: const EdgeInsets.symmetric(horizontal: 16.0, vertical: 16.0),
      sliver: SliverToBoxAdapter(
        child: Row(
          children: [
            const Text(
              'My Visits',
              style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
            ),
            const SizedBox(width: 8),
            Chip(
              label: Text(
                visitCount.toString().padLeft(2, '0'),
                style: const TextStyle(color: Colors.white, fontWeight: FontWeight.bold),
              ),
              backgroundColor: Colors.blue.shade700,
              padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 2),
              visualDensity: VisualDensity.compact,
            ),
            const Spacer(),
            _buildControlButton(
              context: context,
              icon: Icons.search,
              onPressed: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(builder: (context) => const SearchScreen()),
                );
              },
            ),
            const SizedBox(width: 8),
            _buildControlButton(
              context: context,
              icon: Icons.tune,
              onPressed: () {
                showModalBottomSheet(
                  context: context,
                  backgroundColor: Colors.white,
                  isScrollControlled: true,
                  shape: const RoundedRectangleBorder(
                    borderRadius: BorderRadius.vertical(top: Radius.circular(20)),
                  ),
                  builder: (_) => const FilterVisitsSheet(),
                );
              },
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildControlButton({
    required BuildContext context,
    required IconData icon,
    required VoidCallback onPressed,
  }) {
    return InkWell(
      onTap: onPressed,
      borderRadius: BorderRadius.circular(8),
      child: Container(
        padding: const EdgeInsets.all(8),
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(8),
          boxShadow: [
            BoxShadow(
              color: Colors.grey.withOpacity(0.1),
              spreadRadius: 1,
              blurRadius: 3,
              offset: const Offset(0, 1),
            ),
          ],
        ),
        child: Icon(icon, color: Colors.grey.shade600),
      ),
    );
  }


  Widget _buildVisitList(BuildContext context, List<Visit> visits) {
    if (visits.isEmpty) {
      return const SliverFillRemaining(
        child: Center(
          child: Text(
            'No visits found matching your criteria.',
            style: TextStyle(color: Colors.grey),
          ),
        ),
      );
    }

    return SliverPadding(
      padding: const EdgeInsets.only(left: 16.0, right: 16.0, bottom: 16.0),
      sliver: SliverList(
        delegate: SliverChildBuilderDelegate(
              (context, index) {
            final visit = visits[index];
            return Padding(
              padding: const EdgeInsets.only(bottom: 12.0), // Spacing between cards
              child: VisitCard(visit: visit),
            );
          },
          childCount: visits.length,
        ),
      ),
    );
  }
}