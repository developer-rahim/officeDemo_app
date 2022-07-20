import 'package:flutter/material.dart';

import '../detailsScreen.dart';
import '../model/service/sura_service.dart';
import '../model/sura_list_model.dart';

class Home extends StatefulWidget {
  const Home({Key? key}) : super(key: key);

  @override
  State<Home> createState() => _HomeState();
}

class _HomeState extends State<Home> {
  List<SuraListModel> suraList = [];
  //bool initialSura = true;

  Future fetchSuraList() async {
    var data = await SuraService().getSuraList();

    setState(() {
      suraList = data;
      print(suraList);
    });

    // initialSura = false;
  }

  @override
  void initState() {
    // TODO: implement initState

    fetchSuraList();
  
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      drawer: Drawer(),
      appBar: AppBar(
        backgroundColor: Colors.cyan,
        title: Text("Bangla Quran"),
        centerTitle: true,
        actions: [
          Row(
            children: [
              Icon(Icons.search),
              Container(
                  padding: EdgeInsets.only(right: 10),
                  child: Icon(Icons.more_vert)),
            ],
          )
        ],
      ),
      body: SafeArea(
        child: Padding(
          padding: EdgeInsets.symmetric(
            horizontal: 8.0,
          ),
          child: suraList.length > 0
              ? ListView.builder(
                  itemCount: suraList.length,
                  itemBuilder: (context, index) {
                    //var getsuralist = suraList[index];
                    return GestureDetector(
                      onTap: () {
                        Navigator.push(
                            context,
                            MaterialPageRoute(
                                builder: (context) => DetailsScreen(
                                      name: suraList[index].name,
                                      id: int.parse(suraList[index].id),
                                    )));
                      },
                      child: Card(
                        child: ListTile(
                          leading: Text(
                            suraList[index].id.toString(),
                            textAlign: TextAlign.center,
                            style: TextStyle(color: Colors.black),
                          ),
                          title: Text(
                            suraList[index].name.toString(),
                            style: TextStyle(fontSize: 18),
                          ),
                        ),
                      ),
                    );
                  })
              : Center(
                  child: CircularProgressIndicator(),
                ),
        ),
      ),
    );
  }
}
