import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../providers/visits_provider.dart';

class SearchScreen extends StatefulWidget {
  const SearchScreen({super.key});

  @override
  State<SearchScreen> createState() => _SearchScreenState();
}

class _SearchScreenState extends State<SearchScreen> {
  final _searchController = TextEditingController();

  @override
  void initState() {
    super.initState();
    _searchController.text = context.read<VisitsProvider>().searchQuery;
    _searchController.selection = TextSelection.fromPosition(
        TextPosition(offset: _searchController.text.length));
  }

  @override
  void dispose() {
    _searchController.dispose();
    super.dispose();
  }

  void _performSearchAndNavigateBack(String query) {
    if (query.trim().isEmpty) {
      context.read<VisitsProvider>().clearSearch();
    } else {
      context.read<VisitsProvider>().searchVisits(query);
    }
    if (Navigator.canPop(context)) {
      Navigator.pop(context);
    }
  }

  @override
  Widget build(BuildContext context) {
    final visitsProvider = context.watch<VisitsProvider>();

    return Scaffold(
      appBar: AppBar(
        leading: IconButton(
          icon: const Icon(Icons.arrow_back),
          onPressed: () {
            context.read<VisitsProvider>().clearSearch();
            Navigator.pop(context);
          },
        ),
        title: const Text('Search Visit',
            style: TextStyle(fontSize: 18, fontWeight: FontWeight.w600)),
        elevation: 1.0,
        shadowColor: Colors.grey.withOpacity(0.2),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            TextField(
              controller: _searchController,
              autofocus: true,
              decoration: InputDecoration(
                hintText: 'Search.....',
                prefixIcon: Icon(Icons.search, color: Colors.grey.shade500),
                suffixIcon: _searchController.text.isNotEmpty
                    ? IconButton(
                        icon: Icon(Icons.clear, color: Colors.grey.shade500),
                        onPressed: () {
                          _searchController.clear();
                          context.read<VisitsProvider>().clearSearch();
                          setState(() {});
                        },
                      )
                    : null,
                filled: true,
                fillColor: Colors.white,
                contentPadding: const EdgeInsets.symmetric(vertical: 14.0),
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(12.0),
                  borderSide: BorderSide.none,
                ),
                enabledBorder: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(12.0),
                  borderSide:
                      BorderSide(color: Colors.grey.shade300, width: 0.8),
                ),
                focusedBorder: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(12.0),
                  borderSide: BorderSide(
                      color: Theme.of(context).primaryColor, width: 1.0),
                ),
                hintStyle: TextStyle(color: Colors.grey.shade500, fontSize: 14),
              ),
              onChanged: (value) {
                setState(() {});
              },
              onSubmitted: (value) {
                _performSearchAndNavigateBack(value);
              },
              textInputAction: TextInputAction.search,
              style: const TextStyle(fontSize: 15),
            ),
            const SizedBox(height: 24),
            if (visitsProvider.recentSearches.isNotEmpty) ...[
              Text(
                'RECENT SEARCHES',
                style: TextStyle(
                    fontSize: 12,
                    fontWeight: FontWeight.w600,
                    color: Colors.grey.shade600),
              ),
              const SizedBox(height: 12),
              Wrap(
                spacing: 8.0,
                runSpacing: 8.0,
                children: visitsProvider.recentSearches.map((term) {
                  return ActionChip(
                    avatar: Icon(Icons.history,
                        size: 16, color: Colors.grey.shade600),
                    label: Text(term),
                    labelStyle:
                        TextStyle(fontSize: 13, color: Colors.grey.shade800),
                    onPressed: () {
                      _searchController.text = term;
                      _searchController.selection = TextSelection.fromPosition(
                          TextPosition(offset: term.length));
                      setState(() {});
                      _performSearchAndNavigateBack(term);
                    },
                    backgroundColor: Colors.grey.shade100,
                    shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(20),
                        side: BorderSide(
                            color: Colors.grey.shade300, width: 0.5)),
                    materialTapTargetSize: MaterialTapTargetSize.shrinkWrap,
                    padding:
                        const EdgeInsets.symmetric(horizontal: 10, vertical: 6),
                  );
                }).toList(),
              ),
            ],
          ],
        ),
      ),
    );
  }
}
