import 'package:flutter/material.dart';
import 'package:url_launcher/url_launcher.dart';
import 'main.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_core/firebase_core.dart';

void main() {
  runApp(MaterialApp(home: RegistrationPage(),
  debugShowCheckedModeBanner: false,));
}

class RegistrationPage extends StatefulWidget {
  @override
  _RegistrationPageState createState() => _RegistrationPageState();
}

class _RegistrationPageState extends State<RegistrationPage> {

  @override
  Widget build(BuildContext context) {
      double screenWidth = MediaQuery.of(context).size.width;

    Widget content;

    if (screenWidth < 600) {
      content = Mobilescreen();
    } else if (screenWidth < 900) {
      content = Tabletscreen();
    } else if (screenWidth < 1400) {
      content = Desktopscreen();
    } else {
      content = Widescreen();
    }
    return Scaffold(
      appBar: null, // Remove the AppBar
      body: content,
    );
  }
}

class CustomHeader extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment:
          MainAxisAlignment.center, // Center the row horizontally
      crossAxisAlignment:
          CrossAxisAlignment.center, // Center the row vertically
      children: [
        Container(
          height: 100,
          width: 240,
          child: Center(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Text(
                  "Let's Get Started",
                  textAlign: TextAlign.center,
                  style: TextStyle(
                    fontSize: 25,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                Text(
                  'Create An Account',
                  textAlign: TextAlign.center,
                  style: TextStyle(
                    fontSize: 18,
                  ),
                ),
              ],
            ),
          ),
        ),
      ],
    );
  }
}
class Desktopscreen extends StatefulWidget {
  @override
  _DesktopscreenState createState() => _DesktopscreenState();
}

class _DesktopscreenState extends State<Desktopscreen> {
   String _hoveredUpdateInfoButton = '';
  TextEditingController _emailController = TextEditingController();
  TextEditingController _passwordController = TextEditingController();
  TextEditingController _nameController = TextEditingController();
  TextEditingController _usernameController = TextEditingController();
  TextEditingController _confirmpasswordController = TextEditingController();
  bool _isChecked1 = true;
  bool _isChecked2 = true;
final GlobalKey<ScaffoldState> _scaffoldKey = GlobalKey<ScaffoldState>();
void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(
    options: FirebaseOptions(
         apiKey: "AIzaSyCROCE0_sqQkmEaOOJ8vMfuAngOloYy13A",
  authDomain: "pinion-dashboard.firebaseapp.com",
  projectId: "pinion-dashboard",
  storageBucket: "pinion-dashboard.appspot.com",
  messagingSenderId: "728065026848",
  appId: "1:728065026848:web:9202d7628ce2aa49514545",
  measurementId: "G-Q4EW0RBJVJ"),
  );
  runApp(MyApp());
}

  void _launchURL(String url) async {
    if (await canLaunch(url)) {
      await launch(url);
    } else {
      throw 'Could not launch $url';
    }
  }

  Future<void> _register() async {
  try {
    UserCredential userCredential = await FirebaseAuth.instance.createUserWithEmailAndPassword(
     email: _emailController.text,
      password: _passwordController.text,
   );

    final user = userCredential.user;
    if (user != null) {
     
      await user.sendEmailVerification();
 
    
      await Fires.collection('users').doc(user.uid).set({
       'email': _emailController.text,
      });

  
      _showNotification('Verification email sent to your account.');
       Navigator.of(context).pushReplacement(
       MaterialPageRoute(builder: (context) => Desktopscreen()));
  
   }
  } catch (e) {
    
    _showNotification('Error during registration: $e');
 }
}

void _showNotification(String message) {
  final snackBar = SnackBar(content: Text(message));
  ScaffoldMessenger.of(context).showSnackBar(snackBar);
}



  bool _obscureText = true;

  void _togglePasswordVisibility() {
    setState(() {
      _obscureText = !_obscureText;
    });
  }
  @override
  Widget build(BuildContext context) {
    // Your widget's UI goes here
   return Scaffold(
       key: _scaffoldKey,
      body: SingleChildScrollView(
        child: Container(
          child: Row(
            children: [
              Container(
                width: MediaQuery.of(context).size.width * 0.6,
                height: 650, // Half of the screen width
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(0.0),
                  color:
                      Colors.white, // You can set the desired background color
                ),
                child: Column(
                  children: [
                    CustomHeader(),
                    Padding(
                      padding: const EdgeInsets.all(16.0),
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          TextField(
                            controller: _nameController,
                            decoration: InputDecoration(
                              border: OutlineInputBorder(
                                  borderRadius: BorderRadius.circular(8.0)),
                              hintText: 'Full Name',
                            ),
                          ),
                          SizedBox(height: 10),
                          TextField(
                            controller: _emailController,
                            decoration: InputDecoration(
                              border: OutlineInputBorder(
                                  borderRadius: BorderRadius.circular(8.0)),
                              hintText: 'Email Address',
                            ),
                            obscureText: false,
                          ),
                          SizedBox(height: 10),
                          TextField(
                            controller: _usernameController,
                            decoration: InputDecoration(
                              border: OutlineInputBorder(
                                  borderRadius: BorderRadius.circular(8.0)),
                              hintText: 'Username',
                            ),
                          ),
                          SizedBox(height: 10),
                          Container(
                              padding: EdgeInsets.all(0.0),
                              decoration: BoxDecoration(
                                  border: Border.all(
                                    color: const Color.fromARGB(
                                        255, 123, 122, 122),
                                    width: 0.5,
                                  ),
                                  borderRadius: BorderRadius.circular(9.0)),
                              ),
                          SizedBox(height: 10),
                          TextField(
                            obscureText: _obscureText,
                            controller: _passwordController,
                            decoration: InputDecoration(
                              border: OutlineInputBorder(
                                  borderRadius: BorderRadius.circular(8.0)),
                              hintText: 'Password',
                              suffixIcon: IconButton(
                                icon: Icon(
                                  _obscureText
                                      ? Icons.visibility_off
                                      : Icons.visibility,
                                ),
                                onPressed: _togglePasswordVisibility,
                              ),
                            ),
                          ),
                          SizedBox(height: 10),
                          TextField(
                            obscureText: _obscureText,
                            controller: _confirmpasswordController,
                            decoration: InputDecoration(
                              border: OutlineInputBorder(
                                borderRadius: BorderRadius.circular(8.0),
                              ),
                              hintText: 'Confirm Password',
                              suffixIcon: IconButton(
                                icon: Icon(
                                  _obscureText
                                      ? Icons.visibility_off
                                      : Icons.visibility,
                                ),
                                onPressed: _togglePasswordVisibility,
                              ),
                            ),
                          ),
                        
                      
                          SizedBox(height: 30),
                          Container(
                            child: ElevatedButton(
onPressed: (_isChecked1 && _isChecked2)
    ? () {
        String password = _passwordController.text;
        String confirmPassword = _confirmpasswordController.text;

        if (password == confirmPassword) {
          //_register(); // Call the _register method

          // Navigate to the next page (NextPage) here
         
        } else {
          // Handle password mismatch error
          _showNotification('Passwords do not match.');
        }
      }
    : null,

    // Disable button if checkboxes are not both checked
                              style: ElevatedButton.styleFrom(
                                primary: _isChecked1 && _isChecked2
                                    ? Color(0xFF0D47A1)
                                    : Colors.white,
                                padding: EdgeInsets.symmetric(
                                  vertical: 26.0,
                                  horizontal: 49.0,
                                ),
                              ),
                              child: Text(
                                'Register',
                                style: TextStyle(
                                  fontSize: 16.0,
                                  color: _isChecked1 && _isChecked2
                                      ? Colors.white
                                      : Colors.black,
                                ),
                              ),
                            ),
                          ),
                          SizedBox(height: 10),
                        ],
                      ),
                    ),
                  ],
                ),
              ),
              Container(
                width: MediaQuery.of(context).size.width * 0.4,
                height: 650,
                decoration: BoxDecoration(
                  color: Color(0xff0d47a1),
                  borderRadius: BorderRadius.circular(0.0),
                ),
                child: Column(
                  children: [
                    SizedBox(height: 25),
                    Align(
                      alignment: Alignment.topCenter,
                      child: Image.asset(
                        'images/Pinion-Partners-Logo.png',
                        color: Colors.white,
                        width: 300,
                      ),
                    ),
                    SizedBox(height: 30),
                    Align(
                      alignment: Alignment.center,
                      child: Text(
                        'Welcome !',
                        textAlign: TextAlign.center,
                        style: TextStyle(
                          color: Colors.white,
                          fontSize: 30,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    ),
                    SizedBox(height: 20),
                    Text(
                      "please fill the registration form to create your admin account.With your admin account, you'll have access to control your system",
                      textAlign: TextAlign.center, // Add more text here
                      style: TextStyle(
                        color: Colors.white,
                        fontSize: 19,
                      ),
                    ),
                    SizedBox(height: 20),
                    Container(
                      child: MouseRegion(
                        onEnter: (_) {
                          setState(() {
                            _hoveredUpdateInfoButton = '2';
                          });
                        },
                        onExit: (_) {
                          setState(() {
                            _hoveredUpdateInfoButton = '';
                          });
                        },
                        child: ElevatedButton(
                          onPressed: () {
                            Navigator.push(
                              context,
                              MaterialPageRoute(
                                builder: (context) => MyHomePage(),
                              ),
                            );
                            // Implement your update information logic here
                          },
                          style: ElevatedButton.styleFrom(
                            primary: _hoveredUpdateInfoButton == '2'
                                ? Color(0xFF0D47A1)
                                : Colors.white,
                            padding: EdgeInsets.symmetric(
                              vertical: 26.0,
                              horizontal: 49.0,
                            ),
                          ),
                          child: Text(
                            'Already Have An Account ',
                            style: TextStyle(
                              fontSize: 12.0,
                              color: _hoveredUpdateInfoButton == '2'
                                  ? Colors.white
                                  : Colors.black,
                            ),
                          ),
                        ),
                      
                      ),
                    ),
                    SizedBox(height: 40,),
                    Container(
                      width: 350,
                      child: Image.asset(
                        "images/pr.png"
                      ),
                    )
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
class Mobilescreen extends StatefulWidget {
  @override
  _MobilescreenState createState() => _MobilescreenState();
}

class _MobilescreenState extends State<Mobilescreen> {
   String _hoveredUpdateInfoButton = '';
  TextEditingController _emailController = TextEditingController();
  TextEditingController _passwordController = TextEditingController();
  TextEditingController _nameController = TextEditingController();
  TextEditingController _usernameController = TextEditingController();
  TextEditingController _confirmpasswordController = TextEditingController();
  bool _isChecked1 = true;
  bool _isChecked2 = true;
final GlobalKey<ScaffoldState> _scaffoldKey = GlobalKey<ScaffoldState>();

  void _launchURL(String url) async {
    if (await canLaunch(url)) {
      await launch(url);
    } else {
      throw 'Could not launch $url';
    }
  }

  Future<void> _register() async {
  try {
    UserCredential userCredential = await _auth.createUserWithEmailAndPassword(
     email: _emailController.text,
      password: _passwordController.text,
   );

    final user = userCredential.user;
    if (user != null) {
      
      await user.sendEmailVerification();
 
     
      await _firestore.collection('users').doc(user.uid).set({
       'email': _emailController.text,
      });

  
      _showNotification('Verification email sent to your account.');
       Navigator.of(context).pushReplacement(
       MaterialPageRoute(builder: (context) =>LoginPage()));
  
   }
  } catch (e) {
    
    _showNotification('Error during registration: $e');
 }
}

void _showNotification(String message) {
  final snackBar = SnackBar(content: Text(message));
  ScaffoldMessenger.of(context).showSnackBar(snackBar);
}



  bool _obscureText = true;

  void _togglePasswordVisibility() {
    setState(() {
      _obscureText = !_obscureText;
    });
  }
  @override
  Widget build(BuildContext context) {
    // Your widget's UI goes here
  return Scaffold(
       key: _scaffoldKey,
      body: SingleChildScrollView(
        child: Container(
          child: Column(
            children: [
              Container(
                width: MediaQuery.of(context).size.width * 1,
                height: 650, // Half of the screen width
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(0.0),
                  color:
                      Colors.white, // You can set the desired background color
                ),
                child: Column(
                  children: [
                    CustomHeader(),
                    Padding(
                      padding: const EdgeInsets.all(16.0),
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          TextField(
                            controller: _nameController,
                            decoration: InputDecoration(
                              border: OutlineInputBorder(
                                  borderRadius: BorderRadius.circular(8.0)),
                              hintText: 'Full Name',
                            ),
                          ),
                          SizedBox(height: 10),
                          TextField(
                            controller: _emailController,
                            decoration: InputDecoration(
                              border: OutlineInputBorder(
                                  borderRadius: BorderRadius.circular(8.0)),
                              hintText: 'Email Address',
                            ),
                            obscureText: false,
                          ),
                          SizedBox(height: 10),
                          TextField(
                            controller: _usernameController,
                            decoration: InputDecoration(
                              border: OutlineInputBorder(
                                  borderRadius: BorderRadius.circular(8.0)),
                              hintText: 'Username',
                            ),
                          ),
                          SizedBox(height: 10),
                          Container(
                              padding: EdgeInsets.all(0.0),
                              decoration: BoxDecoration(
                                  border: Border.all(
                                    color: const Color.fromARGB(
                                        255, 123, 122, 122),
                                    width: 0.5,
                                  ),
                                  borderRadius: BorderRadius.circular(9.0)),
                              ),
                          SizedBox(height: 10),
                          TextField(
                            obscureText: _obscureText,
                            controller: _passwordController,
                            decoration: InputDecoration(
                              border: OutlineInputBorder(
                                  borderRadius: BorderRadius.circular(8.0)),
                              hintText: 'Password',
                              suffixIcon: IconButton(
                                icon: Icon(
                                  _obscureText
                                      ? Icons.visibility_off
                                      : Icons.visibility,
                                ),
                                onPressed: _togglePasswordVisibility,
                              ),
                            ),
                          ),
                          SizedBox(height: 10),
                          TextField(
                            obscureText: _obscureText,
                            controller: _confirmpasswordController,
                            decoration: InputDecoration(
                              border: OutlineInputBorder(
                                borderRadius: BorderRadius.circular(8.0),
                              ),
                              hintText: 'Confirm Password',
                              suffixIcon: IconButton(
                                icon: Icon(
                                  _obscureText
                                      ? Icons.visibility_off
                                      : Icons.visibility,
                                ),
                                onPressed: _togglePasswordVisibility,
                              ),
                            ),
                          ),
                        
                      
                          SizedBox(height: 30),
                          Container(
                            child: ElevatedButton(
onPressed: (_isChecked1 && _isChecked2)
    ? () {
        String password = _passwordController.text;
        String confirmPassword = _confirmpasswordController.text;

        if (password == confirmPassword) {
          //_register(); // Call the _register method

          // Navigate to the next page (NextPage) here
         
        } else {
          // Handle password mismatch error
          _showNotification('Passwords do not match.');
        }
      }
    : null,

    // Disable button if checkboxes are not both checked
                              style: ElevatedButton.styleFrom(
                                primary: _isChecked1 && _isChecked2
                                    ? Color(0xFF0D47A1)
                                    : Colors.white,
                                padding: EdgeInsets.symmetric(
                                  vertical: 26.0,
                                  horizontal: 49.0,
                                ),
                              ),
                              child: Text(
                                'Register',
                                style: TextStyle(
                                  fontSize: 16.0,
                                  color: _isChecked1 && _isChecked2
                                      ? Colors.white
                                      : Colors.black,
                                ),
                              ),
                            ),
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
              ),
              Container(
                width: MediaQuery.of(context).size.width * 1,
                height: 650,
                decoration: BoxDecoration(
                  color: Color(0xff0d47a1),
                  borderRadius: BorderRadius.circular(0.0),
                ),
                child: Column(
                  children: [
                    SizedBox(height: 25),
                    Align(
                      alignment: Alignment.topCenter,
                      child: Image.asset(
                        'images/Pinion-Partners-Logo.png',
                        color: Colors.white,
                        width: 300,
                      ),
                    ),
                    SizedBox(height: 30),
                    Align(
                      alignment: Alignment.center,
                      child: Text(
                        'Welcome !',
                        textAlign: TextAlign.center,
                        style: TextStyle(
                          color: Colors.white,
                          fontSize: 30,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    ),
                    SizedBox(height: 20),
                    Text(
                      "please fill the registration form to create your admin account.With your admin account, you'll have access to control your system",
                      textAlign: TextAlign.center, // Add more text here
                      style: TextStyle(
                        color: Colors.white,
                        fontSize: 19,
                      ),
                    ),
                    SizedBox(height: 20),
                    Container(
                      child: MouseRegion(
                        onEnter: (_) {
                          setState(() {
                            _hoveredUpdateInfoButton = '2';
                          });
                        },
                        onExit: (_) {
                          setState(() {
                            _hoveredUpdateInfoButton = '';
                          });
                        },
                        child: ElevatedButton(
                          onPressed: () {
                            Navigator.push(
                              context,
                              MaterialPageRoute(
                                builder: (context) => MyHomePage(),
                              ),
                            );
                            // Implement your update information logic here
                          },
                          style: ElevatedButton.styleFrom(
                            primary: _hoveredUpdateInfoButton == '2'
                                ? Color(0xFF0D47A1)
                                : Colors.white,
                            padding: EdgeInsets.symmetric(
                              vertical: 26.0,
                              horizontal: 49.0,
                            ),
                          ),
                          child: Text(
                            'Already Have An Account ',
                            style: TextStyle(
                              fontSize: 12.0,
                              color: _hoveredUpdateInfoButton == '2'
                                  ? Colors.white
                                  : Colors.black,
                            ),
                          ),
                        ),
                      
                      ),
                    ),
                    SizedBox(height: 40,),
                    Container(
                      width: 350,
                      child: Image.asset(
                        "images/pr.png"
                      ),
                    )
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
class Tabletscreen extends StatefulWidget {
  @override
  _TabletscreenState createState() => _TabletscreenState();
}

class _TabletscreenState extends State<Tabletscreen> {
   String _hoveredUpdateInfoButton = '';
  TextEditingController _emailController = TextEditingController();
  TextEditingController _passwordController = TextEditingController();
  TextEditingController _nameController = TextEditingController();
  TextEditingController _usernameController = TextEditingController();
  TextEditingController _confirmpasswordController = TextEditingController();
  bool _isChecked1 = true;
  bool _isChecked2 = true;
final GlobalKey<ScaffoldState> _scaffoldKey = GlobalKey<ScaffoldState>();

  void _launchURL(String url) async {
    if (await canLaunch(url)) {
      await launch(url);
    } else {
      throw 'Could not launch $url';
    }
  }

  //Future<void> _register() async {
  //try {
    //UserCredential userCredential = await _auth.createUserWithEmailAndPassword(
     // email: _emailController.text,
      //password: _passwordController.text,
   // );

    //final user = userCredential.user;
    //if (user != null) {
      // Send email verification
      //await user.sendEmailVerification();
 
      // Store additional user data in Cloud Firestore
      //await _firestore.collection('users').doc(user.uid).set({
      //  'email': _emailController.text,
      //});

  
      //_showNotification('Verification email sent to your account.');
       //Navigator.of(context).pushReplacement(
       // MaterialPageRoute(builder: (context) =>LoginPage()));
  
   // }
  //} catch (e) {
    // Handle registration error
    //_showNotification('Error during registration: $e');
 // }
//}

void _showNotification(String message) {
  final snackBar = SnackBar(content: Text(message));
  ScaffoldMessenger.of(context).showSnackBar(snackBar);
}



  bool _obscureText = true;

  void _togglePasswordVisibility() {
    setState(() {
      _obscureText = !_obscureText;
    });
  }
  @override
  Widget build(BuildContext context) {
    // Your widget's UI goes here
  return Scaffold(
       key: _scaffoldKey,
      body: SingleChildScrollView(
        child: Container(
          child: Column(
            children: [
              Container(
                width: MediaQuery.of(context).size.width * 1,
                height: 650, 
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(0.0),
                  color:
                      Colors.white, // You can set the desired background color
                ),
                child: Column(
                  children: [
                    CustomHeader(),
                    Padding(
                      padding: const EdgeInsets.all(16.0),
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          TextField(
                            controller: _nameController,
                            decoration: InputDecoration(
                              border: OutlineInputBorder(
                                  borderRadius: BorderRadius.circular(8.0)),
                              hintText: 'Full Name',
                            ),
                          ),
                          SizedBox(height: 10),
                          TextField(
                            controller: _emailController,
                            decoration: InputDecoration(
                              border: OutlineInputBorder(
                                  borderRadius: BorderRadius.circular(8.0)),
                              hintText: 'Email Address',
                            ),
                            obscureText: false,
                          ),
                          SizedBox(height: 10),
                          TextField(
                            controller: _usernameController,
                            decoration: InputDecoration(
                              border: OutlineInputBorder(
                                  borderRadius: BorderRadius.circular(8.0)),
                              hintText: 'Username',
                            ),
                          ),
                          SizedBox(height: 10),
                          Container(
                              padding: EdgeInsets.all(0.0),
                              decoration: BoxDecoration(
                                  border: Border.all(
                                    color: const Color.fromARGB(
                                        255, 123, 122, 122),
                                    width: 0.5,
                                  ),
                                  borderRadius: BorderRadius.circular(9.0)),
                              ),
                          SizedBox(height: 10),
                          TextField(
                            obscureText: _obscureText,
                            controller: _passwordController,
                            decoration: InputDecoration(
                              border: OutlineInputBorder(
                                  borderRadius: BorderRadius.circular(8.0)),
                              hintText: 'Password',
                              suffixIcon: IconButton(
                                icon: Icon(
                                  _obscureText
                                      ? Icons.visibility_off
                                      : Icons.visibility,
                                ),
                                onPressed: _togglePasswordVisibility,
                              ),
                            ),
                          ),
                          SizedBox(height: 10),
                          TextField(
                            obscureText: _obscureText,
                            controller: _confirmpasswordController,
                            decoration: InputDecoration(
                              border: OutlineInputBorder(
                                borderRadius: BorderRadius.circular(8.0),
                              ),
                              hintText: 'Confirm Password',
                              suffixIcon: IconButton(
                                icon: Icon(
                                  _obscureText
                                      ? Icons.visibility_off
                                      : Icons.visibility,
                                ),
                                onPressed: _togglePasswordVisibility,
                              ),
                            ),
                          ),
                        
                      
                          SizedBox(height: 30),
                          Container(
                            child: ElevatedButton(
onPressed: (_isChecked1 && _isChecked2)
    ? () {
        String password = _passwordController.text;
        String confirmPassword = _confirmpasswordController.text;

        if (password == confirmPassword) {
          //_register(); // Call the _register method

          // Navigate to the next page (NextPage) here
         
        } else {
          // Handle password mismatch error
          _showNotification('Passwords do not match.');
        }
      }
    : null,

    // Disable button if checkboxes are not both checked
                              style: ElevatedButton.styleFrom(
                                primary: _isChecked1 && _isChecked2
                                    ? Color(0xFF0D47A1)
                                    : Colors.white,
                                padding: EdgeInsets.symmetric(
                                  vertical: 26.0,
                                  horizontal: 49.0,
                                ),
                              ),
                              child: Text(
                                'Register',
                                style: TextStyle(
                                  fontSize: 16.0,
                                  color: _isChecked1 && _isChecked2
                                      ? Colors.white
                                      : Colors.black,
                                ),
                              ),
                            ),
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
              ),
              Container(
                width: MediaQuery.of(context).size.width * 1,
                height: 650,
                decoration: BoxDecoration(
                  color: Color(0xff0d47a1),
                  borderRadius: BorderRadius.circular(0.0),
                ),
                child: Column(
                  children: [
                    SizedBox(height: 25),
                    Align(
                      alignment: Alignment.topCenter,
                      child: Image.asset(
                        'images/Pinion-Partners-Logo.png',
                        color: Colors.white,
                        width: 300,
                      ),
                    ),
                    SizedBox(height: 30),
                    Align(
                      alignment: Alignment.center,
                      child: Text(
                        'Welcome !',
                        textAlign: TextAlign.center,
                        style: TextStyle(
                          color: Colors.white,
                          fontSize: 30,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    ),
                    SizedBox(height: 20),
                    Text(
                      "please fill the registration form to create your admin account.With your admin account, you'll have access to control your system",
                      textAlign: TextAlign.center, // Add more text here
                      style: TextStyle(
                        color: Colors.white,
                        fontSize: 19,
                      ),
                    ),
                    SizedBox(height: 20),
                    Container(
                      child: MouseRegion(
                        onEnter: (_) {
                          setState(() {
                            _hoveredUpdateInfoButton = '2';
                          });
                        },
                        onExit: (_) {
                          setState(() {
                            _hoveredUpdateInfoButton = '';
                          });
                        },
                        child: ElevatedButton(
                          onPressed: () {
                            Navigator.push(
                              context,
                              MaterialPageRoute(
                                builder: (context) => MyHomePage(),
                              ),
                            );
                            // Implement your update information logic here
                          },
                          style: ElevatedButton.styleFrom(
                            primary: _hoveredUpdateInfoButton == '2'
                                ? Color(0xFF0D47A1)
                                : Colors.white,
                            padding: EdgeInsets.symmetric(
                              vertical: 26.0,
                              horizontal: 49.0,
                            ),
                          ),
                          child: Text(
                            'Already Have An Account ',
                            style: TextStyle(
                              fontSize: 12.0,
                              color: _hoveredUpdateInfoButton == '2'
                                  ? Colors.white
                                  : Colors.black,
                            ),
                          ),
                        ),
                      
                      ),
                    ),
                    SizedBox(height: 40,),
                    Container(
                      width: 350,
                      child: Image.asset(
                        "images/pr.png"
                      ),
                    )
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
class Widescreen extends StatefulWidget {
  @override
  _WidecreenState createState() => _WidecreenState();
}

class _WidecreenState extends State<Widescreen> {
   String _hoveredUpdateInfoButton = '';
  TextEditingController _emailController = TextEditingController();
  TextEditingController _passwordController = TextEditingController();
  TextEditingController _nameController = TextEditingController();
  TextEditingController _usernameController = TextEditingController();
  TextEditingController _confirmpasswordController = TextEditingController();
  bool _isChecked1 = true;
  bool _isChecked2 = true;
final GlobalKey<ScaffoldState> _scaffoldKey = GlobalKey<ScaffoldState>();

  void _launchURL(String url) async {
    if (await canLaunch(url)) {
      await launch(url);
    } else {
      throw 'Could not launch $url';
    }
  }

  //Future<void> _register() async {
  //try {
    //UserCredential userCredential = await _auth.createUserWithEmailAndPassword(
     // email: _emailController.text,
      //password: _passwordController.text,
   // );

    //final user = userCredential.user;
    //if (user != null) {
      // Send email verification
      //await user.sendEmailVerification();
 
      // Store additional user data in Cloud Firestore
      //await _firestore.collection('users').doc(user.uid).set({
      //  'email': _emailController.text,
      //});

  
      //_showNotification('Verification email sent to your account.');
       //Navigator.of(context).pushReplacement(
       // MaterialPageRoute(builder: (context) =>LoginPage()));
  
   // }
  //} catch (e) {
    // Handle registration error
    //_showNotification('Error during registration: $e');
 // }
//}

void _showNotification(String message) {
  final snackBar = SnackBar(content: Text(message));
  ScaffoldMessenger.of(context).showSnackBar(snackBar);
}



  bool _obscureText = true;

  void _togglePasswordVisibility() {
    setState(() {
      _obscureText = !_obscureText;
    });
  }
  @override
  Widget build(BuildContext context) {
    // Your widget's UI goes here
  return Scaffold(
       key: _scaffoldKey,
      body: SingleChildScrollView(
        child: Container(
          child: Column(
            children: [
              Container(
                width: MediaQuery.of(context).size.width * 1,
                height: 650, 
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(0.0),
                  color:
                      Colors.white, // You can set the desired background color
                ),
                child: Column(
                  children: [
                    CustomHeader(),
                    Padding(
                      padding: const EdgeInsets.all(16.0),
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          TextField(
                            controller: _nameController,
                            decoration: InputDecoration(
                              border: OutlineInputBorder(
                                  borderRadius: BorderRadius.circular(8.0)),
                              hintText: 'Full Name',
                            ),
                          ),
                          SizedBox(height: 10),
                          TextField(
                            controller: _emailController,
                            decoration: InputDecoration(
                              border: OutlineInputBorder(
                                  borderRadius: BorderRadius.circular(8.0)),
                              hintText: 'Email Address',
                            ),
                            obscureText: false,
                          ),
                          SizedBox(height: 10),
                          TextField(
                            controller: _usernameController,
                            decoration: InputDecoration(
                              border: OutlineInputBorder(
                                  borderRadius: BorderRadius.circular(8.0)),
                              hintText: 'Username',
                            ),
                          ),
                          SizedBox(height: 10),
                          Container(
                              padding: EdgeInsets.all(0.0),
                              decoration: BoxDecoration(
                                  border: Border.all(
                                    color: const Color.fromARGB(
                                        255, 123, 122, 122),
                                    width: 0.5,
                                  ),
                                  borderRadius: BorderRadius.circular(9.0)),
                              ),
                          SizedBox(height: 10),
                          TextField(
                            obscureText: _obscureText,
                            controller: _passwordController,
                            decoration: InputDecoration(
                              border: OutlineInputBorder(
                                  borderRadius: BorderRadius.circular(8.0)),
                              hintText: 'Password',
                              suffixIcon: IconButton(
                                icon: Icon(
                                  _obscureText
                                      ? Icons.visibility_off
                                      : Icons.visibility,
                                ),
                                onPressed: _togglePasswordVisibility,
                              ),
                            ),
                          ),
                          SizedBox(height: 10),
                          TextField(
                            obscureText: _obscureText,
                            controller: _confirmpasswordController,
                            decoration: InputDecoration(
                              border: OutlineInputBorder(
                                borderRadius: BorderRadius.circular(8.0),
                              ),
                              hintText: 'Confirm Password',
                              suffixIcon: IconButton(
                                icon: Icon(
                                  _obscureText
                                      ? Icons.visibility_off
                                      : Icons.visibility,
                                ),
                                onPressed: _togglePasswordVisibility,
                              ),
                            ),
                          ),
                        
                      
                          SizedBox(height: 30),
                          Container(
                            child: ElevatedButton(
onPressed: (_isChecked1 && _isChecked2)
    ? () {
        String password = _passwordController.text;
        String confirmPassword = _confirmpasswordController.text;

        if (password == confirmPassword) {
          //_register(); // Call the _register method

          // Navigate to the next page (NextPage) here
         
        } else {
          // Handle password mismatch error
          _showNotification('Passwords do not match.');
        }
      }
    : null,

    // Disable button if checkboxes are not both checked
                              style: ElevatedButton.styleFrom(
                                primary: _isChecked1 && _isChecked2
                                    ? Color(0xFF0D47A1)
                                    : Colors.white,
                                padding: EdgeInsets.symmetric(
                                  vertical: 26.0,
                                  horizontal: 49.0,
                                ),
                              ),
                              child: Text(
                                'Register',
                                style: TextStyle(
                                  fontSize: 16.0,
                                  color: _isChecked1 && _isChecked2
                                      ? Colors.white
                                      : Colors.black,
                                ),
                              ),
                            ),
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
              ),
              Container(
                width: MediaQuery.of(context).size.width * 1,
                height: 650,
                decoration: BoxDecoration(
                  color: Color(0xff0d47a1),
                  borderRadius: BorderRadius.circular(0.0),
                ),
                child: Column(
                  children: [
                    SizedBox(height: 25),
                    Align(
                      alignment: Alignment.topCenter,
                      child: Image.asset(
                        'images/Pinion-Partners-Logo.png',
                        color: Colors.white,
                        width: 300,
                      ),
                    ),
                    SizedBox(height: 30),
                    Align(
                      alignment: Alignment.center,
                      child: Text(
                        'Welcome !',
                        textAlign: TextAlign.center,
                        style: TextStyle(
                          color: Colors.white,
                          fontSize: 30,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    ),
                    SizedBox(height: 20),
                    Text(
                      "please fill the registration form to create your admin account.With your admin account, you'll have access to control your system",
                      textAlign: TextAlign.center, // Add more text here
                      style: TextStyle(
                        color: Colors.white,
                        fontSize: 19,
                      ),
                    ),
                    SizedBox(height: 20),
                    Container(
                      child: MouseRegion(
                        onEnter: (_) {
                          setState(() {
                            _hoveredUpdateInfoButton = '2';
                          });
                        },
                        onExit: (_) {
                          setState(() {
                            _hoveredUpdateInfoButton = '';
                          });
                        },
                        child: ElevatedButton(
                          onPressed: () {
                            Navigator.push(
                              context,
                              MaterialPageRoute(
                                builder: (context) => MyHomePage(),
                              ),
                            );
                            // Implement your update information logic here
                          },
                          style: ElevatedButton.styleFrom(
                            primary: _hoveredUpdateInfoButton == '2'
                                ? Color(0xFF0D47A1)
                                : Colors.white,
                            padding: EdgeInsets.symmetric(
                              vertical: 26.0,
                              horizontal: 49.0,
                            ),
                          ),
                          child: Text(
                            'Already Have An Account ',
                            style: TextStyle(
                              fontSize: 12.0,
                              color: _hoveredUpdateInfoButton == '2'
                                  ? Colors.white
                                  : Colors.black,
                            ),
                          ),
                        ),
                      
                      ),
                    ),
                    SizedBox(height: 40,),
                    Container(
                      width: 350,
                      child: Image.asset(
                        "images/pr.png"
                      ),
                    )
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}