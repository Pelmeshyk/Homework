import 'dart:io';

import 'package:test/test.dart';
import 'package:mafioznik/detective/detective.dart';
main(){
    group('cleanFile', () {
      late File encryptedData;
      late File decipheredData;
      late File investigationReport;
      late File encryptedInvestigationReport;

      setUp(() {
        encryptedData = File('test_encryptedData.txt')..writeAsStringSync('бааааааааааабушка');
        decipheredData = File('test_decipheredData.txt')..writeAsStringSync('брааааааазааер');
        investigationReport = File('test_investigationReport.txt')..writeAsStringSync('мааааааааамама');
        encryptedInvestigationReport = File('test_encryptedInvestigationReport.txt')..writeAsStringSync('пааааааааааапапап');
      });

      tearDown(() {
        encryptedData.deleteSync();
        decipheredData.deleteSync();
        investigationReport.deleteSync();
        encryptedInvestigationReport.deleteSync();
      });

      test('clears the contents of all given files', () {
        cleanFile(
          encryptedData,
          decipheredData,
          investigationReport,
          encryptedInvestigationReport,
        );

        expect(encryptedData.readAsStringSync(), isEmpty);
        expect(decipheredData.readAsStringSync(), isEmpty);
        expect(investigationReport.readAsStringSync(), isEmpty);
        expect(encryptedInvestigationReport.readAsStringSync(), isEmpty);
      });
    });

    group('writeDataInFileStringSync', () {
      late List<String> data;
      late File file;


      setUp(() {
        data = ['1','2','3'];
        file = File('test_investigationReport.txt')..writeAsStringSync('');
      });

      tearDown(() {
        file.deleteSync();
      });

      test('write data in file string sync', () {
       writeDataInFileStringSync(data, file);

        expect(file.readAsStringSync(), '1, 2, 3, ');
      });
    });

    group('findSuspiciousNumbers', () {
      late List<String> phoneNumbers;

      setUp(() {
        phoneNumbers = ['+380989898989','+380123123123','+380777333773','+380111222111'];
      });

      tearDown(() {
      phoneNumbers = [];
      });

      test('finding suspicious numbers', () {
        final result = findSuspiciousNumbers(phoneNumbers);

        expect(result, ['+380989898989','+380123123123','+380111222111']);
      });
    });



    group('recordInvestigationReport', () {
      late File investigationReport;

      setUp(() {
        investigationReport = File('test_investigationReport.txt')..writeAsStringSync('');
      });

      tearDown(() {
        investigationReport.deleteSync();
      });

      test('writes investigation report correctly', () {
        final int numberOfCharacters = 42;
        final int numberOfUniqueWords = 10;
        final String mostFrequentWord = 'test';
        final List<String> topFiveLongestWords = ['encyclopedia', 'international', 'transformation', 'programming', 'documentation'];
        final List<String> phoneNumbers = ['+1234567890', '+0987654321'];
        final List<String> suspiciousNumbers = ['+0000000000'];

        recordInvestigationReport(
          investigationReport,
          numberOfCharacters,
          numberOfUniqueWords,
          mostFrequentWord,
          topFiveLongestWords,
          phoneNumbers,
          suspiciousNumbers,
        );

        final content = investigationReport.readAsStringSync();

        expect(
          content,
              'Number of characters in the file: 42; '
              'Number of unique words: 10; '
              'The most frequently repeated word: test; '
              'Top fife longest words: encyclopedia, international, transformation, programming, documentation, ;'
              'All phone numbers: +1234567890, +0987654321, ;'
              'All suspicious numbers: +0000000000, ;',
        );
      });
    });

    group('isHasSameStartAndEnd', () {
      test('returns true if first 3 and last 3 digits are the same', () {
        expect(isHasSameStartAndEnd('123456123'), isTrue);
        expect(isHasSameStartAndEnd('999888999'), isTrue);
      });

      test('returns false if first 3 and last 3 digits are different', () {
        expect(isHasSameStartAndEnd('123456789'), isFalse);
        expect(isHasSameStartAndEnd('000123456'), isFalse);
      });

      test('returns false if the string length is less than 3', () {
        expect(isHasSameStartAndEnd('12'), isFalse);
        expect(isHasSameStartAndEnd('1'), isFalse);
        expect(isHasSameStartAndEnd(''), isFalse);
      });
    });

    group('isSymmetric', () {
      test('returns true if the string is symmetric', () {
        expect(isSymmetric('12321'), isTrue);
        expect(isSymmetric('pikip'), isTrue);
        expect(isSymmetric('a'), isTrue);
        expect(isSymmetric(''), isTrue);
      });

      test('returns false if the string is not symmetric', () {
        expect(isSymmetric('12345'), isFalse);
        expect(isSymmetric('hello'), isFalse);
        expect(isSymmetric('abcde'), isFalse);
      });
    });


    group('isNumberSuspicious', () {
      test('returns true if number has same start and end', () {
        expect(isNumberSuspicious('+380123456123'), isTrue);
      });

      test('returns true if number is symmetric', () {
        expect(isNumberSuspicious('+3801223221'), isTrue);
      });

      test('returns false if number is neither symmetric or has same start/end', () {
        expect(isNumberSuspicious('+380123456789'), isFalse);
      });
    });


    group('processPhoneNumber', () {
      late List<String> suspiciousNumbers;

      setUp(() {
        suspiciousNumbers = [];
      });

      test('does not add non-suspicious number to the list', () {
        processPhoneNumber('+380123456789', suspiciousNumbers);

        expect(suspiciousNumbers.length, 0);
      });
      test('add suspicious number to the list', () {
        processPhoneNumber('+380123456123', suspiciousNumbers);
        processPhoneNumber('+3801223221', suspiciousNumbers);

        expect(suspiciousNumbers.length, 2);
      });
    });



    group('findingAllPhoneNumbers', () {
      late List<String> phoneNumbers;

      setUp(() {
        phoneNumbers = [];
      });

      test('finds phone numbers with correct number of digits', () {
        String data = 'ыбсьытс ысрыорс +1234567890 ысбыбс ыиспымсорп +9876543210 nысли +555';

        phoneNumbers = findingAllPhoneNumbers(data);

        expect(phoneNumbers.length, 2);
        expect(phoneNumbers.contains('+1234567890'), isTrue);
        expect(phoneNumbers.contains('+9876543210'), isTrue);
      });

      test('does not find phone numbers that do not match criteria', () {
        String data = 'вьслофтысло +12345 ыстфтылост +9876543210123456789';

        phoneNumbers = findingAllPhoneNumbers(data);

        expect(phoneNumbers.length, 0);
      });

      test('returns an empty list if no valid numbers are found', () {
        String data = 'No phone numbers!';

        phoneNumbers = findingAllPhoneNumbers(data);

        expect(phoneNumbers, isEmpty);
      });

      test('correctly handles empty input', () {
        String data = '';

        phoneNumbers = findingAllPhoneNumbers(data);

        expect(phoneNumbers, isEmpty);
      });
    });
  }
