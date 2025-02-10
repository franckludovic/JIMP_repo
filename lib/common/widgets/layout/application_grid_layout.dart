import 'package:flutter/material.dart';


class JIGridLaout extends StatelessWidget {
  const JIGridLaout({
    super.key,
    required this.JList,
    this.aspectRatio = 0.64
  });

  final List<Widget> JList;
  final double aspectRatio;

  @override
  Widget build(BuildContext context) {
    return GridView.builder(
      shrinkWrap: true,
      physics: NeverScrollableScrollPhysics(),
      gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
        crossAxisCount: 2,
        crossAxisSpacing: 12.5,
        mainAxisSpacing: 12.5,
        childAspectRatio: aspectRatio,
      ),
      itemCount: JList.length,
      itemBuilder: (context, index) {
        return JList[index];
      },
    );
  }
}
