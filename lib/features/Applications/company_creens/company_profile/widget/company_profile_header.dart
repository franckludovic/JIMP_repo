import 'package:flutter/material.dart';


class CompanyProfileHeader extends StatelessWidget {
  const CompanyProfileHeader({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [

        Positioned.fill(
          child: Align(
            alignment: Alignment.center,
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                // Company Logo
                CircleAvatar(
                  radius: 40,
                  backgroundColor: Colors.white,
                  child: Text("C",
                      style: TextStyle(
                        fontSize: 30,
                        color: Colors.blueAccent,
                        fontWeight: FontWeight.bold,
                      )),
                ),
                const SizedBox(height: 10),
                // Company Name
                const Text(
                  "Metatron Industries",
                  style: TextStyle(
                    fontSize: 18,
                    fontWeight: FontWeight.bold,
                    color: Colors.white,
                  ),
                ),
                const SizedBox(height: 4),
                // Basic Info
                const Text(
                  "metatron@company.com",
                  style: TextStyle(color: Colors.white70),
                ),
              ],
            ),
          ),
        ),
      ],
    );
  }
}

