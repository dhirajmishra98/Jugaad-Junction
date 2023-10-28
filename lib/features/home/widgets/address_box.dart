import 'package:flutter/material.dart';
import 'package:jugaad_junction/common/global_variables.dart';
import 'package:jugaad_junction/providers/user_provider.dart';
import 'package:provider/provider.dart';
import 'package:text_scroll/text_scroll.dart';

class AddressBox extends StatelessWidget {
  const AddressBox({super.key});

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.sizeOf(context);
    final user = Provider.of<UserProvider>(context).user;
    return Container(
      color: Colors.grey.shade300,
      child: Row(
        children: [
          const Icon(
            Icons.location_on_outlined,
            color: GlobalVariables.secondaryColor,
          ),
          Container(
            margin: const EdgeInsets.all(10),
            width: size.width * 0.8,
            child: user.address.isEmpty
                ? const Text("Your Address Here")
                : TextScroll(
                    'Delivery to ${user.name} - ${user.address}. Happy Shopping!😝         ',
                    mode: TextScrollMode.endless,
                    velocity: const Velocity(pixelsPerSecond: Offset(25, 0)),
                    delayBefore: const Duration(milliseconds: 100),
                    pauseBetween: const Duration(milliseconds: 50),
                    style: const TextStyle(
                      color: Colors.black,
                      fontWeight: FontWeight.w600,
                      fontSize: 15,
                    ),
                    selectable: true,
                    fadedBorder: true,
                    fadeBorderSide: FadeBorderSide.right,
                    fadeBorderVisibility: FadeBorderVisibility.always,
                    fadedBorderWidth: 0.1,
                  ),
          ),
        ],
      ),
    );
  }
}
