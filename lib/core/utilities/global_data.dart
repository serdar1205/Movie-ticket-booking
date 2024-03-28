
import 'package:uuid/uuid.dart';

const uuid = Uuid();

String replaceSubstringAtIndex(String originalString, int index, String newSubstring) {
  // Check if the index is within the bounds of the original string
  if (index < 0 || index >= originalString.length) {
    // Return the original string if the index is out of bounds
    return originalString;
  }

  // Construct the new string by concatenating the substring before the index,
  // the new substring, and the substring after the index
  String newString =
      originalString.substring(0, index) + newSubstring + originalString.substring(index + newSubstring.length);

  return newString;
}

