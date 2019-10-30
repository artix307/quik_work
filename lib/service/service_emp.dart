import 'dart:async';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:quik_work/model/employer.dart';

final CollectionReference employerCollection =
    Firestore.instance.collection('employers');

class FirebaseFirestoreService {
  static final FirebaseFirestoreService _instance =
      new FirebaseFirestoreService.internal();

  factory FirebaseFirestoreService() => _instance;

  FirebaseFirestoreService.internal();

  //add data
  Future<Employer> createEmployer(String name, String phone, String email,
      String address, String about, String like, String img) async {
    final TransactionHandler createTransaction = (Transaction tx) async {
      final DocumentSnapshot ds = await tx.get(employerCollection.document());

      final Employer employer = new Employer(
          ds.documentID, name, phone, email, address, about, like, img);
      final Map<String, dynamic> data = employer.toMap();

      await tx.set(ds.reference, data);

      return data;
    };

    return Firestore.instance.runTransaction(createTransaction).then((mapData) {
      return Employer.fromMap(mapData);
    }).catchError((error) {
      print('error: $error');
      return null;
    });
  }

  //can copy
  Stream<QuerySnapshot> getEmployerList({int offset, int limit}) {
    Stream<QuerySnapshot> snapshots = employerCollection.snapshots();

    if (offset != null) {
      snapshots = snapshots.skip(offset);
    }

    if (limit != null) {
      snapshots = snapshots.take(limit);
    }

    return snapshots;
  }

  //update
  Future<dynamic> updateEmployer(Employer employer) async {
    final TransactionHandler updateTransacation = (Transaction tx) async {
      final DocumentSnapshot ds =
          await tx.get(employerCollection.document(employer.id));

      await tx.update(ds.reference, employer.toMap());
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
  Future<dynamic> deleteEmployer(String id) async {
    final TransactionHandler deleteTransaction = (Transaction tx) async {
      final DocumentSnapshot ds = await tx.get(employerCollection.document(id));

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
