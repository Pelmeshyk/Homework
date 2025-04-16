import 'dart:core';
import 'dart:io';

const int numberDenotingTheTopNumberOfLongestWords = 5;
const int wordOccurrenceIncrement = 1;

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
  // кількість унікальних слів у кожному файлі.

  mostFrequentlyRepeatedWord =
      findingWordThatOccursMostFrequently(decipheredIntelligenceData);
  print('The most frequently repeated word: $mostFrequentlyRepeatedWord');
  // слово, которое встречается чаще всего

  topFifeLongestWords = getTopFifeTheLongestWords(decipheredIntelligenceData);
  print('');
  // Знайти топ-5 найдовших слів.

  phoneNumbersList = findingAllPhoneNumbers(decipheredIntelligenceData);
  // находим все номера
  print('');
  suspiciousNumbers = findSuspiciousNumbers(phoneNumbersList);
  // работа с подозрительными номерами
  recordInvestigationReport(
      investigationReport,
      numberOfCharactersInTheFile,
      numberOfUniqueWords,
      mostFrequentlyRepeatedWord,
      topFifeLongestWords,
      phoneNumbersList,
      suspiciousNumbers);
  investigationReportData = investigationReport.readAsStringSync();
  // записываем данные в новый файл
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
  // зашифровка данных детективом

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
  for (int i = 0; i < topFifeLongestWords.length; i++) {
    investigationReport.writeAsStringSync('${topFifeLongestWords[i]}, ',
        mode: FileMode.append);
  }
  investigationReport.writeAsStringSync(';', mode: FileMode.append);
  print('');
  investigationReport.writeAsStringSync('All phone numbers: ',
      mode: FileMode.append);
  for (int i = 0; i < phoneNumbersList.length; i++) {
    investigationReport.writeAsStringSync('${phoneNumbersList[i]}, ',
        mode: FileMode.append);
  }
  investigationReport.writeAsStringSync(';', mode: FileMode.append);
  print('');
  investigationReport.writeAsStringSync('All suspicious numbers: ',
      mode: FileMode.append);
  for (int i = 0; i < suspiciousNumbers.length; i++) {
    investigationReport.writeAsStringSync('${suspiciousNumbers[i]}, ',
        mode: FileMode.append);
  }
  investigationReport.writeAsStringSync(';', mode: FileMode.append);
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

void processPhoneNumber(String phoneNumber, List<String> suspiciousNumbers) {
  String phoneDigits = phoneNumber.substring(4);

  if (isHasSameStartAndEnd(phoneDigits)) {
    suspiciousNumbers.add(phoneNumber);
    return;
  }
  if (isSymmetric(phoneDigits)) {
    suspiciousNumbers.add(phoneNumber);
  }
}

List<String> findingAllPhoneNumbers(String decipheredIntelligenceData) {
  RegExp phoneRegExp = RegExp(r'\+\d{9,15}');
  Iterable<RegExpMatch> matches =
      phoneRegExp.allMatches(decipheredIntelligenceData);
  List<String> phoneNumbersList = [];
  print('All phone numbers: ');
  if (matches.isEmpty) {
    print('There are no mobile numbers here.');
    return [];
  }
  for (var match in matches) {
    phoneNumbersList.add(match.group(0)!);
    print(match.group(0));
  }
  return phoneNumbersList;
}

List<String> getTopFifeTheLongestWords(String decipheredIntelligenceData) {
  List<String> intelligenceDataList = decipheredIntelligenceData
      .split(RegExp(r'\s+')) // разбивает данные в нашей строке по пробелам
      .map((word) =>
          word.replaceAll(RegExp(r'\W'), '')) // убирает знаки перепинания
      .where((word) => RegExp(r'^[a-zA-Z]+$')
          .hasMatch(word)) // читает только латинские буквы
      .toList();

  List<String> topFifeLongestWords = [];
  for (int i = 0; i < numberDenotingTheTopNumberOfLongestWords; i++) {
    String longestWord = intelligenceDataList.reduce((a, b) {
      return a.length > b.length ? a : b;
    });
    topFifeLongestWords.add(longestWord);
    intelligenceDataList.remove(longestWord);
  }
  print('Top fife longest words: ');
  for (int i = 0; i < topFifeLongestWords.length; i++) {
    print(topFifeLongestWords[i]);
  }
  return topFifeLongestWords;
}

String findingWordThatOccursMostFrequently(String decipheredIntelligenceData) {
  List<String> intelligenceDataList =
      decipheredIntelligenceData.split(RegExp(r'\s+'));
  var count = <String, int>{};
  for (final w in intelligenceDataList) {
    count[w] = wordOccurrenceIncrement + (count[w] ?? 0);
  }
  var orderedList = count.keys.toList();
  orderedList.sort((a, b) => count[b]!.compareTo(count[a]!));
  return orderedList[0];
}

int countsTheNumberUniqueWords(String decipheredIntelligenceData) {
  List<String> intelligenceDataList = decipheredIntelligenceData
      .split(RegExp(r'\s+'))
      .map((word) => word.replaceAll(RegExp(r'\W'), ''))
      .where((word) => RegExp(r'^[a-zA-Z]+$').hasMatch(word))
      .toList();
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
  numberOfCharactersInTheFile =
      decipheredIntelligenceData.length; // длина файла
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
    stdout.write(
        '$char '); // когда ключ цифра 3, не работает, не выводит столько знаков сколько есть в файле, при других случаях все норм;
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
