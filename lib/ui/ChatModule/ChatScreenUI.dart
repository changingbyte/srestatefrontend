// ignore_for_file: invalid_use_of_visible_for_testing_member

import 'dart:convert';

import 'package:croma_brokrage/helper/PreferenceHelper.dart';
import 'package:croma_brokrage/ui/ChatModule/ViewProfileScreenUI.dart';
import 'package:croma_brokrage/utils/AppCommonFunction.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:image_picker/image_picker.dart';
import 'package:web_socket_channel/io.dart';
import 'package:web_socket_channel/status.dart' as status;

import '../../controller/ChatController.dart';
import '../../model/ChatListResponse.dart';
import '../../utils/AppColors.dart';
import '../../widgets/Txt.dart';
import '../ViewChatImageScreenUi.dart';

class ChatScreenUI extends StatefulWidget {
  String reciver;
  String webSocketUrl;
  String sender;
  ChatScreenUI({required this.reciver,required this.webSocketUrl,required this.sender});

  @override
  State<ChatScreenUI> createState() => _ChatScreenUIState();
}

class _ChatScreenUIState extends State<ChatScreenUI> {
  var channel;
  TextEditingController msgController  = TextEditingController();
  ChatController chatController = Get.put(ChatController());
  ScrollController scrollController = new ScrollController();


  @override
  initState(){
    super.initState();
    print("WEB SOCKET URL  ::  ${widget.webSocketUrl}");
    getMessage();

    channel = IOWebSocketChannel.connect(Uri.parse(widget.webSocketUrl));
    channel.stream.listen((message) {
      print("SOCKET MESSAGE  :: $message");
      var desc = json.decode(message);
      var sent = desc['sent'];
      var receiverMsg = sent ? widget.reciver : widget.sender;
      var senderMsg = sent ? widget.sender : widget.reciver;
      chatController.chatDataList.add(ChatListData(
        id: 0,
        description: desc['message'],
        timestamp: 1657368029,
        receiverName: receiverMsg,
        senderName: senderMsg,
        seen: true,
        sent: sent,
      ));

      scrollDown();

      chatController.sendChatMsgApi(
        token: PreferenceHelper().getUserData().authToken!,
        description: desc['message'],
        receiver_name: receiverMsg,
        seen: "false"
      );
      setState((){});


    });
  }

  getMessage(){
    chatController.progressDataLoading(true);
    chatController.chatListApi(
      token: PreferenceHelper().getUserData().authToken!,phNumber: widget.reciver).then((response){
        if(response.success == true){
          if(response.message == "fetch successfully"){
            chatController.chatListResponse = response;
            chatController.chatDataList = response.data!;
            chatController.progressDataLoading(false);

            scrollDown();

          }
        }
        chatController.progressDataLoading(false);
    });

  }


  @override
  Widget build(BuildContext context) {
    return SafeArea(
        child: Scaffold(
          appBar: AppBar(
            leading: InkWell(
              onTap: () {
                Get.to(()=> ViewProfileScreenUI(contactNumber: widget.reciver,) );
              },
              child: Padding(
                padding: const EdgeInsets.all(5.0),
                child: CircleAvatar(
                  child: Txt("PC"),
                ),
              ),
            ),
            title: InkWell(
              onTap: () {
                Get.to(()=> ViewProfileScreenUI(contactNumber: widget.reciver,) );
              },
              child: Text(widget.reciver)),
            flexibleSpace: Container(
              decoration: BoxDecoration(
                gradient: LinearGradient(
                    begin: Alignment.topLeft,
                    end: Alignment.bottomRight,
                    colors: [
                      AppColors.primaryColor,
                      Colors.black,
                    ]
                ),
              ),
            ),
          ),
          body: GetBuilder(
            init: ChatController(),
            builder: (ChatController controller) {
              return controller.isDataLoading
                ? AppCommonFunction.circularIndicator()
                : controller.chatDataList.isEmpty
                  ? Center(child: AppCommonFunction.noDataFound(),)
                  : Container(
                      padding: EdgeInsets.all(8.0),
                      child: Column(
                        children: [
                          Flexible(
                            child:

                            /*
                            ListView.builder(

                              // Scroll Controller for functionality
                              controller: scrollController,
                              itemCount: 100,
                              itemBuilder: (context, index) {
                                return ListTile(
                                  title: Text("Item ${index + 1}"),
                                );
                              },
                            ),
                            */



                            ListView.builder(
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
                                        color: Colors.black54.withOpacity(0.045),
                                        child: Wrap(
                                          children: [

                                            /*
                                            Container(
                                              alignment: Alignment.topRight,
                                              padding: const EdgeInsets.all(6.0),
                                              child:
                                              msgData[index].attachment.isNotEmpty
                                                  ? InkWell(
                                                onTap: () {
                                                  Navigator.push(
                                                      context, MaterialPageRoute(builder: (context) =>
                                                      ViewImageScreenUi(imageList: bytes,index: index,fileType: "memory",) ));
                                                },
                                                child: Image.memory(
                                                  bytes[index],
                                                  width: 180,
                                                  height: 200,
                                                  fit: BoxFit.fill,
                                                ),
                                              )
                                                  : Container(),
                                            ),
                                             */

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
                                              child:Text("${AppCommonFunction.timestampToDatetime(controller.chatDataList[index].timestamp!)} ",
                                                style: TextStyle(color: Colors.black54),
                                              ),
                                            ),

                                          ],),
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
                                          color: Colors.black54.withOpacity(0.045),
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
                                                child:Text("${AppCommonFunction.timestampToDatetime(controller.chatDataList[index].timestamp!)} ",
                                                  style: TextStyle(color: Colors.black54),
                                                ),
                                              ),

                                            ],),
                                        ),
                                      ),


                                    ],);
                              },
                            ),

                          ),
                          Row(
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
                                                getImage();
                                              },
                                              child: Icon(Icons.attach_file,color: Colors.grey,)),
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

                                  channel.sink.add(json.encode({"message":"${msgController.text}","sender" : "7984702696",'sent':'True'}));

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
                          ),
                      ],
                  ),
              );
            },

          ),
        )
    );
  }


  void getImage() async{
    final ImagePicker _picker = ImagePicker();
    final XFile? image = await _picker.pickImage(source: ImageSource.gallery);
    print("tempFile  ::  ${image!.path}");

    if(image != null){
      Get.to(()=> ViewChatImageScreenUi(file: image.path,ticketId: "abcd id" ,email: "abc@gmail.com",pwd: "12345",) );
    }
  }

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

}
