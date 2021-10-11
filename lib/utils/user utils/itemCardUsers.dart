import 'package:client_data/screens/select.dart';
import 'package:client_data/utils/user%20utils/model%20user.dart';
import 'package:flutter/material.dart';

class ItemCardUser extends StatefulWidget {
  final DonaloPostUser Userproduct;
  ItemCardUser({
    Key key,
    
    this.Userproduct,
    DonaloPostUser donaloPostUser,
  }) : super(key: key);

  @override
  State<ItemCardUser> createState() => _ItemCardUserState();
}

class _ItemCardUserState extends State<ItemCardUser> {
  
  @override
  Widget build(BuildContext context) {
    
    return GestureDetector(
      onTap: () {
        Navigator.push(
            (context),
            MaterialPageRoute(
                builder: (context) => SelectScreen(
                      currentUserID: widget.Userproduct.userID,
                    )));
      },
      
      child: Column(
        
        
        crossAxisAlignment: CrossAxisAlignment.center,
        children: <Widget>[
          Expanded(
            child: Container(
              padding: EdgeInsets.all(20),
              
              
              decoration: BoxDecoration(
                color: Colors.grey,
                borderRadius: BorderRadius.circular(16),
              ),
              child: Column(
                children: [
                  Image.asset(
                    "assets/images/client.jpg",
                    width: 50,
                    height: 40,
                    
                  ),
                  SizedBox(
                    height: 5,
                  ),
                  Text("${widget.Userproduct.Name}"),
                  SizedBox(height: 5),
                  
                  Text(widget.Userproduct.email),
                  SizedBox(height: 5),
                  
                  
                  Spacer(),
                  
                  
                  
                  
                  
                  
                  
                  
                  
                  
                  
                  
                  
                  
                  
                  
                  
                  
                  
                  
                ],
              ), 
            ),
          ),
          
          
          
          
          
          
          
          
          
          
          
        ],
      ),
    );
  }
}
