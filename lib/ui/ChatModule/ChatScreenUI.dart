// ignore_for_file: invalid_use_of_visible_for_testing_member

import 'dart:async';
import 'dart:convert';

import 'package:brokerBook/helper/PreferenceHelper.dart';
import 'package:brokerBook/ui/ChatModule/ViewProfileScreenUI.dart';
import 'package:brokerBook/ui/DashboardModule/DashboardScreenUI.dart';
import 'package:brokerBook/utils/AppCommonFunction.dart';
import 'package:brokerBook/utils/AppString.dart';
import 'package:brokerBook/utils/FieldValidator.dart';
import 'package:brokerBook/widgets/ScaffoldWidget.dart';
import 'package:brokerBook/widgets/TextFormInputField.dart';
import 'package:brokerBook/widgets/WidgetButton.dart';
import 'package:flutter/material.dart';
import 'package:flutter_datetime_picker/flutter_datetime_picker.dart';
import 'package:flutter_keyboard_visibility/flutter_keyboard_visibility.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:get/get.dart';
import 'package:image_picker/image_picker.dart';
import 'package:keyboard_visibility/keyboard_visibility.dart';
import 'package:web_socket_channel/io.dart';
import 'package:web_socket_channel/status.dart' as status;

import '../../controller/ChatController.dart';
import '../../controller/HomeController.dart';
import '../../model/ChatListResponse.dart';
import '../../utils/AppColors.dart';
import '../../widgets/EstateCardList.dart';
import '../../widgets/Txt.dart';
import '../ViewChatImageScreenUi.dart';

class ChatScreenUI extends StatefulWidget {
  String reciver;
  String webSocketUrl;
  String sender;
  String abs_url;
  ChatScreenUI({required this.reciver,required this.webSocketUrl,required this.sender,required this.abs_url});

  @override
  State<ChatScreenUI> createState() => _ChatScreenUIState();
}

class _ChatScreenUIState extends State<ChatScreenUI> {
  var channel;
  late StreamSubscription<bool> keyboardSubscription;

  TextEditingController msgController  = TextEditingController();
  TextEditingController reminderDescController  = TextEditingController();

  ChatController chatController = Get.put(ChatController());
  HomeController homeController = Get.put(HomeController());

  ScrollController scrollController = new ScrollController();

  KeyboardVisibilityNotification _keyboardVisibility = new KeyboardVisibilityNotification();
  late int _keyboardVisibilitySubscriberId;
  late bool _keyboardState;


  @override
  initState(){
    super.initState();
    print("WEB SOCKET URL  ::  ${widget.webSocketUrl}");
    getMessage();
    seenUpdate();

    channel = IOWebSocketChannel.connect(Uri.parse(widget.webSocketUrl));
    channel.stream.listen((message) {
      print("SOCKET MESSAGE  :: $message");
      var desc = json.decode(message);
      var sent = desc['sent'];
      var receiverMsg = sent ? widget.reciver : widget.sender;
      var senderMsg = sent ? widget.sender : widget.reciver;
      chatController.chatDataList.add(
        ChatListData(
          id: 0,
          description: desc['message'],
          timestamp: desc['timestamp'],
          receiverName: receiverMsg,
          senderName: senderMsg,
          seen: true,
          sent: sent,
        )
      );
      scrollDown();

      chatController.sendChatMsgApi(
        token: PreferenceHelper().getUserData().authToken!,
        description: desc['message'],
        receiver_name: receiverMsg,
        seen: "false"
      );
      setState((){});

      var keyboardVisibilityController = KeyboardVisibilityController();
      keyboardSubscription = keyboardVisibilityController.onChange.listen((bool visible) {
        print('Keyboard visibility update. Is visible: $visible');
      });

      KeyboardVisibilityNotification().addNewListener(
        onChange: (bool visible) {
          print("AAAAA"+visible.toString());
        },
      );
    });

    _keyboardState = _keyboardVisibility.isKeyboardVisible;
    setState((){});

    _keyboardVisibilitySubscriberId = _keyboardVisibility.addNewListener(
      onChange: (bool visible) {
        setState(() {
          _keyboardState = visible;
        });
      },
    );
  }


  @override
  Widget build(BuildContext context) {
    return ScaffoldWidget(
      appBar: AppBar(
        backgroundColor: AppColors.primaryColor,
        leading: InkWell(
          onTap: () {
            Get.to(()=> ViewProfileScreenUI(contactNumber: widget.reciver,abs_url: widget.abs_url,) );
          },
          child: Padding(
            padding: const EdgeInsets.all(5.0),
            child: CircleAvatar(
              child: Icon(Icons.account_circle,size: 35),
            ),
          ),
        ),
        title: InkWell(
          onTap: () {
            Get.to(()=> ViewProfileScreenUI(contactNumber: widget.reciver,abs_url: widget.abs_url,) );
          },
          child: Text(widget.reciver)),
      ),
      body: WillPopScope(
        onWillPop: () {
          Navigator.pop(context,true);
          return Future<bool>.value(true);
        },
        child: Container(
          height: Get.height,
          width: Get.width,
          padding: EdgeInsets.all(0),
          margin:  EdgeInsets.all(0),
          decoration: BoxDecoration(
            image: DecorationImage(image: AssetImage(AppString.imagesBackgroundPath+"ic_chat_bg.png"),fit: BoxFit.cover,opacity: 0.8)
          ),
          child: GetBuilder(
            init: ChatController(),
            builder: (ChatController controller) {
              return controller.isDataLoading
                ? AppCommonFunction.circularIndicator()
                : controller.chatDataList.isEmpty
                  ? Column(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Expanded(child: Center(child: AppCommonFunction.noDataFound(text: "No Messages"),)),
                      enterMessageContainer(),
                    ],
                  )
                  : Stack(
                    children: [
                      Column(
                        children: [
                          Flexible(
                            child: ListView.builder(
                              controller: scrollController,
                              itemCount: controller.chatDataList.length,
                              itemBuilder: (context,index){
                                return controller.chatDataList[index].sent!
                                    ? Row(
                                  mainAxisAlignment: MainAxisAlignment.end,
                                  children: [
                                    Padding(
                                      padding: const EdgeInsets.only(top: 10.0),
                                      child: Container(
                                        constraints: BoxConstraints(maxWidth: 230),
                                        //color: Colors.black54.withOpacity(0.045),
                                        child: Card(
                                          color: Colors.lightBlue.shade50,
                                          child: Padding(
                                            padding: const EdgeInsets.all(8.0),
                                            child: Wrap(
                                              children: [
                                              Container(
                                                padding: const EdgeInsets.all(2.0),
                                                alignment: Alignment.bottomRight,
                                                child:Text("${controller.chatDataList[index].description}",
                                                  style: TextStyle(color: Colors.black),
                                                ),
                                              ),

                                              Container(
                                                padding: const EdgeInsets.all(2.0),
                                                alignment: Alignment.bottomLeft,
                                                child:Text("${AppCommonFunction.timestampToDatetime(controller.chatDataList[index].timestamp!,true)} ",
                                                  style: TextStyle(color: Colors.black54),
                                                ),
                                              ),

                                            ],),
                                          ),
                                        ),
                                    ),
                                  ),
                                  SizedBox(width: 5,),
                                  CircleAvatar(
                                    radius: 15,
                                    backgroundColor: AppColors.primaryAccent ,
                                    child: Icon(Icons.account_circle_sharp,color: Colors.white,size: 20, ),
                                  ),
                                ],)
                                  : Row(
                                mainAxisAlignment: MainAxisAlignment.start,
                                children: [
                                  CircleAvatar(
                                    radius: 15,
                                    backgroundColor: AppColors.primaryAccent ,
                                    child: Icon(Icons.account_circle_sharp,color: Colors.white,size: 20, ),
                                  ),
                                  SizedBox(width: 5,),
                                  Padding(
                                    padding: const EdgeInsets.only(top: 10.0),
                                    child: Container(
                                      constraints: BoxConstraints(maxWidth: 230),
                                      //color: Colors.black54.withOpacity(0.045),
                                      child: Card(
                                        color: Colors.greenAccent.shade100,
                                        child: Padding(
                                          padding: const EdgeInsets.all(8.0),
                                          child: Wrap(
                                            children: [

                                              Container(
                                                padding: const EdgeInsets.all(2.0),
                                                alignment: Alignment.bottomLeft,
                                                child:Text("${controller.chatDataList[index].description}",
                                                  style: TextStyle(color: Colors.black),
                                                ),
                                              ),

                                              Container(
                                                padding: const EdgeInsets.all(2.0),
                                                alignment: Alignment.bottomRight,
                                                child:Text("${AppCommonFunction.timestampToDatetime(controller.chatDataList[index].timestamp!,true)} ",
                                                  style: TextStyle(color: Colors.black54),
                                                ),
                                              ),

                                            ],),
                                        ),
                                      ),
                                    ),
                                  ),

                                ],);
                            },
                          ),
                       ),
                          enterMessageContainer(),
                        ],
                      ),

                      controller.isStackDataLoading
                        ? AppCommonFunction.circularIndicator()
                        : Container()

                    ],
                  );
            },

          ),
        ),
      ),
    );
  }

  Widget enterMessageContainer(){
    return GetBuilder(
      builder: (ChatController controller) {
        return Row(
          children:[
            Flexible(
              child: Container(
                  margin: EdgeInsets.only(top: 5),
                  alignment: Alignment.center,
                  child: Theme(
                    data: ThemeData(primaryColor: AppColors.primaryColor,),
                    child: TextFormField(
                      controller: msgController,
                      enableSuggestions: true,
                      minLines: 1,
                      maxLines: 5,
                      textCapitalization: TextCapitalization.sentences,
                      decoration: InputDecoration(
                        filled: true,
                        suffixIcon: InkWell(
                            onTap: () {
                              showModalBottomSheet(
                                context: context,
                                barrierColor: Colors.transparent,
                                backgroundColor: AppColors.primaryColor,
                                elevation: 10,
                                shape: RoundedRectangleBorder(
                                  borderRadius: BorderRadius.circular(10.0),
                                ),
                                builder: (BuildContext context) {
                                  return SizedBox(
                                    height: 120,
                                    child: Center(
                                      child: Row(
                                        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                                        crossAxisAlignment: CrossAxisAlignment.center,
                                        children: <Widget>[
                                          InkWell(
                                            onTap: (){
                                              showModalBottomSheet(
                                                context: context,
                                                barrierColor: Colors.transparent,
                                                backgroundColor: AppColors.white,
                                                elevation: 50,
                                                shape: RoundedRectangleBorder(
                                                  borderRadius: BorderRadius.circular(10.0),
                                                ),
                                                builder: (BuildContext context) {
                                                  return SizedBox(
                                                    height:
                                                    _keyboardState
                                                      ? 650
                                                      : 250,
                                                    child: Center(
                                                      child: Column(
                                                        children: <Widget>[

                                                          SizedBox(height: 10),

                                                          Txt("Set Reminder",fontWeight: FontWeight.w500,fontSize: 22,color: AppColors.primaryColor),

                                                          Padding(
                                                            padding: EdgeInsets.only(top: 12,bottom: 12),
                                                            child: Container(
                                                              height: 40,
                                                              width: Get.width/1.1,
                                                              decoration: BoxDecoration(
                                                                  color: AppColors.white,
                                                                  borderRadius: BorderRadius.all(Radius.circular(11))
                                                              ),
                                                              child: Row(
                                                                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                                                children: [

                                                                  Padding(
                                                                    padding: EdgeInsets.only(left: 10.0),
                                                                    child: Txt("${controller.selectedDateTime}",fontSize: 18,fontWeight: FontWeight.w500,color: AppColors.primaryColor),
                                                                  ),

                                                                  InkWell(
                                                                    onTap: () {

                                                                      DatePicker.showDateTimePicker(context,
                                                                          showTitleActions: true, onConfirm: (date) {
                                                                            var temp = date.toString();
                                                                            print("TEMP  ::  $temp");
                                                                            controller.selectedDateTime = temp.toString();
                                                                          },
                                                                          currentTime: DateTime.now()
                                                                      );

                                                                    },
                                                                    child: Container(
                                                                      height: 40,
                                                                      padding: EdgeInsets.only(left: 12,right: 12),
                                                                      decoration: BoxDecoration(
                                                                          color: AppColors.blueColor,
                                                                          borderRadius: BorderRadius.only(
                                                                            bottomRight: Radius.circular(10),
                                                                            topRight: Radius.circular(10),
                                                                          )
                                                                      ),
                                                                      child: Icon(Icons.date_range_outlined,color: Colors.white),
                                                                    ),
                                                                  ),

                                                                ],
                                                              ),
                                                            ),
                                                          ),

                                                          Padding(
                                                            padding: const EdgeInsets.only(left: 15,right: 15),
                                                            child: TextFormInputField(
                                                              controller: reminderDescController,
                                                              hintText: "Enter Message",
                                                              validator: (value) {
                                                                return FieldValidator.validateValueIsEmpty(value!);
                                                              },
                                                            ),
                                                          ),

                                                          SizedBox(height: 20),

                                                          WidgetButton(
                                                            text: "Submit",
                                                            onPressed: (){
                                                                chatReminder();
                                                            }
                                                          ),

                                                          SizedBox(height: 10),

                                                        ],
                                                      ),
                                                    ),
                                                  );
                                                },
                                              );

                                            },
                                            child: Column(
                                              mainAxisAlignment: MainAxisAlignment.center,
                                              children: [
                                                Icon(Icons.notifications_active,size: 35,color: Colors.white),
                                                SizedBox(height: 5),
                                                Txt("Reminder",fontWeight: FontWeight.w600,color: Colors.white),
                                              ],
                                            ),
                                          ),
                                          InkWell(
                                            onTap: (){

                                              showModalBottomSheet(
                                                context: context,
                                                barrierColor: Colors.transparent,
                                                backgroundColor: AppColors.primaryColor,
                                                elevation: 50,
                                                shape: RoundedRectangleBorder(
                                                  borderRadius: BorderRadius.circular(10.0),
                                                ),
                                                builder: (BuildContext context) {
                                                  return SizedBox(
                                                    height: 650,
                                                    child: Center(
                                                      child: Column(
                                                        children: <Widget>[
                                                          SizedBox(height: 10),
                                                          Txt("Properties",fontWeight: FontWeight.w600,color: Colors.white,fontSize: 21),

                                                          SizedBox(height: 10),

                                                          Expanded(
                                                            child: EstateCardList(
                                                              homeController: homeController,
                                                              estateList: homeController.estateList,
                                                            ),
                                                          ),

                                                        ],
                                                      ),
                                                    ),
                                                  );
                                                },
                                              );
                                            },
                                            child: Column(
                                              mainAxisAlignment: MainAxisAlignment.center,
                                              children: [
                                                FaIcon(FontAwesomeIcons.buildingCircleArrowRight,size: 35,color: Colors.white),
                                                SizedBox(height: 5),
                                                Txt("Properties",fontWeight: FontWeight.w600,color: Colors.white),
                                              ],
                                            ),
                                          ),

                                        ],
                                      ),
                                    ),
                                  );
                                },
                              );
                            },
                            child: Icon(Icons.timer,color: Colors.grey,)),
                        fillColor: Colors.grey[100],
                        hintText: "Enter your message..",
                        border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(30),
                        ),
                      ),
                      onChanged: (value) {

                      },
                    ),
                  )
              ),
            ),
            SizedBox(width: 10,),
            InkWell(
              onTap: () {
                channel.sink.add(json.encode({"message":"${msgController.text}","sender" : "${widget.sender}",'sent':'True',"message_type":"message"}));

                msgController.clear();
                setState((){});
              },
              child: Container(
                margin: EdgeInsets.only(top: 5),
                padding: EdgeInsets.all(10.0),
                decoration: BoxDecoration(
                  shape: BoxShape.circle,
                  color: AppColors.primaryColor,
                ),
                child: Icon(Icons.send, color: Colors.white),
              ),
            ),
          ],
        );
      },

    );
  }


  /*
  void getImage() async{
    final ImagePicker _picker = ImagePicker();
    final XFile? image = await _picker.pickImage(source: ImageSource.gallery);
    print("tempFile  ::  ${image!.path}");

    if(image != null){
      Get.to(()=> ViewChatImageScreenUi(file: image.path,ticketId: "abcd id" ,email: "abc@gmail.com",pwd: "12345",) );
    }
  }
  */


  @override
  void dispose(){
    super.dispose();
    channel.sink.close(status.goingAway);
  }


  void scrollDown(){
    Future.delayed(Duration(milliseconds: 50),() {
      final position = scrollController.position.maxScrollExtent;
      scrollController.jumpTo(position,);
    },);
  }


  getMessage(){
    chatController.progressDataLoading(true);
    chatController.chatListApi(
        token: PreferenceHelper().getUserData().authToken!,phNumber: widget.reciver).then((response){
      if(response.success == true){
        if(response.message == "fetch successfully"){
          chatController.chatListResponse = response;
          chatController.chatDataList = response.data!;
          scrollDown();
        }
      }
      chatController.progressDataLoading(false);
    });

  }

  seenUpdate(){
    chatController.seenUpdateApi(
      token: PreferenceHelper().getUserData().authToken!,receiver: widget.reciver).then((response){
      chatController.seenUpdateResponse = response;
      print("---seen update---");
    });
  }

  chatReminder(){
    chatController.updateIsStackDataLoading(true);
    chatController.chatReminderApi(
      token: PreferenceHelper().getUserData().authToken!,
      receiver: widget.reciver,
      sender: widget.sender,
      time: chatController.selectedDateTime,
      description: reminderDescController.text,
    ).then((response){
      if(response.success == true){
        if(response.message == "fetch successfully"){
          Get.back();
          Get.back();
          clearReminderData();
          chatController.chatReminderResponse = response;
          AppCommonFunction.flutterToast("Reminder set successfully", true);

        }
        else{
          AppCommonFunction.flutterToast("unable to set reminder", false);
        }
      }

      chatController.updateIsStackDataLoading(false);
    });
  }

  clearReminderData(){
    chatController.selectedDateTime = "";
    reminderDescController.clear();
  }

}
