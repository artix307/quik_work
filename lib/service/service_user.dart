import 'dart:async';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:quik_work/model/user.dart';

final CollectionReference userCollection =
    Firestore.instance.collection('users');

class FirebaseFirestoreService {
  static final FirebaseFirestoreService _instance =
      new FirebaseFirestoreService.internal();

  factory FirebaseFirestoreService() => _instance;

  FirebaseFirestoreService.internal();

  //add data
  Future<User> createUser(String name, String email, String phone,
      String gender, String dob, String edu, List bkm) async {
    final TransactionHandler createTransaction = (Transaction tx) async {
      final DocumentSnapshot ds = await tx.get(userCollection.document());

      final User user =
          new User(ds.documentID, name, email, phone, gender, dob, edu, bkm);
      final Map<String, dynamic> data = user.toMap();

      await tx.set(ds.reference, data);

      return data;
    };

    return Firestore.instance.runTransaction(createTransaction).then((mapData) {
      return User.fromMap(mapData);
    }).catchError((error) {
      print('error: $error');
      return null;
    });
  }

  //can copy
  Stream<QuerySnapshot> getUserList({int offset, int limit}) {
    Stream<QuerySnapshot> snapshots = userCollection.snapshots();

    if (offset != null) {
      snapshots = snapshots.skip(offset);
    }

    if (limit != null) {
      snapshots = snapshots.take(limit);
    }

    return snapshots;
  }

  //update
  Future<dynamic> updateUser(User user) async {
    final TransactionHandler updateTransacation = (Transaction tx) async {
      final DocumentSnapshot ds =
          await tx.get(userCollection.document(user.id));

      await tx.update(ds.reference, user.toMap());
      return {'updated': true};
    };

    return Firestore.instance
        .runTransaction(updateTransacation)
        .then((result) => result['updated'])
        .catchError((error) {
      print('error: $error');
      return false;
    });
  }

  //delete
  Future<dynamic> deleteUser(String id) async {
    final TransactionHandler deleteTransaction = (Transaction tx) async {
      final DocumentSnapshot ds = await tx.get(userCollection.document(id));

      await tx.delete(ds.reference);
      return {'deleted': true};
    };

    return Firestore.instance
        .runTransaction(deleteTransaction)
        .then((result) => result['deleted'])
        .catchError((error) {
      print('error: $error');
      return false;
    });
  }
}
