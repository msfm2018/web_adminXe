import 'package:flutter/material.dart';

TextStyle titleStyle = const TextStyle(
  fontSize: 24, // Adjust the font size as per your preference
  fontWeight: FontWeight.bold, // Optionally make it bold
  color: Colors.white, // Set the text color
  // Add more styling properties if needed, like font family, letterSpacing, etc.
);

TextStyle loginTextStyle = const TextStyle(color: Color.fromARGB(255, 255, 255, 255), fontFamily: "Avenger", fontWeight: FontWeight.normal, fontSize: 20);

decorationStyle(controller, hitText) => InputDecoration(
      border: const OutlineInputBorder(
        borderRadius: BorderRadius.all(Radius.circular(10)),
      ),
      hintText: hitText,
      suffixIcon: IconButton(
        focusNode: FocusNode(skipTraversal: true),
        icon: const Icon(Icons.close),
        onPressed: () {
          controller.clear();
        },
      ),
    );

boxDecoration(img) => BoxDecoration(image: DecorationImage(fit: BoxFit.cover, colorFilter: const ColorFilter.linearToSrgbGamma(), image: AssetImage(img)));
