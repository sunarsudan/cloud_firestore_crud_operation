import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';

class FetchScreen extends StatefulWidget {
  const FetchScreen({super.key});

  @override
  State<FetchScreen> createState() => _FetchScreenState();
}

class _FetchScreenState extends State<FetchScreen> {
  final fetchData = FirebaseFirestore.instance.collection('users').snapshots();
  final ref = FirebaseFirestore.instance.collection('users');
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
          child: StreamBuilder<QuerySnapshot>(
        stream: fetchData,
        builder: (context, AsyncSnapshot<QuerySnapshot> snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return Center(
              child: CircularProgressIndicator(),
            );
          } else {
            return ListView.builder(
              itemCount: snapshot.data!.docs.length,
              itemBuilder: (context, index) {
                return ListTile(
                  onTap: () {
                    setState(() {
                      // ref
                      //     .doc(snapshot.data!.docs[index]['id'].toString())
                      //     .delete();

                      ref
                          .doc(snapshot.data!.docs[index]['id'].toString())
                          .update({
                        'name': 'the love',
                      });
                    });
                  },
                  title: Text(snapshot.data!.docs[index]['name'].toString()),
                  subtitle: Text(snapshot.data!.docs[index]['id'].toString()),
                );
              },
            );
          }
        },
      )),
    );
  }
}
