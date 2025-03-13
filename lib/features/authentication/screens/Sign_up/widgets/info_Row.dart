import 'package:flutter/material.dart';
import 'package:project_bc_tuto/utils/constants/colors.dart';


class CandidateInfoRow extends StatelessWidget {
  const CandidateInfoRow({
    super.key,
    required this.leadingIcon, 
    required this.title, 
    this.followingIcon,
    
  });
  
  final IconData leadingIcon;
  final IconData? followingIcon;
  final String title;

  
  @override
  Widget build(BuildContext context) {

    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 4),
      child: Row(
        children: [
          Icon(leadingIcon, size: 20, color: Colors.deepPurple),
          const SizedBox(width: 10),
          Text(title, style: TextStyle(fontSize: 14, color: Colors.black)),
          const Spacer(),

         followingIcon != null ? IconButton(onPressed: () {}, icon: Icon(followingIcon)) :IconButton(icon:  Icon(Icons.edit, size: 18, color: JColors.primary,), onPressed: () {},),
            
        ],
      ),
    );
  }
}
