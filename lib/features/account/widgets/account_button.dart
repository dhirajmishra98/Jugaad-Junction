import 'package:flutter/material.dart';

class AccountButton extends StatelessWidget {
  final VoidCallback onTap;
  final String text;
  const AccountButton({super.key, required this.onTap, required this.text});

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.sizeOf(context);
    return ElevatedButton(
      onPressed: onTap,
      style: ElevatedButton.styleFrom(
        backgroundColor: const Color.fromARGB(255, 225, 225, 225),
        fixedSize: Size(size.width / 2.4, 10),
      ),
      child: Text(text),
    );
  }
}
