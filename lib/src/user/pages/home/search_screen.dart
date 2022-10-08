import 'dart:math';

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:mapmyindia_gl/mapmyindia_gl.dart';
import 'package:ride_hailer/src/user/constants/api_key.dart';
import 'package:ride_hailer/src/user/data/singleton.dart';
import 'package:ride_hailer/src/user/pages/home/map_search_screen.dart';

class SearchScreen extends StatefulWidget {
  SearchScreen({Key? key, this.isCurrentLoc}) : super(key: key);

  bool? isCurrentLoc;

  @override
  State<SearchScreen> createState() => _SearchScreenState();
}

class _SearchScreenState extends State<SearchScreen> {
  List<ELocation> searchRes = [];
  TextEditingController tct = TextEditingController();
  String inputText = "";

  void initMapMyIndia() {
    MapmyIndiaAccountManager.setMapSDKKey(ApiKey.REST_API_KEY);
    MapmyIndiaAccountManager.setRestAPIKey(ApiKey.REST_API_KEY);
    MapmyIndiaAccountManager.setAtlasClientId(ApiKey.ATLAS_CLIENT_ID);
    MapmyIndiaAccountManager.setAtlasClientSecret(ApiKey.ATLAS_CLIENT_SECRET);
  }

  Future<void> initMapOperations(String term) async {
    if (term.length < 3) {
      return;
    }

    MapmyIndiaAutoSuggest(
            query: term, location: const LatLng(12.9587464, 77.5573456))
        .callAutoSuggest()
        .then((value) {
      if (value!.suggestedLocations!.isNotEmpty) {
        setState(() {
          // searchRes = (searchRes + value.suggestedLocations!);
          searchRes = value.suggestedLocations!;
        });
      }

      value!.suggestedLocations!.forEach((element) {
        print("sL1 : ${element.placeAddress}");
        print("sL2 : ${element.placeName}");
        print("sL3 : ${element.p}");
      });
    }).onError((error, stackTrace) {
      print(error);
    });
  }

  @override
  void initState() {
    initMapMyIndia();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        resizeToAvoidBottomInset: true,
        body: SafeArea(
            child: SingleChildScrollView(
          child: Column(
            children: [searchField(), suggestionListView()],
          ),
        )));
  }

  Widget suggestionListView() {
    return SizedBox(
        height: MediaQuery.of(context).size.height,
        child: ListView.builder(
          scrollDirection: Axis.vertical,
          physics: const AlwaysScrollableScrollPhysics(),
          itemCount: searchRes.length,
          itemBuilder: (context, index) {
            return GestureDetector(
              onTap: () {
                if (widget.isCurrentLoc == true) {
                  Singleton().currentLoc = searchRes[index].placeName!;
                  // Singleton().currentLat = searchRes[index].latitude!;
                  // Singleton().currentLong = searchRes[index].longitude!;
                  print("list item clicked.");
                  print(
                      "curLat : ${searchRes[index].latitude} curLong: ${searchRes[index].longitude}");
                  Navigator.push(
                    context,
                    MaterialPageRoute(builder: (context) => MapSearchScreen()),
                  );
                } else {
                  Singleton().togoLoc = searchRes[index].placeName!;
                  print(
                      "togoLat : ${searchRes[index].latitude} togoLong: ${searchRes[index].longitude}");
                  // Singleton().togoLat = searchRes[index].latitude!;
                  // Singleton().togoLong = searchRes[index].longitude!;
                  Navigator.push(
                    context,
                    MaterialPageRoute(builder: (context) => MapSearchScreen()),
                  );
                  Singleton().togoLat = searchRes[index].latitude!;
                  Singleton().togoLong = searchRes[index].longitude!;
                }
              },
              child: listviewItem(
                  index: index,
                  heading: searchRes[index].placeName!,
                  subHeading: searchRes[index].placeAddress!,
                  km: "${Random().nextInt(100)} km"),
            );
          },
        ));
  }

  Widget listviewItem(
      {required int index,
      required String km,
      required String heading,
      required String subHeading}) {
    return Container(
      padding: const EdgeInsets.all(7),
      margin: const EdgeInsets.all(7),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Column(
            children: [
              Container(
                  padding: const EdgeInsets.all(4),
                  decoration: const BoxDecoration(
                      borderRadius: BorderRadius.all(Radius.circular(48)),
                      color: Colors.grey),
                  child: const Icon(Icons.location_on, color: Colors.white)),
              const SizedBox(height: 3),
              Text(
                km,
                style: const TextStyle(
                    fontSize: 13,
                    color: Colors.grey,
                    fontWeight: FontWeight.w500),
              )
            ],
          ),
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              SizedBox(
                width: 220,
                child: Text(
                  heading,
                  maxLines: 2,
                  overflow: TextOverflow.ellipsis,
                  style: const TextStyle(
                      fontSize: 16,
                      color: Colors.black,
                      fontWeight: FontWeight.w500),
                ),
              ),
              const SizedBox(height: 5),
              SizedBox(
                width: 210,
                child: Text(
                  subHeading,
                  maxLines: 3,
                  overflow: TextOverflow.ellipsis,
                  style: const TextStyle(
                      fontSize: 14,
                      color: Colors.grey,
                      fontWeight: FontWeight.w500),
                ),
              )
            ],
          ),
          Column(
            children: [
              Icon(
                Icons.bookmark_add_outlined,
                color: Colors.grey[600],
              )
            ],
          )
        ],
      ),
    );
  }

  MapmyIndiaPlaceDetail mapPlaceSearch({required String query}) {
    return MapmyIndiaPlaceDetail(eLoc: query);
  }

  MapmyIndiaTextSearch mapMyIndiaPicker({required String query}) {
    return MapmyIndiaTextSearch(query: query);
  }

  MapmyIndiaNearby mapNearBy() {
    return MapmyIndiaNearby(keyword: "gaya");
  }

  MapmyIndiaAutoSuggest mapMy() {
    return MapmyIndiaAutoSuggest(query: "delhi");
  }

  Widget searchField() {
    return Card(
        elevation: 2,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(0.0),
        ),
        child: TextFormField(
          autofocus: true,
          controller: tct,
          textAlign: TextAlign.justify,
          decoration: InputDecoration(
              hintText: widget.isCurrentLoc == true
                  ? "Search pickup location"
                  : "Search drop location",
              suffixIcon: suffixIconWidget(),
              prefixIcon: prefixIconWidget()),
          onChanged: (value) {
            initMapOperations(value);
            setState(() {
              inputText = value;
            });
          },
        ));
  }

  Widget prefixIconWidget() {
    return GestureDetector(
        onTap: () {
          Navigator.pop(context);
        },
        child: const Icon(Icons.arrow_back_sharp, color: Colors.black));
  }

  Widget suffixIconWidget() {
    return Visibility(
        visible: inputText.isNotEmpty,
        child: GestureDetector(
            onTap: () {
              tct.clear();
            },
            child: const Icon(Icons.cancel)));
  }
}
