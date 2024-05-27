import 'package:flutter/material.dart';
import 'package:smart_ambulance/providers/user_provider.dart';
import 'package:smart_ambulance/widgets/custom_appbar.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:smart_ambulance/widgets/custom_button.dart';
import 'package:smart_ambulance/constants/sizes.dart';
import 'package:smart_ambulance/models/user/user_model.dart';
import 'package:provider/provider.dart';
import 'package:smart_ambulance/screens/home/add_hospital.dart';

class AdminHomePage extends StatefulWidget {
  const AdminHomePage({super.key});

  @override
  State<AdminHomePage> createState() => _AdminHomePageState();
}

class _AdminHomePageState extends State<AdminHomePage> {
  @override
  void initState() {
    super.initState();
  }
    @override
  Widget build(BuildContext context) {
   // var userProvider = context.watch<UserProvider>();
    var userProvider = context.watch<UserProvider>();
    return FutureBuilder(
      future: Future.wait([
        userProvider.getUsersForApproval
      ]), 
      builder: (BuildContext context, AsyncSnapshot asyncSnapshot) {
         return Scaffold(
      appBar: CustomAppBar(title: AppLocalizations.of(context)!.admin_home, backButton: false, signOutButton: true),
      resizeToAvoidBottomInset: false,
      body: SafeArea(
            child: Center(
          child: Padding(
            padding: const EdgeInsets.all(8),
            child: Column(
              children: [
                const SizedBox(height: 5),
                Expanded(child: ListView.builder(
                  itemCount:  userProvider.usersForApproval.length,
                  shrinkWrap: true,
                  itemBuilder: (BuildContext context, int index) {
                    return GestureDetector(
                        onTap: () async {
                          await userProvider.approveUser(userProvider.usersForApproval[index]);
                        },
                        child: Container(
                          color: Colors.blue,
                          padding: EdgeInsets.all(16.0),
                          child: Text(
                            "First Name:"+
                            userProvider.usersForApproval[index].firstName+"\nLast Name:"+
                            userProvider.usersForApproval[index].lastName+
                            "\nEmail: "+ userProvider.usersForApproval[index].email+
                            "\nRole: " + role_to_string(userProvider.usersForApproval[index].role)
                            ,
                            style: TextStyle(color: const Color.fromARGB(255, 12, 7, 7)),
                          ),
                        ),
                      );
                  },
                ),),
                SmartAmbulanceButton(text: "Add Hospital", fontSize: SmartAmbulanceSizes.bigButtonFontSize, onPressed: (() async {
                   Navigator.push(
                    context,
                    MaterialPageRoute(builder: (context) => AddHospital()),
                  );
                }),),
              ]
            )
          )
            )
         )
         );
      }
    );
  }
  String role_to_string(int role)
  {
    if(role==1)
    return "Paramedic";
    else
    return "Doctor";
  }
}