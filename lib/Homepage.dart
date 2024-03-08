import 'dart:io';
import 'dart:typed_data';
import 'package:assignment_3/pages/ContactPage.dart';
import 'package:assignment_3/pages/HomeView.dart';
import 'package:assignment_3/pages/authentication/login_page.dart';
import 'package:assignment_3/provider/theme.dart';
import 'package:connectivity_plus/connectivity_plus.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:google_nav_bar/google_nav_bar.dart';
import 'package:provider/provider.dart';
import 'InternetConnectivity/internet_connectivity.dart';
import 'pages/CalculatorView.dart';
import 'pages/Notifications.dart';
import 'package:image_picker/image_picker.dart';



class Homepage extends StatefulWidget {
  const Homepage({Key? key}) : super(key: key);

  @override
  State<Homepage> createState() => _HomepageState();
}

class _HomepageState extends State<Homepage> {
  int _selectedIndex = 0;
  late ConnectivityResult _previousConnectivity;
  Uint8List? _image;
  File? selectedImage;

  final GlobalKey<ScaffoldState> _scaffoldKey = GlobalKey();

  final List<Widget> _pages = [
    HomeViewPage(),
    CalculatorView(),
    ContactPage(),
    NotificationsPageWidget(),
  ];

  @override
  void initState() {
    super.initState();
    Connectivity().onConnectivityChanged.listen((ConnectivityResult result) {
      if (_previousConnectivity == ConnectivityResult.none &&
          (result == ConnectivityResult.mobile ||
              result == ConnectivityResult.wifi)) {
        _showOnlineSnackBar(context);
      }
      _previousConnectivity = result;
    });
    _previousConnectivity = ConnectivityResult.mobile;
  }
  final user = FirebaseAuth.instance.currentUser; 
  void signerUserOut(){
    FirebaseAuth.instance.signOut();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      key: _scaffoldKey,
      appBar: AppBar(
        title: Text(
          'Mail App',
          style: TextStyle(color: Colors.white),
        ),
        backgroundColor: Colors.black,
        leading: IconButton(
          icon: const Icon(Icons.menu),
          color: Colors.white,
          onPressed: () {
            _scaffoldKey.currentState?.openDrawer();
          },
        ),

        actions: <Widget>[
          IconButton(
            icon: Icon(Icons.brightness_6),
            color: Colors.white,
            onPressed: () {
              ThemeProvider themeProvider =
                  Provider.of<ThemeProvider>(context, listen: false);
              themeProvider.swaTheme();
            },
          ),
          IconButton(
            icon: Icon(Icons.logout), 
            onPressed: signerUserOut,
  )
        ],
      ),
      drawer: Drawer(
        child: ListView(
          children: [
            DrawerHeader(
              decoration: BoxDecoration(
                image: _image != null
        ? DecorationImage(
            fit: BoxFit.fill,
            image: MemoryImage(_image!), // Assuming _image is Uint8List
          )
        : DecorationImage(
            fit: BoxFit.fill,
            image: AssetImage('images/background.jpeg'),
          ),
              ),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Row(
  mainAxisAlignment: MainAxisAlignment.spaceBetween, 
  children: [
    Container(
      height: 60,
      width: 60,
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(30),
        color: Colors.white,
      ),
      child: Center(
        child: Text(
          'RM',
          style: TextStyle(fontSize: 26),
        ),
      ),
    ),
    Container(
      child: Center(
        child: IconButton(
          onPressed: (){
            showImagePickerOption(context);
          },
          icon:const Icon(Icons.add_a_photo,
            size: 45,
            color: Colors.black,
          ),
          
        ),
      ),
    ),
  ],
),
                  SizedBox(height: 20),
                  Text(
                    user!.email!, 
                    style: TextStyle(color: Colors.white, fontSize: 26)
                  ),
                ],
              ),
            ),
            ListTile(
              onTap: () {
                _selectPage(0);
              },
              leading: Icon(Icons.home, size: 26, color: Colors.black),
              title: Text('Home', style: TextStyle(fontSize: 26)),
            ),
            ListTile(
              onTap: () {
                _selectPage(1);
              },
              leading: Icon(Icons.calculate, size: 26, color: Colors.black),
              title: Text('calculate', style: TextStyle(fontSize: 26)),
            ),
            ListTile(
              onTap: () {
                _selectPage(2);
              },
              leading: Icon(Icons.contact_phone, size: 26, color: Colors.black),
              title: Text('Contacts', style: TextStyle(fontSize: 26)),
            ),
            ListTile(
              onTap: () {
                _selectPage(3);
              },
              leading: Icon(Icons.notifications, size: 26, color: Colors.black),
              title: Text('Notifications', style: TextStyle(fontSize: 26)),
            ),
            Divider(color: Colors.black),
            ListTile(
              onTap: () {},
              leading: Icon(Icons.settings, size: 26, color: Colors.black),
              title: Text('Settings', style: TextStyle(fontSize: 26)),
            ),
          ],
        ),
      ),
      body: StreamBuilder<ConnectivityResult>(
        stream: Connectivity().onConnectivityChanged,
        builder: (context, snapshot) {
          if (snapshot.hasData) {
            ConnectivityResult result = snapshot.data!;
            if (result == ConnectivityResult.none) {
              return internet_connectivity();
            } else {
              return _pages[_selectedIndex];
            }
          } else {
            return CircularProgressIndicator();
          }
        },
      ),
      bottomNavigationBar: Container(
        color: Colors.black,
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 15.0, vertical: 20),
          child: GNav(
            backgroundColor: Colors.black,
            color: Colors.white,
            activeColor: Colors.white,
            tabBackgroundColor: Colors.grey.shade800,
            gap: 8,
            padding: EdgeInsets.all(16),
            tabs: [
              GButton(
                icon: Icons.home,
                text: 'Home',
              ),
              GButton(
                icon: Icons.calculate,
                text: 'Calc',
              ),
              GButton(
                icon: Icons.inbox,
                text: 'Inbox',
              ),
              GButton(
                icon: Icons.notifications,
                text: 'Notifications',
              ),
            ],
            selectedIndex: _selectedIndex,
            onTabChange: (index) {
              setState(() {
                _selectedIndex = index;
              });
            },
          ),
        ),
      ),
    );
  }

  void _selectPage(int index) {
    setState(() {
      _selectedIndex = index;
    });
    Navigator.of(context).pop();
  }

  void _showOnlineSnackBar(BuildContext context) {
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: Text('Back Online!'),
      ),
    );
  }
  void showImagePickerOption(BuildContext context){
    showModalBottomSheet(
      backgroundColor: Colors.black,
      context: context, builder: (builder){
      return Padding(
        padding: const EdgeInsets.all(18.0),
        child: SizedBox(
          width: MediaQuery.of(context).size.width,
          height: MediaQuery.of(context).size.height/4,
          child: Row(children: [
            Expanded(
              child: InkWell(
                onTap: (){
                  _pickImageFromGallery();
                },
                child: const SizedBox(
                  child: Column(
                    children: [
                    Icon(
                      Icons.image, 
                      size: 70,
                      ),
                    Text('Gallery',style: TextStyle(color: Colors.white),)
                    ],
                  ),
                ),
              ),
            ),
            Expanded(
              child: InkWell(
                onTap: (){
                  _pickImageFromCamera();
                },
                child: const SizedBox(
                  child: Column(
                    children: [
                    Icon(
                      Icons.camera_alt,
                       size: 70),
                    Text('Camera',style: TextStyle(color: Colors.white),)
                    ],
                  ),
                ),
              ),
            )
          ]),
        ),
      );
    });
  }
  Future _pickImageFromGallery()async{
    final returnImage = await ImagePicker().pickImage(source: ImageSource.gallery);
    if(returnImage ==null)return;
    setState(() {
      selectedImage = File(returnImage.path);
      _image  = File(returnImage.path).readAsBytesSync();
    });
    Navigator.of(context).pop();

  }
   Future _pickImageFromCamera()async{
    final returnImage = await ImagePicker().pickImage(source: ImageSource.camera);
    if(returnImage ==null)return;
    setState(() {
      selectedImage = File(returnImage.path);
      _image  = File(returnImage.path).readAsBytesSync();
    });
    Navigator.of(context).pop();
    
  }
}
