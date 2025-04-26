import 'dart:core';
import 'dart:io';

const int numberDenotingTheTopNumberOfLongestWords = 5;
const int wordOccurrenceIncrement = 1;
const int minimumNumberOfDigitsInAPhoneNumber = 9;
const int maximumNumberOfDigitsInAPhoneNumber = 15;
const int plusSymbolBeforeTheNumber = 1;

void main() {
  int symbolsCount = 0;
  int numberOfCharactersInTheFile = 0;
  int numberOfUniqueWords = 0;
  String mostFrequentlyRepeatedWord = '';
  List<String> topFifeLongestWords = [];
  List<String> phoneNumbersList = [];
  List<String> suspiciousNumbers = [];
  int? encryptionKey;
  File secretData = File('lib/detective/intelligence_data.txt');
  File encryptedData = File('lib/detective/encrypted_intelligence_data.txt');
  File decipheredData = File('lib/detective/deciphered_intelligence_data.txt');
  File investigationReport = File('lib/detective/investigation_report.txt.');
  File encryptedInvestigationReport =
      File('lib/detective/encrypted_investigation_report.txt');

  String intelligenceData = secretData.readAsStringSync();
  String investigationReportData = '';

  if (intelligenceData.isEmpty) {
    print('We have no data :)');
    exit(0);
  }
  print(
      "Bandit: Here, this is the stolen data, John, encrypt it, and make sure it doesn't disappear anywhere");
  print('');
  print(
      '********************************************************************************************************************');
  print(intelligenceData);
  symbolsCount = intelligenceData.length;
  print(
      '********************************************************************************************************************');

  encryptionKey = getTheKeyFromTheUser(encryptionKey);

  encryptedData = dataEncodingByKey(
      symbolsCount, encryptionKey, intelligenceData, encryptedData);
  String encryptedIntelligenceData = encryptedData.readAsStringSync();
  symbolsCount = encryptedIntelligenceData.length;
  print('');
  print('');
  print('Bandit: Well done, now the data is encrypted!');
  print('');
  print('****The encrypted data reaches the detective****');
  print('');

  print('Detective: I received encrypted data, where can I get the key?');
  print('Police Officer: Key is: ' '$encryptionKey');
  print('Detective: Thank you officer');
  print("Detective: I'll try to decipher the data");
  print('');
  print(
      '********************************************************************************************************************');
  decipheredData = dataDecipheringByKey(
      symbolsCount, encryptionKey, encryptedIntelligenceData, decipheredData);
  String decipheredIntelligenceData = decipheredData.readAsStringSync();
  print(decipheredIntelligenceData);
  print(
      '********************************************************************************************************************');
  print('');
  print("I got it, the data is decrypted, I'm starting the analysis.");
  print('');

  numberOfCharactersInTheFile = countTheNumberOfCharactersInTheText(
      numberOfCharactersInTheFile, decipheredIntelligenceData);
  print('Number of characters in the file: $numberOfCharactersInTheFile');

  numberOfUniqueWords = countsTheNumberUniqueWords(decipheredIntelligenceData);
  print('Number of unique words: $numberOfUniqueWords');

  mostFrequentlyRepeatedWord =
      findingWordThatOccursMostFrequently(decipheredIntelligenceData);
  print('The most frequently repeated word: $mostFrequentlyRepeatedWord');

  topFifeLongestWords = getTopFifeTheLongestWords(decipheredIntelligenceData);
  print('');

  phoneNumbersList = findingAllPhoneNumbers(decipheredIntelligenceData);
  print('');
  suspiciousNumbers = findSuspiciousNumbers(phoneNumbersList);
  recordInvestigationReport(
      investigationReport,
      numberOfCharactersInTheFile,
      numberOfUniqueWords,
      mostFrequentlyRepeatedWord,
      topFifeLongestWords,
      phoneNumbersList,
      suspiciousNumbers);
  investigationReportData = investigationReport.readAsStringSync();
  print('');
  print(
      'Detective: I have collected the necessary information, now I encrypt the data.');
  encryptionKey = getTheKeyFromTheUser(encryptionKey);
  print('Detective: I got the key now I will encrypt it.');
  print('');
  encryptedInvestigationReport = dataEncodingByKey(
      symbolsCount, encryptionKey, investigationReportData, encryptedData);
  print('');
  print('Detective: Mission accomplished sir.');

  cleanFile(encryptedData, decipheredData, investigationReport,
      encryptedInvestigationReport);
}

void cleanFile(File encryptedData, File decipheredData,
    File investigationReport, File encryptedInvestigationReport) {
  encryptedData.writeAsStringSync('');
  decipheredData.writeAsStringSync('');
  investigationReport.writeAsStringSync('');
  encryptedInvestigationReport.writeAsStringSync('');
}

void recordInvestigationReport(
    File investigationReport,
    int numberOfCharactersInTheFile,
    int numberOfUniqueWords,
    String mostFrequentlyRepeatedWord,
    List<String> topFifeLongestWords,
    List<String> phoneNumbersList,
    List<String> suspiciousNumbers) {
  investigationReport.writeAsStringSync(
      'Number of characters in the file: $numberOfCharactersInTheFile; ',
      mode: FileMode.append);
  print('');
  investigationReport.writeAsStringSync(
      'Number of unique words: $numberOfUniqueWords; ',
      mode: FileMode.append);
  print('');

  investigationReport.writeAsStringSync(
      'The most frequently repeated word: $mostFrequentlyRepeatedWord; ',
      mode: FileMode.append);
  print('');
  investigationReport.writeAsStringSync('Top fife longest words: ',
      mode: FileMode.append);
  writeDataInFileStringSync(topFifeLongestWords, investigationReport);
  investigationReport.writeAsStringSync(';', mode: FileMode.append);
  print('');
  investigationReport.writeAsStringSync('All phone numbers: ',
      mode: FileMode.append);
  writeDataInFileStringSync(phoneNumbersList, investigationReport);
  investigationReport.writeAsStringSync(';', mode: FileMode.append);
  print('');
  investigationReport.writeAsStringSync('All suspicious numbers: ',
      mode: FileMode.append);
  writeDataInFileStringSync(suspiciousNumbers, investigationReport);
  investigationReport.writeAsStringSync(';', mode: FileMode.append);
}

void writeDataInFileStringSync(List<String> data, File file) {
  for (int i = 0; i < data.length; i++) {
    file.writeAsStringSync('${data[i]}, ', mode: FileMode.append);
  }
}

List<String> findSuspiciousNumbers(List<String> phoneNumbers) {
  List<String> suspiciousNumbers = [];
  print('All suspicious numbers: ');
  if (phoneNumbers.isEmpty) {
    print('There are no suspicious mobile numbers here.');
    return [];
  }
  for (var phoneNumber in phoneNumbers) {
    if (phoneNumber.startsWith('+380')) {
      processPhoneNumber(phoneNumber, suspiciousNumbers);
    }
  }
  for (int i = 0; i < suspiciousNumbers.length; i++) {
    print(suspiciousNumbers[i]);
  }
  return suspiciousNumbers;
}

bool isHasSameStartAndEnd(String phoneDigits) {
  return phoneDigits.substring(0, 3) ==
      phoneDigits.substring(phoneDigits.length - 3);
}

bool isSymmetric(String phoneDigits) {
  for (int i = 0; i < phoneDigits.length ~/ 2; i++) {
    if (phoneDigits[i] != phoneDigits[phoneDigits.length - i - 1]) {
      return false;
    }
  }
  return true;
}

bool isNumberSuspicious(String phoneNumber) {
  String phoneDigits = phoneNumber.substring(4);

  if (isHasSameStartAndEnd(phoneDigits)) {
    return true;
  }
  if (isSymmetric(phoneDigits)) {
    return true;
  }
  return false;
}

void processPhoneNumber(String phoneNumber, List<String> suspiciousNumbers) {
  if (isNumberSuspicious(phoneNumber)) {
    suspiciousNumbers.add(phoneNumber);
  }
}

List<String> findingAllPhoneNumbers(String decipheredIntelligenceData) {
  List<String> phoneNumbersList = [];
  int i = 0;

  while (i < decipheredIntelligenceData.length) {
    if (decipheredIntelligenceData[i] == '+') {
      int start = i;
      int digitCount = 0;
      i++;
      while (i < decipheredIntelligenceData.length &&
          '0123456789'.contains(decipheredIntelligenceData[i])) {
        digitCount++;
        i++;
      }
      if (digitCount >= minimumNumberOfDigitsInAPhoneNumber &&
          digitCount <= maximumNumberOfDigitsInAPhoneNumber) {
        phoneNumbersList.add(decipheredIntelligenceData.substring(
            start, start + plusSymbolBeforeTheNumber + digitCount));
      }
    } else {
      i++;
    }
  }
  print("All phone numbers: ");
  for (int i = 0; i < phoneNumbersList.length; i++) {
    print(phoneNumbersList[i]);
  }
  return phoneNumbersList;
}

List<String> getTopFifeTheLongestWords(String decipheredIntelligenceData) {
  List<String> intelligenceDataList = splitStringBySpaces(decipheredIntelligenceData);
  intelligenceDataList = removeNonWordCharacters(intelligenceDataList);
  intelligenceDataList = filterOnlyAlphabetic(intelligenceDataList);

  List<String> topFifeLongestWords = [];
  findTheFiveLongestWords(intelligenceDataList, topFifeLongestWords);
  print('Top fife longest words: ');
  for (int i = 0; i < topFifeLongestWords.length; i++) {
    print(topFifeLongestWords[i]);
  }
  return topFifeLongestWords;
}

void findTheFiveLongestWords(
    List<String> intelligenceDataList, List<String> topFifeLongestWords) {
  for (int i = 0; i < numberDenotingTheTopNumberOfLongestWords; i++) {
    if (intelligenceDataList.isEmpty) {
      break;
    }
    String longestWord = intelligenceDataList[0];
    int longestIndex = 0;

    for (int j = 1; j < intelligenceDataList.length; j++) {
      if (intelligenceDataList[j].length > longestWord.length) {
        longestWord = intelligenceDataList[j];
        longestIndex = j;
      }
    }
    topFifeLongestWords.add(longestWord);
    intelligenceDataList.removeAt(longestIndex);
  }
}

String findingWordThatOccursMostFrequently(String decipheredIntelligenceData) {
  List<String> intelligenceDataList = splitStringBySpaces(decipheredIntelligenceData);

  Map<String, int> count = {};
  for (var word in intelligenceDataList) {
    count[word] = 1 + (count[word] ?? 0);
  }

  List<String> wordList = count.keys.toList();

  for (int i = 0; i < wordList.length - 1; i++) {
    for (int j = 0; j < wordList.length - i - 1; j++) {
      if (count[wordList[j]]! < count[wordList[j + 1]]!) {
        var temp = wordList[j];
        wordList[j] = wordList[j + 1];
        wordList[j + 1] = temp;
      }
    }
  }
  return wordList[0];
}

List<String> splitStringBySpaces(String data) {
  List<String> words = [];
  String currentWord = '';
  for (int i = 0; i < data.length; i++) {
    String char = data[i];

    if (char != ' ') {
      currentWord += char;
    } else {
      if (currentWord.isNotEmpty) {
        words.add(currentWord);
        currentWord = '';
      }
    }
  }
  if (currentWord.isNotEmpty) {
    words.add(currentWord);
  }
  return words;
}

List<String> removeNonWordCharacters(List<String> words) {
  List<String> result = [];

  for (var word in words) {
    String cleanedWord = '';

    for (int i = 0; i < word.length; i++) {
      String char = word[i];
      if (_isLetterOrDigit(char)) {
        cleanedWord += char;
      }
    }

    result.add(cleanedWord);
  }

  return result;
}

List<String> filterOnlyAlphabetic(List<String> words) {
  List<String> result = [];

  for (var word in words) {
    if (_isAllLetters(word)) {
      result.add(word);
    }
  }

  return result;
}

bool _isAllLetters(String word) {
  for (int i = 0; i < word.length; i++) {
    if (!_isLetter(word[i])) {
      return false;
    }
  }
  return true;
}

bool _isLetter(String char) {
  int code = char.codeUnitAt(0);
  return (code >= 65 && code <= 90) ||
      (code >= 97 && code <= 122);
}


bool _isLetterOrDigit(String char) {
  int code = char.codeUnitAt(0);
  return (code >= 65 && code <= 90) ||
      (code >= 97 && code <= 122) ||
      (code >= 48 && code <= 57);
}

int countsTheNumberUniqueWords(String decipheredIntelligenceData) {
  List<String> intelligenceDataList = splitStringBySpaces(decipheredIntelligenceData);
  intelligenceDataList = removeNonWordCharacters(intelligenceDataList);
  intelligenceDataList = filterOnlyAlphabetic(intelligenceDataList);

  String listElement = '';
  int numberOfUniqueWords = 0;

  for (int i = 0; i < intelligenceDataList.length; i++) {
    int numberOfMatches = 0;
    listElement = intelligenceDataList[i];
    for (int i = 0; i < intelligenceDataList.length; i++) {
      if (listElement == intelligenceDataList[i]) {
        numberOfMatches++;
      }
    }
    if (numberOfMatches == 1) {
      numberOfUniqueWords++;
    }
  }
  return numberOfUniqueWords;
}

int countTheNumberOfCharactersInTheText(
    int numberOfCharactersInTheFile, String decipheredIntelligenceData) {
  numberOfCharactersInTheFile = decipheredIntelligenceData.length;
  return numberOfCharactersInTheFile;
}

int getTheKeyFromTheUser(int? encryptionKey) {
  while (encryptionKey == null) {
    print('Enter the encryption key, it must be a number:');
    String? input = stdin.readLineSync();
    encryptionKey = int.tryParse(input ?? '');
    if (encryptionKey == null) {
      print('Wrong:');
    }
  }
  return encryptionKey;
}

File dataEncodingByKey(
    int countSymbols, int key, String data, File encryptedData) {
  for (int i = 0; i < countSymbols; i++) {
    int value = data.codeUnitAt(i) + key;
    String char = String.fromCharCode(value);
    encryptedData.writeAsStringSync(char, mode: FileMode.append);
    stdout.write('$char ');
  }
  return encryptedData;
}

File dataDecipheringByKey(
    int countSymbols, int key, String data, File decipheredData) {
  for (int i = 0; i < countSymbols; i++) {
    int value = data.codeUnitAt(i) - key;
    String char = String.fromCharCode(value);
    decipheredData.writeAsStringSync(char, mode: FileMode.append);
  }
  return decipheredData;
}
