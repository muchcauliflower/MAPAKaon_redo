import 'package:flutter/material.dart';

PreferredSizeWidget buildMapAppBar({
  required BuildContext context,
  required bool isAddingMarkers,
  required VoidCallback onToggleAdd,
  required VoidCallback onClear,
  required void Function(String) onSaveRoute,
  required VoidCallback onOpenRoutes, // <- this must be here
}) {
  return AppBar(
    title: const Text('Interactive Map Routes'),
    actions: [
      IconButton(
        icon: Icon(isAddingMarkers ? Icons.cancel : Icons.add_location_alt),
        tooltip: isAddingMarkers ? 'Cancel Adding Markers' : 'Add Markers',
        onPressed: onToggleAdd,
      ),
      IconButton(
        icon: const Icon(Icons.clear_all),
        tooltip: 'Clear All Points',
        onPressed: onClear,
      ),
      IconButton(
        icon: const Icon(Icons.folder_open),
        tooltip: 'View Saved Routes',
        onPressed: onOpenRoutes, // <-- SHOW DIALOG
      ),
      IconButton(
        icon: const Icon(Icons.save),
        tooltip: 'Save Current Route',
        onPressed: () {
          showDialog(
            context: context,
            builder: (context) {
              String routeName = '';
              return AlertDialog(
                title: const Text('Name this route'),
                content: TextField(
                  onChanged: (value) => routeName = value,
                  decoration: const InputDecoration(hintText: 'Enter route name'),
                ),
                actions: [
                  TextButton(
                    onPressed: () {
                      Navigator.of(context).pop();
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
    ],
  );
}
