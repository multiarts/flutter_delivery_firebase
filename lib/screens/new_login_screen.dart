import 'package:flutter/material.dart';

class NewLoginScreen extends StatefulWidget {
  @override
  _NewLoginScreenState createState() => _NewLoginScreenState();
}

class _NewLoginScreenState extends State<NewLoginScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SingleChildScrollView(
        child: Stack(
          alignment: Alignment.center,
          children: <Widget>[
            Container(
              height: MediaQuery.of(context).size.height,
              decoration: BoxDecoration(
                gradient: LinearGradient(
                  colors: [
                    Colors.white,
                    // Colors.redAccent
                    Theme.of(context).accentColor
                  ],
                  stops: [.40,0],
                  begin: Alignment.centerRight,
                  end: Alignment.topRight
                )
              ),
            ),
            Positioned(
              top: 120,
              left: 18,
              right: 18,
              child: Text(
                "Let's Start with Login",
                style: TextStyle(
                  color: Colors.white,
                  fontSize: 25,
                  fontWeight: FontWeight.bold
                ),
              ),
            ),
            // Card
            Positioned(
              top: 200,
              left: 20,
              right: 20,
              child: Container(
                width: MediaQuery.of(context).size.width,
                padding: EdgeInsets.symmetric(horizontal: 25, vertical: 70),
                decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.circular(10.0),
                  boxShadow: [
                    BoxShadow( 
                      color: Colors.grey,
                      offset: Offset(0.0, 10.0), 
                      blurRadius: 30.0,
                      spreadRadius: 4.0
                    )
                  ],
                ),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: <Widget>[
                    TextField(
                      decoration: InputDecoration(
                        hintText: 'Email',
                        border: OutlineInputBorder(),
                        contentPadding: EdgeInsets.all(15),
                        hintStyle: TextStyle(color: Theme.of(context).primaryColor),
                        prefixIcon: Icon(Icons.alternate_email, color: Theme.of(context).primaryColor),
                      )
                    ),
                    SizedBox(height: 25),
                    TextField(
                      obscureText: true,
                      decoration: InputDecoration(
                        hintText: 'Password',
                        border: OutlineInputBorder(),
                        suffixIcon: Icon(Icons.visibility),
                        contentPadding: EdgeInsets.all(15),
                        hintStyle: TextStyle(color: Theme.of(context).primaryColor),
                        prefixIcon: Icon(Icons.lock, color: Theme.of(context).primaryColor)
                      )
                    ),
                    SizedBox(height: 25),
                    MaterialButton(
                      height: 40,
                      elevation: 8,
                      onPressed: (){},
                      child: Text('Login'),
                      color: Theme.of(context).accentColor,
                      textColor: Colors.white,
                      // enableFeedback: true,
                      minWidth: MediaQuery.of(context).size.width,
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(20)
                      ),
                    ),
                    SizedBox(height: 20),
                    MaterialButton(
                      height: 40,
                      elevation: 0,
                      onPressed: (){},
                      child: Text('Login with Google'),
                      color: Theme.of(context).accentColor.withOpacity(.2),
                      textColor: Colors.redAccent,
                      highlightElevation: 0,
                      minWidth: MediaQuery.of(context).size.width,
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(20)
                      ),
                    ),
                  ],
                ),
              ),
            ),
            Positioned(
              bottom: 60,
              child: Column(
                children: <Widget>[
                  Text('Forgot password?', style: TextStyle(fontWeight: FontWeight.bold, color: Colors.blueGrey)),
                  SizedBox(height: 25),
                  Text('Ainda não tem uma conta?', style: TextStyle(fontWeight: FontWeight.bold, color: Colors.blueGrey,),),
                ],
              ),
            )
          ],
        ),
      ),
    );
  }
}