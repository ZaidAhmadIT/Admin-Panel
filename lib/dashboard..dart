import 'package:flutter/material.dart';
import 'package:country_list_pick/country_list_pick.dart';
import 'package:intl_phone_number_input/intl_phone_number_input.dart';
import 'main.dart';
class DashboardPage extends StatefulWidget {
  @override
  _DashboardPageState createState() => _DashboardPageState();
}

class _DashboardPageState extends State<DashboardPage> {


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
    

class  Desktopscreen extends StatefulWidget {
  @override
  DesktopscreenState createState() => DesktopscreenState();
}

class DesktopscreenState extends State< Desktopscreen> {
    bool _isHovered = false;
  String _selectedButton = 'user_profile';
  String _hoveredButton = '';
  String _hoveredUpdateInfoButton = '';
  TextEditingController _newPasswordController = TextEditingController();
  TextEditingController _confirmPasswordController = TextEditingController();
  bool _showPassword = false;

  @override
  void dispose() {
    _newPasswordController.dispose();
    _confirmPasswordController.dispose();
    super.dispose();
  }
  @override
  Widget build(BuildContext context) {
return Scaffold(
      appBar: AppBar(
         automaticallyImplyLeading: false,
        toolbarHeight: 60,
        backgroundColor: Color(0xFF0D47A1),
        actions: [
          Row(
            children: [
              MouseRegion(
                onEnter: (event) {
                  // Handle hover event, you can update state here
                  setState(() {
                    _isHovered = true;
                  });
                },
                onExit: (event) {
                  // Handle exit event, you can update state here
                  setState(() {
                    _isHovered = false;
                  });
                },
                child: InkWell(
                  onTap: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(builder: (context) =>  MyHomePage()),
                    );
                  },
                  child: Row(
                    children: [
                      Icon(
                        Icons.logout,
                        size: _isHovered ? 28 : 24, // Increase size on hover
                        color: _isHovered
                            ? Colors.white
                            : Colors.white, // Change color on hover
                      ),
                      SizedBox(width: 5),
                      Text(
                        "Sign Out",
                        style: TextStyle(
                          fontSize: _isHovered
                              ? 16
                              : 14, // Increase font size on hover
                          color: _isHovered
                              ? Colors.white
                              : Colors.white, // Change color on hover
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            ],
          ),
          SizedBox(width: 40),
        ],
      ),
      body: Container(
        child: Row(
          children: [
            SingleChildScrollView(
              child: Container(
                height: 800,
                width: 300,
                color: Colors.grey[200],
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Container(
                      margin: EdgeInsets.only(top: 30, left: 20, right: 20),
                      padding: EdgeInsets.all(25.0),
                      child: Align(
                        alignment: Alignment.topLeft,
                        child: Image.asset(
                          'images/Pinion-Partners-Logo.png',
                          //width: 900,
                        ),
                      ),
                    ),
                    SizedBox(height: 20),
                    Center(child: _userProfileWidget()),
                    SizedBox(height: 30.0),
                    Divider(
                      thickness: 1,
                      color: Colors.grey[300],
                    ),
                    _dashboardButton(
                        'user_profile', 'User Profile', Icons.person),
                    SizedBox(height: 10.0),
                    _dashboardButton(
                        'pr_dashboard', 'Latest PR', Icons.dashboard),
                   
                  ],
                ),
              ),
            ),
            Expanded(
              child: _displayContent(),
            ),
          ],
        ),
      ),
    );
  }

  Widget _userProfileWidget() {
    return Column(
      children: [
        CircleAvatar(
          radius: 40,
          backgroundImage: AssetImage(
              'images/user.jpg'), // Replace with your image path
        ),
        SizedBox(height: 10.0),
        Text(
          'Username',
          style: TextStyle(
            fontWeight: FontWeight.bold,
            fontSize: 18,
          ),
        ),
      ],
    );
  }

  Widget _dashboardButton(
      String buttonId, String buttonText, IconData iconData) {
    final isActive = _selectedButton == buttonId || _hoveredButton == buttonId;

    return InkWell(
      onTap: () {
        setState(() {
          _selectedButton = buttonId;
        });
      },
      onHover: (value) {
        setState(() {
          _hoveredButton = value ? buttonId : '';
        });
      },
      child: Container(
        decoration: BoxDecoration(
          color: isActive ? Color(0xFF0D47A1) : Colors.transparent,
          borderRadius: BorderRadius.circular(12.0),
        ),
        padding: EdgeInsets.symmetric(vertical: 8.0, horizontal: 16.0),
        child: Row(
          children: [
            Container(
              padding: EdgeInsets.all(8.0),
              decoration: BoxDecoration(
                color: isActive ? Colors.blue : Colors.lightBlue,
                borderRadius: BorderRadius.circular(8.0),
              ),
              child: Icon(
                iconData,
                color: Colors.white,
              ),
            ),
            SizedBox(width: 12.0),
            Text(
              buttonText,
              style: TextStyle(
                color: isActive ? Colors.white : Colors.black,
                fontSize: 12.0,
                fontWeight: FontWeight.normal,
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _displayContent() {
    switch (_selectedButton) {
      case 'user_profile':
        return SingleChildScrollView(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              SizedBox(height: 20.0),
              Padding(
                padding: EdgeInsets.symmetric(horizontal: 20.0),
                child: Text(
                  'User Information',
                  style: TextStyle(
                    fontSize: 28.0,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ),
              SizedBox(height: 20.0),
              _personalInfoForm(),
            ],
          ),
        );
      case 'pr_dashboard':
        return Center(
           child: PRDashboard(),
        );
      case 'communication_tips':
        
      case 'packages':
       
      default:
        return Container();
    }
  }

  Widget _personalInfoForm() {
    return Container(
      padding: EdgeInsets.all(20.0),
      decoration: BoxDecoration(
        color: Colors.white,
        boxShadow: [
          BoxShadow(
            color: Colors.black12,
            offset: Offset(0, 2),
            blurRadius: 6.0,
          ),
        ],
      ),
      child: Row(
        children: [
          Expanded(
            flex: 3,
            child: Container(
              decoration: BoxDecoration(
                border: Border.all(color: Colors.black12, width: 2.0),
                borderRadius: BorderRadius.circular(8.0),
              ),
              padding: EdgeInsets.all(25.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Row(
                    children: [
                      Icon(Icons.person, color: Colors.blue),
                      SizedBox(width: 10.0),
                      Text(
                        'Personal Information',
                        style: TextStyle(
                          fontSize: 18.0,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    ],
                  ),
                  SizedBox(height: 20.0),
                  _buildPersonalInfoFormField('Name'),
                  _buildPersonalInfoFormField('Full Name'),
                  _buildPersonalInfoFormField('Country'),
                  PhoneNumberInputPage(),
                  _buildPersonalInfoFormField('Address'),
                  _buildPersonalInfoFormField('City'),
                  SizedBox(height: 20.0),
                  Container(
                    child: MouseRegion(
                      onEnter: (_) {
                        setState(() {
                          _hoveredUpdateInfoButton = 'update_info';
                        });
                      },
                      onExit: (_) {
                        setState(() {
                          _hoveredUpdateInfoButton = '';
                        });
                      },
                      child: ElevatedButton(
                        onPressed: () {
                          // Implement your update information logic here
                        },
                        style: ElevatedButton.styleFrom(
                          primary: _hoveredUpdateInfoButton == 'update_info'
                              ? Color(0xFF0D47A1)
                              : Colors.white,
                          padding: EdgeInsets.symmetric(
                            vertical: 26.0,
                            horizontal: 32.0,
                          ),
                        ),
                        child: Text(
                          'Update Information',
                          style: TextStyle(
                            fontSize: 16.0,
                            color: _hoveredUpdateInfoButton == 'update_info'
                                ? Colors.white
                                : Colors.black,
                          ),
                        ),
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ),
          SizedBox(width: 20.0),
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Container(
                decoration: BoxDecoration(
                  border: Border.all(color: Colors.black12, width: 2.0),
                  borderRadius: BorderRadius.circular(8.0),
                ),
                height: 420,
                width: 400,
                padding: EdgeInsets.all(20.0),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Row(
                      children: [
                        Icon(Icons.lock, color: Colors.blue),
                        SizedBox(width: 10.0),
                        Text(
                          'Update Password',
                          style: TextStyle(
                            fontSize: 18.0,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                      ],
                    ),
                    SizedBox(height: 20.0),
                    _buildUpdatePasswordFormField('Old Password'),
                    _buildUpdatePasswordFormField('New Password',
                        controller: _newPasswordController),
                    _buildUpdatePasswordFormField('Confirm Password',
                        controller: _confirmPasswordController),
                    SizedBox(height: 20.0),
                    Container(
                      child: MouseRegion(
                        onEnter: (_) {
                          setState(() {
                            _hoveredUpdateInfoButton = 'update_pass';
                          });
                        },
                        onExit: (_) {
                          setState(() {
                            _hoveredUpdateInfoButton = '';
                          });
                        },
                        child: ElevatedButton(
                          onPressed: () {
                            // Implement your update information logic here
                          },
                          style: ElevatedButton.styleFrom(
                            primary: _hoveredUpdateInfoButton == 'update_pass'
                                ? Color(0xFF0D47A1)
                                : Colors.white,
                            padding: EdgeInsets.symmetric(
                              vertical: 26.0,
                              horizontal: 32.0,
                            ),
                          ),
                          child: Text(
                            'Update Password',
                            style: TextStyle(
                              fontSize: 16.0,
                              color: _hoveredUpdateInfoButton == 'update_pass'
                                  ? Colors.white
                                  : Colors.black,
                            ),
                          ),
                        ),
                      ),
                    ),
                  ],
                ),
              ),
              SizedBox(height: 20.0),
              Container(
                decoration: BoxDecoration(
                  border: Border.all(color: Colors.black12, width: 2.0),
                  borderRadius: BorderRadius.circular(8.0),
                ),
                height: 420,
                width: 400,
                padding: EdgeInsets.all(20.0),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Row(
                      children: [
                        Icon(Icons.email, color: Colors.blue),
                        SizedBox(width: 10.0),
                        Text(
                          'Update Email',
                          style: TextStyle(
                            fontSize: 18.0,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                      ],
                    ),
                    SizedBox(height: 20.0),
                    _buildEmailFormField('Current Email'),
                    _buildEmailFormField('Enter New Email'),
                    _buildUpdatePasswordFormField('Enter Password'),
                    SizedBox(height: 20.0),
                    Container(
                      child: MouseRegion(
                        onEnter: (_) {
                          setState(() {
                            _hoveredUpdateInfoButton = 'update_email';
                          });
                        },
                        onExit: (_) {
                          setState(() {
                            _hoveredUpdateInfoButton = '';
                          });
                        },
                        child: ElevatedButton(
                          onPressed: () {
                            // Implement your update information logic here
                          },
                          style: ElevatedButton.styleFrom(
                            primary: _hoveredUpdateInfoButton == 'update_email'
                                ? Color(0xFF0D47A1)
                                : Colors.white,
                            padding: EdgeInsets.symmetric(
                              vertical: 26.0,
                              horizontal: 49.0,
                            ),
                          ),
                          child: Text(
                            'Update Email',
                            style: TextStyle(
                              fontSize: 16.0,
                              color: _hoveredUpdateInfoButton == 'update_email'
                                  ? Colors.white
                                  : Colors.black,
                            ),
                          ),
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }

  Widget _buildPersonalInfoFormField(String label, {bool dropdown = false}) {
    return Container(
      margin: EdgeInsets.symmetric(vertical: 8.0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            label,
            style: TextStyle(
              fontSize: 12.0,
              fontWeight: FontWeight.normal,
              color: Colors.black,
            ),
          ),
          SizedBox(height: 8.0),
          Container(
            height: 40.0,
            child: dropdown
                ? CountryListPick(
                    appBar: AppBar(
                      backgroundColor: Colors.blue,
                      title: Text('Pick your country'),
                    ),
                    theme: CountryTheme(
                      isShowFlag: true,
                      isShowTitle: true,
                      isShowCode: true,
                      isDownIcon: true,
                      showEnglishName: true,
                    ),
                    initialSelection: '+1',
                    onChanged: (CountryCode? code) {
                      // Handle the selected country
                    },
                  )
                : TextFormField(
                    decoration: InputDecoration(
                      contentPadding: EdgeInsets.symmetric(horizontal: 16.0),
                      border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(8.0),
                      ),
                    ),
                  ),
          ),
        ],
      ),
    );
  }

  Widget _buildUpdatePasswordFormField(
    String label, {
    TextEditingController? controller,
  }) {
    return Container(
      margin: EdgeInsets.symmetric(vertical: 8.0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            label,
            style: TextStyle(
              fontSize: 12.0,
              fontWeight: FontWeight.normal,
              color: Colors.black,
            ),
          ),
          SizedBox(height: 8.0),
          Container(
            height: 40.0, // Adjust the height as needed
            child: TextFormField(
              controller: controller,
              obscureText: !_showPassword,
              decoration: InputDecoration(
                contentPadding: EdgeInsets.symmetric(horizontal: 16.0),
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(8.0),
                ),
                suffixIcon: IconButton(
                  icon: Icon(
                    _showPassword ? Icons.visibility : Icons.visibility_off,
                    color: Colors.grey,
                  ),
                  onPressed: () {
                    setState(() {
                      _showPassword = !_showPassword;
                    });
                  },
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildEmailFormField(String label) {
    return Container(
      margin: EdgeInsets.symmetric(vertical: 8.0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            label,
            style: TextStyle(
              fontSize: 12.0,
              fontWeight: FontWeight.normal,
              color: Colors.black,
            ),
          ),
          SizedBox(height: 8.0),
          Container(
            height: 40.0, // Adjust the height as needed
            child: TextFormField(
              decoration: InputDecoration(
                contentPadding: EdgeInsets.symmetric(horizontal: 16.0),
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(8.0),
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
class PRDashboard extends StatefulWidget {
  @override
  _PRDashboardState createState() => _PRDashboardState();
}

class _PRDashboardState extends State<PRDashboard> {
  String searchKeyword = '';
  bool showSearchResults = false;
  int entriesPerPage = 10;

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: <Widget>[
        Container(
          margin: EdgeInsets.only(
            top: 0.0,
            left: 10,
          ),
          width: double.infinity,
          padding: EdgeInsets.all(20),
          child: Text(
            'Submit Your Press Release',
            style: TextStyle(fontSize: 28, fontWeight: FontWeight.bold),
          ),
        ),
        SizedBox(
          height: 15.0,
        ),
        //outer contaner of two
        Container(
          margin: EdgeInsets.only(
            left: 10.0,
            right: 10.0,
          ),
          decoration: BoxDecoration(
              color: Color.fromARGB(255, 255, 255, 255),
              boxShadow: [
                BoxShadow(
                  color: const Color.fromARGB(255, 220, 206, 206),
                  spreadRadius: 2,
                  blurRadius: 5,
                  offset: Offset(0, 3),
                ),
              ],
              borderRadius: BorderRadius.only(
                  topLeft: Radius.circular(6.0),
                  bottomLeft: Radius.circular(6.0))),
          child: Column(children: [
            Container(
              //1st of two
              decoration: BoxDecoration(
                color: Color.fromRGBO(255, 255, 255, 1),
                borderRadius: BorderRadius.circular(4.0),
                boxShadow: [
                  BoxShadow(
                    color: Colors.grey.withOpacity(0.5),
                    spreadRadius: 2,
                    blurRadius: 5,
                    offset: Offset(0, 3),
                  ),
                ],
              ),
              margin: EdgeInsets.all(30.0),
              height: 110.0,
              width: double.infinity,
              // padding: EdgeInsets.all(16),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  // title input
                  Container(
                    margin: EdgeInsets.only(
                      top: 20.0,
                      left: 10,
                    ),
                    // height: 30,
                    width: MediaQuery.of(context).size.width * 0.28,
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.start,
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text("Press Release Title"),
                        SizedBox(height: 8.0),
                        Container(
                          //height control
                          height: 30.0,
                          child: TextField(
                            onChanged: (value) {
                              setState(
                                () {
                                  searchKeyword = value;
                                  showSearchResults = false;
                                },
                              );
                            },
                            decoration: InputDecoration(
                              hintText: 'Enter Press Release Title',
                              border: OutlineInputBorder(
                                borderSide: BorderSide(
                                    color: Color.fromARGB(
                                        255, 222, 222, 222)), // Border color
                              ),
                              filled: true,
                              fillColor: Color.fromARGB(
                                  255, 255, 255, 255), // Background color
                              contentPadding:
                                  EdgeInsets.symmetric(horizontal: 10),
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                  SizedBox(
                    width: 10,
                  ),
                  //date input
                  Container(
                    margin: EdgeInsets.only(
                      top: 20.0,
                      left: 10,
                    ),
                    // height: 30,
                    width: MediaQuery.of(context).size.width * 0.28,
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.start,
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text("Date"),
                        SizedBox(height: 8.0),
                        Container(
                          //height control
                          height: 30.0,
                          child: TextField(
                            onChanged: (value) {
                              setState(
                                () {
                                  searchKeyword = value;
                                  showSearchResults = false;
                                },
                              );
                            },
                            decoration: InputDecoration(
                              hintText: 'Enter Date',
                              border: OutlineInputBorder(
                                borderSide: BorderSide(
                                    color: const Color.fromARGB(
                                        255, 125, 160, 189)), // Border color
                              ),
                              filled: true,
                              fillColor: Color.fromARGB(
                                  255, 255, 255, 255), // Background color
                              contentPadding:
                                  EdgeInsets.symmetric(horizontal: 10),
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                  SizedBox(width: 10),
                  Container(
                    margin: EdgeInsets.only(
                      top: 18,
                    ),
                    height: 30.0,
                    width: MediaQuery.of(context).size.width * 0.08,
                    child: OutlinedButton(
                      onPressed: () {
                        setState(() {
                          showSearchResults = true;
                        });
                      },
                      child: Text(
                        'Search',
                        style: TextStyle(
                            color: const Color.fromARGB(255, 0, 0, 0)),
                      ),
                    ),
                  ),
                ],
              ),
            ),
            Container(
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(4.0),
                color: Color.fromRGBO(255, 255, 255, 1),
                boxShadow: [
                  BoxShadow(
                    color: Color.fromARGB(255, 185, 183, 183).withOpacity(0.5),
                    spreadRadius: 2,
                    blurRadius: 5,
                    offset: Offset(0, 3),
                  ),
                ],
              ),
              margin: EdgeInsets.all(30.0),
              width: double.infinity,
              padding: EdgeInsets.all(16),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  DropdownButton<int>(
                    value: entriesPerPage,
                    onChanged: (value) {
                      setState(() {
                        entriesPerPage = value!;
                      });
                    },
                    items: [
                      DropdownMenuItem(
                        value: 10,
                        child: Text('Show 10 entries'),
                      ),
                      DropdownMenuItem(
                        value: 25,
                        child: Text('Show 25 entries'),
                      ),
                      DropdownMenuItem(
                        value: 100,
                        child: Text('Show 100 entries'),
                      ),
                    ],
                  ),

                  Text(
                    'Search Results:',
                    style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
                  ),
                  SizedBox(height: 10),
                  // Display search results or default data
                  showSearchResults
                      ? Text('Display search results here')
                      : Text('Display any PR data here'),
                  SizedBox(height: 10),
                ],
              ),
            ),
          ]),
        )
      ],
    );
  }
}
class PhoneNumberInputPage extends StatefulWidget {
  @override
  _PhoneNumberInputPageState createState() => _PhoneNumberInputPageState();
}

class _PhoneNumberInputPageState extends State<PhoneNumberInputPage> {
  PhoneNumber _phoneNumber = PhoneNumber(isoCode: 'US');

  @override
  Widget build(BuildContext context) {
    var padding2 = Padding(
      padding: const EdgeInsets.all(16.0),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Container( 
            child: InternationalPhoneNumberInput(
              onInputChanged: (PhoneNumber phoneNumber) {
                setState(() {
                  _phoneNumber = phoneNumber;
                });
              },
              selectorConfig: SelectorConfig(
                selectorType: PhoneInputSelectorType.DIALOG,
              ),
              ignoreBlank: false,
              autoValidateMode: AutovalidateMode.disabled,
              selectorTextStyle: TextStyle(color: Colors.black),
              initialValue: _phoneNumber,
              hintText: 'Phone Number',
              errorMessage: 'Invalid phone number',
            ),
          ),
        ],
      ),
    );
    return padding2;
  }
}
class  Mobilescreen extends StatefulWidget {
  @override
  _MobilescreenState createState() => _MobilescreenState();
}

class _MobilescreenState extends State< Mobilescreen> {

  @override
  Widget build(BuildContext context) {
return Container(
  child: Text('data'),
);
  
    
    }
}
