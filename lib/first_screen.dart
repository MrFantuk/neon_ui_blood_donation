import 'package:flutter/material.dart';
import 'package:neon_ui_blood_donation/second_screen.dart';

class FirstScreen extends StatefulWidget {
  const FirstScreen({Key? key}) : super(key: key);

  @override
  State<FirstScreen> createState() => _FirstScreenState();
}

class _FirstScreenState extends State<FirstScreen> {
  Color kPrimaryColorRed = const Color.fromARGB(255, 183, 25, 25);
  final bloodTypeList = ['A', 'B', '0', 'AB'];
  final rhFactors = ['+', '--'];
  bool _recieveNotifications = true;
  String? selectedBloodType;
  String? selectedRh;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 15),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.start,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              const Icon(
                Icons.bloodtype,
                size: 135,
                color: Color.fromARGB(255, 183, 25, 25),
              ),
              const Text(
                "Please pick your blood type",
                style: TextStyle(fontSize: 40, fontWeight: FontWeight.w400),
                textAlign: TextAlign.center,
              ),
              TextButton(
                onPressed: () {},
                child: const Text(
                  "Don't know about blood type?",
                  style: TextStyle(fontSize: 20, fontWeight: FontWeight.w400),
                ),
              ),
              _selectBloodType(),
              _selectRHfactor(),
              const Spacer(),
              _notificationsAgree(),
              _finishButton()
            ],
          ),
        ),
      ),
    );
  }

  Widget _selectBloodType() {
    return GridView.builder(
        physics: const NeverScrollableScrollPhysics(),
        shrinkWrap: true,
        itemCount: bloodTypeList.length,
        gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
          crossAxisCount: 2,
          mainAxisExtent: 100,
        ),
        itemBuilder: ((context, index) => InkWell(
              onTap: () {
                setState(() {
                  selectedBloodType = bloodTypeList[index];
                  print(selectedBloodType);
                });
              },
              child: Container(
                margin: const EdgeInsets.all(10),
                decoration: BoxDecoration(
                  color: selectedBloodType == bloodTypeList[index]
                      ? kPrimaryColorRed
                      : Colors.grey.withOpacity(0.1),
                  borderRadius: BorderRadius.circular(20),
                ),
                child: Center(
                    child: Text(
                  bloodTypeList[index],
                  style: TextStyle(
                      fontSize: 30,
                      color: selectedBloodType == bloodTypeList[index]
                          ? Colors.white
                          : null),
                )),
              ),
            )));
  }

  Widget _selectRHfactor() {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
      crossAxisAlignment: CrossAxisAlignment.center,
      children: [
        rhTile(title: "+"),
        rhTile(title: "-"),
      ],
    );
  }

  Widget _notificationsAgree() {
    return CheckboxListTile(
        title: const Text(
            "I want tot recieve notifications about blood donation campaigns"),
        value: _recieveNotifications,
        onChanged: ((value) => setState(() {
              _recieveNotifications = value!;
            })));
  }

  Widget _finishButton() {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 20, horizontal: 10),
      child: Row(
        children: [
          Expanded(
              child: ElevatedButton(
                  style: ElevatedButton.styleFrom(
                      primary: kPrimaryColorRed,
                      shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(10)),
                      textStyle: const TextStyle(
                          fontSize: 20, fontWeight: FontWeight.bold)),
                  onPressed: () {
                    if (selectedBloodType != null && selectedRh != null) {
                      Navigator.push(
                          context,
                          MaterialPageRoute(
                              builder: (context) => const SecondPage()));
                    } else {
                      ScaffoldMessenger.of(context).showSnackBar(SnackBar(
                          content:
                              Text("You need to select blood type and rh")));
                    }
                  },
                  child: const Padding(
                    padding: EdgeInsets.all(20.0),
                    child: Text("Finish"),
                  ))),
        ],
      ),
    );
  }

  Widget rhTile({required String title}) {
    return InkWell(
      onTap: () {
        setState(() {
          selectedRh = title;
        });
      },
      child: Container(
        margin: const EdgeInsets.all(10),
        decoration: BoxDecoration(
          color: selectedRh == title
              ? kPrimaryColorRed
              : Colors.grey.withOpacity(0.1),
          borderRadius: BorderRadius.circular(5),
        ),
        padding: const EdgeInsets.all(15),
        child: Text(
          title,
          style: TextStyle(
              fontSize: 25, color: selectedRh == title ? Colors.white : null),
        ),
      ),
    );
  }
}
