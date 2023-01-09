import 'package:flutter/material.dart';
import 'package:myapp/Crud/UserDL.dart';

class SearchPage extends StatefulWidget {
  const SearchPage({Key? key}) : super(key: key);

  @override
  State<SearchPage> createState() => _SearchPageState();
}
class _SearchPageState extends State<SearchPage> {
  var objs = [];
  var searchName = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Column(
        children: [
          const Padding(padding: EdgeInsets.only(top: 20)),
          const Center(
            child: Text(
              'Search',
              style: TextStyle(color: Colors.teal, fontSize: 33),
            ),
          ),
          Container(
            margin: const EdgeInsets.only(
                left: 35, right: 35, top: 10, bottom: 10),
            child: TextField(
              controller: searchName,
              style: const TextStyle(color: Colors.black),
              decoration: InputDecoration(
                  enabledBorder: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(10),
                    borderSide: const BorderSide(
                      color: Colors.teal,
                    ),
                  ),
                  focusedBorder: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(10),
                    borderSide: const BorderSide(
                      color: Colors.black,
                    ),
                  ),
                  hintText: 'Search',
                  hintStyle: const TextStyle(color: Colors.grey)
              ),
            ),
          ),
          ElevatedButton(
            onPressed: () async{
              await searchUsers(searchName.text);
            },
            style: ElevatedButton.styleFrom(
              backgroundColor: Colors.teal,
              foregroundColor: Colors.white,
              minimumSize: const Size(140, 40),
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(32.0),
              ),
            ),
            child: const Text('Search'),
          ),

          //search results

          Expanded(
            child: ListView.builder(
              itemCount: objs.length,
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
                          backgroundImage: NetworkImage(objs[index].data()['profile_pic']),
                        ),
                        const Padding(padding: EdgeInsets.only(left: 10, right: 10)),
                        GestureDetector(
                          onTap: () {
                            Navigator.of(context).pushNamed('/UserProfile', arguments: objs[index].data()['email']);

                          },
                          child: Text(
                              objs[index].data()['name'],
                              style: const TextStyle(color: Colors.teal, fontSize: 20)
                          ),
                        ),
                      ],
                    ),
                );
              },
            ),
          ),
        ],
      ),
    );
  }

  Future<void> searchUsers(String query) async{
    var v = await UserDL.SearchQuery(query);
    setState(() {
      objs = v;
    });
  }
}
