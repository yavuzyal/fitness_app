import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:google_sign_in/google_sign_in.dart';

class signInGoogle {
  final FirebaseAuth _auth = FirebaseAuth.instance;
  final GoogleSignIn _googleSignIn = GoogleSignIn();

  Future<String?> signInwithGoogle() async {
    try {
      final GoogleSignInAccount? googleSignInAccount = await _googleSignIn.signIn();

      final GoogleSignInAuthentication googleSignInAuthentication = await googleSignInAccount!.authentication;

      final AuthCredential credential = GoogleAuthProvider.credential(
        accessToken: googleSignInAuthentication.accessToken,
        idToken: googleSignInAuthentication.idToken,
      );

      await _auth.signInWithCredential(credential);

      String userId = _auth.currentUser!.uid;

      QuerySnapshot snap = await FirebaseFirestore.instance.collection('users').get();

      if(!snap.docs.contains(userId)){
        await FirebaseFirestore.instance.collection('users').doc(userId).set({
          'username': googleSignInAccount.displayName.toString(),
          'email': googleSignInAccount.email.toString(),
          'age': -1,
          'weight': -1,
          'height': -1,
          'gender': 'Non-selected',
        });
      }

    } on FirebaseAuthException catch (e) {
      print(e.message);
      throw e;
    }
  }

  Future<void> signOutFromGoogle() async{
    await _googleSignIn.signOut();
    await _auth.signOut();
  }
}