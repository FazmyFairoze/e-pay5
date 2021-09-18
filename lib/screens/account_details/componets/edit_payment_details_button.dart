import 'package:flutter/material.dart';
import 'package:e_pay/screens/complete_profile/complete_profile_screen.dart';
import 'package:e_pay/screens/edit_account_details_screen/edit_account_details_screen.dart';

import '../../../components/default_button.dart';
import '../../../size_config.dart';

class EditPaymentDetailsButton extends StatelessWidget {
  Widget build(BuildContext context) {
    return Container(
        alignment: Alignment.bottomCenter,
        height: getProportionateScreenHeight(56),
        width: double.infinity,
        //alignment: Alignment.topLeft,
        child: SizedBox(

            //fit: BoxFit.fill,
            child: ClipRRect(
          borderRadius: BorderRadius.circular(15),
          child: Stack(
            children: <Widget>[
              Positioned.fill(
                //textDirection: null,
                child: Container(
                  //height: getProportionateScreenHeight(56),
                  //width: double.infinity,
                  decoration: const BoxDecoration(
                    gradient: LinearGradient(
                      colors: <Color>[
                        Colors.teal,
                        Colors.teal,
                        //Color(0xFF0D47A1),
                        //Colors.deepOrangeAccent,
                        //!!!!!Color(0xFFFF8A65),
                      ],
                    ),
                  ),
                ),
              ),
              Container(
                alignment: Alignment.center,
                child: TextButton(
                  style: TextButton.styleFrom(
                    //alignment: ,
                    padding: const EdgeInsets.all(16.0),
                    primary: Colors.white,
                    textStyle: const TextStyle(fontSize: 20),
                  ),
                  onPressed: () {},
                  child: const Text('Edit Payment Details',
                      textAlign: TextAlign.left),
                ),
              )
            ],
          ),
        )));
  }
}
