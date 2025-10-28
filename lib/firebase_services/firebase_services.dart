import 'dart:math';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:event_app/models/category_model.dart';
import 'package:event_app/models/event_model.dart';
import 'package:event_app/models/user_model.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:google_sign_in/google_sign_in.dart';

class FirebaseServices {
  static Future<UserCredential> register(String email, String password) async {
    UserCredential userCredential = await FirebaseAuth.instance
        .createUserWithEmailAndPassword(email: email, password: password);
    return userCredential;
  }

  static Future<UserCredential> login(String email, String password) async {
    UserCredential userCredential = await FirebaseAuth.instance
        .signInWithEmailAndPassword(email: email, password: password);
    return userCredential;
  }

  static CollectionReference<UserModel> getUserCollection() {
    FirebaseFirestore db = FirebaseFirestore.instance;
    CollectionReference<UserModel> usersCollection = db
        .collection("Users")
        .withConverter<UserModel>(
          fromFirestore: (snapshot, _) => UserModel.fromJson(snapshot.data()!),
          toFirestore: (user, _) => user.toJson(),
        );
    return usersCollection;
  }

  static Future<void> addUserToFireStore(UserModel user) {
    CollectionReference<UserModel> usersCollection = getUserCollection();
    DocumentReference<UserModel> userDocument = usersCollection.doc(user.id);
    return userDocument.set(user);
  }

  static Future<UserModel> getUserFromFireStoreById(String uid) async {
    CollectionReference<UserModel> usersCollection = getUserCollection();
    DocumentReference<UserModel> userDocument = usersCollection.doc(uid);
    DocumentSnapshot<UserModel> documentSnapshot = await userDocument.get();
    return documentSnapshot.data()!;
  }

  static CollectionReference<EventModel> getEventsCollection(
    BuildContext context,
  ) {
    FirebaseFirestore db = FirebaseFirestore.instance;
    CollectionReference<EventModel> eventsCollection = db
        .collection("Event")
        .withConverter<EventModel>(
          fromFirestore: (snapshot, _) =>
              EventModel.fromJson(snapshot.data()!, context),
          toFirestore: (event, _) => event.toJson(),
        );
    return eventsCollection;
  }

  static Future<void> addEventToFireStore(
    EventModel event,
    BuildContext context,
  ) {
    CollectionReference<EventModel> eventsCollection = getEventsCollection(
      context,
    );
    DocumentReference<EventModel> eventDocument = eventsCollection.doc();
    event.eventId = eventDocument.id;
    return eventDocument.set(event);
  }

  static Future<List<EventModel>> getEvents(
    BuildContext context,
    CategoryModel category,
  ) async {
    CollectionReference<EventModel> eventsCollection = getEventsCollection(
      context,
    );
    QuerySnapshot<EventModel> querySnapshot = await eventsCollection
        .orderBy("dateTime")
        .get();
    List<EventModel> events = querySnapshot.docs
        .map((documentSnapshot) => documentSnapshot.data())
        .toList();
    if (category.id == "0") {
      return events;
    }
    events = events.where((event) => event.category.id == category.id).toList();
    return events;
  }

  static Stream<List<EventModel>> getEventsWithRealTime(
    BuildContext context,
    CategoryModel category,
  ) async* {
    CollectionReference<EventModel> eventsCollection = getEventsCollection(
      context,
    );
    Stream<QuerySnapshot<EventModel>> collectionSnapshots = eventsCollection
        .where("categoryId", isEqualTo: category.id == "0" ? null : category.id)
        .orderBy("dateTime")
        .snapshots();
    var events = collectionSnapshots.map(
      (snapshot) =>
          snapshot.docs.map((docSnapshot) => docSnapshot.data()).toList(),
    );
    yield* events;
  }

  static Future<void> addEventToFavourite(EventModel event) {
    UserModel currentUser = UserModel.currentUser!;
    currentUser.favouriteEventsIds.add(event.eventId);
    CollectionReference<UserModel> usersCollection = getUserCollection();
    DocumentReference<UserModel> userDocument = usersCollection.doc(
      currentUser.id,
    );
    return userDocument.set(currentUser);
  }

  static Future<void> removeEventToFavourite(EventModel event) {
    UserModel currentUser = UserModel.currentUser!;
    currentUser.favouriteEventsIds.remove(event.eventId);
    CollectionReference<UserModel> usersCollection = getUserCollection();
    DocumentReference<UserModel> userDocument = usersCollection.doc(
      currentUser.id,
    );
    return userDocument.set(currentUser);
  }

  static Future<List<EventModel>> getFavouriteEvents(
    BuildContext context,
  ) async {
    CollectionReference<EventModel> eventsCollections = getEventsCollection(
      context,
    );
    QuerySnapshot<EventModel> querySnapshot = await eventsCollections.get();
    List<QueryDocumentSnapshot<EventModel>> documntsSnapshootes =
        querySnapshot.docs;
    List<EventModel> events = documntsSnapshootes
        .map((docSnapshot) => docSnapshot.data())
        .toList();
    List<EventModel> favouriteEvents = events
        .where(
          (event) =>
              UserModel.currentUser!.favouriteEventsIds.contains(event.eventId),
        )
        .toList();
    return favouriteEvents;
  }
  // static Future<void> logoutWithGoogle() async {
  //   try {
  //     await FirebaseAuth.instance.signOut();
  //     await GoogleSignIn().signOut();
  //     print('Logout successful');
  //   } catch (error) {
  //     print('Error while signing out: $error');
  //   }
  // }


  static Future<void> signInWithGoogle() async {
    // Trigger the authentication flow
    final GoogleSignInAccount? googleUser = await GoogleSignIn().signIn();
    // Obtain the auth details from the request
    final GoogleSignInAuthentication? googleAuth =
        await googleUser?.authentication;
    // Create a new credential
    final credential = GoogleAuthProvider.credential(
      accessToken: googleAuth?.accessToken,
      idToken: googleAuth?.idToken,
    );

    // Once signed in, return the UserCredential
    await FirebaseAuth.instance.signInWithCredential(credential);
    UserModel user = UserModel(
      id: FirebaseAuth.instance.currentUser!.uid,
      name: googleUser?.displayName ?? 'NO Name',
      email: googleUser?.email ?? 'NO Name',
      favouriteEventsIds: [],
    );
    CollectionReference<UserModel> usersCollection = getUserCollection();
    await usersCollection.doc(FirebaseAuth.instance.currentUser!.uid).set(user);
  }
  static Future<void> updatedEvent(EventModel event ,BuildContext context) async{
    CollectionReference<EventModel> collectionReference = getEventsCollection(context);
    await collectionReference.doc(event.eventId).update(event.toJson());
  }
  static Future<void> deleteEvent(String eventId ,BuildContext context) async{
    CollectionReference<EventModel> collectionReference = getEventsCollection(context);
    await collectionReference.doc(eventId).delete();
  }






}
