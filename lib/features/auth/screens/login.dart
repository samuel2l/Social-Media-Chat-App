import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:social_media_chat_app/features/auth/controller/auth_controller.dart';
import 'package:social_media_chat_app/features/common/utils/utils.dart';
import 'package:social_media_chat_app/utils/colors.dart';
import 'package:country_picker/country_picker.dart';


class LoginScreen extends ConsumerStatefulWidget {
   static const routeName = '/login-screen';
  const LoginScreen({super.key});

  @override
  ConsumerState<ConsumerStatefulWidget> createState() => _LoginScreenState();
}

class _LoginScreenState extends ConsumerState<LoginScreen> {

  final numberController = TextEditingController();
  String countryCode = '';
  String countryName = '';
  String countryPhoneCode='';

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
          countryPhoneCode=country.phoneCode;
        });
      },
    );
  }
// void navigateToHome(){
//   Navigator.pushNamed();
// }
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
                onPressed: () async{
                  if (numberController.text.trim().length ==10 || numberController.text.trim().length ==9){
                   ref.watch(authControllerProvider).signInWPhone(context, '+$countryPhoneCode${numberController.text.trim()} ' );

                  }else{
                    showSnackBar(context: context, content: 'Invalid phone number');
                  }
                },
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