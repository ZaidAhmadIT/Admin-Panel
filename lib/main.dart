import 'package:flutter/material.dart';
import 'Registrationpage.dart';
import 'dashboard..dart';
import 'forget.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  // ignore: use_key_in_widget_constructors
  const MyApp({Key? key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Page with Buttons and Logo',
      theme: ThemeData(
        scaffoldBackgroundColor:
            Colors.white, // Set the background color to white
      ),
      home: const MyHomePage(),
      debugShowCheckedModeBanner: false, // Turn off the debug banner
    );
  }
}

class MyHomePage extends StatelessWidget {
  // ignore: use_key_in_widget_constructors
  const MyHomePage({Key? key});

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

class Desktopscreen extends StatelessWidget {
  const Desktopscreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        // Blue line with rounded borders at the top
        Positioned(
          top: 0,
          left: -20, // Adjust the left value to add a gap to the left wall
          right: -20, // Adjust the right value to add a gap to the right wall
          child: Container(
            height: 50, // Adjust the height of the line as needed
            decoration: BoxDecoration(
              color: Color(0xff0d47a1),
              borderRadius:
                  const BorderRadius.vertical(bottom: Radius.circular(20)),
              boxShadow: [
                BoxShadow(
                  color: Colors.grey.withOpacity(0.5),
                  spreadRadius: 5,
                  blurRadius: 7,
                ),
              ],
            ),
          ),
        ),

        // Logo at the top-left corner
        Positioned(
          top: -20,
          left: 40,
          child: Image.asset(
            'images/Pinion-Partners-Logo.png', // Replace with your logo image path
            width: 350, // Increase the width and height of the logo
            height: 350,
          ),
        ),

        // Heading below the logo
        Positioned(
          top: 150,
          left: 40,
          child: Image.asset(
            'images/PANEL.png', // Replace with your logo image path
            width: 380, // Increase the width and height of the logo
            height: 380,
          ),
        ),
        // Register Button within a rounded rectangle with white background
        Positioned(
          top: 125,
          right: 40, // Add some gap from the right
          child: ElevatedButton(
            onPressed: () {
              Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (context) => RegistrationPage(),
                ),
              );
              // Implement your update information logic here
            },
            style: ElevatedButton.styleFrom(
              backgroundColor: Color(0xff0d47a1),
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(10.0),
              ),
              elevation: 10,
            ),
            child: const Text(
              'Register',
              style: TextStyle(color: Colors.white),
            ),
          ),
        ),

        // Sign In Button within a rounded rectangle with white background

        // Centered "admin.png" image
        Positioned(
          child: Center(
            child: Transform.scale(
              scale: 1, // Adjust the scale factor as needed
              child: Image.asset(
                'images/admin.png', // Replace with your image path
              ),
            ),
          ),
        ),

        // Login and Password Container
        Positioned(
          top: MediaQuery.of(context).size.height / 2 - 130,
          right: 40,
          child: Container(
            width: 280,
            padding: const EdgeInsets.all(20),
            decoration: BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.circular(10),
              boxShadow: [
                BoxShadow(
                  color: Colors.grey.withOpacity(0.5),
                  spreadRadius: 5,
                  blurRadius: 7,
                ),
              ],
            ),
            child: Column(
              children: [
                // Username or Email Input Field
                TextFormField(
                  decoration: const InputDecoration(
                    labelText: 'Username or Email',
                  ),
                ),
                const SizedBox(height: 40),

                // Password Input Field
                TextFormField(
                  obscureText: true,
                  decoration: const InputDecoration(
                    labelText: 'Password',
                  ),
                ),
                const SizedBox(height: 16),

                // Forget Password Option
                Align(
                  alignment: Alignment.centerRight,
                  child: TextButton(
                    onPressed: () {
                      Navigator.of(context).push(MaterialPageRoute(
                        builder: (context) =>
                            ResetPasswordScreen(), // Replace with the actual page you want to navigate to
                      ));
                    },
                    child: const Text(
                      'Forget Password?',
                      style: TextStyle(
                        color: Colors.blue,
                      ),
                    ),
                  ),
                ),
                SizedBox(
                  height: 20,
                ),
                // Elevated Button (Login Button)
                ElevatedButton(
                  onPressed: () {
                    Navigator.of(context).push(MaterialPageRoute(
                      builder: (context) =>
                          DashboardPage(), // Replace with the actual page you want to navigate to
                    ));
                  },
                  style: ElevatedButton.styleFrom(
                    backgroundColor:
                        Color(0xff0d47a1), // Set the background color here
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(10.0),
                    ),
                    elevation: 10,
                  ),
                  child: const Text(
                    'Login',
                    style: TextStyle(
                      color: Colors.white,
                    ),
                  ),
                ),
              ],
            ),
          ),
        ),

        // Blue line with rounded borders at the bottom
        Positioned(
          bottom: 0,
          left: -20, // Adjust the left value to add a gap to the right wall
          right: -20, // Adjust the right value to add a gap to the right wall
          child: Container(
            height: 50, // Adjust the height of the line as needed
            decoration: BoxDecoration(
              color: Color(0xff0d47a1),
              borderRadius:
                  const BorderRadius.vertical(top: Radius.circular(20)),
              boxShadow: [
                BoxShadow(
                  color: Colors.grey.withOpacity(0.5),
                  spreadRadius: 5,
                  blurRadius: 7,
                ),
              ],
            ),
          ),
        ),
      ],
    );
  }
}

class Tabletscreen extends StatelessWidget {
  const Tabletscreen({super.key});

  @override
  Widget build(BuildContext context) {
    // double screenWidth = MediaQuery.of(context).size.width;
    return Stack(
      children: [
        // Blue line with rounded borders at the top
        Positioned(
          top: 0,
          left: -20, // Adjust the left value to add a gap to the left wall
          right: -20, // Adjust the right value to add a gap to the right wall
          child: Container(
            height: 50, // Adjust the height of the line as needed
            decoration: BoxDecoration(
              color: Color(0xff0d47a1),
              borderRadius:
                  const BorderRadius.vertical(bottom: Radius.circular(20)),
              boxShadow: [
                BoxShadow(
                  color: Colors.grey.withOpacity(0.5),
                  spreadRadius: 5,
                  blurRadius: 7,
                ),
              ],
            ),
          ),
        ),

        // Logo at the top-left corner
        Positioned(
          top: -20,
          left: 20,
          child: Image.asset(
            'images/Pinion-Partners-Logo.png', // Replace with your logo image path
            width: 300, // Increase the width and height of the logo
            height: 300,
          ),
        ),

        // Heading below the logo
        Positioned(
          top: 100,
          left: 20,
          child: Image.asset(
            'images/PANEL.png', // Replace with your logo image path
            width: MediaQuery.of(context).size.height / 3 +
                50, // Increase the width and height of the logo
            height: MediaQuery.of(context).size.height / 3 + 50,
          ),
        ),
        // Register Button within a rounded rectangle with white background
        Positioned(
          top: 125,
          right: 50, // Add some gap from the right
          child: ElevatedButton(
            onPressed: () {
              Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (context) => RegistrationPage(),
                ),
              );
              // Implement your update information logic here
            },
            style: ElevatedButton.styleFrom(
              backgroundColor: Color(0xff0d47a1),
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(10.0),
              ),
              elevation: 10,
            ),
            child: const Text(
              'Register',
              style: TextStyle(color: Colors.white),
            ),
          ),
        ),

        // Sign In Button within a rounded rectangle with white background

        // Centered "admin.png" image
        Positioned(
          top: MediaQuery.of(context).size.height / 5 + 170,
          child: Container(
            height: MediaQuery.of(context).size.height / 2 + 20,
            width: MediaQuery.of(context).size.width / 2 + 20,
            // color: Colors.amberAccent,
            child: Transform.scale(
              scale: 2.5, // Adjust the scale factor as needed
              child: Image.asset(
                'images/admin.png', // Replace with your image path
              ),
            ),
          ),
        ),

        // Login and Password Container
        Positioned(
          top: MediaQuery.of(context).size.height / 5 + 310,
          right: 50,
          child: Container(
            width: MediaQuery.of(context).size.height / 3 + 20,
            padding: const EdgeInsets.all(20),
            decoration: BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.circular(10),
              boxShadow: [
                BoxShadow(
                  color: Colors.grey.withOpacity(0.5),
                  spreadRadius: 5,
                  blurRadius: 7,
                ),
              ],
            ),
            child: Column(
              children: [
                // Username or Email Input Field
                TextFormField(
                  decoration: const InputDecoration(
                    labelText: 'Username or Email',
                  ),
                ),
                const SizedBox(height: 40),

                // Password Input Field
                TextFormField(
                  obscureText: true,
                  decoration: const InputDecoration(
                    labelText: 'Password',
                  ),
                ),
                const SizedBox(height: 16),

                // Forget Password Option
                Align(
                  alignment: Alignment.centerRight,
                  child: TextButton(
                    onPressed: () {
                      Navigator.of(context).push(MaterialPageRoute(
                        builder: (context) =>
                            ResetPasswordScreen(), // Replace with the actual page you want to navigate to
                      ));
                    },
                    child: const Text(
                      'Forget Password?',
                      style: TextStyle(
                        color: Colors.blue,
                      ),
                    ),
                  ),
                ),
                SizedBox(
                  height: 20,
                ),
                // Elevated Button (Login Button)
                ElevatedButton(
                  onPressed: () {
                    Navigator.of(context).push(MaterialPageRoute(
                      builder: (context) =>
                          DashboardPage(), // Replace with the actual page you want to navigate to
                    ));
                  },
                  style: ElevatedButton.styleFrom(
                    backgroundColor:
                        Color(0xff0d47a1), // Set the background color here
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(10.0),
                    ),
                    elevation: 10,
                  ),
                  child: const Text(
                    'Login',
                    style: TextStyle(
                      color: Colors.white,
                    ),
                  ),
                ),
              ],
            ),
          ),
        ),

        // Blue line with rounded borders at the bottom
        Positioned(
          bottom: 0,
          left: -20, // Adjust the left value to add a gap to the right wall
          right: -20, // Adjust the right value to add a gap to the right wall
          child: Container(
            height: 50, // Adjust the height of the line as needed
            decoration: BoxDecoration(
              color: Color(0xff0d47a1),
              borderRadius:
                  const BorderRadius.vertical(top: Radius.circular(20)),
              boxShadow: [
                BoxShadow(
                  color: Colors.grey.withOpacity(0.5),
                  spreadRadius: 5,
                  blurRadius: 7,
                ),
              ],
            ),
          ),
        ),
      ],
    );
  }
}

class Mobilescreen extends StatelessWidget {
  const Mobilescreen({super.key});

  @override
  Widget build(BuildContext context) {
    double screenWidth = MediaQuery.of(context).size.width;
    return SingleChildScrollView(
      child: Column(
        children: [
          Container(
            padding: EdgeInsets.fromLTRB(15, 30, 15, 0),
            child: Row(
              crossAxisAlignment: CrossAxisAlignment.center,
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Container(
                  width: 200,
                  child: Image.asset(
                    'images/Pinion-Partners-Logo.png', // Replace with your logo image path
                    // width: 350, // Increase the width and height of the logo
                    // height: 350,
                  ),
                ),
                SizedBox(
                  width: 40,
                ),
                Container(
                  child: ElevatedButton(
                    onPressed: () {
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (context) => RegistrationPage(),
                        ),
                      );
                      // Implement your update information logic here
                    },
                    style: ElevatedButton.styleFrom(
                      backgroundColor: Color(0xff0d47a1),
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(10.0),
                      ),
                      elevation: 10,
                    ),
                    child: const Text(
                      'Register',
                      style: TextStyle(color: Colors.white),
                    ),
                  ),
                ),
              ],
            ),
          ),
          SizedBox(
            height: 20,
          ),
          Container(
            height: 100,
            // color: Colors.amber,
            child: Image.asset(
              'images/PANEL.png',
            ),
          ),
          SizedBox(
            height: 20,
          ),
          Container(
            child: Container(
              width: 280,
              padding: const EdgeInsets.all(20),
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.circular(10),
                boxShadow: [
                  BoxShadow(
                    color: Colors.grey.withOpacity(0.5),
                    spreadRadius: 5,
                    blurRadius: 7,
                  ),
                ],
              ),
              child: Column(
                children: [
                  // Username or Email Input Field
                  TextFormField(
                    decoration: const InputDecoration(
                      labelText: 'Username or Email',
                    ),
                  ),
                  const SizedBox(height: 40),

                  // Password Input Field
                  TextFormField(
                    obscureText: true,
                    decoration: const InputDecoration(
                      labelText: 'Password',
                    ),
                  ),
                  const SizedBox(height: 16),

                  // Forget Password Option
                  Align(
                    alignment: Alignment.centerRight,
                    child: TextButton(
                      onPressed: () {
                        Navigator.of(context).push(MaterialPageRoute(
                          builder: (context) =>
                              ResetPasswordScreen(), // Replace with the actual page you want to navigate to
                        ));
                      },
                      child: const Text(
                        'Forget Password?',
                        style: TextStyle(
                          color: Colors.blue,
                        ),
                      ),
                    ),
                  ),
                  SizedBox(
                    height: 20,
                  ),
                  // Elevated Button (Login Button)
                  ElevatedButton(
                    onPressed: () {
                      Navigator.of(context).push(MaterialPageRoute(
                        builder: (context) =>
                            DashboardPage(), // Replace with the actual page you want to navigate to
                      ));
                    },
                    style: ElevatedButton.styleFrom(
                      backgroundColor:
                          Color(0xff0d47a1), // Set the background color here
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(10.0),
                      ),
                      elevation: 10,
                    ),
                    child: const Text(
                      'Login',
                      style: TextStyle(
                        color: Colors.white,
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ),
          SizedBox(
            height: 10,
          ),
          Container(
            child: Center(
              child: Transform.scale(
                scale: 1.8, // Adjust the scale factor as needed
                child: Image.asset(
                  'images/admin.png', // Replace with your image path
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}

class Widescreen extends StatelessWidget {
  const Widescreen({super.key});

  @override
  Widget build(BuildContext context) {
    double screenWidth = MediaQuery.of(context).size.width;
    return Stack(
      children: [
        // Blue line with rounded borders at the top
        Positioned(
          top: 0,
          left: -20, // Adjust the left value to add a gap to the left wall
          right: -20, // Adjust the right value to add a gap to the right wall
          child: Container(
            height: 50, // Adjust the height of the line as needed
            decoration: BoxDecoration(
              color: Color(0xff0d47a1),
              borderRadius:
                  const BorderRadius.vertical(bottom: Radius.circular(20)),
              boxShadow: [
                BoxShadow(
                  color: Colors.grey.withOpacity(0.5),
                  spreadRadius: 5,
                  blurRadius: 7,
                ),
              ],
            ),
          ),
        ),

        // Logo at the top-left corner
        Positioned(
          top: -20,
          left: 90,
          child: Image.asset(
            'images/Pinion-Partners-Logo.png', // Replace with your logo image path
            width: 350, // Increase the width and height of the logo
            height: 350,
          ),
        ),

        // Heading below the logo
        Positioned(
          top: 150,
          left: 75,
          child: Image.asset(
            'images/PANEL.png', // Replace with your logo image path
            width: 380, // Increase the width and height of the logo
            height: 380,
          ),
        ),
        // Register Button within a rounded rectangle with white background
        Positioned(
          top: 125,
          right: 170, // Add some gap from the right
          child: ElevatedButton(
            onPressed: () {
              Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (context) => RegistrationPage(),
                ),
              );
              // Implement your update information logic here
            },
            style: ElevatedButton.styleFrom(
              backgroundColor: Color(0xff0d47a1),
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(10.0),
              ),
              elevation: 10,
            ),
            child: const Text(
              'Register',
              style: TextStyle(color: Colors.white),
            ),
          ),
        ),

        // Sign In Button within a rounded rectangle with white background

        // Centered "admin.png" image
        Positioned(
          child: Center(
            child: Transform.scale(
              scale: 1, // Adjust the scale factor as needed
              child: Image.asset(
                'images/admin.png', // Replace with your image path
              ),
            ),
          ),
        ),

        // Login and Password Container
        Positioned(
          top: MediaQuery.of(context).size.height / 2 - 130,
          right: 150,
          child: Container(
            width: 280,
            padding: const EdgeInsets.all(20),
            decoration: BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.circular(10),
              boxShadow: [
                BoxShadow(
                  color: Colors.grey.withOpacity(0.5),
                  spreadRadius: 5,
                  blurRadius: 7,
                ),
              ],
            ),
            child: Column(
              children: [
                // Username or Email Input Field
                TextFormField(
                  decoration: const InputDecoration(
                    labelText: 'Username or Email',
                  ),
                ),
                const SizedBox(height: 40),

                // Password Input Field
                TextFormField(
                  obscureText: true,
                  decoration: const InputDecoration(
                    labelText: 'Password',
                  ),
                ),
                const SizedBox(height: 16),

                // Forget Password Option
                Align(
                  alignment: Alignment.centerRight,
                  child: TextButton(
                    onPressed: () {
                      Navigator.of(context).push(MaterialPageRoute(
                        builder: (context) =>
                            ResetPasswordScreen(), // Replace with the actual page you want to navigate to
                      ));
                    },
                    child: const Text(
                      'Forget Password?',
                      style: TextStyle(
                        color: Colors.blue,
                      ),
                    ),
                  ),
                ),
                SizedBox(
                  height: 20,
                ),
                // Elevated Button (Login Button)
                ElevatedButton(
                  onPressed: () {
                    Navigator.of(context).push(MaterialPageRoute(
                      builder: (context) =>
                          DashboardPage(), // Replace with the actual page you want to navigate to
                    ));
                  },
                  style: ElevatedButton.styleFrom(
                    backgroundColor:
                        Color(0xff0d47a1), // Set the background color here
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(10.0),
                    ),
                    elevation: 10,
                  ),
                  child: const Text(
                    'Login',
                    style: TextStyle(
                      color: Colors.white,
                    ),
                  ),
                ),
              ],
            ),
          ),
        ),

        // Blue line with rounded borders at the bottom
        Positioned(
          bottom: 0,
          left: -20, // Adjust the left value to add a gap to the right wall
          right: -20, // Adjust the right value to add a gap to the right wall
          child: Container(
            height: 50, // Adjust the height of the line as needed
            decoration: BoxDecoration(
              color: Color(0xff0d47a1),
              borderRadius:
                  const BorderRadius.vertical(top: Radius.circular(20)),
              boxShadow: [
                BoxShadow(
                  color: Colors.grey.withOpacity(0.5),
                  spreadRadius: 5,
                  blurRadius: 7,
                ),
              ],
            ),
          ),
        ),
      ],
    );
  }
}
