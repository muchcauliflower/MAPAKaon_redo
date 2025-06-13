import 'package:flutter/material.dart';

const bool debugMode = false; // debug mode

PreferredSizeWidget buildMapAppBar({
  required BuildContext context,
  required bool isAddingMarkers,
  required VoidCallback onToggleAdd,
  required VoidCallback onClear,
  required bool debugMode,
  VoidCallback? onShowRoutes,
  void Function(String)? onSaveRoute,
}) {
  return AppBar(
    title: const Text('Interactive Map Routes'),
    actions: [
      IconButton(
        icon: Icon(isAddingMarkers ? Icons.edit_off : Icons.add_location_alt),
        onPressed: onToggleAdd,
        tooltip: isAddingMarkers ? 'Stop Adding' : 'Add Marker',
      ),
      IconButton(
        icon: const Icon(Icons.clear),
        onPressed: onClear,
        tooltip: 'Clear Points',
      ),
      if (debugMode && onSaveRoute != null)
        IconButton(
          icon: const Icon(Icons.save),
          tooltip: 'Save Route',
          onPressed: () {
            showDialog(
              context: context,
              builder: (context) {
                String routeName = '';
                return AlertDialog(
                  title: const Text('Save Route'),
                  content: TextField(
                    onChanged: (value) => routeName = value,
                    decoration: const InputDecoration(hintText: 'Route name'),
                  ),
                  actions: [
                    TextButton(
                      onPressed: () => Navigator.pop(context),
                      child: const Text('Cancel'),
                    ),
                    TextButton(
                      onPressed: () {
                        Navigator.pop(context);
                        if (routeName.isNotEmpty) {
                          onSaveRoute(routeName);
                        }
                      },
                      child: const Text('Save'),
                    ),
                  ],
                );
              },
            );
          },
        ),
      if (debugMode && onShowRoutes != null)
        IconButton(
          icon: const Icon(Icons.list),
          tooltip: 'Show Saved Routes',
          onPressed: onShowRoutes,
        ),
    ],
  );
}
