import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:shopit/constants/global_variables.dart';
import 'package:shopit/providers/user.provider.dart';

class BelowAppBar extends StatelessWidget {
  const BelowAppBar({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final user = Provider.of<UserProvider>(context).user;

    return Container(
      decoration: const BoxDecoration(
        gradient: GlobalVariables.appBarGradient,
      ),
      padding: const EdgeInsets.only(left: 10.0, right: 10.0, bottom: 10.0),
      child: SizedBox(
        width: MediaQuery.of(context).size.width,
        child: RichText(
          text: TextSpan(
            text: 'Hello, ',
            style: const TextStyle(fontSize: 22.0, color: Colors.black),
            children: [
              TextSpan(
                text: user.name,
                style: const TextStyle(
                  fontSize: 22.0,
                  color: Colors.black,
                  fontWeight: FontWeight.w600,
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
