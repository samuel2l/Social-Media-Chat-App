import 'package:flutter/material.dart';
import 'package:social_media_chat_app/utils/colors.dart';
import 'package:country_picker/country_picker.dart';

class LoginScreen extends StatefulWidget {
  static const routeName = '/login-screen';
  const LoginScreen({super.key});

  @override
  State<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  final numberController = TextEditingController();
  String countryCode = '+233';
  String countryName = 'Ghana';

  @override
  void dispose() {
    numberController.dispose();
    super.dispose();
  }

  void selectCountry() {
    showCountryPicker(
      context: context,
      showPhoneCode:
          true, // optional. Shows phone code before the country name.
      onSelect: (Country country) {
        setState(() {
          countryCode = country.flagEmoji + '+ ' + country.phoneCode;
          countryName = country.displayName;
        });
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Enter phone number'),
      ),
      body: Column(
        children: [
          const SizedBox(
            height: 30,
          ),
          Center(
            child: TextButton(
              onPressed: selectCountry,
              style: TextButton.styleFrom(backgroundColor: tabColor),
              child: const Text('Pick country'),
            ),
          ),
          const SizedBox(
            height: 30,
          ),
          Text(countryName),
          Padding(
            padding: const EdgeInsets.all(28.0),
            child: Row(
              children: [
                Text(countryCode),
                const SizedBox(
                  width: 10,
                ),
                SizedBox(
                  width: MediaQuery.of(context).size.width * 0.7,
                  child: TextField(
                    keyboardType: TextInputType.number,
                    controller: numberController,
                  ),
                ),
              ],
            ),
          ),
          SizedBox(
            height: MediaQuery.of(context).size.height * 0.6,
          ),
          SizedBox(
              width: MediaQuery.of(context).size.width * 0.75,
              child: TextButton(
                onPressed: () {},
                style: TextButton.styleFrom(
                  backgroundColor: tabColor, // Set background color
                  shape: RoundedRectangleBorder(
                    borderRadius:
                        BorderRadius.circular(8.0), // Set rounded corners
                  ),
                ),
                child: const Text('NEXT'),
              )),
        ],
      ),
    );
  }
}
