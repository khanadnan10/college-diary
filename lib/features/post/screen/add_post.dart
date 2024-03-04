// //! Bottom Sheet - Nav bar
import 'package:flutter/material.dart';

void addPostBottomModelSheet(BuildContext context) {
  showModalBottomSheet(
    context: context,
    builder: (BuildContext context) {
      return Container(
        // Modify the container as needed for your bottom sheet content
        padding: const EdgeInsets.all(16.0),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            const Text('Bottom Sheet Content'),
            const SizedBox(height: 16.0),
            ElevatedButton(
              onPressed: () {
                Navigator.pop(context); // Close the bottom sheet
              },
              child: const Text('Close'),
            ),
          ],
        ),
      );
    },
  );
}
