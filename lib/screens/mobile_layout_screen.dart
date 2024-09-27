import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:social_media_chat_app/features/auth/controller/auth_controller.dart';
import 'package:social_media_chat_app/features/common/utils/utils.dart';
import 'package:social_media_chat_app/features/contacts/screens/contacts.dart';
import 'package:social_media_chat_app/features/story/screens/confirm_story_post.dart';
import 'package:social_media_chat_app/features/story/screens/stories.dart';
import 'package:social_media_chat_app/utils/colors.dart';
import 'package:social_media_chat_app/features/chat/screens/contacts_list.dart';

class MobileLayoutScreen extends ConsumerStatefulWidget {
  const MobileLayoutScreen({super.key});

  @override
  ConsumerState<ConsumerStatefulWidget> createState() =>
      _MobileLayoutScreenState();
}

class _MobileLayoutScreenState extends ConsumerState<MobileLayoutScreen>
    with WidgetsBindingObserver,TickerProviderStateMixin {
      late TabController tabController;
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    WidgetsBinding.instance.addObserver(this);
    tabController=TabController(length: 3, vsync: this);
  }

  @override
  void dispose() {
    // TODO: implement dispose
    WidgetsBinding.instance.removeObserver(this);
    super.dispose();
  }

  @override
  //we use this method to check if online or not
  void didChangeAppLifecycleState(AppLifecycleState state) {
    super.didChangeAppLifecycleState(state);
    switch (state) {
      case AppLifecycleState.resumed:
        ref.read(authControllerProvider).setUserState(true);
        break;
      case AppLifecycleState.inactive:
      case AppLifecycleState.detached:
      case AppLifecycleState.paused:
        ref.read(authControllerProvider).setUserState(false);
        break;
      default:
        null;
    }
  }

  @override
  Widget build(BuildContext context) {
    return DefaultTabController(
      length: 3,
      child: Scaffold(
        appBar: AppBar(
          elevation: 0,
          backgroundColor: appBarColor,
          centerTitle: false,
          title: const Text(
            'WhatsApp',
            style: TextStyle(
              fontSize: 20,
              color: Colors.grey,
              fontWeight: FontWeight.bold,
            ),
          ),
          actions: [
            IconButton(
              icon: const Icon(Icons.search, color: Colors.grey),
              onPressed: () {},
            ),
            IconButton(
              icon: const Icon(Icons.more_vert, color: Colors.grey),
              onPressed: () {},
            ),
          ],
          bottom:  TabBar(
            controller: tabController,
            indicatorColor: tabColor,
            indicatorWeight: 4,
            labelColor: tabColor,
            unselectedLabelColor: Colors.grey,
            labelStyle:const TextStyle(
              fontWeight: FontWeight.bold,
            ),
            tabs: const[
              Tab(
                text: 'CHATS',
              ),
              Tab(
                text: 'STORIES',
              ),
              Tab(
                text: 'CALLS',
              ),
            ],
          ),
        ),
        body:  TabBarView(
          controller: tabController,
          children:const [
            ContactsList(),
            Story(),
            Text('CALLS')

          ],
        ),
        floatingActionButton: FloatingActionButton(
          onPressed: () async{
            if(tabController.index==0){
            Navigator.pushNamed(context, ContactsScreen.routeName);

            }else if(tabController.index==1){
              File? img=await pickImageFromGallery(context);
              if(img!=null){
                Navigator.pushNamed(context, ConfirmStoryPost.routeName,arguments: img);
              }

            }else{
              //go to calls screen
            }
          },
          backgroundColor: tabColor,
          child: const Icon(
            Icons.comment,
            color: Colors.white,
          ),
        ),
      ),
    );
  }
}
