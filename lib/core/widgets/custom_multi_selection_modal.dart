import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:smart_catalog/extensions/context_extensions.dart';

class CustomMultiSelectionModal extends StatefulWidget {
  final String title; // Modal title
  final String subtitle; // Modal subtitle
  final List<String> options; // Options to display
  final String buttonName; // Main button text
  final ValueChanged<List<String>> onSelected; // Callback with selected options

  const CustomMultiSelectionModal({
    super.key,
    required this.title,
    required this.subtitle,
    required this.options,
    required this.buttonName,
    required this.onSelected,
  });

  @override
  State<CustomMultiSelectionModal> createState() =>
      _CustomMultiSelectionModalState();
}

class _CustomMultiSelectionModalState extends State<CustomMultiSelectionModal> {
  // Keeps track of which options are selected
  late List<bool> selected;

  @override
  void initState() {
    super.initState();
    selected = List.generate(widget.options.length, (_) => false);
  }

  @override
  Widget build(BuildContext context) {
    return Dialog(
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(20)),
      child: Container(
        padding: const EdgeInsets.all(20),
        constraints: const BoxConstraints(maxHeight: 400),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // Close button
            Align(
              alignment: Alignment.topRight,
              child: IconButton(
                icon: const Icon(Icons.close),
                onPressed: () => Navigator.of(context).pop(),
              ),
            ),

            // Title
            Text(widget.title, style: context.textTheme.titleMedium),
            const SizedBox(height: 4),

            // Subtitle
            Text(widget.subtitle, style: context.textTheme.bodyMedium),
            const SizedBox(height: 16),

            // List of selectable options (multiple selection)
            Expanded(
              child: ListView.builder(
                itemCount: widget.options.length,
                itemBuilder: (context, index) {
                  return InkWell(
                    onTap: () {
                      setState(() {
                        selected[index] = !selected[index];
                      });
                    },
                    child: Padding(
                      padding: const EdgeInsets.symmetric(vertical: 8.0),
                      child: Row(
                        children: [
                          Checkbox(
                            value: selected[index],
                            onChanged: (value) {
                              setState(() {
                                selected[index] = value ?? false;
                              });
                            },
                          ),
                          const SizedBox(width: 10),
                          Expanded(
                            child: Text(widget.options[index]),
                          ),
                        ],
                      ),
                    ),
                  );
                },
              ),
            ),
            const SizedBox(height: 10),

            // Main button
            SizedBox(
              width: double.infinity,
              child: ElevatedButton(
                onPressed: () {
                  // Get selected options
                  final selectedOptions = widget.options
                      .asMap()
                      .entries
                      .where((e) => selected[e.key])
                      .map((e) => e.value)
                      .toList();

                  // Send selected options to the callback
                  widget.onSelected(selectedOptions);

                  // Close modal
                  context.pop();
                },
                child: Text(
                  widget.buttonName,
                  style: context.textTheme.labelLarge,
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}

// Function to display the modal
void showCustomMultiSelectionModal({
  required BuildContext context,
  required String title,
  required String subtitle,
  required List<String> options,
  required String buttonName,
  required ValueChanged<List<String>> onSelected,
}) {
  showDialog(
    context: context,
    barrierColor: const Color(0x8AFFDABA), // Custom semi-transparent background
    builder: (context) => CustomMultiSelectionModal(
      title: title,
      subtitle: subtitle,
      options: options,
      buttonName: buttonName,
      onSelected: onSelected,
    ),
  );
}
