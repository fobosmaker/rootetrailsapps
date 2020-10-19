import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_maps/constant.dart';
import 'package:flutter_maps/src/model/trail_model.dart';
import 'package:flutter_maps/src/provider/trail_provider.dart';
import 'package:flutter_maps/src/widget/default_trail_card.dart';
class HomeScreen extends StatefulWidget {
  @override
  _HomeScreenState createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  TrailProvider trailAPI = new TrailProvider();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: Text('Home'),
          centerTitle: true,
          backgroundColor: defaultPrimaryColor,
        ),
        body: SingleChildScrollView(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              viewTrail(),
              viewStories(),
              viewSubscription()
            ],
          ),
        )
    );
  }

  Widget viewTrail(){
    return Container(
      padding: EdgeInsets.symmetric(vertical: 20),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          ListTile(
            title: Text("Our Trails", style: defaultPrimaryHeaderStyle),
            subtitle: Padding(
              padding: const EdgeInsets.fromLTRB(0,5,0,10),
              child: Text("Jalur wisata tematik penguhubung antar destinasi wisata secara gratis!", style: defaultPrimaryHeaderContentStyle),
            ),
          ),
          FutureBuilder(
              future: trailAPI.getAllTrail(),
              builder: (context, snapshot){
                if(snapshot.connectionState == ConnectionState.done){
                  if(snapshot.hasError){
                    print('error');
                  }
                  else{
                    if(snapshot.hasData){
                      List<TrailCardModel> result = snapshot.data;
                      print(result.length);
                      return Container(
                          height: 215,
                          child: ListView.builder(
                              shrinkWrap: true,
                              padding: EdgeInsets.symmetric(horizontal: 10),
                              scrollDirection: Axis.horizontal,
                              itemCount: result.length,
                              itemBuilder: (context,index){
                                return new DefaultTrailCardWidget(
                                  title: result[index].name,
                                  imageURL: result[index].imageURL,
                                  onTap: () => Navigator.pushNamed(context, '/trail',arguments: result[index]),
                                );
                              })
                      );
                    } else {
                      print('no data');
                    }
                  }
                }
                return Center(child: CircularProgressIndicator());
              }),
        ],
      ),
    );
  }

  Widget viewStories(){
    return Container(
      padding: EdgeInsets.symmetric(vertical: 20),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          ListTile(
            title: Text("Stories", style: defaultPrimaryHeaderStyle),
            trailing: FlatButton(
              onPressed: (){
                print('yeay');
              },
              child: Text('View All', style: TextStyle(fontSize: 13, fontWeight: FontWeight.w700, color: defaultPrimaryColor)),
            ),
          ),
          Container(
            height: 205,
            child: ListView(
              scrollDirection: Axis.horizontal,
              shrinkWrap: true,
              padding: EdgeInsets.symmetric(horizontal: 10),
              children: [
                InkWell(
                  onTap: null,
                  child: Container(
                    padding: EdgeInsets.symmetric(horizontal: 5),
                    width: 300,
                    height: 215,
                    child:  Card(
                      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10.0)),
                      clipBehavior: Clip.antiAlias,
                      elevation: 2,
                      child: Column(
                        mainAxisSize: MainAxisSize.min,
                        children: [
                          Container(
                            child: ListTile(
                              title: Padding(
                                padding: const EdgeInsets.only(top: 10.0),
                                child: Text('My Story: A Dream of a Better Tourism and Why I Build Roote', style: defaultPrimaryContentHeaderStyle),
                              ),
                              subtitle: Padding(
                                padding: const EdgeInsets.symmetric(vertical:5.0),
                                child: Text('April 12, 2020 by Roote', style: TextStyle(fontSize: 10, fontWeight: FontWeight.w300)),
                              ),
                            ),
                          ),
                          Padding(
                            padding: const EdgeInsets.fromLTRB(15, 5, 15, 15),
                            child: Text('Hello, Faiz here, one of the founders of Roote. I am a researcher (at least that’s what I like to think) but this piece of writing is not at all academic. I am just pouring out my thoughts on why I dedicated my time to build and nurture Roote. Since I was younger, I think and ask questions more tha...',
                              style: defaultPrimaryContentDetailStyle,
                            ),
                          )
                        ],
                      ),
                    ),
                  ),
                ),
                InkWell(
                  onTap: null,
                  child: Container(
                    padding: EdgeInsets.symmetric(horizontal: 5),
                    width: 300,
                    height: 215,
                    child:  Card(
                      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10.0)),
                      clipBehavior: Clip.antiAlias,
                      elevation: 2,
                      child: Column(
                        mainAxisSize: MainAxisSize.min,
                        children: [
                          Container(
                            child: ListTile(
                              title: Padding(
                                padding: const EdgeInsets.only(top: 10.0),
                                child: Text('Covid-19: A Hope for Changes', style: defaultPrimaryContentHeaderStyle),
                              ),
                              subtitle: Padding(
                                padding: const EdgeInsets.symmetric(vertical:5.0),
                                child: Text('April 12, 2020 by Roote', style: TextStyle(fontSize: 10, fontWeight: FontWeight.w300)),
                              ),
                            ),
                          ),
                          Padding(
                            padding: const EdgeInsets.fromLTRB(15, 5, 15, 15),
                            child: Text('Hello, Faiz here, one of the founders of Roote. I am a researcher (at least that’s what I like to think) but this piece of writing is not at all academic. I am just pouring out my thoughts on why I dedicated my time to build and nurture Roote. Since I was younger, I think and ask questions more tha...',
                              style: defaultPrimaryContentDetailStyle,
                            ),
                          )
                        ],
                      ),
                    ),
                  ),
                ),
              ],
            ),
          ),
          //FlatButton.icon(onPressed: (){}, icon: Icon(Icons.launch, size: 13, color: Colors.blue), label: ))
        ],
      ),
    );
  }

  Widget viewSubscription(){
    return Container(
      margin: EdgeInsets.only(top: 20),
      padding: EdgeInsets.symmetric(vertical: 20),
      color: defaultPrimaryColor,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          ListTile(
            title: Text("Subscription", style: defaultAccentHeaderStyle),
            subtitle: Padding(
              padding: const EdgeInsets.fromLTRB(0,5,0,10),
              child: Text("Kita akan selalu update trail-trail baru setiap bulannya yang bisa jadi inspirasi kamu!", style: defaultAccentHeaderContentStyle),
            ),
          ),
          Padding(
            padding: const EdgeInsets.all(15.0),
            child: Container(
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.circular(10),
              ),
              padding: EdgeInsets.symmetric(vertical: 5, horizontal: 15),
              child: TextField(
                decoration: InputDecoration(
                  fillColor: Colors.white,
                  border: InputBorder.none,
                  hintText: 'Nama lengkap kamu',
                  hintStyle: TextStyle(fontSize: 13, fontWeight: FontWeight.w300, color:Colors.black)
                ),
              ),
            ),
          ),
          Padding(
            padding: const EdgeInsets.all(15.0),
            child: Container(
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.circular(10),
              ),
              padding: EdgeInsets.symmetric(vertical: 5, horizontal: 15),
              child: TextField(
                decoration: InputDecoration(
                    fillColor: Colors.white,
                    border: InputBorder.none,
                    hintText: 'Email aktif kamu',
                    hintStyle: TextStyle(fontSize: 13, fontWeight: FontWeight.w300, color:Colors.black)
                ),
              ),
            ),
          ),
          Padding(
            padding: const EdgeInsets.all(15.0),
            child: Container(
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.circular(10),
              ),
              child: FlatButton.icon( color: Colors.white, onPressed: (){}, icon: Icon(Icons.send_rounded, size: 13, color: defaultPrimaryColor), label: Text('Subscribe', style: defaultPrimaryContentHeaderStyle))
            ),
          )
        ],
      ),
    );
  }
}
