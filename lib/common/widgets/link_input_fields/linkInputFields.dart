import 'package:flutter/material.dart';

import 'package:url_launcher/url_launcher.dart';

class LinkInputWidget extends StatefulWidget {
  final String title;
  final String defaultUrl;

  const LinkInputWidget({
    super.key,
    required this.title,
    this.defaultUrl = "",
  });

  @override
  _LinkInputWidgetState createState() => _LinkInputWidgetState();
}

class _LinkInputWidgetState extends State<LinkInputWidget> {
  final TextEditingController _controller = TextEditingController();

  @override
  void initState() {
    super.initState();
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
        Text(widget.title, style: const TextStyle(fontSize: 16, fontWeight: FontWeight.bold)),
        const SizedBox(height: 5),

        // Text Field for entering the URL
        TextField(
          controller: _controller,
          decoration: InputDecoration(
            hintText: "Enter ${widget.title} URL",
            border: OutlineInputBorder(),
            suffixIcon: IconButton(
              icon: const Icon(Icons.open_in_browser,color: Colors.purple,),
              onPressed: _launchURL,
            ),
          ),
        ),
      ],
    );
  }
}
