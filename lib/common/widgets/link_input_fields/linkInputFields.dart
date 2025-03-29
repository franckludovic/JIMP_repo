import 'package:flutter/material.dart';
import 'package:url_launcher/url_launcher.dart';

class LinkInputWidget extends StatefulWidget {
  final String title;
  final String defaultUrl;
  final TextEditingController? controller; // Optional external controller

  const LinkInputWidget({
    super.key,
    required this.title,
    this.defaultUrl = "",
    this.controller,
  });

  @override
  _LinkInputWidgetState createState() => _LinkInputWidgetState();
}

class _LinkInputWidgetState extends State<LinkInputWidget> {
  late final TextEditingController _controller;

  @override
  void initState() {
    super.initState();
    // Use the provided controller or create a new one.
    _controller = widget.controller ?? TextEditingController();
    _controller.text = widget.defaultUrl; // Set initial value
  }

  Future<void> _launchURL() async {
    final Uri url = Uri.parse(_controller.text);
    if (await canLaunchUrl(url)) {
      await launchUrl(url, mode: LaunchMode.externalApplication);
    } else {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text("Could not open the link")),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(widget.title,
            style: const TextStyle(fontSize: 16, fontWeight: FontWeight.bold)),
        const SizedBox(height: 5),
        TextField(
          controller: _controller,
          decoration: InputDecoration(
            hintText: "Enter ${widget.title} URL",
            border: const OutlineInputBorder(),
            suffixIcon: IconButton(
              icon: const Icon(
                Icons.open_in_browser,
                color: Colors.purple,
              ),
              onPressed: _launchURL,
            ),
          ),
        ),
      ],
    );
  }
}
