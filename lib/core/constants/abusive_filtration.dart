// TODO: Create a function to check and filter the contents before posting it to publicly

Set<String> abusiveWords = {
  "dumb",
  "teachers pet",
  "scaredy cat",
  "piss",
  "pissed off",
  "jerk",
  "stupid",
  "idiot",
  "mother fucker",
  "madarchor",
  "madarchod",
  "gandu",
  "gu",
  "guu",
  "goo",
  "hagal",
  "suwr",
  "suwar",
  "behenchod",
  "behen ke lode",
  "bhosdike",
  "bsdk",
  "fuck",
  "fuckk",
  "fuckkk",
  "fcuk",
  "gand",
  "gandd",
  "land",
  "lund",
  "makara",
  "behenkara",
  "behenkada",
  "makada",
  "makda",
  'kamini',
  'kamina',
  'harami',
  'bhomsdiwala',
  'bhomsdiwali',
  'bhomsdi',
  "chodu",
  "bekar",
  "behuda",
  "wahiyat",
};

bool checkForAbusiveWord(String test) {
  // String test = 'how you doing FUgCK, and what aboyt ouy';
  List<String> item = test.split(RegExp(r'[ .,!?]'));
  for (String word in item) {
    if (abusiveWords.contains(word.toLowerCase())) {
      return false;
    }
  }
  return true;
}
