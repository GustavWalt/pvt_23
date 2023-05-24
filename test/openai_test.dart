import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/mockito.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:pvt_23/screens/FindGroupResultPage/find_group_result_page.dart';

class MockFirebaseFirestore extends Mock implements FirebaseFirestore {}

void main() {
  group('FindGroupResultPage', () {
    late FindGroupResultPage findGroupResultPage;
    late MockFirebaseFirestore mockFirestore;

    setUp(() {
      mockFirestore = MockFirebaseFirestore();
      findGroupResultPage = FindGroupResultPage(foundGroups: null);
    });

    testWidgets('Joining a group adds user to the group', (WidgetTester tester) async {
      // Set up the test by providing a mock instance of FirebaseFirestore
      // and a mock user ID for authentication.
      final mockUserId = 'user123';
      when(mockFirestore.collection(any)).thenReturn(mockFirestore);
      when(mockFirestore.doc(any)).thenReturn(mockFirestore);
      when(mockFirestore.collection('groups')).thenReturn(mockFirestore);
      when(mockFirestore.doc('group123')).thenReturn(mockFirestore);
      when(mockFirestore.collection('groups').doc('group123').collection('users')).thenReturn(mockFirestore);
      
      // Simulate the user clicking the 'Join' button for a group with ID 'group123'.
      await tester.pumpWidget(findGroupResultPage);

      // Ensure that the 'Join' button exists in the UI.
      final joinButtonFinder = find.text('Join');
      expect(joinButtonFinder, findsOneWidget);

      // Mock the behavior of Firestore when adding the user to the group.
      when(mockFirestore.collection('groups').doc('group123').collection('users').add(any))
        .thenAnswer((_) => Future.value());

      // Tap the 'Join' button.
      await tester.tap(joinButtonFinder);
      await tester.pump();

      // Verify that the user was added to the group in the database.
      verify(mockFirestore.collection('groups').doc('group123').collection('users').add({'uid': mockUserId})).called(1);
    });
  });
}