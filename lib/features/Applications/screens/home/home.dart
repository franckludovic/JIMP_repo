import 'package:flutter/material.dart';
import '../../../../common/widgets/custom_shapes/container_shapes/primary_header_conatiner.dart';
import '../widgets/home_appbar.dart';

class HomeScreen extends StatelessWidget {
  const HomeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SingleChildScrollView(
        child: Column(
          children: [
            ///Header
            PrimaryHeaderContainer(
              child: Column(
                children: [
                  /// Appbar
                  HomeAppbar(),


                  ///Searchbar



                  ///Categories
                ],
              ),
            )
          ],
        ),
      ),
    );
  }
}
