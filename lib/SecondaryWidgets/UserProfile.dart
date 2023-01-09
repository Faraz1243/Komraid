import 'package:flutter/material.dart';
import 'package:myapp/Crud/ConnectionDL.dart';
import 'package:myapp/Crud/UserDL.dart';
class UserProfile extends StatefulWidget {
  late String s ;
  UserProfile(this.s, {Key? key}) : super(key: key);

  @override
  State<UserProfile> createState() => _UserProfileState(s);
}
class _UserProfileState extends State<UserProfile> {
  late String email;
  _UserProfileState(this.email);

  String imageUrl = "";
  String name = "";
  String bio = "";
  int friends = 0;
  bool isFriend = false;
  bool isRequestSent = false;
  bool wasRequestReceived = false;

  String buttonText="Add Friend";

  @override
  void initState(){
    super.initState();
    load();
  }
  void load() async{
    var user = await UserDL.GetUserData(email);
    setState(() {
      imageUrl = user['profile_pic'];
      name = user['name'];
      bio = user['bio'];
      friends = user['friends'].length;
    });
    isFriend = await ConnectionDL.isConnection(email, UserDL.email);
    isRequestSent = await ConnectionDL.isRequestSent(email);
    var v = await UserDL.GetRequests();
    for (int i = 0; i < v.length; i++) {
      if (v[i]['email'] == email) {
        wasRequestReceived = true;
        break;
      }
    }
  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Profile View"),
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.start,
          children: [
            const Padding(padding: EdgeInsets.only(top: 20)),
            CircleAvatar(
              radius: 80,
              backgroundImage: NetworkImage(imageUrl),
            ),
            Text(
                name,
              style: const TextStyle(
                fontSize: 30,
                fontWeight: FontWeight.normal,
                color: Colors.teal,
              ),
            ),
            Text(bio),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                const Text(
                  " Friends : ",
                  style: TextStyle(
                    fontSize: 15,
                    fontWeight: FontWeight.normal,
                  ),
                ),

                Text(
                  friends.toString(),
                  style: const TextStyle(
                    fontSize: 15,
                    fontWeight: FontWeight.normal,
                  ),
                ),
              ],
            ),

            Center(
              child: ElevatedButton(
                  onPressed: () async{
                    await buttonPressed();
                  },
                  style: ElevatedButton.styleFrom(
                    backgroundColor: Colors.teal,
                    foregroundColor: Colors.white,
                    minimumSize: const Size(140, 40),
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(32.0),
                    ),
                  ),
                  child: Text(buttonText),
              ),
            )
          ],
        ),
      ),
    );
  }

  Future<void> buttonPressed() async {
    if(isFriend){
      await ConnectionDL.removeConnection(email);
      isFriend = false;
    }
    else if(isRequestSent){
      await ConnectionDL.removeRequest(email);
      isRequestSent = false;
    }
    else if(wasRequestReceived){
      await ConnectionDL.addConnection(email);
      wasRequestReceived = false;
      isFriend = true;
    }
    else{
      await ConnectionDL.sendRequest(email);
      isRequestSent = true;
    }
    updateForm();
    load();
  }
  void updateForm() {
    if(isFriend){
      setState(() {
        buttonText = "Remove Friend";
      });
    }
    else if(isRequestSent){
      setState(() {
        buttonText = "Withdraw Request";
      });
    }
    else if(wasRequestReceived){
      setState(() {
        buttonText = "Accept Request";
      });
    }
    else{
      setState(() {
        buttonText = "Add Friend";
      });
    }
  }
}


