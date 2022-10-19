import 'package:flutter/material.dart';
import 'package:shopit/features/account/services/account.service.dart';
import 'package:shopit/features/account/widgets/account_button.dart';

class TopButtons extends StatelessWidget {
  const TopButtons({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Column(
      children: <Widget>[
        Row(
          children: <Widget>[
            AccountButton(text: 'Your Orders', onTap: () {}),
            AccountButton(text: 'Turn Seller', onTap: () {}),
          ],
        ),
        const SizedBox(
          height: 10.0,
        ),
        Row(
          children: <Widget>[
            AccountButton(
              text: 'Logout',
              onTap: () => AccountService().logOut(context),
            ),
            AccountButton(text: 'Your Wish List', onTap: () {}),
          ],
        )
      ],
    );
  }
}
