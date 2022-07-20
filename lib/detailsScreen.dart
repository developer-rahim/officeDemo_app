import 'package:flutter/material.dart';
import 'package:quran_app/model/service/ayat_service.dart';

import 'model/ayat_model.dart';

class DetailsScreen extends StatefulWidget {
  int? id;
  String? name;

  DetailsScreen({required this.id, required this.name});

  @override
  State<DetailsScreen> createState() => _DetailsScreenState();
}

class _DetailsScreenState extends State<DetailsScreen> {
  List<AyatListModel> ayatList = [];
  int? gobalindex = 0;
  int page = 1;
  bool isLoding = true;
  ScrollController _xcrollController = ScrollController();
  bool _isInitial = true;
  int _page = 1;
  String _searchKey = "";
  int _totalData = 0;
  bool _showLoadingContainer = false;

  fatchAyatList() async {
    ayatList = await AyatService().getAyatService(widget.id!, page);
    setState(() {
      isLoding = false;
    });
    _isInitial = false;
    _totalData = page;
    _showLoadingContainer = false;
    setState(() {});
  }

  @override
  void initState() {
    // TODO: implement initState
    fatchAyatList();
    _xcrollController.addListener(() {
      //print("position: " + _xcrollController.position.pixels.toString());
      //print("max: " + _xcrollController.position.maxScrollExtent.toString());

      if (_xcrollController.position.pixels ==
          _xcrollController.position.maxScrollExtent) {
        setState(() {
          page++;
          fatchAyatList();
        });
        _showLoadingContainer = true;
      }
    });
  }

  @override
  void dispose() {
    // TODO: implement dispose

    _xcrollController.dispose();
    super.dispose();
  }
  reset() {
    ayatList.clear();
    _isInitial = true;
    _totalData = 0;
    _page = 1;
    _showLoadingContainer = false;
    setState(() {});
  }

  Future<void> _onRefresh() async {
    reset();
    fatchAyatList();
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        appBar: AppBar(
          backgroundColor: Colors.cyan,
          title: Text(widget.name!),
          centerTitle: true,
        ),
        body: Stack( children: [
           RefreshIndicator(  color: Colors.amber,
        backgroundColor: Colors.white,
        displacement: 0,
        onRefresh: _onRefresh,
             child: SingleChildScrollView(
               child: Column(
                children: [
                  SizedBox(
                    height: 20,
                  ),
                  ListView.builder(
                      itemCount: ayatList.length,
                      shrinkWrap: true,
                      physics: NeverScrollableScrollPhysics(),
                      itemBuilder: (context, index) {
                        // var getAyatdata=ayatList[index];
                        SizedBox(
                          height: 20,
                        );
                        return Card(
                          elevation: 5,
                          color: Colors.white,
                          child: ListTile(
                              title: Text(ayatList[index].ayahNo!),
                              subtitle: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Container(
                                    width: double.infinity,
                                    child: Column(
                                      crossAxisAlignment: CrossAxisAlignment.end,
                                      children: [
                                        Directionality(
                                            textDirection: TextDirection.rtl,
                                            child: Text(
                                              ayatList[index].ayahText!,
                                              style: TextStyle(
                                                  color: Colors.black, fontSize: 20),
                                            )),
                                      ],
                                    ),
                                  ),
                                  ListView.builder(
                                    shrinkWrap: true,
                                    controller: _xcrollController,
                                    physics: NeverScrollableScrollPhysics(),
                                    itemCount: ayatList[index].bn!.length,
                                    itemBuilder: (context, gobalindex) {
                                      return Text(
                                        ayatList[index].bn![gobalindex].tokenTrans!,
                                        style: TextStyle(color: Colors.black),
                                      );
                                    },
                                  )
                                ],
                              )),
                        );
                     
                        // title: Text(ayatList[index].ayahText!),
                        //
                      }),
                ],
                       ),
             ),
           ),
       buildLoadingContainer() ]),
      ),
    );
  }
    Container buildLoadingContainer() {
    return Container(
      height: _showLoadingContainer ? 36 : 0,
      width: double.infinity,
      color: Colors.white,
      child: Center(
        child: Text(_totalData != page
            ? 'no ,ore data'
            : 'AppLocalizations.of(context).common_loading_more_products)',
      ),
    ));
  }
}
