import 'package:flutter/material.dart';
import 'Constants.dart';

Column myField(
    BuildContext context,
    String label,
    TextEditingController controller,
    bool obscure, {
      String? subLabel,
      String? Function(String?)? validator,
      bool isNumber = false,
    }) {
  return Column(
    crossAxisAlignment: CrossAxisAlignment.start,
    children: [
      Text(
        label,
        style: TextStyle(
          fontSize: 18,
          fontFamily: 'SF-Pro-Display',
          fontWeight: FontWeight.w500,
          color: Theme.of(context).primaryColor,
        ),
      ),
      Text(
        subLabel ?? '',
        style: TextStyle(
          fontSize: 14,
          fontFamily: 'SF-Pro-Display',
          fontWeight: FontWeight.w300,
          color: Theme.of(context).primaryColor,
        ),
      ),

      const SizedBox(height: 10),
      Container(
        width: 360,
        height: 50,
        decoration: border(context,
            colorbg: Colors.grey.withOpacity(0.25),
            borderColor: Colors.transparent,
            borderRadius: 10),
        child: TextFormField(
          autovalidateMode: AutovalidateMode.onUserInteraction,
          controller: controller,
          obscureText: obscure,
          keyboardType: isNumber ? TextInputType.number : TextInputType.text,
          style: TextStyle(
            color: Theme.of(context).primaryColor,
          ),
          decoration: const InputDecoration(
            border: InputBorder.none,
            contentPadding: EdgeInsets.symmetric(horizontal: 15),
          ),
          validator: validator,
        ),
      ),
      const SizedBox(height: 20),
    ],
  );
}

Column ValidateField(
    BuildContext context,
    String label,
    TextEditingController controller,
    bool obscure, {
      String? truePhrase,
      String? regexPattern,
      String? falsePhrase,
      bool isNumber = false,
    }) {
  return Column(
    crossAxisAlignment: CrossAxisAlignment.start,
    children: [
      Text(
        label,
        style: TextStyle(
          fontSize: 18,
          fontFamily: 'SF-Pro-Display',
          fontWeight: FontWeight.w500,
          color: Theme.of(context).primaryColor,
        ),
      ),
      const SizedBox(height: 10),
      Container(
        width: 360,
        height: 50,
        decoration: border(context,
            colorbg: Colors.grey.withOpacity(0.25),
            borderColor: Colors.transparent,
            borderRadius: 10),
        child: Stack(
          alignment: Alignment.center,
          children: [
            TextFormField(
              autovalidateMode: AutovalidateMode.onUserInteraction,
              controller: controller,
              obscureText: obscure,
              keyboardType:
              isNumber ? TextInputType.number : TextInputType.text,
              style: TextStyle(
                color: Theme.of(context).primaryColor,
              ),
              decoration: const InputDecoration(
                border: InputBorder.none,
                contentPadding: EdgeInsets.symmetric(horizontal: 15),
              ),
              validator: (value) {
                if (value == null || value.isEmpty) {
                  return truePhrase;
                } else if (regexPattern != null &&
                    !RegExp(regexPattern!).hasMatch(value)) {
                  return falsePhrase;
                } else {
                  return null;
                }
              },
            ),
            if (truePhrase != null)
              Align(
                alignment: Alignment.center,
                child: Text(
                  truePhrase,
                  style: const TextStyle(
                    fontSize: 14,
                    color: Colors.red,
                  ),
                  textAlign: TextAlign.center,
                ),
              ),
          ],
        ),
      ),
      const SizedBox(height: 20),
    ],
  );
}
