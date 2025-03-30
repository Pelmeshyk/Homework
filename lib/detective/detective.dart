import 'dart:core';
import 'dart:io';

void main() {
  int? encryptionKey;
  File secretData = File('lib/detective/intelligence_data.txt');

  print(
      "Bandit: Here, this is the stolen data, John, encrypt it, and make sure it doesn't disappear anywhere");
  print('');
  print('********************************************************************************************************************');
  String intelligenceData = secretData.readAsStringSync();
  print(intelligenceData);
  int countSymbols = intelligenceData.length;
  print('********************************************************************************************************************');

  encryptionKey = getTheKeyFromTheUser(encryptionKey);

  File encryptedData = dataEncodingByKey(countSymbols, encryptionKey, intelligenceData);
  String encryptedIntelligenceData = encryptedData.readAsStringSync();
  countSymbols = encryptedIntelligenceData.length;
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
  print('********************************************************************************************************************');
  File decipheredData = dataDecipheringByKey(countSymbols, encryptionKey, encryptedIntelligenceData);
  String decipheredIntelligenceData = decipheredData.readAsStringSync();
  print(decipheredIntelligenceData);
  print('********************************************************************************************************************');
  print('');
  print("We got it, the data is decrypted, I'm starting the analysis.");
}

int getTheKeyFromTheUser(int? encryptionKey) {
  while (encryptionKey == null) {
    print('Bandit: Enter the encryption key, it must be a number:');
    String? input = stdin.readLineSync();
    encryptionKey = int.tryParse(input ?? '');
    if (encryptionKey == null) {
      print('Wrong:');
    }
  }
  return encryptionKey;
}

File dataEncodingByKey(int countSymbols, int key, String data) {
  File encryptedData = File('lib/detective/encrypted_intelligence_data.txt');
  for (int i = 0; i < countSymbols; i++) {
    int value = data.codeUnitAt(i) + key;
    String char = String.fromCharCode(value);
    encryptedData.writeAsStringSync(char, mode: FileMode.append);
    stdout.write('$char '); // когда ключ цифра 3, не работает, не выводит столько знаков сколько есть в файле, при других случаях все норм;
  }
  return encryptedData;
}

File dataDecipheringByKey(int countSymbols, int key, String data) {
  File decipheredData = File('lib/detective/deciphered_intelligence_data.txt');
  for (int i = 0; i < countSymbols; i++) {
    int value = data.codeUnitAt(i) - key;
    String char = String.fromCharCode(value);
    decipheredData.writeAsStringSync(char, mode: FileMode.append);
  }
  return decipheredData;
}

