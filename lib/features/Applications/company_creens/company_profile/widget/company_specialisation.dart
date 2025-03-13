import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:iconsax/iconsax.dart';


class CompanySpecialsationSection extends StatelessWidget {
  const CompanySpecialsationSection({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 10),
      child: Card(
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
        child: Padding(
          padding: const EdgeInsets.all(10),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Center(
                child: const Text(
                  "Focus / Specialties",
                  style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
                ),
              ),
              const SizedBox(height: 16),
              // Example chips for specialties
              Wrap(
                  spacing: 5,
                  runSpacing: 2,
                  children: [
                    JcompanyProfilechip(text: "Ai", icon: FontAwesomeIcons.robot,),
                    JcompanyProfilechip(text: "Bioinformatics",),
                    JcompanyProfilechip(text: "DL", icon: FontAwesomeIcons.brain,),
                    JcompanyProfilechip(text: "Data Analysis", icon: FontAwesomeIcons.connectdevelop,),
                    JcompanyProfilechip(text: "Cloud Services", icon: FontAwesomeIcons.cloud,),
                  ]
              ),
            ],
          ),
        ),
      ),
    );
  }
}

class JcompanyProfilechip extends StatelessWidget {
  const JcompanyProfilechip({
    super.key, required this.text, this.icon =  Iconsax.activity, size = 16 ,
  });

  final String text;
  final IconData icon;

  @override
  Widget build(BuildContext context) {
    return Chip(
      label: Text(text),
      iconTheme: IconThemeData(size: 15, ),
      backgroundColor: Colors.blueAccent.withAlpha((0.1 * 255).toInt()),
      labelStyle: Theme.of(context).textTheme.bodyMedium,
      avatar: Icon(icon),
    );
  }
}
