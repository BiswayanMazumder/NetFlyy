import 'dart:typed_data';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/material.dart';
final FirebaseStorage _storage= FirebaseStorage.instance;
final FirebaseFirestore _firestore=FirebaseFirestore.instance;

class StoreData{
  Future<String> uploadImagetoStorage(String childname,Uint8List file)async{
   Reference ref=_storage.ref().child(childname);
   UploadTask uploadTask=ref.putData(file);
   TaskSnapshot snapshot=await uploadTask;
   String downloadUrl=await snapshot.ref.getDownloadURL();
   return downloadUrl;
  }
  Future<String> saveData({required Uint8List file}) async{
    String resp="Some Error Occured";
    try{
      String imageUrl=await uploadImagetoStorage('profile_pictures', file);
      await _firestore.collection('userProfile').add({
         'imageLink':imageUrl,
      });
      resp='success';
    }
        catch(err){
      resp=err.toString();
        }
        return resp;
  }
}
