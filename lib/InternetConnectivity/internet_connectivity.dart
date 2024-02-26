import 'package:flutter/material.dart';
import 'package:connectivity_plus/connectivity_plus.dart';


class internet_connectivity extends StatefulWidget {
  const internet_connectivity({super.key});

  @override
  State<internet_connectivity> createState() => _internet_connectivityState();
}

class _internet_connectivityState extends State<internet_connectivity> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        margin: const EdgeInsets.all(20),
        width: double.infinity,
        height: double.infinity,
        child: StreamBuilder(
          stream: Connectivity().onConnectivityChanged, 
          builder: (context, AsyncSnapshot<ConnectivityResult> snapshot){
            print(snapshot.toString());
            if(snapshot.hasData){
              return loading();
            }else{
              return noInternet();
            }
        


          },)
        
      ),
    );
  }
}


Widget loading(){
  return const Center(
    child: CircularProgressIndicator(
      valueColor: AlwaysStoppedAnimation<Color>(Colors.green),
    ),
  );
}

Widget connected(String type){
  return Center(
    child: Text(
      "$type Connected", 
      style: const TextStyle(
        color: Colors.green, 
        fontSize:20),),
  );
}

Widget noInternet(){
  return  Column(
    crossAxisAlignment: CrossAxisAlignment.center,
    mainAxisAlignment: MainAxisAlignment.center,
    children: [
      Image.asset(
        'images/no_internet.png',
          height:100,
      ),
      Container(
        margin: const EdgeInsets.only(top:20, bottom:10),
        child: const Text(
          'No internet connection', 
          style:  TextStyle(fontSize: 22),
          )
      ),
      Container(
        child: const Text("Check your connection"),
      ),
      
    ],
  );
}

