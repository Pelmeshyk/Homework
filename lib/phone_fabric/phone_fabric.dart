import 'dart:io';
const int countOfFirstDetailsToCreateTheBottomPart = 3;
const int countOfSecondDetailsToCreateTheSidePart = 2;
const int enoughDetailsToCreateTheBottomParts = 3;
const int enoughDetailsToCreateTheSideParts = 4;
const int minimumNumberOfBottomPartsToCreateAPhone = 1;
const int minimumNumberOfSidePartsToCreateAPhone = 2;


void main(List<String> arguments) {
  List<String> ore = [
    '*.**::::**..*::.*…**.*::',
    '*.**::::**..*::.*…**.*::',
    '*.**::::**..*::.*…**.*::',
  ];
  int countFirstDetail = 0;
  int countSecondDetail = 0;
  int countBottomPart = 0;
  int countSidePart = 0;
  int phonesCounter = 0;

  print("let's process the ore!");
  printAllOre(ore);
  print('This is the ore we got.');
  print('');

  String combinedOre = ore.join('');
  countFirstDetail = combinedOre.split('*.').length - 1;
  countSecondDetail = combinedOre.split(':').length - 1;

  print('Details of type *. = $countFirstDetail');
  print('Details of type : = $countSecondDetail');

  if (!isDetailsCountEnough(countFirstDetail, countSecondDetail)) {
    exit(0);
  }

  countBottomPart = calculatingCountBottomParts(countFirstDetail, countBottomPart);

  countSidePart = calculatingCountSideParts(countSecondDetail, countSidePart);

  print('');

  print('To make a whole phone you need |_|');

  phonesCounter = calculatePhoneCount(countSidePart, countBottomPart);

  print('We made $phonesCounter phones:');
  printPhones(phonesCounter);
}

int calculatingCountSideParts(int countSecondDetail, int countSidePart) {
   print('to do | this part of the phone is necessary : x2');
  for (int i = countSecondDetail; i >= countOfSecondDetailsToCreateTheSidePart; i -= countOfSecondDetailsToCreateTheSidePart) {
    countSidePart++;
  }
  print('We can do $countSidePart side parts');
  return countSidePart;
}

int calculatingCountBottomParts(int countFirstDetail, int countBottomPart) {
  print('to do _ this part of the phone is necessary *. x3');
  for (int i = countFirstDetail; i >= countOfFirstDetailsToCreateTheBottomPart; i -= countOfFirstDetailsToCreateTheBottomPart) {
    countBottomPart++;
  }
  print('We can do $countBottomPart bottom parts');
  return countBottomPart;
}

bool isDetailsCountEnough(int countFirstDetail, int countSecondDetail) {
  if (countFirstDetail < enoughDetailsToCreateTheBottomParts) {
    print("We don't have enough parts '*.' to make a phone.");
    return false;
  }
  if (countSecondDetail < enoughDetailsToCreateTheSideParts) {
    print("We don't have enough parts ':' to make a phone.");
    return false;
  }
  return true;
}

printAllOre(List<String> ore) {
  for (int i = 0; i < ore.length; i++) {
    print(ore[i]);
  }
}

printPhones(int countPhones) {
  for (int i = 0; i < countPhones; i++) {
    print('|_|');
  }
}

calculatePhoneCount(int sidePart, int bottomPart) {
  int phonesCounter = 0;
  for (int i = 0; sidePart > 0 && bottomPart > 0; i++) {
    sidePart -= minimumNumberOfSidePartsToCreateAPhone;
    bottomPart -= minimumNumberOfBottomPartsToCreateAPhone;
    phonesCounter++;
  }
  return phonesCounter;
}
