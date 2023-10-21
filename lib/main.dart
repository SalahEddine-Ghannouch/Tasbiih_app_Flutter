import 'package:flutter/material.dart';
import 'package:flutter_islamic_icons/flutter_islamic_icons.dart';
import 'package:flutter_share/flutter_share.dart';
void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Tasbiih - تسبيح',
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: const PrayerCounter(),
    );
  }
}


class GradientAppBar extends StatelessWidget implements PreferredSizeWidget {
  final double preferredHeight = 70.0;

  const GradientAppBar({super.key});

  @override
  Widget build(BuildContext context) {
  return Container(
    alignment: Alignment.center,
    decoration:  const BoxDecoration(
      gradient: LinearGradient(
        colors: [Color.fromARGB(255, 103, 160, 207), Color.fromRGBO(98, 188, 101, 1)], // Customize the gradient colors
        begin: Alignment.topLeft,
        end: Alignment.bottomRight,
      ),
    ),
    child:  Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        const Padding(
          padding: EdgeInsets.only(top: 20,left: 9), // Add your desired padding
          child: Text('تسبيح', textDirection: TextDirection.rtl, style: TextStyle(fontWeight: FontWeight.bold, fontSize: 24,color: Colors.white,fontFamily: AutofillHints.name),),
        ),
         Padding(
          padding: const EdgeInsets.only(top: 20,right: 9), // Add your desired padding
          child: IconButton(onPressed: share, icon: const Icon(FlutterIslamicIcons.tasbih3,size: 30,color: Colors.white,))

        ),
      ],
    ),
  );
}



  @override
  Size get preferredSize => Size.fromHeight(preferredHeight);

  Future<void> share() async {   
    await FlutterShare.share(
      title: 'تطبيق تسبيح',
      text: 'تطبيق تسبيح لعد الأذكار في جميع الأوقات',
      linkUrl: 'https://drive.google.com/uc?export=download&id=1tjJ1FN2Gsq0MnjUoVCpYFJz9LKanGHQV',
      chooserTitle: 'تطبيق تسبيح'
    );
  }
}


class PrayerCounter extends StatefulWidget {
  const PrayerCounter({Key? key}) : super(key: key);

  @override
  _PrayerCounterState createState() => _PrayerCounterState();
}

class _PrayerCounterState extends State<PrayerCounter> {
  int number = 0;

  String get _title {
    if (number < 33) {
      return 'سبحان الله';
    } else if (number < 66) {
      return 'الحمد لله';
    } else if (number < 100) {
      return 'الله أكبر';
    }
    return 'لا إله إلا الله وحده لا شريك له\n له الملك وله الحمد\n وهو على كل شيء قدير';
  }

  Color get _color {
    if (number < 33) {
      return Colors.orange[400]!;
    } else if (number < 66) {
      return const Color.fromARGB(255, 219, 178, 82);
    } else if (number < 100) {
      return Colors.orange[400]!;
    }
    return const Color.fromARGB(255, 219, 178, 82);
  }

  @override
  Widget build(BuildContext context) {
    double progress = number / 100.0;

    return Scaffold(
      appBar: const GradientAppBar(),
      body: Container(
        decoration: BoxDecoration(
          image: DecorationImage(
            image: const AssetImage('assets/image.jpg'), // Background image
            fit: BoxFit.cover,
            colorFilter: ColorFilter.mode(
              Colors.black.withOpacity(0.6),
              BlendMode.dstATop,
            ),
          ),
        ),
        child: Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: <Widget>[
              Text(
                _title,
                textAlign: TextAlign.center,
                style: TextStyle(
                  fontSize: 29,
                  fontWeight: FontWeight.w800,
                  color: _color,
                ),
              ),
              Container(
                margin: const EdgeInsets.symmetric(vertical: 10), // Add margin
                child: Stack(
                  alignment: Alignment.center,
                  children: [
                    SizedBox(
                      width: 190,
                      height: 190,
                      child: CircularProgressIndicator(
                        value: progress,
                        strokeWidth: 10,
                        strokeCap: StrokeCap.round,
                        backgroundColor: Colors.white,
                        valueColor: AlwaysStoppedAnimation<Color>(_color),
                      ),
                    ),
                    Text(
                      number.toString(),
                      style:  TextStyle(
                        fontSize: 50,
                        fontWeight: FontWeight.w600,
                        color: _color,
                      ),
                    ),
                  ],
                ),
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: <Widget>[
                  ElevatedButton(
                    onPressed: () {
                      setState(() {
                        number = 0;
                      });
                    },
                    style: ElevatedButton.styleFrom(
                      primary: Colors.blue.withAlpha(370), // Background color
                      fixedSize: const Size(130, 70), // Set the size
                    ),
                    child: const Column(
                      children: [
                        Icon(Icons.refresh, size: 30),
                        Text('إعادة الضبط', style: TextStyle(fontSize: 18)),
                      ],
                    ),
                  ),
                  ElevatedButton(
                    onPressed: () {
                      setState(() {
                        if (number < 100) {
                          number++;
                        }
                      });
                    },
                    style: ElevatedButton.styleFrom(
                      primary: Colors.green.withAlpha(370), // Background color
                      fixedSize: const Size(130, 70), // Set the size
                    ),
                    child:  Column(
                      children: [
                        const Icon(Icons.add, size: 30),
                        Text(number == 0 ?'بدأ عد':'عد', style: const TextStyle(fontSize: 18)),
                      ],
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
