import 'dart:io';

void main(List<String> arguments) {
  List<String> ore = [
    "*.**::::**..*::.*…**.*::",
    "*.**::::**..*::.*…**.*::",
    "*.**::::**..*::.*…**.*::",
  ];
  int countFirstDetail = 0;
  int countSecondDetail = 0;
  int countBottomPart = 0;
  int countSidePart = 0;
  int phonesCounter = 0;

  print("let's process the ore!");
  printAllOre(ore);
  print("This is the ore we got.");
  print("");

  String combinedOre = ore.join('');
  countFirstDetail = combinedOre.split("*.").length - 1;
  countSecondDetail = combinedOre.split(":").length - 1;

  print("Details of type *. = $countFirstDetail");
  print("Details of type : = $countSecondDetail");

  checkingMinimumDetails(countFirstDetail, countSecondDetail);

  print("to do _ this part of the phone is necessary *. x3");
  for (int i = countFirstDetail; i >= 3; i -= 3) {
    countBottomPart++;
  }
  print("We can do $countBottomPart bottom parts");

  print("to do | this part of the phone is necessary : x2");
  for (int i = countSecondDetail; i >= 2; i -= 2) {
    countSidePart++;
  }
  print("We can do $countSidePart side parts");
  print("");

  print("To make a whole phone you need |_|");

  phonesCounter = phoneCreating(countSidePart, countBottomPart);

  print("We made $phonesCounter phones:");
  printPhones(phonesCounter);
}

void checkingMinimumDetails(int countFirstDetail, int countSecondDetail) {
  if(countFirstDetail < 3){
    print("We don't have enough parts '*.' to make a phone.");
    exit(0);
  }
  if(countSecondDetail < 4){
    print("We don't have enough parts ':' to make a phone.");
    exit(0);
  }
}

printAllOre(List<String> ore) {
  for (int i = 0; i < ore.length; i++) {
    print(ore[i]);
  }
}

printPhones(int countPhones) {
  for (int i = 0; i < countPhones; i++) {
    print("|_|");
  }
}

phoneCreating(int sidePart, int bottomPart) {
  int phonesCounter = 0;
  for (int i = 0; sidePart > 0 && bottomPart > 0; i++) {
    sidePart -= 2;
    bottomPart -= 1;
    phonesCounter++;
  }
  return phonesCounter;
}
