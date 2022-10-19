import 'package:bluetooth_test_beacon_app/change_reason.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_database/firebase_database.dart';
import 'package:flutter/material.dart';

class MainPage extends StatefulWidget {
  const MainPage({Key? key}) : super(key: key);

  @override
  State<MainPage> createState() => _MainPageState();
}


class _MainPageState extends State<MainPage> {
  var userProfile;
  final db = FirebaseDatabase.instance.ref();
  final uid = FirebaseAuth.instance.currentUser!.uid;
  var profilePic = '';
  var username = '';
  var location = '';
  var favoriteBook = '';
  var wyliAns = '';

  String description = "";

  @override
  Widget build(BuildContext context) {
    String love;
    return Scaffold(
      backgroundColor: const Color(0xffdee2fe),
      body: Stack(
        children: [
          StreamBuilder(stream: db
              .child("users/$uid")
              .orderByKey()
              .onValue,
            builder: (context, snapshot) {
              final tilesList = {};
              if (snapshot.hasData) {
                final cardsList = Map<String, dynamic>.from(
                    (snapshot.data! as DatabaseEvent).snapshot.value as Map);
                for (dynamic type in cardsList.keys) {
                  tilesList[type] = cardsList[type];
                }
                var love = tilesList['book'].toString();
                var kiss = tilesList['username'].toString();
                var description = tilesList['wyli'].toString();
                favoriteBook = love;
                wyliAns = description;
                username = kiss;
              }
              return Column(
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  Expanded(
                    flex: 20,
                    child: Column(
                      children: [
                        Container(
                          height: 120,
                          width: 95,
                          margin: const EdgeInsets.only(
                            top: 100,
                            bottom: 8,
                          ),
                          decoration: BoxDecoration(
                            color: Colors.white,
                            borderRadius: BorderRadius.circular(10),
                            boxShadow: const [
                              BoxShadow(
                                color: Colors.black26,
                                offset: Offset(2, 2),
                                blurRadius: 10,
                              ),
                            ],
                            image:  DecorationImage(
                              image: NetworkImage("https://upload.wikimedia.org/wikipedia/commons/thumb/b/b6/Gutenberg_Bible%2C_Lenox_Copy%2C_New_York_Public_Library%2C_2009._Pic_01.jpg/330px-Gutenberg_Bible%2C_Lenox_Copy%2C_New_York_Public_Library%2C_2009._Pic_01.jpg"),
                              fit: BoxFit.fill,
                            ),
                          ),
                        ),
                        Text(
                          username,
                          style:  const TextStyle(
                            fontFamily: "Montserrat",
                            color: Colors.black87,
                            fontWeight: FontWeight.bold,
                            fontSize: 30,
                          ),
                        ),
                        const Text(
                          "Study forever, since books are invaluable",
                          style: TextStyle(
                            fontFamily: "Montserrat",
                            color: Colors.black54,
                            fontSize: 16,
                          ),
                        ),
                      ],
                    ),
                  ),
                  Expanded(
                    flex: 20,
                    child: Container(
                      padding: const EdgeInsets.only(
                        top: 20,
                        left: 24,
                        right: 24,
                      ),
                      decoration: const BoxDecoration(
                        color: Colors.white,
                        borderRadius: BorderRadius.only(
                          topLeft: Radius.circular(50),
                          topRight: Radius.circular(50),
                        ),
                      ),
                      child: Stack(
                        children:[
                          Column(
                            crossAxisAlignment: CrossAxisAlignment.center,
                            children: [
                              const Text(
                                "PROFILE",
                                style: TextStyle(
                                  fontFamily: "Montserrat",
                                  color: Colors.black87,
                                  fontWeight: FontWeight.bold,
                                  fontSize: 20,
                                ),
                              ),
                              const SizedBox(),
                              listProfile(Icons.person, "Username", username),
                              listProfile(Icons.book, "Favorite book", favoriteBook),
                              GestureDetector(
                                  onTap: (){
                                    Navigator.push(
                                      context,
                                      MaterialPageRoute(builder: (context) => const ChangeName()),
                                    );
                                  },
                                  child: listProfile(Icons.question_mark, "Why you like it", wyliAns)),
                            ],
                          ),
                        ],
                      ),
                    ),
                  ),
                ],
              );
            },
          ),
        ],
      ),
    );
  }


  Widget listProfile(IconData icon, String text1, String text2) {
    return Container(
      width: double.infinity,
      margin: const EdgeInsets.only(top: 20),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          Icon(
            icon,
            size: 20,
          ),
          const SizedBox(width: 10,),
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                text1,
                style: const TextStyle(
                  color: Colors.black87,
                  fontFamily: "Montserrat",
                  fontSize: 14,
                ),
              ),
              Text(
                text2,
                style: const TextStyle(
                  color: Colors.black87,
                  fontFamily: "Montserrat",
                  fontWeight: FontWeight.bold,
                  fontSize: 16,
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }
}



