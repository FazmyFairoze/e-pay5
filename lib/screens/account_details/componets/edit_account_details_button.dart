import 'package:flutter/material.dart';
import 'package:e_pay/screens/complete_profile/complete_profile_screen.dart';
import 'package:e_pay/screens/home/home_screen.dart';
import 'package:e_pay/screens/items_available/components/items_available_screen.dart';
import '../../../components/default_button.dart';

class EditAccountDetailsButton extends StatelessWidget {
  Widget build(BuildContext context) {
    return TextButton(
        onPressed: () {
          Navigator.pushNamed(context, CompleteProfileScreen.routeName);
        },
        child: const Text('Edit Profile'));
    //text: "Edit Profile");
  }
}
