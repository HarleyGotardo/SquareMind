import 'package:flutter_test/flutter_test.dart';
import 'package:android_mims_development/model/user_model.dart';
import 'package:android_mims_development/services/database_helper.dart';
import 'package:android_mims_development/model/user_model.dart';

void main() {
  group('DatabaseHelper', () {
    late DatabaseHelper databaseHelper;

    setUp(() {
      databaseHelper = DatabaseHelper.instance;
    });

    test('Insert user into the database', () async {
      final user = User(
        emailOrNumber: 'test@example.com',
        username: 'testuser',
        password: 'password123',
      );

      final insertedId = await databaseHelper.insert(user);

      expect(insertedId, isNotNull);
    });

    test('Query all users from the database', () async {
      final users = await databaseHelper.queryAllRows();

      expect(users, isNotEmpty);
    });

    test('Delete user from the database', () async {
      final emailOrNumber = 'test@example.com';

      final rowsDeleted = await databaseHelper.delete(emailOrNumber);

      expect(rowsDeleted, greaterThan(0));
    });

    test('Check if email or number exists in the database', () async {
      final emailOrNumber = 'test@example.com';

      final exists = await databaseHelper.emailOrNumberExists(emailOrNumber);

      expect(exists, isTrue);
    });

    test('Check if username and password combination is valid for login', () async {
      final username = 'testuser';
      final password = 'password123';

      final isValid = await databaseHelper.checkLogin(username, password);

      expect(isValid, isTrue);
    });

    test('Clear the entire database', () async {
      await databaseHelper.clearDatabase();

      final users = await databaseHelper.queryAllRows();

      expect(users, isEmpty);
    });
  });
}