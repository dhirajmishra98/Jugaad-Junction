import 'package:flutter/material.dart';
import 'package:jugaad_junction/features/account/services/account_service.dart';
import 'package:jugaad_junction/features/account/widgets/account_button.dart';

class TopButton extends StatelessWidget {
  const TopButton({super.key});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 8.0, vertical: 15),
      child: Column(
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              AccountButton(onTap: () {}, text: "Your Orders"),
              AccountButton(onTap: () {}, text: "Turn Seller")
            ],
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              AccountButton(
                  onTap: () => AccountService().logOut(context),
                  text: "Log Out"),
              AccountButton(onTap: () {}, text: "Your Wishlist")
            ],
          )
        ],
      ),
    );
  }
}
