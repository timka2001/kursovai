import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter_calendar_week/flutter_calendar_week.dart';
import 'package:flutter/services.dart' show ByteData, Uint8List, rootBundle;
import 'package:intl/intl.dart';
import 'package:path_provider/path_provider.dart';
import 'package:http/http.dart' as http;
import 'package:image/image.dart' as img;

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      theme: ThemeData(
     
        colorScheme: ColorScheme.fromSeed(seedColor: Colors.deepPurple),
        useMaterial3: true,
      ),
      home: const MyHomePage(title: 'Flutter Demo Home Page'),
    );
  }
}

const double plase_1 = (3.14 * (2.3 * 2.3) / 4);

class MyHomePage extends StatefulWidget {
  const MyHomePage({super.key, required this.title});

  // This widget is the home page of your application. It is stateful, meaning
  // that it has a State object (defined below) that contains fields that affect
  // how it looks.

  // This class is the configuration for the state. It holds the values (in this
  // case the title) provided by the parent (in this case the App widget) and
  // used by the build method of the State. Fields in a Widget subclass are
  // always marked "final".

  final String title;

  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  final CalendarWeekController _controller = CalendarWeekController();
  String rgbToHex(int r, int g, int b) {
    Color color = Color.fromRGBO(r, g, b, 1.0);
    String hexColor =
        '#${color.value.toRadixString(16).substring(2).toUpperCase()}';
    return hexColor;
  }

  List<String> blueHEX = [];
  List<String> greyHEX = [];
  int sizePixel_1 = 0;
  int sizePixel_2 = 0;

  double plase_2 = 0;
  @override
  void initState() {
    //               серо
    // серый
//Серовато
    for (String item in array) {
      if (item.contains("синий") ||
          item.contains("Cиний") ||
          item.contains("сине") ||
          item.contains("Сине") ||
          item.contains("Синяя") ||
          item.contains("синяя") ||
          item.contains("Синевато") ||
          item.contains("синевато")) {
        RegExp colorRegex = RegExp(r'#([A-Fa-f0-9]{6})');
        RegExpMatch? match = colorRegex.firstMatch(item);
        String colorValue = match!.group(0)!;
        blueHEX.add(colorValue);
        print("Значение: $colorValue");
      } else if (item.contains("серый") ||
          item.contains("Серый") ||
          item.contains("Серовато") ||
          item.contains("серовато") ||
          item.contains("серо") ||
          item.contains("Серо")) {
        RegExp colorRegex = RegExp(r'#([A-Fa-f0-9]{6})');
        RegExpMatch? match = colorRegex.firstMatch(item);
        String colorValue = match!.group(0)!;
        print("Значение: $colorValue");
        greyHEX.add(colorValue);
      }
    }
    print(blueHEX.length);
    print(greyHEX.length);
    super.initState();
  }

  final blackPixels = <Pixel>[];
  @override
  Widget build(BuildContext context) => Scaffold(
      floatingActionButton: FloatingActionButton(
        onPressed: () async {
       
          ByteData? response_1;
          rootBundle
              .load("assets/c.jpg")
              .then((value) => response_1 = value)
              .whenComplete(() {
            final Uint8List list = response_1!.buffer.asUint8List();
            final imageBytes = list;
            final image = img.decodeImage(imageBytes);
            final image_copy = img.decodeImage(imageBytes);
            final byteData = image_copy!.getBytes();
          final buffer = byteData.buffer;
            final pixel32List = byteData.buffer.asUint32List();
       if (image != null) {
              // Получите размеры изображения
              // Переберите все пиксели изображения
              for (var i = 0; i < pixel32List.length; i++) {
                final pixel32 = pixel32List[i];
                final pixelColor = Color(pixel32);
                String hex =
                    rgbToHex(pixelColor.red, pixelColor.green, pixelColor.blue);

                // print(
                //     'pixelColor.red: ${pixelColor.red}, pixelColor.green: ${pixelColor.green}, pixelColor.green: ${pixelColor.blue}');
                for (int i = 0; i < blueHEX.length; i++) {
                  if (blueHEX[i] == hex) {
                    sizePixel_2++;
                  }
                }
                for (int i = 0; i < greyHEX.length; i++) {
                  if (greyHEX[i] == hex) {
                    sizePixel_1++;
                  }
                }
              }
            }

            print("Размер первого объекта: ${sizePixel_1}");
            print("Размер воторого объекта: ${sizePixel_2}");
            plase_2 = ((plase_1 * sizePixel_2) / sizePixel_1);
            setState(() {});
          });
        },
        child: Icon(Icons.today),
      ),
      body: Column(
        children: [
          Container(
            width: 400,
            height: MediaQuery.of(context).size.height * 0.6,
            decoration: BoxDecoration(
              image: DecorationImage(
                image: AssetImage('assets/c.jpg'),
                fit: BoxFit.fill,
              ),
            ),
          ),
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: Container(
              width: double.infinity,
              height: MediaQuery.of(context).size.height * 0.38,
              child: Column(children: [
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [Text("Площадь монетки"), Text("${plase_1} см^2")],
                ),
                Row(
                  children: [
                    Text("Количество пикселей монетки:   "),
                    Text("${sizePixel_1} ")
                  ],
                ),
                Row(
                  children: [
                    Text("Количество пикселей объекта:    "),
                    Text("${sizePixel_2} ")
                  ],
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [Text("Площадь объекта"), Text("${plase_2} см^2")],
                )
              ]),
            ),
          ),
        ],
      ));
}

class Pixel {
  final int x;
  final int y;
  final Color color;

  Pixel(this.x, this.y, this.color);
}
//  List<String> array = [
//                   '<li style="background-color:#FFCBBB"><a class="select" style="color:#000;" href="#FFCBBB">Циннвальдитово-розовый - #FFCBBB</a></li>',
//                   '<li style="background-color:#343E40"><a class="select" style="color:#fff;" href="#343E40">Черно-зеленый (Black Green) - #343E40</a></li>',
//                   '<li style="background-color:#212121"><a class="select" style="color:#fff;" href="#212121">Черно-коричневый (Black Brown) - #212121</a></li>',
//                   '<li style="background-color:#412227"><a class="select" style="color:#fff;" href="#412227">Черно-красный (Black Red) - #412227</a></li>',
//                   '<li style="background-color:#3B3C36"><a class="select" style="color:#fff;" href="#3B3C36">Черно-оливковый (Black Olive) - #3B3C36</a></li>',
//                   '<li style="background-color:#23282B"><a class="select" style="color:#fff;" href="#23282B">Черно-серый (Black Gray) - #23282B</a></li>',
//                   '<li style="background-color:#18171C"><a class="select" style="color:#fff;" href="#18171C">Черно-синий (Blue Black) - #18171C</a></li>',
//                   '<li style="background-color:#141613"><a class="select" style="color:#fff;" href="#141613">Черновато-зеленый - #141613</a></li>',
//                   '<li style="background-color:#1F0E11"><a class="select" style="color:#fff;" href="#1F0E11">Черновато-красный - #1F0E11</a></li>',
//                   '<li style="background-color:#1D1018"><a class="select" style="color:#fff;" href="#1D1018">Черновато-пурпурный - #1D1018</a></li>',
//                   '<li style="background-color:#161A1E"><a class="select" style="color:#fff;" href="#161A1E">Черновато-синий - #161A1E</a></li>',
//                   '<li style="background-color:#000000"><a class="select" style="color:#fff;" href="#000000">Черный (Black) - #000000</a></li>',
//                 ];

//                 String searchText = "синий";

//                 for (String item in array) {
//                   if (item.contains(searchText)) {
//                     RegExp colorRegex = RegExp(r'#([A-Fa-f0-9]{6})');
//                     RegExpMatch? match = colorRegex.firstMatch(item);
//                     String colorValue = match!.group(0)!;
//                     print("Значение: $colorValue");

//                   }
//                 }

List<String> array = [
  '<li style="background-color:#FBCEB1"><a class="select" style="color:#000;" href="#FBCEB1">Абрикосовый (Apricot) - #FBCEB1</a></li>',
  '<li style="background-color:#FDD9B5"><a class="select" style="color:#000;" href="#FDD9B5">Абрикосовый Крайола - #FDD9B5</a></li>',
  '<li style="background-color:#B5B8B1"><a class="select" style="color:#000;" href="#B5B8B1">Агатовый серый (Colorhouse Metal .03) - #B5B8B1</a></li>',
  '<li style="background-color:#7FFFD4"><a class="select" style="color:#000;" href="#7FFFD4">Аквамариновый (Aquamarine) - #7FFFD4</a></li>',
  '<li style="background-color:#78DBE2"><a class="select" style="color:#000;" href="#78DBE2">Аквамариновый Крайола - #78DBE2</a></li>',
  '<li style="background-color:#E32636"><a class="select" style="color:#fff;" href="#E32636">Ализариновый красный (Alizarin Crimson) - #E32636</a></li>',
  '<li style="background-color:#FF2400"><a class="select" style="color:#fff;" href="#FF2400">Алый (Scarlet) - #FF2400</a></li>',
  '<li style="background-color:#AB274F"><a class="select" style="color:#fff;" href="#AB274F">Амарантово-пурпурный (Amaranth Purple) - #AB274F</a></li>',
  '<li style="background-color:#F19CBB"><a class="select" style="color:#000;" href="#F19CBB">Амарантово-розовый (Amaranth Pink) - #F19CBB</a></li>',
  '<li style="background-color:#E52B50"><a class="select" style="color:#fff;" href="#E52B50">Амарантовый (Amaranth) - #E52B50</a></li>',
  '<li style="background-color:#9F2B68"><a class="select" style="color:#fff;" href="#9F2B68">Амарантовый глубоко-пурпурный - #9F2B68</a></li>',
  '<li style="background-color:#ED3CCA"><a class="select" style="color:#fff;" href="#ED3CCA">Амарантовый маджента (Amaranth Magenta) - #ED3CCA</a></li>',
  '<li style="background-color:#CD2682"><a class="select" style="color:#fff;" href="#CD2682">Амарантовый светло-вишневый (Amaranth Light Cherry) - #CD2682</a></li>',
  '<li style="background-color:#FF033E"><a class="select" style="color:#fff;" href="#FF033E">Американская роза (American Rose) - #FF033E</a></li>',
  '<li style="background-color:#9966CC"><a class="select" style="color:#fff;" href="#9966CC">Аметистовый (Amethyst) - #9966CC</a></li>',
  '<li style="background-color:#CD9575"><a class="select" style="color:#fff;" href="#CD9575">Античная латунь (Antique Brass) - #CD9575</a></li>',
  '<li style="background-color:#293133"><a class="select" style="color:#fff;" href="#293133">Антрацитово-серый - #293133</a></li>',
  '<li style="background-color:#464451"><a class="select" style="color:#fff;" href="#464451">Антрацитовый (Anthracite) - #464451</a></li>',
  '<li style="background-color:#44944A"><a class="select" style="color:#fff;" href="#44944A">Арлекин (Harlequin) - #44944A</a></li>',
  '<li style="background-color:#4B5320"><a class="select" style="color:#fff;" href="#4B5320">Армейский зеленый (Army Green) - #4B5320</a></li>',
  '<li style="background-color:#2F4F4F"><a class="select" style="color:#fff;" href="#2F4F4F">Аспидно-серый (Dark Slate Gray) - #2F4F4F</a></li>',
  '<li style="background-color:#6A5ACD"><a class="select" style="color:#fff;" href="#6A5ACD">Аспидно-синий (Slate Blue) - #6A5ACD</a></li>',
  '<li style="background-color:#A8E4A0"><a class="select" style="color:#000;" href="#A8E4A0">Бабушкины яблоки (Granny Smith Apple) - #A8E4A0</a></li>',
  '<li style="background-color:#4E5754"><a class="select" style="color:#fff;" href="#4E5754">Базальтово-серый - #4E5754</a></li>',
  '<li style="background-color:#990066"><a class="select" style="color:#fff;" href="#990066">Баклажановый (Eggplant) - #990066</a></li>',
  '<li style="background-color:#6E5160"><a class="select" style="color:#fff;" href="#6E5160">Баклажановый Крайола - #6E5160</a></li>',
  '<li style="background-color:#FAE7B5"><a class="select" style="color:#000;" href="#FAE7B5">Бананомания (Banana Mania) - #FAE7B5</a></li>',
  '<li style="background-color:#CCCCFF"><a class="select" style="color:#000;" href="#CCCCFF">Барвинок, Перванш (Lavender Blue) - #CCCCFF</a></li>',
  '<li style="background-color:#C5D0E6"><a class="select" style="color:#000;" href="#C5D0E6">Барвинок Крайола - #C5D0E6</a></li>',
  '<li style="background-color:#FAEEDD"><a class="select" style="color:#000;" href="#FAEEDD">Бедра испуганной нимфы - #FAEEDD</a></li>',
  '<li style="background-color:#79553D"><a class="select" style="color:#fff;" href="#79553D">Бежево-коричневый (Beige Brown) - #79553D</a></li>',
  '<li style="background-color:#C1876B"><a class="select" style="color:#fff;" href="#C1876B">Бежево-красный (Beige Red) - #C1876B</a></li>',
  '<li style="background-color:#6D6552"><a class="select" style="color:#fff;" href="#6D6552">Бежево-серый (Beige Gray) - #6D6552</a></li>',
  '<li style="background-color:#F5F5DC"><a class="select" style="color:#000;" href="#F5F5DC">Бежевый (Beige) - #F5F5DC</a></li>',
  '<li style="background-color:#A5A5A5"><a class="select" style="color:#000;" href="#A5A5A5">Бело-алюминиевый (White Aluminum) - #A5A5A5</a></li>',
  '<li style="background-color:#BDECB6"><a class="select" style="color:#000;" href="#BDECB6">Бело-зеленый (White Green) - #BDECB6</a></li>',
  '<li style="background-color:#FFFAFA"><a class="select" style="color:#000;" href="#FFFAFA">Белоснежный (Snow) - #FFFAFA</a></li>',
  '<li style="background-color:#FFFFFF"><a class="select" style="color:#000;" href="#FFFFFF">Белый (White) - #FFFFFF</a></li>',
  '<li style="background-color:#FAEBD7"><a class="select" style="color:#000;" href="#FAEBD7">Белый антик (Antique White) - #FAEBD7</a></li>',
  '<li style="background-color:#FFDEAD"><a class="select" style="color:#000;" href="#FFDEAD">Белый навахо (Navajo White) - #FFDEAD</a></li>',
  '<li style="background-color:#003153"><a class="select" style="color:#fff;" href="#003153">Берлинская лазурь (Prussian Blue) - #003153</a></li>',
  '<li style="background-color:#77DDE7"><a class="select" style="color:#000;" href="#77DDE7">Бирюзово-голубой - #77DDE7</a></li>',
  '<li style="background-color:#1E5945"><a class="select" style="color:#fff;" href="#1E5945">Бирюзово-зеленый - #1E5945</a></li>',
  '<li style="background-color:#3F888F"><a class="select" style="color:#fff;" href="#3F888F">Бирюзово-синий - #3F888F</a></li>',
  '<li style="background-color:#30D5C8"><a class="select" style="color:#000;" href="#30D5C8">Бирюзовый (Turquoise) - #30D5C8</a></li>',
  '<li style="background-color:#FFE4C4"><a class="select" style="color:#000;" href="#FFE4C4">Бисквитный (Bisque) - #FFE4C4</a></li>',
  '<li style="background-color:#A5260A"><a class="select" style="color:#fff;" href="#A5260A">Бисмарк-фуриозо (Bismarck Furioso) - #A5260A</a></li>',
  '<li style="background-color:#3D2B1F"><a class="select" style="color:#fff;" href="#3D2B1F">Бистр (Bistre) - #3D2B1F</a></li>',
  '<li style="background-color:#ABCDEF"><a class="select" style="color:#000;" href="#ABCDEF">Бледно-васильковый (Pale Cornflower Blue) - #ABCDEF</a></li>',
  '<li style="background-color:#FFDB8B"><a class="select" style="color:#000;" href="#FFDB8B">Бледно-желтый (Pale Yellow) - #FFDB8B</a></li>',
  '<li style="background-color:#8D917A"><a class="select" style="color:#000;" href="#8D917A">Бледно-зелено-серый - #8D917A</a></li>',
  '<li style="background-color:#EEE8AA"><a class="select" style="color:#000;" href="#EEE8AA">Бледно-золотистый (Pale Goldenrod) - #EEE8AA</a></li>',
  '<li style="background-color:#B03F35"><a class="select" style="color:#fff;" href="#B03F35">Бледно-карминный (Pale Carmine) - #B03F35</a></li>',
  '<li style="background-color:#DDADAF"><a class="select" style="color:#000;" href="#DDADAF">Бледно-каштановый (Pale Chestnut) - #DDADAF</a></li>',
  '<li style="background-color:#755C48"><a class="select" style="color:#fff;" href="#755C48">Бледно-коричневый (Pale Brown) - #755C48</a></li>',
  '<li style="background-color:#DABDAB"><a class="select" style="color:#000;" href="#DABDAB">Бледно-песочный (Pale Sand) - #DABDAB</a></li>',
  '<li style="background-color:#F984E5"><a class="select" style="color:#000;" href="#F984E5">Бледно-пурпурный (Pale Magenta) - #F984E5</a></li>',
  '<li style="background-color:#FFCBDB"><a class="select" style="color:#000;" href="#FFCBDB">Бледно-розоватый - #FFCBDB</a></li>',
  '<li style="background-color:#FADADD"><a class="select" style="color:#000;" href="#FADADD">Бледно-розовый (Pale Pink) - #FADADD</a></li>',
  '<li style="background-color:#AFEEEE"><a class="select" style="color:#000;" href="#AFEEEE">Бледно-синий (Pale Turquoise) - #AFEEEE</a></li>',
  '<li style="background-color:#957B8D"><a class="select" style="color:#fff;" href="#957B8D">Бледно-фиолетовый (Pale Purple) - #957B8D</a></li>',
  '<li style="background-color:#ECEBBD"><a class="select" style="color:#000;" href="#ECEBBD">Бледный весенний бутон (Pale Spring Bud) - #ECEBBD</a></li>',
  '<li style="background-color:#F0D698"><a class="select" style="color:#000;" href="#F0D698">Бледный желто-зеленый - #F0D698</a></li>',
  '<li style="background-color:#FFC8A8"><a class="select" style="color:#000;" href="#FFC8A8">Бледный желто-розовый - #FFC8A8</a></li>',
  '<li style="background-color:#FFDF84"><a class="select" style="color:#000;" href="#FFDF84">Бледный зеленовато-желтый - #FFDF84</a></li>',
  '<li style="background-color:#98FB98"><a class="select" style="color:#000;" href="#98FB98">Бледный зеленый (Pale Green) - #98FB98</a></li>',
  '<li style="background-color:#AC7580"><a class="select" style="color:#fff;" href="#AC7580">Бледный красно-пурпурный - #AC7580</a></li>',
  '<li style="background-color:#FFCA86"><a class="select" style="color:#000;" href="#FFCA86">Бледный оранжево-желтый - #FFCA86</a></li>',
  '<li style="background-color:#FDBDBA"><a class="select" style="color:#000;" href="#FDBDBA">Бледный пурпурно-розовый - #FDBDBA</a></li>',
  '<li style="background-color:#8A7F8E"><a class="select" style="color:#fff;" href="#8A7F8E">Бледный пурпурно-синий - #8A7F8E</a></li>',
  '<li style="background-color:#BC987E"><a class="select" style="color:#fff;" href="#BC987E">Бледный серо-коричневый - #BC987E</a></li>',
  '<li style="background-color:#919192"><a class="select" style="color:#fff;" href="#919192">Бледный синий (Pale Blue) - #919192</a></li>',
  '<li style="background-color:#D87093"><a class="select" style="color:#fff;" href="#D87093">Бледный фиолетово-красный - #D87093</a></li>',
  '<li style="background-color:#CED23A"><a class="select" style="color:#000;" href="#CED23A">Блестящий желто-зеленый - #CED23A</a></li>',
  '<li style="background-color:#8CCB5E"><a class="select" style="color:#000;" href="#8CCB5E">Блестящий желтовато-зеленый - #8CCB5E</a></li>',
  '<li style="background-color:#FFCF40"><a class="select" style="color:#000;" href="#FFCF40">Блестящий желтый (Brilliant Yellow) - #FFCF40</a></li>',
  '<li style="background-color:#FFDC33"><a class="select" style="color:#000;" href="#FFDC33">Блестящий зеленовато-желтый - #FFDC33</a></li>',
  '<li style="background-color:#2A8D9C"><a class="select" style="color:#fff;" href="#2A8D9C">Блестящий зеленовато-синий - #2A8D9C</a></li>',
  '<li style="background-color:#47A76A"><a class="select" style="color:#fff;" href="#47A76A">Блестящий зеленый (Brilliant Green) - #47A76A</a></li>',
  '<li style="background-color:#FFB841"><a class="select" style="color:#000;" href="#FFB841">Блестящий оранжевый (Brilliant Orange) - #FFB841</a></li>',
  '<li style="background-color:#FF97BB"><a class="select" style="color:#000;" href="#FF97BB">Блестящий пурпурно-розовый - #FF97BB</a></li>',
  '<li style="background-color:#62639B"><a class="select" style="color:#fff;" href="#62639B">Блестящий пурпурно-синий - #62639B</a></li>',
  '<li style="background-color:#DD80CC"><a class="select" style="color:#fff;" href="#DD80CC">Блестящий пурпурный (Brilliant Purple) - #DD80CC</a></li>',
  '<li style="background-color:#009B76"><a class="select" style="color:#fff;" href="#009B76">Блестящий синевато-зеленый - #009B76</a></li>',
  '<li style="background-color:#4285B4"><a class="select" style="color:#fff;" href="#4285B4">Блестящий синий (Brilliant Blue) - #4285B4</a></li>',
  '<li style="background-color:#755D9A"><a class="select" style="color:#fff;" href="#755D9A">Блестящий фиолетовый (Brilliant Purple) - #755D9A</a></li>',
  '<li style="background-color:#FAF0BE"><a class="select" style="color:#000;" href="#FAF0BE">Блонд (Blond) - #FAF0BE</a></li>',
  '<li style="background-color:#755A57"><a class="select" style="color:#fff;" href="#755A57">Блошиный (Красновато-коричневый) - #755A57</a></li>',
  '<li style="background-color:#9F8170"><a class="select" style="color:#fff;" href="#9F8170">Бобровый (Beaver) - #9F8170</a></li>',
  '<li style="background-color:#480607"><a class="select" style="color:#fff;" href="#480607">Болгарская роза (Bulgarian Rose) - #480607</a></li>',
  '<li style="background-color:#ACB78E"><a class="select" style="color:#000;" href="#ACB78E">Болотный (Swamp Green) - #ACB78E</a></li>',
  '<li style="background-color:#B00000"><a class="select" style="color:#fff;" href="#B00000">Бордо, Красно-бордовый (Bordeaux, Red Maroon) - #B00000</a></li>',
  '<li style="background-color:#641C34"><a class="select" style="color:#fff;" href="#641C34">Бордово-фиолетовый - #641C34</a></li>',
  '<li style="background-color:#9B2D30"><a class="select" style="color:#fff;" href="#9B2D30">Бордовый (Vinous) - #9B2D30</a></li>',
  '<li style="background-color:#D5D5D5"><a class="select" style="color:#000;" href="#D5D5D5">Бороды Абдель-Керима - #D5D5D5</a></li>',
  '<li style="background-color:#4C514A"><a class="select" style="color:#fff;" href="#4C514A">Брезентово-серый (Tarpaulin Gray) - #4C514A</a></li>',
  '<li style="background-color:#3E5F8A"><a class="select" style="color:#fff;" href="#3E5F8A">Бриллиантово-синий (Diamond Blue) - #3E5F8A</a></li>',
  '<li style="background-color:#FFB02E"><a class="select" style="color:#000;" href="#FFB02E">Бриллиантовый оранжево-желтый - #FFB02E</a></li>',
  '<li style="background-color:#CD7F32"><a class="select" style="color:#fff;" href="#CD7F32">Бронзовый (Bronze) - #CD7F32</a></li>',
  '<li style="background-color:#900020"><a class="select" style="color:#fff;" href="#900020">Бургундский (Burgundy) - #900020</a></li>',
  '<li style="background-color:#45161C"><a class="select" style="color:#fff;" href="#45161C">Бурый - #45161C</a></li>',
  '<li style="background-color:#343B29"><a class="select" style="color:#fff;" href="#343B29">Бутылочно-зеленый - #343B29</a></li>',
  '<li style="background-color:#64400F"><a class="select" style="color:#fff;" href="#64400F">В меру оливково-коричневый - #64400F</a></li>',
  '<li style="background-color:#D5713F"><a class="select" style="color:#fff;" href="#D5713F">Ванильный (Vanilla) - #D5713F</a></li>',
  '<li style="background-color:#6495ED"><a class="select" style="color:#fff;" href="#6495ED">Васильковый (Cornflower Blue) - #6495ED</a></li>',
  '<li style="background-color:#9ACEEB"><a class="select" style="color:#000;" href="#9ACEEB">Васильковый Крайола (Cornflower) - #9ACEEB</a></li>',
  '<li style="background-color:#C19A6B"><a class="select" style="color:#fff;" href="#C19A6B">Верблюжий, Увядших листьев (Camel, Desert) - #C19A6B</a></li>',
  '<li style="background-color:#DAD871"><a class="select" style="color:#000;" href="#DAD871">Вердепешевый - #DAD871</a></li>',
  '<li style="background-color:#34C924"><a class="select" style="color:#000;" href="#34C924">Вердепомовый - #34C924</a></li>',
  '<li style="background-color:#DE4C8A"><a class="select" style="color:#fff;" href="#DE4C8A">Вересково-фиолетовый (Heather Purple) - #DE4C8A</a></li>',
  '<li style="background-color:#00FF7F"><a class="select" style="color:#000;" href="#00FF7F">Весенне-зеленый, Зеленая весна (Spring Green) - #00FF7F</a></li>',
  '<li style="background-color:#ECEABE"><a class="select" style="color:#000;" href="#ECEABE">Весенне-зеленый Крайола - #ECEABE</a></li>',
  '<li style="background-color:#A7FC00"><a class="select" style="color:#000;" href="#A7FC00">Весенний бутон (Spring Bud) - #A7FC00</a></li>',
  '<li style="background-color:#BD33A4"><a class="select" style="color:#fff;" href="#BD33A4">Византийский (Byzantine) - #BD33A4</a></li>',
  '<li style="background-color:#702963"><a class="select" style="color:#fff;" href="#702963">Византия (Byzantium) - #702963</a></li>',
  '<li style="background-color:#5E2129"><a class="select" style="color:#fff;" href="#5E2129">Винно-красный (Wine Red) - #5E2129</a></li>',
  '<li style="background-color:#414833"><a class="select" style="color:#fff;" href="#414833">Винтовочный зеленый (Rifle Green) - #414833</a></li>',
  '<li style="background-color:#911E42"><a class="select" style="color:#fff;" href="#911E42">Вишневый (Cherry) - #911E42</a></li>',
  '<li style="background-color:#256D7B"><a class="select" style="color:#fff;" href="#256D7B">Водная синь (Water Blue) - #256D7B</a></li>',
  '<li style="background-color:#0095B6"><a class="select" style="color:#fff;" href="#0095B6">Вода пляжа Бонди (Bondi Blue) - #0095B6</a></li>',
  '<li style="background-color:#5D8AA8"><a class="select" style="color:#fff;" href="#5D8AA8">Военно-воздушный синий (Air Force Blue) - #5D8AA8</a></li>',
  '<li style="background-color:#FFCF48"><a class="select" style="color:#000;" href="#FFCF48">Восход солнца (Sunrise) - #FFCF48</a></li>',
  '<li style="background-color:#B8B799"><a class="select" style="color:#000;" href="#B8B799">Галечный серый (Pebble Grey) - #B8B799</a></li>',
  '<li style="background-color:#DCDCDC"><a class="select" style="color:#000;" href="#DCDCDC">Гейнсборо (Gainsboro) - #DCDCDC</a></li>',
  '<li style="background-color:#DF73FF"><a class="select" style="color:#000;" href="#DF73FF">Гелиотроповый (Heliotrope) - #DF73FF</a></li>',
  '<li style="background-color:#F3A505"><a class="select" style="color:#000;" href="#F3A505">Георгиново-желтый (Dahlia Yellow) - #F3A505</a></li>',
  '<li style="background-color:#734222"><a class="select" style="color:#fff;" href="#734222">Глиняный коричневый - #734222</a></li>',
  '<li style="background-color:#C9A0DC"><a class="select" style="color:#000;" href="#C9A0DC">Глициния, Глициниевый (Wisteria) - #C9A0DC</a></li>',
  '<li style="background-color:#CDA4DE"><a class="select" style="color:#000;" href="#CDA4DE">Глициния Крайола - #CDA4DE</a></li>',
  '<li style="background-color:#C154C1"><a class="select" style="color:#fff;" href="#C154C1">Глубокая фуксия (Deep Fuchsia) - #C154C1</a></li>',
  '<li style="background-color:#593315"><a class="select" style="color:#fff;" href="#593315">Глубокий желто-коричневый - #593315</a></li>',
  '<li style="background-color:#F64A46"><a class="select" style="color:#fff;" href="#F64A46">Глубокий желто-розовый - #F64A46</a></li>',
  '<li style="background-color:#00541F"><a class="select" style="color:#fff;" href="#00541F">Глубокий желтовато-зеленый - #00541F</a></li>',
  '<li style="background-color:#B57900"><a class="select" style="color:#fff;" href="#B57900">Глубокий желтый (Deep Yellow) - #B57900</a></li>',
  '<li style="background-color:#425E17"><a class="select" style="color:#fff;" href="#425E17">Глубокий желтый зеленый - #425E17</a></li>',
  '<li style="background-color:#9F8200"><a class="select" style="color:#fff;" href="#9F8200">Глубокий зеленовато-желтый - #9F8200</a></li>',
  '<li style="background-color:#004524"><a class="select" style="color:#fff;" href="#004524">Глубокий зеленый (Deep Green) - #004524</a></li>',
  '<li style="background-color:#EF3038"><a class="select" style="color:#fff;" href="#EF3038">Глубокий карминно-розовый - #EF3038</a></li>',
  '<li style="background-color:#A9203E"><a class="select" style="color:#fff;" href="#A9203E">Глубокий карминный (Deep Carmine) - #A9203E</a></li>',
  '<li style="background-color:#FF4040"><a class="select" style="color:#fff;" href="#FF4040">Глубокий коралловый (Coral Red) - #FF4040</a></li>',
  '<li style="background-color:#4D220E"><a class="select" style="color:#fff;" href="#4D220E">Глубокий коричневый (Deep Brown) - #4D220E</a></li>',
  '<li style="background-color:#490005"><a class="select" style="color:#fff;" href="#490005">Глубокий красно-коричневый - #490005</a></li>',
  '<li style="background-color:#A91D11"><a class="select" style="color:#fff;" href="#A91D11">Глубокий красно-оранжевый - #A91D11</a></li>',
  '<li style="background-color:#641349"><a class="select" style="color:#fff;" href="#641349">Глубокий красно-пурпурный - #641349</a></li>',
  '<li style="background-color:#7B001C"><a class="select" style="color:#fff;" href="#7B001C">Глубокий красный (Deep Red) - #7B001C</a></li>',
  '<li style="background-color:#142300"><a class="select" style="color:#fff;" href="#142300">Глубокий оливково-зеленый - #142300</a></li>',
  '<li style="background-color:#D76E00"><a class="select" style="color:#fff;" href="#D76E00">Глубокий оранжево-желтый - #D76E00</a></li>',
  '<li style="background-color:#C34D0A"><a class="select" style="color:#fff;" href="#C34D0A">Глубокий оранжевый (Deep Orange) - #C34D0A</a></li>',
  '<li style="background-color:#6F0035"><a class="select" style="color:#fff;" href="#6F0035">Глубокий пурпурно-красный - #6F0035</a></li>',
  '<li style="background-color:#EB5284"><a class="select" style="color:#000;" href="#EB5284">Глубокий пурпурно-розовый - #EB5284</a></li>',
  '<li style="background-color:#1A153F"><a class="select" style="color:#fff;" href="#1A153F">Глубокий пурпурно-синий - #1A153F</a></li>',
  '<li style="background-color:#531A50"><a class="select" style="color:#fff;" href="#531A50">Глубокий пурпурный - #531A50</a></li>',
  '<li style="background-color:#FF1493"><a class="select" style="color:#000;" href="#FF1493">Глубокий розовый (Deep Pink) - #FF1493</a></li>',
  '<li style="background-color:#00382B"><a class="select" style="color:#fff;" href="#00382B">Глубокий синевато-зеленый - #00382B</a></li>',
  '<li style="background-color:#002F55"><a class="select" style="color:#fff;" href="#002F55">Глубокий синий (Deep Blue) - #002F55</a></li>',
  '<li style="background-color:#240935"><a class="select" style="color:#fff;" href="#240935">Глубокий фиолетово-черный - #240935</a></li>',
  '<li style="background-color:#423189"><a class="select" style="color:#fff;" href="#423189">Глубокий фиолетовый (Deep Purple) - #423189</a></li>',
  '<li style="background-color:#606E8C"><a class="select" style="color:#fff;" href="#606E8C">Голубино-синий (Pigeon Blue) - #606E8C</a></li>',
  '<li style="background-color:#42AAFF"><a class="select" style="color:#000;" href="#42AAFF">Голубой - #42AAFF</a></li>',
  '<li style="background-color:#A2A2D0"><a class="select" style="color:#000;" href="#A2A2D0">Голубой колокольчик (Blue Bell) - #A2A2D0</a></li>',
  '<li style="background-color:#80DAEB"><a class="select" style="color:#000;" href="#80DAEB">Голубой Крайола - #80DAEB</a></li>',
  '<li style="background-color:#0E294B"><a class="select" style="color:#fff;" href="#0E294B">Горечавково-синий (Gentian Blue) - #0E294B</a></li>',
  '<li style="background-color:#30BA8F"><a class="select" style="color:#000;" href="#30BA8F">Горный луг (Mountain Madow) - #30BA8F</a></li>',
  '<li style="background-color:#87CEEB"><a class="select" style="color:#000;" href="#87CEEB">Городское небо, Пасмурно-небесный (Sky Blue) - #87CEEB</a></li>',
  '<li style="background-color:#FFDB58"><a class="select" style="color:#000;" href="#FFDB58">Горчичный (Mustard) - #FFDB58</a></li>',
  '<li style="background-color:#FD7C6E"><a class="select" style="color:#000;" href="#FD7C6E">Горько-сладкий - #FD7C6E</a></li>',
  '<li style="background-color:#F34723"><a class="select" style="color:#000;" href="#F34723">Гранатовый (Pomegranate) - #F34723</a></li>',
  '<li style="background-color:#2F353B"><a class="select" style="color:#fff;" href="#2F353B">Гранитный (Granite) - #2F353B</a></li>',
  '<li style="background-color:#1C1C1C"><a class="select" style="color:#fff;" href="#1C1C1C">Графитно-черный (Graphite Black) - #1C1C1C</a></li>',
  '<li style="background-color:#474A51"><a class="select" style="color:#fff;" href="#474A51">Графитовый серый (Graphite Grey) - #474A51</a></li>',
  '<li style="background-color:#C7D0CC"><a class="select" style="color:#000;" href="#C7D0CC">Гридеперлевый - #C7D0CC</a></li>',
  '<li style="background-color:#D71868"><a class="select" style="color:#000;" href="#D71868">Грузинский розовый (Dogwood Rose) - #D71868</a></li>',
  '<li style="background-color:#D1E231"><a class="select" style="color:#000;" href="#D1E231">Грушево-зеленый - #D1E231</a></li>',
  '<li style="background-color:#EFD334"><a class="select" style="color:#000;" href="#EFD334">Грушевый (Pear) - #EFD334</a></li>',
  '<li style="background-color:#E49B0F"><a class="select" style="color:#000;" href="#E49B0F">Гуммигут (Gamboge) - #E49B0F</a></li>',
  '<li style="background-color:#B2EC5D"><a class="select" style="color:#000;" href="#B2EC5D">Гусеница (Inchworm) - #B2EC5D</a></li>',
  '<li style="background-color:#00693E"><a class="select" style="color:#fff;" href="#00693E">Дартмутский зеленый (Dartmouth Green) - #00693E</a></li>',
  '<li style="background-color:#CA3767"><a class="select" style="color:#fff;" href="#CA3767">Джазовый джем (Jazz Jam) - #CA3767</a></li>,'
      '<li style="background-color:#1560BD"><a class="select" style="color:#fff;" href="#1560BD">Джинсовый синий (Denim) - #1560BD</a></li>',
  '<li style="background-color:#FF43A4"><a class="select" style="color:#000;" href="#FF43A4">Дикая клубника (Wild Strawberry) - #FF43A4</a></li>',
  '<li style="background-color:#FC6C85"><a class="select" style="color:#000;" href="#FC6C85">Дикий арбуз (Wild Watermelon, Ultra Red) - #FC6C85</a></li>',
  '<li style="background-color:#A2ADD0"><a class="select" style="color:#000;" href="#A2ADD0">Дикий синий (Wild Blue Yonder) - #A2ADD0</a></li>',
  '<li style="background-color:#85BB65"><a class="select" style="color:#fff;" href="#85BB65">Долларовая банкнота (Dollar Bill) - #85BB65</a></li>',
  '<li style="background-color:#F5F5F5"><a class="select" style="color:#000;" href="#F5F5F5">Дымчато-белый (White Smoke) - #F5F5F5</a></li>',
  '<li style="background-color:#F4A900"><a class="select" style="color:#000;" href="#F4A900">Дынно-желтый (Melon Yellow) - #F4A900</a></li>',
  '<li style="background-color:#F9F8BB"><a class="select" style="color:#000;" href="#F9F8BB">Дыня (Melon) - #F9F8BB</a></li>',
  '<li style="background-color:#0A5F38"><a class="select" style="color:#fff;" href="#0A5F38">Еловый - #0A5F38</a></li>',
  '<li style="background-color:#FFC1CC"><a class="select" style="color:#000;" href="#FFC1CC">Жевательная резинка (Bubble Gum) - #FFC1CC</a></li>',
  '<li style="background-color:#434B4D"><a class="select" style="color:#fff;" href="#434B4D">Железно-серый (Iron Grey) - #434B4D</a></li>',
  '<li style="background-color:#EDFF21"><a class="select" style="color:#000;" href="#EDFF21">Желтая сера (Yellow Sulfur) - #EDFF21</a></li>',
  '<li style="background-color:#E1CC4F"><a class="select" style="color:#000;" href="#E1CC4F">Желтая слоновая кость (Yellow Ivory) - #E1CC4F</a></li>',
  '<li style="background-color:#9ACD32"><a class="select" style="color:#000;" href="#9ACD32">Желто-зеленый (Yellow Green) - #9ACD32</a></li>',
  '<li style="background-color:#C5E384"><a class="select" style="color:#000;" href="#C5E384">Желто-зеленый Крайола - #C5E384</a></li>',
  '<li style="background-color:#CDA434"><a class="select" style="color:#fff;" href="#CDA434">Желто-золотой (Yellow Gold) - #CDA434</a></li>',
  '<li style="background-color:#47402E"><a class="select" style="color:#fff;" href="#47402E">Желто-оливковый (Yellow Olive) - #47402E</a></li>',
  '<li style="background-color:#ED760E"><a class="select" style="color:#fff;" href="#ED760E">Желто-оранжевый (Yellow Orange) - #ED760E</a></li>',
  '<li style="background-color:#FFAE42"><a class="select" style="color:#000;" href="#FFAE42">Желто-оранжевый Крайола - #FFAE42</a></li>',
  '<li style="background-color:#FADFAD"><a class="select" style="color:#000;" href="#FADFAD">Желто-персиковый (Peach Yellow) - #FADFAD</a></li>',
  '<li style="background-color:#FFE4B2"><a class="select" style="color:#000;" href="#FFE4B2">Желто-розовый (Yellow Pink) - #FFE4B2</a></li>',
  '<li style="background-color:#8F8B66"><a class="select" style="color:#fff;" href="#8F8B66">Желто-серый (Yellow Gray) - #8F8B66</a></li>',
  '<li style="background-color:#FFE2B7"><a class="select" style="color:#000;" href="#FFE2B7">Желтовато-белый - #FFE2B7</a></li>',
  '<li style="background-color:#CAA885"><a class="select" style="color:#000;" href="#CAA885">Желтовато-серый - #CAA885</a></li>',
  '<li style="background-color:#FFFF00"><a class="select" style="color:#000;" href="#FFFF00">Желтый (Yellow) - #FFFF00</a></li>',
  '<li style="background-color:#9D9101"><a class="select" style="color:#fff;" href="#9D9101">Желтый карри (Yellow Curry) - #9D9101</a></li>',
  '<li style="background-color:#FCE883"><a class="select" style="color:#000;" href="#FCE883">Желтый Крайола - #FCE883</a></li>',
  '<li style="background-color:#D6AE01"><a class="select" style="color:#000;" href="#D6AE01">Желтый ракитник (Yellow Broom) - #D6AE01</a></li>',
  '<li style="background-color:#EAE6CA"><a class="select" style="color:#000;" href="#EAE6CA">Жемчужно-белый - #EAE6CA</a></li>',
  '<li style="background-color:#CC5500"><a class="select" style="color:#fff;" href="#CC5500">Жженый апельсин, Выгоревший оранжевый (Burnt Orange) - #CC5500</a></li>',
  '<li style="background-color:#CB6586"><a class="select" style="color:#fff;" href="#CB6586">Жимолость (Honeysuckle) - #CB6586</a></li>',
  '<li style="background-color:#1E90FF"><a class="select" style="color:#fff;" href="#1E90FF">Защитно-синий (Dodger Blue) - #1E90FF</a></li>',
  '<li style="background-color:#78866B"><a class="select" style="color:#fff;" href="#78866B">Защитный хаки, Камуфляжный (Camouflage Green) - #78866B</a></li>',
  '<li style="background-color:#FF47CA"><a class="select" style="color:#000;" href="#FF47CA">Звезды в шоке (Stars in Shock) - #FF47CA</a></li>',
  '<li style="background-color:#7CFC00"><a class="select" style="color:#000;" href="#7CFC00">Зеленая лужайка (Lawn Green) - #7CFC00</a></li>',
  '<li style="background-color:#01796F"><a class="select" style="color:#fff;" href="#01796F">Зеленая сосна (Pine Green) - #01796F</a></li>',
  '<li style="background-color:#158078"><a class="select" style="color:#fff;" href="#158078">Зеленая сосна Крайола - #158078</a></li>',
  '<li style="background-color:#BEBD7F"><a class="select" style="color:#000;" href="#BEBD7F">Зелено-бежевый (Pine Glade) - #BEBD7F</a></li>',
  '<li style="background-color:#ADFF2F"><a class="select" style="color:#000;" href="#ADFF2F">Зелено-желтый (Green Yellow) - #ADFF2F</a></li>',
  '<li style="background-color:#F0E891"><a class="select" style="color:#000;" href="#F0E891">Зелено-желтый Крайола - #F0E891</a></li>',
  '<li style="background-color:#826C34"><a class="select" style="color:#fff;" href="#826C34">Зелено-коричневый - #826C34</a></li>',
  '<li style="background-color:#BFFF00"><a class="select" style="color:#000;" href="#BFFF00">Зелено-лаймовый (Lemon Lime) - #BFFF00</a></li>',
  '<li style="background-color:#4D5645"><a class="select" style="color:#fff;" href="#4D5645">Зелено-серый - #4D5645</a></li>',
  '<li style="background-color:#1F3438"><a class="select" style="color:#fff;" href="#1F3438">Зелено-синий - #1F3438</a></li>',
  '<li style="background-color:#1164B4"><a class="select" style="color:#fff;" href="#1164B4">Зелено-синий Крайола - #1164B4</a></li>',
  '<li style="background-color:#F5E6CB"><a class="select" style="color:#000;" href="#F5E6CB">Зеленовато-белый - #F5E6CB</a></li>',
  '<li style="background-color:#7A7666"><a class="select" style="color:#fff;" href="#7A7666">Зеленовато-серый - #7A7666</a></li>',
  '<li style="background-color:#181513"><a class="select" style="color:#fff;" href="#181513">Зеленовато-черный - #181513</a></li>',
  '<li style="background-color:#4E5452"><a class="select" style="color:#fff;" href="#4E5452">Зеленоватый мокрый асфальт - #4E5452</a></li>',
  '<li style="background-color:#2E8B57"><a class="select" style="color:#fff;" href="#2E8B57">Зеленое море (Sea Green) - #2E8B57</a></li>',
  '<li style="background-color:#98FF98"><a class="select" style="color:#000;" href="#98FF98">Зеленой мяты (Mint Green) - #98FF98</a></li>',
  '<li style="background-color:#3BB08F"><a class="select" style="color:#fff;" href="#3BB08F">Зеленые джунгли - #3BB08F</a></li>',
  '<li style="background-color:#29AB87"><a class="select" style="color:#fff;" href="#29AB87">Зеленые джунгли 90-го года (Jungle Green) - #29AB87</a></li>',
  '<li style="background-color:#008000"><a class="select" style="color:#fff;" href="#008000">Зеленый (Green) - #008000</a></li>',
  '<li style="background-color:#1CAC78"><a class="select" style="color:#fff;" href="#1CAC78">Зеленый Крайола - #1CAC78</a></li>',
  '<li style="background-color:#ADDFAD"><a class="select" style="color:#000;" href="#ADDFAD">Зеленый лишайник, Мох (Moss Green) - #ADDFAD</a></li>',
  '<li style="background-color:#006633"><a class="select" style="color:#fff;" href="#006633">Зеленый Мичиганского университета (University of Michigan) - #006633</a></li>',
  '<li style="background-color:#2F4538"><a class="select" style="color:#fff;" href="#2F4538">Зеленый мох - #2F4538</a></li>',
  '<li style="background-color:#004953"><a class="select" style="color:#fff;" href="#004953"Зеленый орел (Midnight Green) - #004953</a></li>',
  '<li style="background-color:#4F7942"><a class="select" style="color:#fff;" href="#4F7942">Зеленый папоротник (Fern Green) - #4F7942</a></li>',
  '<li style="background-color:#009A63"><a class="select" style="color:#fff;" href="#009A63">Зеленый трилистник - #009A63</a></li>',
  '<li style="background-color:#D0F0C0"><a class="select" style="color:#000;" href="#D0F0C0">Зеленый чай (Tea Green) - #D0F0C0</a></li>',
  '<li style="background-color:#FCD975"><a class="select" style="color:#000;" href="#FCD975">Золотарник (Goldenrod) - #FCD975</a></li>',
  '<li style="background-color:#DAA520"><a class="select" style="color:#000;" href="#DAA520">Золотисто-березовый - #DAA520</a></li>',
  '<li style="background-color:#712F26"><a class="select" style="color:#fff;" href="#712F26">Золотисто-каштановый - #712F26</a></li>',
  '<li style="background-color:#FFD700"><a class="select" style="color:#000;" href="#FFD700">Золотой, Золотистый (Gold) - #FFD700</a></li>',
  '<li style="background-color:#E7C697"><a class="select" style="color:#000;" href="#E7C697">Золотой Крайола - #E7C697</a></li>',
  '<li style="background-color:#321414"><a class="select" style="color:#fff;" href="#321414">Ивово-коричневый (Seal Brown) - #321414</a></li>',
  '<li style="background-color:#79443B"><a class="select" style="color:#fff;" href="#79443B">Известковая глина (Bole, Marl) - #79443B</a></li>',
  '<li style="background-color:#009B77"><a class="select" style="color:#fff;" href="#009B77">Изумруд - #009B77</a></li>',
  '<li style="background-color:#287233"><a class="select" style="color:#fff;" href="#287233">Изумрудно-зеленый - #287233</a></li>',
  '<li style="background-color:#50C878"><a class="select" style="color:#fff;" href="#50C878">Изумрудный (Emerald) - #50C878</a></li>',
  '<li style="background-color:#4B0082"><a class="select" style="color:#fff;" href="#4B0082">Индиго (Indigo) - #4B0082</a></li>',
  '<li style="background-color:#5D76CB"><a class="select" style="color:#fff;" href="#5D76CB">Индиго Крайола - #5D76CB</a></li>',
  '<li style="background-color:#138808"><a class="select" style="color:#fff;" href="#138808">Индийский зеленый (India Green) - #138808</a></li>',
  '<li style="background-color:#CD5C5C"><a class="select" style="color:#fff;" href="#CD5C5C">Индийский красный, Каштановый (Indian Red, Chestnut) - #CD5C5C</a></li>',
  '<li style="background-color:#4CBB17"><a class="select" style="color:#fff;" href="#4CBB17">Ирландский зеленый (Kelly Green) - #4CBB17</a></li>',
  '<li style="background-color:#BDDA57"><a class="select" style="color:#000;" href="#BDDA57">Июньский бутон (June Bud) - #BDDA57</a></li>',
  '<li style="background-color:#536872"><a class="select" style="color:#fff;" href="#536872">Кадетский (Cadet) - #536872</a></li>',
  '<li style="background-color:#5F9EA0"><a class="select" style="color:#fff;" href="#5F9EA0">Кадетский синий (Cadet Blue) - #5F9EA0</a></li>',
  '<li style="background-color:#B0B7C6"><a class="select" style="color:#fff;" href="#B0B7C6">Кадетский синий Крайола - #B0B7C6</a></li>,'
      '<li style="background-color:#A25F2A"><a class="select" style="color:#fff;" href="#A25F2A">Камелопардовый (Dark Orange) - #A25F2A</a></li>',
  '<li style="background-color:#8B8C7A"><a class="select" style="color:#fff;" href="#8B8C7A">Каменно-серый (Stone Grey) - #8B8C7A</a></li>',
  '<li style="background-color:#FFFF99"><a class="select" style="color:#000;" href="#FFFF99">Канареечный (Canary) - #FFFF99</a></li>',
  '<li style="background-color:#1B5583"><a class="select" style="color:#fff;" href="#1B5583">Капри синий (Capri Blue) - #1B5583</a></li>',
  '<li style="background-color:#E4717A"><a class="select" style="color:#fff;" href="#E4717A">Карамельно-розовый (Candy Pink) - #E4717A</a></li>',
  '<li style="background-color:#AF6F09"><a class="select" style="color:#fff;" href="#AF6F09">Карамельный блонд (Caramel) - #AF6F09</a></li>',
  '<li style="background-color:#C41E3A"><a class="select" style="color:#fff;" href="#C41E3A">Кардинал (Cardinal) - #C41E3A</a></li>',
  '<li style="background-color:#1CD3A2"><a class="select" style="color:#000;" href="#1CD3A2">Карибский зеленый (Caribbean Green) - #1CD3A2</a></li>',
  '<li style="background-color:#960018"><a class="select" style="color:#fff;" href="#960018">Кармин (Carmine) - #960018</a></li>',
  '<li style="background-color:#A2231D"><a class="select" style="color:#fff;" href="#A2231D">Карминно-красный (Poppy Red) - #A2231D</a></li>',
  '<li style="background-color:#EB4C42"><a class="select" style="color:#fff;" href="#EB4C42">Карминно-розовый (Carmine Pink) - #EB4C42</a></li>',
  '<li style="background-color:#FF0033"><a class="select" style="color:#fff;" href="#FF0033">Карминово-красный - #FF0033</a></li>',
  '<li style="background-color:#1E213D"><a class="select" style="color:#fff;" href="#1E213D">Кобальтово-синий (Cobalt) - #1E213D</a></li>',
  '<li style="background-color:#503D33"><a class="select" style="color:#fff;" href="#503D33">Коричневато-серый - #503D33</a></li>',
  '<li style="background-color:#140F0B"><a class="select" style="color:#fff;" href="#140F0B">Коричневато-черный - #140F0B</a></li>',
  '<li style="background-color:#464531"><a class="select" style="color:#fff;" href="#464531">Коричневый серый - #464531</a></li>',
  '<li style="background-color:#4169E1"><a class="select" style="color:#fff;" href="#4169E1">Королевский синий (Royal Blue) - #4169E1</a></li>',
  '<li style="background-color:#8B6C62"><a class="select" style="color:#fff;" href="#8B6C62">Красновато-серый - #8B6C62</a></li>',
  '<li style="background-color:#007BA7"><a class="select" style="color:#fff;" href="#007BA7">Лазурно-серый (Cerulean) - #007BA7</a></li>',
  '<li style="background-color:#025669"><a class="select" style="color:#fff;" href="#025669">Лазурно-синий (Azure Blue) - #025669</a></li>',
  '<li style="background-color:#646B63"><a class="select" style="color:#fff;" href="#646B63">Мышино-серый (Mouse Grey) - #646B63</a></li>',
  '<li style="background-color:#00677E"><a class="select" style="color:#fff;" href="#00677E">Насыщенный зеленовато-синий - #00677E</a></li>',
  '<li style="background-color:#474389"><a class="select" style="color:#fff;" href="#474389">Насыщенный пурпурно-синий - #474389</a></li>',
  '<li style="background-color:#006D5B"><a class="select" style="color:#fff;" href="#006D5B">Насыщенный синевато-зеленый - #006D5B</a></li>',
  '<li style="background-color:#00538A"><a class="select" style="color:#fff;" href="#00538A">Насыщенный синий - #00538A</a></li>',
  '<li style="background-color:#2271B3"><a class="select" style="color:#fff;" href="#2271B3">Небесно-синий - #2271B3</a></li>',
  '<li style="background-color:#252850"><a class="select" style="color:#fff;" href="#252850">Ночной синий (Night Blue) - #252850</a></li>',
  '<li style="background-color:#4D4234"><a class="select" style="color:#fff;" href="#4D4234">Оливковый серый (Olive Grey) - #4D4234</a></li>',
  '<li style="background-color:#49678D"><a class="select" style="color:#fff;" href="#49678D">Отдаленно-синий (Remotely Blue) - #49678D</a></li>',
  '<li style="background-color:#CBBAC5"><a class="select" style="color:#000;" href="#CBBAC5">Очень бледный пурпурно-синий - #CBBAC5</a></li>',
  '<li style="background-color:#C1CACA"><a class="select" style="color:#000;" href="#C1CACA">Очень бледный синий - #C1CACA</a></li>',
  '<li style="background-color:#A3C6C0"><a class="select" style="color:#000;" href="#A3C6C0">Очень светлый зеленовато-синий - #A3C6C0</a></li>',
  '<li style="background-color:#BAACC7"><a class="select" style="color:#000;" href="#BAACC7">Очень светлый пурпурно-синий - #BAACC7</a></li>',
  '<li style="background-color:#A0D6B4"><a class="select" style="color:#000;" href="#A0D6B4">Очень светлый синевато-зеленый - #A0D6B4</a></li>',
  '<li style="background-color:#A6BDD7"><a class="select" style="color:#000;" href="#A6BDD7">Очень светлый синий - #A6BDD7</a></li>',
  '<li style="background-color:#022027"><a class="select" style="color:#fff;" href="#022027">Очень темный зеленовато-синий - #022027</a></li>',
  '<li style="background-color:#5D9B9B"><a class="select" style="color:#fff;" href="#5D9B9B">Пастельно-синий (Pastel Blue) - #5D9B9B</a></li>',
  '<li style="background-color:#2A6478"><a class="select" style="color:#fff;" href="#2A6478">Перламутровый горечавково-синий - #2A6478</a></li>',
  '<li style="background-color:#9C9C9C"><a class="select" style="color:#fff;" href="#9C9C9C">Перламутровый светло-серый - #9C9C9C</a></li>',
  '<li style="background-color:#828282"><a class="select" style="color:#fff;" href="#828282">Перламутровый темно-серый - #828282</a></li>',
  '<li style="background-color:#6600FF"><a class="select" style="color:#fff;" href="#6600FF">Персидский синий (Persian Blue) - #6600FF</a></li>',
  '<li style="background-color:#7F7679"><a class="select" style="color:#fff;" href="#7F7679">Платиново-серый (Platinum Grey) - #7F7679</a></li>',
  '<li style="background-color:#8A795D"><a class="select" style="color:#fff;" href="#8A795D">Полумрак (Twilight, Shadow) - #8A795D</a></li>',
  '<li style="background-color:#003366"><a class="select" style="color:#fff;" href="#003366">Полуночно-синий (Dark Midnight Blue) - #003366</a></li>',
  '<li style="background-color:#88706B"><a class="select" style="color:#fff;" href="#88706B">Пурпурно-серый (Purple Gray) - #88706B</a></li>',
  '<li style="background-color:#20155E"><a class="select" style="color:#fff;" href="#20155E">Пурпурно-синий (Purple Blue) - #20155E</a></li>',
  '<li style="background-color:#7D7F7D"><a class="select" style="color:#fff;" href="#7D7F7D">Пыльно-серый (Nerolac Rockslide) - #7D7F7D</a></li>',
  '<li style="background-color:#C8A696"><a class="select" style="color:#fff;" href="#C8A696">Розовато-серый - #C8A696</a></li>',
  '<li style="background-color:#905D5D"><a class="select" style="color:#fff;" href="#905D5D">Розово-серо-коричневый (Rose Taupe) - #905D5D</a></li>',
  '<li style="background-color:#1D1E33"><a class="select" style="color:#fff;" href="#1D1E33">Сапфирово-синий (Sapphire Blue) - #1D1E33</a></li>',
  '<li style="background-color:#BBBBBB"><a class="select" style="color:#000;" href="#BBBBBB">Светло-серый (Light Grey) - #BBBBBB</a></li>',
  '<li style="background-color:#A6CAF0"><a class="select" style="color:#000;" href="#A6CAF0">Светло-синий (Light Blue) - #A6CAF0</a></li>',
  '<li style="background-color:#649A9E"><a class="select" style="color:#fff;" href="#649A9E">Светлый зеленовато-синий - #649A9E</a></li>',
  '<li style="background-color:#E66761"><a class="select" style="color:#fff;" href="#E66761">Светлый карминово-розовый - #E66761</a></li>',
  '<li style="background-color:#8B6D5C"><a class="select" style="color:#fff;" href="#8B6D5C">Светлый коричневато-серый - #8B6D5C</a></li>',
  '<li style="background-color:#A86540"><a class="select" style="color:#fff;" href="#A86540">Светлый коричневый - #A86540</a></li>',
  '<li style="background-color:#AA6651"><a class="select" style="color:#fff;" href="#AA6651">Светлый красно-коричневый - #AA6651</a></li>',
  '<li style="background-color:#887359"><a class="select" style="color:#fff;" href="#887359">Светлый оливковый серый - #887359</a></li>',
  '<li style="background-color:#C8A99E"><a class="select" style="color:#000;" href="#C8A99E">Светлый пурпурно-серый - #C8A99E</a></li>',
  '<li style="background-color:#837DA2"><a class="select" style="color:#fff;" href="#837DA2">Светлый пурпурно-синий - #837DA2</a></li>',
  '<li style="background-color:#B48764"><a class="select" style="color:#fff;" href="#B48764">Светлый серо-желто-коричневый - #B48764</a></li>',
  '<li style="background-color:#946B54"><a class="select" style="color:#fff;" href="#946B54">Светлый серо-коричневый - #946B54</a></li>',
  '<li style="background-color:#966A57"><a class="select" style="color:#fff;" href="#966A57">Светлый серо-красно-коричневый - #966A57</a></li>',
  '<li style="background-color:#B17267"><a class="select" style="color:#fff;" href="#B17267">Светлый серо-красный - #B17267</a></li>',
  '<li style="background-color:#8B734B"><a class="select" style="color:#fff;" href="#8B734B">Светлый серо-оливковый - #8B734B</a></li>',
  '<li style="background-color:#B27070"><a class="select" style="color:#fff;" href="#B27070">Светлый серо-пурпурно-красный - #B27070</a></li>',
  '<li style="background-color:#84C3BE"><a class="select" style="color:#fff;" href="#84C3BE">Светлый серо-синий - #84C3BE</a></li>',
  '<li style="background-color:#D7D7D7"><a class="select" style="color:#000;" href="#D7D7D7">Светлый серый - #D7D7D7</a></li>',
  '<li style="background-color:#6C92AF"><a class="select" style="color:#fff;" href="#6C92AF">Светлый сине-серый - #6C92AF</a></li>',
  '<li style="background-color:#669E85"><a class="select" style="color:#fff;" href="#669E85">Светлый синевато-зеленый - #669E85</a></li>',
  '<li style="background-color:#BEADA1"><a class="select" style="color:#000;" href="#BEADA1">Светлый синевато-серый - #BEADA1</a></li>',
  '<li style="background-color:#ADD8E6"><a class="select" style="color:#000;" href="#ADD8E6">Светлый синий - #ADD8E6</a></li>',
  '<li style="background-color:#B0C4DE"><a class="select" style="color:#000;" href="#B0C4DE">Светлый стальной синий - #B0C4DE</a></li>',
  '<li style="background-color:#78858B"><a class="select" style="color:#fff;" href="#78858B">Серая белка (Gray Squirrel) - #78858B</a></li>',
  '<li style="background-color:#465945"><a class="select" style="color:#fff;" href="#465945">Серая спаржа (Grey Asparagus) - #465945</a></li>',
  '<li style="background-color:#8A9597"><a class="select" style="color:#fff;" href="#8A9597">Серебристо-серый (Silver Gray) - #8A9597</a></li>',
  '<li style="background-color:#9E9764"><a class="select" style="color:#fff;" href="#9E9764">Серо-бежевый (Grey Beige) - #9E9764</a></li>',
  '<li style="background-color:#735184"><a class="select" style="color:#fff;" href="#735184">Серобуромалиновый - #735184</a></li>',
  '<li style="background-color:#90845B"><a class="select" style="color:#fff;" href="#90845B">Серовато-желто-зеленый - #90845B</a></li>',
  '<li style="background-color:#785840"><a class="select" style="color:#fff;" href="#785840">Серовато-желто-коричневый - #785840</a></li>',
  '<li style="background-color:#D39B85"><a class="select" style="color:#fff;" href="#D39B85">Серовато-желто-розовый - #D39B85</a></li>',
  '<li style="background-color:#CEA262"><a class="select" style="color:#fff;" href="#CEA262">Серовато-желтый - #CEA262</a></li>',
  '<li style="background-color:#C4A55F"><a class="select" style="color:#fff;" href="#C4A55F">Серовато-зеленовато-желтый - #C4A55F</a></li>',
  '<li style="background-color:#575E4E"><a class="select" style="color:#fff;" href="#575E4E">Серовато-зеленый - #575E4E</a></li>',
  '<li style="background-color:#5A3D30"><a class="select" style="color:#fff;" href="#5A3D30">Серовато-коричневый - #5A3D30</a></li>',
  '<li style="background-color:#5E3830"><a class="select" style="color:#fff;" href="#5E3830">Серовато-красно-коричневый - #5E3830</a></li>',
  '<li style="background-color:#B85D43"><a class="select" style="color:#fff;" href="#B85D43">Серовато-красно-оранжевый - #B85D43</a></li>',
  '<li style="background-color:#7D4D5D"><a class="select" style="color:#fff;" href="#7D4D5D">Серовато-красно-пурпурный - #7D4D5D</a></li>',
  '<li style="background-color:#8C4743"><a class="select" style="color:#fff;" href="#8C4743">Серовато-красный - #8C4743</a></li>',
  '<li style="background-color:#52442C"><a class="select" style="color:#fff;" href="#52442C">Серовато-оливковый - #52442C</a></li>',
  '<li style="background-color:#C2A894"><a class="select" style="color:#fff;" href="#C2A894">Серовато-оранжевый - #C2A894</a></li>',
  '<li style="background-color:#8C4852"><a class="select" style="color:#fff;" href="#8C4852">Серовато-пурпурно-красный - #8C4852</a></li>',
  '<li style="background-color:#CC9293"><a class="select" style="color:#fff;" href="#CC9293">Серовато-пурпурно-розовый - #CC9293</a></li>',
  '<li style="background-color:#413D51"><a class="select" style="color:#fff;" href="#413D51">Серовато-пурпурно-синий - #413D51</a></li>',
  '<li style="background-color:#72525C"><a class="select" style="color:#fff;" href="#72525C">Серовато-пурпурный - #72525C</a></li>',
  '<li style="background-color:#CF9B8F"><a class="select" style="color:#fff;" href="#CF9B8F">Серовато-розовый - #CF9B8F</a></li>',
  '<li style="background-color:#4A545C"><a class="select" style="color:#fff;" href="#4A545C">Серовато-синий - #4A545C</a></li>',
  '<li style="background-color:#9DA1AA"><a class="select" style="color:#fff;" href="#9DA1AA">Серое окно - #9DA1AA</a></li>',
  '<li style="background-color:#808080"><a class="select" style="color:#fff;" href="#808080">Серый (Gray) - #808080</a></li>',
  '<li style="background-color:#686C5E"><a class="select" style="color:#fff;" href="#686C5E">Серый бетон (Grey Concrete) - #686C5E</a></li>',
  '<li style="background-color:#CADABA"><a class="select" style="color:#000;" href="#CADABA">Серый зеленый чай (Grey-Tea Green) - #CADABA</a></li>',
  '<li style="background-color:#403A3A"><a class="select" style="color:#fff;" href="#403A3A">Серый коричневый (Grey Brown) - #403A3A</a></li>',
  '<li style="background-color:#95918C"><a class="select" style="color:#fff;" href="#95918C">Серый Крайола - #95918C</a></li>',
  '<li style="background-color:#6C7059"><a class="select" style="color:#fff;" href="#6C7059">Серый мох (Gray Moss) - #6C7059</a></li>',
  '<li style="background-color:#A0A0A4"><a class="select" style="color:#fff;" href="#A0A0A4">Серый нейтральный (Grey Neutral) - #A0A0A4</a></li>',
  '<li style="background-color:#3E3B32"><a class="select" style="color:#fff;" href="#3E3B32">Серый оливковый (Grey Olive) - #3E3B32</a></li>',
  '<li style="background-color:#26252D"><a class="select" style="color:#fff;" href="#26252D">Серый синий (Grey Blue) - #26252D</a></li>',
  '<li style="background-color:#6A5F31"><a class="select" style="color:#fff;" href="#6A5F31">Серый хаки (Grey Khaki) - #6A5F31</a></li>',
  '<li style="background-color:#CAC4B0"><a class="select" style="color:#000;" href="#CAC4B0">Серый шелк (Grey Silk) - #CAC4B0</a></li>',
  '<li style="background-color:#708090"><a class="select" style="color:#fff;" href="#708090">Серый шифер, Аспидно-серый (Slate Grey) - #708090</a></li>',
  '<li style="background-color:#969992"><a class="select" style="color:#fff;" href="#969992">Сигнальный серый (Signal Grey) - #969992</a></li>',
  '<li style="background-color:#1E2460"><a class="select" style="color:#fff;" href="#1E2460">Сигнальный синий (Signal Blue) - #1E2460</a></li>',
  '<li style="background-color:#1F3A3D"><a class="select" style="color:#fff;" href="#1F3A3D">Сине-зеленый - #1F3A3D</a></li>',
  '<li style="background-color:#0D98BA"><a class="select" style="color:#fff;" href="#0D98BA">Сине-зеленый Крайола (Blue Green) - #0D98BA</a></li>,'
      '<li style="background-color:#8A2BE2"><a class="select" style="color:#fff;" href="#8A2BE2">Сине-лиловый (Blue Violet, Blue Purple) - #8A2BE2</a></li>',
  '<li style="background-color:#6699CC"><a class="select" style="color:#fff;" href="#6699CC">Сине-серый (Blue Gray) - #6699CC</a></li>',
  '<li style="background-color:#6C4675"><a class="select" style="color:#fff;" href="#6C4675">Сине-сиреневый (Blue Lilac) - #6C4675</a></li>',
  '<li style="background-color:#7366BD"><a class="select" style="color:#fff;" href="#7366BD">Сине-фиолетовый - #7366BD</a></li>',
  '<li style="background-color:#F9DFCF"><a class="select" style="color:#000;" href="#F9DFCF">Синевато-белый (Bluish White) - #F9DFCF</a></li>',
  '<li style="background-color:#7D746D"><a class="select" style="color:#fff;" href="#7D746D">Синевато-серый (Bluish Gray) - #7D746D</a></li>',
  '<li style="background-color:#151719"><a class="select" style="color:#fff;" href="#151719">Синевато-черный (Bluish Black) - #151719</a></li>',
  '<li style="background-color:#0000FF"><a class="select" style="color:#fff;" href="#0000FF">Синий (Blue) - #0000FF</a></li>',
  '<li style="background-color:#AFDAFC"><a class="select" style="color:#000;" href="#AFDAFC">Синий-синий иней (Blue Frost) - #AFDAFC</a></li>',
  '<li style="background-color:#007DFF"><a class="select" style="color:#fff;" href="#007DFF">Синий Градуса - #007DFF</a></li>',
  '<li style="background-color:#3A75C4"><a class="select" style="color:#fff;" href="#3A75C4">Синий Клейна (Klein Blue) - #3A75C4</a></li>',
  '<li style="background-color:#1F75FE"><a class="select" style="color:#fff;" href="#1F75FE">Синий Крайола - #1F75FE</a></li>',
  '<li style="background-color:#474B4E"><a class="select" style="color:#fff;" href="#474B4E">Синий серый - #474B4E</a></li>',
  '<li style="background-color:#18A7B5"><a class="select" style="color:#fff;" href="#18A7B5">Синий чирок (Blue Teal) - #18A7B5</a></li>',
  '<li style="background-color:#122FAA"><a class="select" style="color:#fff;" href="#122FAA">Синий экран смерти - #122FAA</a></li>',
  '<li style="background-color:#2A52BE"><a class="select" style="color:#fff;" href="#2A52BE">Синяя лазурь, Лазурно-голубо (Cerulean Blue) - #2A52BE</a></li>',
  '<li style="background-color:#003399"><a class="select" style="color:#fff;" href="#003399">Синяя пыль (Smalt) - #003399</a></li>',
  '<li style="background-color:#4682B4"><a class="select" style="color:#fff;" href="#4682B4">Синяя сталь (Steel Blue) - #4682B4</a></li>',
  '<li style="background-color:#F0F8FF"><a class="select" style="color:#000;" href="#F0F8FF">Синяя Элис (Alice Blue) - #F0F8FF</a></li>',
  '<li style="background-color:#C8A2C8"><a class="select" style="color:#fff;" href="#C8A2C8">Сиреневый (Lilac) - #C8A2C8</a></li>',
  '<li style="background-color:#B565A7"><a class="select" style="color:#fff;" href="#B565A7">Сияющая орхидея (Shining Orchid) - #B565A7</a></li>',
  '<li style="background-color:#ACE5EE"><a class="select" style="color:#000;" href="#ACE5EE">Снежно-синий (Blizzard Blue) - #ACE5EE</a></li>',
  '<li style="background-color:#817066"><a class="select" style="color:#fff;" href="#817066">Средний серый (Medium Grey) - #817066</a></li>',
  '<li style="background-color:#231A24"><a class="select" style="color:#fff;" href="#231A24">Стальной синий - #231A24</a></li>',
  '<li style="background-color:#C08081"><a class="select" style="color:#fff;" href="#C08081">Старинный розовый (Old Rose) - #C08081</a></li>',
  '<li style="background-color:#CFB53B"><a class="select" style="color:#fff;" href="#CFB53B">Старое золото (Old Gold) - #CFB53B</a></li>',
  '<li style="background-color:#FDF5E6"><a class="select" style="color:#000;" href="#FDF5E6">Старое кружево (Old Lace) - #FDF5E6</a></li>',
  '<li style="background-color:#EEDC82"><a class="select" style="color:#000;" href="#EEDC82">Старый лен (Flax) - #EEDC82</a></li>',
  '<li style="background-color:#483C32"><a class="select" style="color:#fff;" href="#483C32">Темно-серо-коричневый (Taupe) - #483C32</a></li>',
  '<li style="background-color:#49423D"><a class="select" style="color:#fff;" href="#49423D">Темно-серый (Dark Grey) - #49423D</a></li>',
  '<li style="background-color:#002137"><a class="select" style="color:#fff;" href="#002137">Темно-синий (Dark Blue) - #002137</a></li>',
  '<li style="background-color:#1974D2"><a class="select" style="color:#fff;" href="#1974D2">Темно-синий Крайола - #1974D2</a></li>',
  '<li style="background-color:#483D8B"><a class="select" style="color:#fff;" href="#483D8B">Темный аспидно-синий - #483D8B</a></li>',
  '<li style="background-color:#45433B"><a class="select" style="color:#fff;" href="#45433B">Темный зеленовато-серый - #45433B</a></li>',
  '<li style="background-color:#003841"><a class="select" style="color:#fff;" href="#003841">Темный зеленовато-синий - #003841</a></li>',
  '<li style="background-color:#523C36"><a class="select" style="color:#fff;" href="#523C36">Темный красно-серый - #523C36</a></li>',
  '<li style="background-color:#564042"><a class="select" style="color:#fff;" href="#564042">Темный пурпурно-серый - #564042</a></li>',
  '<li style="background-color:#1A162A"><a class="select" style="color:#fff;" href="#1A162A">Темный пурпурно-синий - #1A162A</a></li>',
  '<li style="background-color:#660099"><a class="select" style="color:#fff;" href="#660099">Темный пурпурно-фиолетовый - #660099</a></li>',
  '<li style="background-color:#A47C45"><a class="select" style="color:#fff;" href="#A47C45">Темный серо-желтый - #A47C45</a></li>',
  '<li style="background-color:#32221A"><a class="select" style="color:#fff;" href="#32221A">Темный серо-коричневый - #32221A</a></li>',
  '<li style="background-color:#371F1C"><a class="select" style="color:#fff;" href="#371F1C">Темный серо-красно-коричневый - #371F1C</a></li>',
  '<li style="background-color:#482A2A"><a class="select" style="color:#fff;" href="#482A2A">Темный серо-красный - #482A2A</a></li>',
  '<li style="background-color:#27261A"><a class="select" style="color:#fff;" href="#27261A">Темный серо-оливково-зеленый - #27261A</a></li>',
  '<li style="background-color:#2B2517"><a class="select" style="color:#fff;" href="#2B2517">Темный серо-оливковый - #2B2517</a></li>',
  '<li style="background-color:#2C3337"><a class="select" style="color:#fff;" href="#2C3337">Темный серо-синий - #2C3337</a></li>',
  '<li style="background-color:#013A33"><a class="select" style="color:#fff;" href="#013A33">Темный синевато-зеленый - #013A33</a></li>',
  '<li style="background-color:#464544"><a class="select" style="color:#fff;" href="#464544">Темный синевато-черный - #464544</a></li>',
  '<li style="background-color:#8D948D"><a class="select" style="color:#fff;" href="#8D948D">Транспортный серый (Transport Gray) - #8D948D</a></li>',
  '<li style="background-color:#063971"><a class="select" style="color:#fff;" href="#063971">Транспортный синий (Transport Blue) - #063971</a></li>',
  '<li style="background-color:#696969"><a class="select" style="color:#fff;" href="#696969">Тусклый серый - #696969</a></li>',
  '<li style="background-color:#30626B"><a class="select" style="color:#fff;" href="#30626B">Умеренный зеленовато-синий - #30626B</a></li>',
  '<li style="background-color:#423C63"><a class="select" style="color:#fff;" href="#423C63">Умеренный пурпурно-синий - #423C63</a></li>',
  '<li style="background-color:#EE9086"><a class="select" style="color:#000;" href="#EE9086">Умеренный розовый (Medium Pink) - #EE9086</a></li>',
  '<li style="background-color:#674C47"><a class="select" style="color:#fff;" href="#674C47">Умеренный серо-коричневый - #674C47</a></li>',
  '<li style="background-color:#2F6556"><a class="select" style="color:#fff;" href="#2F6556">Умеренный синевато-зеленый - #2F6556</a></li>',
  '<li style="background-color:#395778"><a class="select" style="color:#fff;" href="#395778">Умеренный синий - #395778</a></li>',
  '<li style="background-color:#161A1E"><a class="select" style="color:#fff;" href="#161A1E">Черновато-синий - #161A1E</a></li>',
  '<li style="background-color:#007CAD"><a class="select" style="color:#fff;" href="#007CAD">Ярко-синий (Bright Blue) - #007CAD</a></li>',
];

  

// void main() {
  

//   String searchText = "синий";

//   for (String item in array) {
//     if (item.contains(searchText)) {
//       RegExp colorRegex = RegExp(r'#([A-Fa-f0-9]{6})');
//       RegExpMatch match = colorRegex.firstMatch(item);
//       String colorValue = match.group(0)!;
//       print("Значение: $colorValue");

//       RegExp nameRegex = RegExp(r'(?<=\()-.*?(?=\))');
//       RegExpMatch nameMatch = nameRegex.firstMatch(item);
//       String colorName = nameMatch!.group(0)!;
//       print("Цвет: $colorName");
//       break;
//     }
//   }
// }