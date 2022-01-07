import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:osfs1/Model/AddUserDataFirebase.dart';
import 'package:osfs1/Model/Authentication.dart';
import 'package:osfs1/commanWidget/bottemWave.dart';
import 'package:osfs1/commanWidget/logoContainer.dart';
import 'package:provider/provider.dart';
import 'package:random_string/random_string.dart';
import '../constant.dart';
import '../route.dart';


class OrgRegistrationScreen extends StatelessWidget {

  //Provider
  Authentication  userProvider;
  AddUserDataFirebase addData;

  //for storing form state.
  final _form = GlobalKey<FormState>(); 

  //Validation Form
  void _saveForm() {
    final isValid = _form.currentState.validate();
    if (!isValid) {
      return;
    }
  }

  //For Generate Organation Code
  String genrateOrgCode() {
    return randomAlphaNumeric(6);
  }


  addOrgDataToUsers(uId) {
    String orgCode = genrateOrgCode();
    addData.addOrgnationData(
      uId: uId,
      institudeName: instituteName,
      orgCode: orgCode
    );
  }
 
  @override
  Widget build(BuildContext context) {
     userProvider = Provider.of<Authentication>(context);
    return Scaffold(
      body: SafeArea(
        child:Form(
           key: _form,
          child: Stack(
            alignment: Alignment.bottomCenter,
            children: [
              BottomWave(),
              Column(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: [
                  LogoHeading(),
                  Container(
                    margin: EdgeInsets.all(15),
                    child: Column(
                      children: [
                        InstituteTextField(),
                        SizedBox(height: 10),
                        EmailTextField(),
                        SizedBox(height: 10),
                        PasswordTextField(),
                        SizedBox(
                            height: 20,
                          ),
                          Container(
                            margin: EdgeInsets.only(
                                top: 10, bottom: 18),
                            child: SizedBox(
                              height: 40,
                              width: 150,
                              child: ElevatedButton(
                                style: ButtonStyle(
                                  elevation: MaterialStateProperty.all(5),
                                  shape: MaterialStateProperty.all<
                                      RoundedRectangleBorder>(
                                    RoundedRectangleBorder(
                                      borderRadius: BorderRadius.circular(25.0),
                                    ),
                                  ),
                                ),
                                onPressed: () async {
                                  _saveForm();
                                  try {
                                    final newUser = await userProvider.registrationAuthentication(
                                        emailAddress: email,
                                        password: password);
                                        print(newUser);
                                        if(newUser !=null) {
                                    addOrgDataToUsers(newUser.toString());
                                    Navigator.pushNamed(
                                        context, loginScreenRoute);}
                                  } catch (e) {
                                    return alertBox(context, e);
                                    // print(e);
                                  }
                                },
                                child: Text(
                                  'Register',
                                  style: TextStyle(
                                      fontSize: 20,
                                      fontWeight: FontWeight.w700),
                                ),
                              ),
                            ),
                          ),
                      Container(
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                Text('Alredy Register? '),
                                GestureDetector(
                                  onTap: () {
                                    Navigator.pushNamed(context, loginScreenRoute);
                                  },
                                  child: Text('Go to login',style: TextStyle(color: Colors.blue),))
                              ],
                            ),
                          ),
                      ],
                    ),
                  )
                ],
              ),
            ],
          ),
        )
        ),
    );
  }

    //AlertBox
    Future<void> alertBox(BuildContext context, e) {
    return showDialog(
      context: context,
      builder: (ctx) => AlertDialog(
        title: Text("Alert"),
        content: Text(e.toString()),
        actions: <Widget>[
          TextButton(
            onPressed: () {
              Navigator.of(ctx).pop();
            },
            child: Text("Okay"),
          ),
        ],
      ),
    );
  }
}



class InstituteTextField extends StatelessWidget {
  const InstituteTextField({
    Key key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return TextFormField(
      decoration: InputDecoration(
        labelText: 'Institute Name',
        prefixIcon: Icon(FontAwesomeIcons.city,),
      ),
      onChanged: (text) {
        instituteName = text;
      },
      validator: (text) {
        if (text.isEmpty) {
          return "Enter Institute Name ";
        }
        return null;
      },
    );
  }
}


class PasswordTextField extends StatelessWidget {
  const PasswordTextField({
    Key key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return TextFormField(
      validator: (val) => val.length < 6 ? 'Password too short.' : null,
      decoration: InputDecoration(
        labelText: 'Password',
        prefixIcon: Icon(Icons.lock),
      ),
      onChanged: (text) {
        password = text;
      },
    );
  }
}

class EmailTextField extends StatelessWidget {
  const EmailTextField({
    Key key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return TextFormField(
      keyboardType: TextInputType.emailAddress,
      decoration: InputDecoration(
        labelText: 'Email',
        prefixIcon: Icon(Icons.email),
      ),
      validator: (text) {
        if (!(text.contains('@')) && text.isEmpty) {
          return "Enter a valid email address!";
        }
        return null;
      },
      onChanged: (text) {
        email = text;
      },
    );
  }
}