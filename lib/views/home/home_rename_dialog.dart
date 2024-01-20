import 'package:flutter/material.dart';

class RenameDialog extends StatefulWidget {
  final Function(String) onNameChanged;

  const RenameDialog({Key? key, required this.onNameChanged}) : super(key: key);

  @override
  State<RenameDialog> createState() => RenameDialogState();
}

class RenameDialogState extends State<RenameDialog> {
  TextEditingController controller = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      title: const Text("Change your plant name"),
      backgroundColor: const Color(0xFF976b48),
      content: TextField(
        controller: controller,
        decoration: const InputDecoration(hintText: "New name"),
      ),
      actions: [
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          children: [
            ElevatedButton(
              onPressed: () {
                Navigator.pop(context);
              },
              child: const Text("Cancel"),
            ),
            ElevatedButton(
              onPressed: () {
                widget.onNameChanged(controller.text);
                Navigator.pop(context);
              },
              child: const Text("Apply"),
            ),
          ],
        )
      ],
    );
  }

}