import 'dart:io';
import 'dart:ui' as ui;

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:flutter/services.dart';
import 'package:get/get.dart';
import 'package:path_provider/path_provider.dart';
import 'package:quotes_app_with_sqldb/controller/quote_controller.dart';
import 'package:share_extend/share_extend.dart';

import '../../utils/globals.dart';

class EditQuotes extends StatelessWidget {
  const EditQuotes({super.key});

  @override
  Widget build(BuildContext context) {

    var controller = Get.put(QuotesController());
    GlobalKey editimgKey = GlobalKey();
    double height = MediaQuery.of(context).size.height;
    double width = MediaQuery.of(context).size.width;

    return SafeArea(
      child: Scaffold(
        body: Container(
          width: width,
          height: height,
          decoration: BoxDecoration(
            gradient: LinearGradient(
              colors: [Color(0xFF60D19C), Color(0xFF4AB8F7)],
              begin: Alignment.topLeft,
              end: Alignment.bottomRight,
            ),
          ),
          child: Column(
            children: [
              Padding(
                padding: const EdgeInsets.all(15.0),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    GestureDetector(
                      onTap: () {
                        Navigator.of(context).pop();
                      },
                      child: Icon(
                        Icons.close,
                        color: Colors.black,
                        size: 25,
                      ),
                    ),
                    SizedBox(width: width*0.3+10,),
                    Text(
                      'Edit',
                      style: TextStyle(
                          color: Colors.black,
                          fontWeight: FontWeight.bold,
                          fontSize: 20),
                    ),
                    Spacer()
                  ],
                ),
              ),
              SizedBox(
                height: height * 0.05,
              ),
              RepaintBoundary(
                key: editimgKey,
                child: Container(
                  height: height * 0.7,
                  width: width * 0.8,
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(20),
                    color: Colors.white70,
                  ),
                  child: Padding(
                    padding: const EdgeInsets.only(left: 40, right: 30),
                    child: Obx(
                          () => Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          SelectableText(
                            cursorColor: Colors.black,
                            controller.quotes[controller.selectQuotes.toInt()].quote,
                            textAlign: controller.textAlign.value,
                            style: TextStyle(
                              color: controller.selectColor.value,
                              fontWeight: FontWeight.bold,
                              fontSize: 20,
                              fontFamily: controller.selectedFontFamily.value,
                            ),
                          ),
                          SizedBox(height: height*0.03,),
                          Text(
                            "- ${controller.quotes[controller.selectQuotes.toInt()].author} -",
                            textAlign: controller.textAlign.value,
                            style: TextStyle(
                              color: controller.selectColor.value,
                              fontFamily: controller.selectedFontFamily.value,
                              fontSize: 17,
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                ),
              ),
              SizedBox(height: height*0.05,),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: [
                  Container(
                    height: MediaQuery.of(context).size.height * 0.06,
                    width: MediaQuery.of(context).size.width * 0.27,
                    decoration: BoxDecoration(
                      color: Colors.white,borderRadius: BorderRadius.circular(10)
                    ),
                    child: IconButton(
                      icon: Icon(CupertinoIcons.text_cursor,  color: Colors.black,),
                      onPressed: () {
                        showModalBottomSheet(
                          context: context,
                          builder: (context) => Container(
                            height: height * 0.5,
                            width: width,
                            child: Padding(
                              padding: const EdgeInsets.only(left: 20),
                              child: Column(
                                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Text('Text align',
                                      style: TextStyle(
                                          color: Colors.black,
                                          fontWeight: FontWeight.bold,
                                          fontSize: 18)),
                                  Row(
                                    mainAxisAlignment: MainAxisAlignment.spaceAround,
                                    children: [
                                      InkWell(
                                        onTap: () {
                                          controller.textAlign.value = TextAlign.left;
                                        },
                                        child: Icon(
                                          CupertinoIcons.text_alignleft,
                                          color: Colors.black,
                                          size: 32,
                                        ),
                                      ),
                                      InkWell(
                                        onTap: () {
                                          controller.textAlign.value =
                                              TextAlign.justify;
                                        },
                                        child: Icon(
                                          CupertinoIcons.text_justify,
                                          color: Colors.black,
                                          size: 32,
                                        ),
                                      ),
                                      InkWell(
                                        onTap: () {
                                          controller.textAlign.value =
                                              TextAlign.center;
                                        },
                                        child: Icon(
                                          CupertinoIcons.text_aligncenter,
                                          color: Colors.black,
                                          size: 32,
                                        ),
                                      ),
                                      InkWell(
                                        onTap: () {
                                          controller.textAlign.value =
                                              TextAlign.right;
                                        },
                                        child: Icon(
                                          CupertinoIcons.text_alignright,
                                          color: Colors.black,
                                          size: 32,
                                        ),
                                      ),
                                    ],
                                  ),
                                  Text('Font colors',
                                      style: TextStyle(
                                          color: Colors.black,
                                          fontWeight: FontWeight.bold,
                                          fontSize: 18)),
                                  SingleChildScrollView(
                                    scrollDirection: Axis.horizontal,
                                    child: Row(
                                      children: [
                                        ...List.generate(
                                          colorList.length,
                                              (index) => GestureDetector(
                                            onTap: () {
                                              controller.colorChange(index);
                                            },
                                            child: Container(
                                              margin: EdgeInsets.only(right: 12),
                                              height: height * 0.05,
                                              width: width * 0.1,
                                              decoration: BoxDecoration(
                                                borderRadius:
                                                BorderRadius.circular(10),
                                                color: colorList[index],
                                                border: Border.all(
                                                    color: Colors.black),
                                              ),
                                            ),
                                          ),
                                        ),
                                      ],
                                    ),
                                  ),
                                  Padding(
                                    padding: const EdgeInsets.only(left: 2, bottom: 10),
                                    child: Column(
                                      crossAxisAlignment: CrossAxisAlignment.start,
                                      children: [
                                        Text('Font style',
                                            style: TextStyle(
                                                color: Colors.black,
                                                fontWeight: FontWeight.bold,
                                                fontSize: 18)),
                                        SingleChildScrollView(
                                          scrollDirection: Axis.horizontal,
                                          child: Row(
                                            children: [
                                              ...List.generate(
                                                fontFamily.length,
                                                    (index) => Padding(
                                                  padding: const EdgeInsets.only(
                                                      right: 10, top: 10),
                                                  child: GestureDetector(
                                                    onTap: () {
                                                      controller.textChange(index);
                                                    },
                                                    child: Container(
                                                      height: height * 0.05,
                                                      width: width * 0.2,
                                                      decoration: BoxDecoration(
                                                        color: Colors.transparent,
                                                        border: Border.all(
                                                            color: Colors.black),
                                                        borderRadius:
                                                        BorderRadius.circular(10),
                                                      ),
                                                      alignment: Alignment.center,
                                                      child: Text(
                                                        'abc',
                                                        overflow: TextOverflow.ellipsis,
                                                        style: TextStyle(
                                                            color: Colors.black,
                                                            fontSize: 20,
                                                            fontFamily:
                                                            '${fontFamily[index]}'),
                                                      ),
                                                    ),
                                                  ),
                                                ),
                                              ),
                                            ],
                                          ),
                                        ),
                                      ],
                                    ),
                                  ),
                                ],
                              ),
                            ),
                          ),
                        );
                      },
                    ),
                  ),
                  Container(
                    height: MediaQuery.of(context).size.height * 0.06,
                    width: MediaQuery.of(context).size.width * 0.27,
                    decoration: BoxDecoration(
                        color: Colors.white,borderRadius: BorderRadius.circular(10)
                    ),
                    child: IconButton(
                      onPressed: () {
                        Clipboard.setData(
                          ClipboardData(
                            text: controller.quotes[selectedIndex].quote,
                          ),
                        );
                      },
                      icon: Icon(Icons.copy, color: Colors.black),
                    ),
                  ),
                  Container(
                    height: MediaQuery.of(context).size.height * 0.06,
                    width: MediaQuery.of(context).size.width * 0.27,
                    decoration: BoxDecoration(
                        color: Colors.white,borderRadius: BorderRadius.circular(10)
                    ),
                    child: IconButton(
                      icon: Icon(Icons.share, color: Colors.black,),
                      onPressed: () async {
                        RenderRepaintBoundary boundary =
                        editimgKey.currentContext!.findRenderObject()
                        as RenderRepaintBoundary;

                        ui.Image image = await boundary.toImage();
                        ByteData? bytedata = await image.toByteData(
                            format: ui.ImageByteFormat.png);
                        Uint8List img = bytedata!.buffer.asUint8List();

                        final path = await getApplicationDocumentsDirectory();
                        File file = File("${path.path}/img.png");
                        file.writeAsBytes(img);
                        ShareExtend.share(file.path, "image");
                      },
                    ),
                  ),

                ],
              ),
            ],
          ),
        ),
      ),
    );
  }
}
