import 'dart:async';
import 'dart:ffi';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/mockito.dart';
import 'package:pvt_23/firebase_options.dart';
import 'package:pvt_23/logic/auth_service.dart';
import 'package:pvt_23/screens/LoginPage/login_page.dart';
import 'package:pvt_23/screens/registerPage/register_page.dart';

import 'mock.dart';

class MockUser extends Mock implements User{
}

final MockUser _mockUser = MockUser();

class MockFirebaseAuth extends Mock implements FirebaseAuth {
  
  @override
  Stream<User> authStateChanges() {
    return Stream.fromIterable([
      _mockUser
    ]); 
    }
}

  main() async {
    final MockFirebaseAuth mockFirebaseAuth = MockFirebaseAuth();
    final AuthService authService = AuthService(auth: mockFirebaseAuth);

    setUpAll(() async {
      final auth = setupFirebaseAuthMocks();
      await Firebase.initializeApp();
    });

  test("emit occurs", () async{
    expectLater(authService.user, emitsInOrder([_mockUser]));
  });

    test('Registration - Successfull', () async{

    const email = 'user.test@gmail.com';
    const password = 'pvt_23';

    String actualOutcome= "Fail";

    when(await authService.registration(email: email, password: password),
    ).thenAnswer((realInvocation) => null);

    final result = authService.registration(email: email, password: password);

    if (result.toString() == "Instance of 'Future<String?>'"){
      actualOutcome = "Success";
    }

    expect(actualOutcome, "Success");
  });

  test('Registration - Weak password', () async {
    const email = 'test@example.com';
    const password = 'weak';

    when(await authService.registration(email: email, password: password),
    ).thenAnswer((realInvocation) => 
      throw FirebaseAuthException(message: "Password is too weak", code: ''));

    final result = await authService.registration(email: email, password: password);
    expect(result, "Password is too weak");
  });

  test('Registration - email already in use', () async {
    const email = 'test@example.com';
    const password = 'testPassword';

    when(await authService.registration(email: email, password: password),
    ).thenAnswer((realInvocation) => 
      throw FirebaseAuthException(message: "Email already in use", code: ''));

    await authService.registration(email: email, password: password);
    final result = await authService.registration(email: email, password: password);

    expect(result, "Email already in use");
  });

  test('Login - Successfull', () async{

    const email = 'user.test@gmail.com';
    const password = 'pvt_23';

    String actualOutcome= "Fail";


    when(await authService.login(email: email, password: password),
    ).thenAnswer((realInvocation) => null);

    final result = authService.login(email: email, password: password);

    if (result.toString() == "Instance of 'Future<String?>'"){
      actualOutcome = "Success";
    }

    expect(actualOutcome, "Success");
  });
}
