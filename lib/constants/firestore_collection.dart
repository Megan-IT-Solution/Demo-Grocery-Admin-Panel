import 'package:cloud_firestore/cloud_firestore.dart';

class FireStoreCollections {
  static CollectionReference clientCollection = FirebaseFirestore.instance
      .collection('clients');
  static CollectionReference creativeCollection = FirebaseFirestore.instance
      .collection('creatives');
  static CollectionReference servicesCollection = FirebaseFirestore.instance
      .collection('services');

  static CollectionReference categoryCollection = FirebaseFirestore.instance
      .collection('categories');
}
