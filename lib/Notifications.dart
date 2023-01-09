import 'package:flutter/material.dart';
import 'package:myapp/Crud/ConnectionDL.dart';
import 'package:myapp/Crud/UserDL.dart';


class NotificationPage extends StatefulWidget {
  const NotificationPage({Key? key}) : super(key: key);

  @override
  State<NotificationPage> createState() => _NotificationPageState();
}

class _NotificationPageState extends State<NotificationPage> {

  var reqs=[];
  @override
  void initState() {
    super.initState();
    updateReqs();
  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Column(
        children: [
          Expanded(
            child: ListView.builder(
              itemCount: reqs.length,
              itemBuilder: (context, index) {
                return Container(
                  margin: const EdgeInsets.only(left: 25, right: 25, top: 10, bottom: 10),
                  height: 70,
                  decoration: BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.circular(10),
                    boxShadow: [
                      BoxShadow(
                        color: Colors.grey.withOpacity(0.5),
                        spreadRadius: 5,
                        blurRadius: 7,
                        offset: const Offset(0, 3), // changes position of shadow
                      ),
                    ],
                  ),
                  child:
                  Row(
                    children: [
                      const Padding(padding: EdgeInsets.only(left: 10, right: 10)),
                      CircleAvatar(
                        backgroundImage: NetworkImage(reqs[index].data()['profile_pic']),
                      ),
                      const Padding(padding: EdgeInsets.only(left: 10, right: 10)),
                      // GestureDetector(
                      //   onTap: () {
                      //     Navigator.of(context).pushNamed('/UserProfile', arguments: reqs[index].data()['email']);
                      //   },
                      //   child:
                        Text(
                            reqs[index].data()['name'],
                            style: const TextStyle(color: Colors.teal, fontSize: 20)
                        ),
                      // ),
                      Row(
                        mainAxisSize: MainAxisSize.max,
                        mainAxisAlignment: MainAxisAlignment.end,
                        children: [
                          ElevatedButton(
                              onPressed: () async{
                                await ConnectionDL.addConnection(reqs[index].data()['email']);
                                updateReqs();
                              },
                              child: const Text('Accept')
                          ),
                          const Padding(padding: EdgeInsets.only(left: 5, right: 5)),
                          ElevatedButton(
                              onPressed: ()async{
                                await ConnectionDL.removeRequest(reqs[index].data()['email']);
                                updateReqs();
                              },
                              style: ElevatedButton.styleFrom(
                                backgroundColor: Colors.white,
                                foregroundColor: Colors.teal,
                                side: const BorderSide(color: Colors.teal, width: 1),
                              ),
                              child: const Text('Reject'),
                          ),
                        ],
                      )
                    ],
                  ),
                );
              },
            ),
          ),
        ]
      ),
    );
  }
  void updateReqs() async{
    var v = await UserDL.GetRequests();
    setState(() {
      reqs = v;
    });
  }
}

