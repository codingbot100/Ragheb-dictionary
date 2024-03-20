import 'package:flutter/material.dart';
import 'package:hive_flutter/hive_flutter.dart';
import 'package:ragheb_dictionary/Setting/data/fontFamilyDataBase.dart';
import 'package:ragheb_dictionary/Setting/data/sliderData.dart';

class Web_Log_Detail extends StatefulWidget {
  const Web_Log_Detail({super.key});

  @override
  State<Web_Log_Detail> createState() => _Web_Log_DetailState();
}

class _Web_Log_DetailState extends State<Web_Log_Detail> {
  ToDodatabase6 db6 = ToDodatabase6();
  final _meBox = Hive.box('mybox');
  ToDoDataBaseFont DB_fontFamily = ToDoDataBaseFont();

  @override
  void initState() {
    super.initState();
    if (_meBox.get("FontFamily") == null) {
      DB_fontFamily.createInitialData();
    } else {
      DB_fontFamily.loadData();
    }
    if (_meBox.get("TODOSlid") == null) {
      db6.createInitialData();
    } else {
      db6.loadData();
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Color(0xFFF5F5DC),
      body: SafeArea(
          child: Column(
        children: [
          Container(
            height: 250,
            child: Stack(
              children: <Widget>[
                // Background image
                Image.asset(
                  'images2/22.jpg',
                  width: double.infinity,
                  height: double.infinity,
                  fit: BoxFit.cover,
                ),
                // Text overlay
              ],
            ),
          ),
          Expanded(
            child: SingleChildScrollView(
              child: Padding(
                padding: const EdgeInsets.only(top: 15, right: 10, left: 5),
                child: Directionality(
                  textDirection: TextDirection.rtl,
                  child: Column(
                    children: [
                      Text(
                        "اسلام دین سلامتی و رمضان، ماه سلامتی است!",
                        style: TextStyle(
                            fontSize: db6.title_Web,
                            fontWeight: FontWeight.w700),
                      ),
                      Padding(
                        padding: const EdgeInsets.only(left: 10, right: 10),
                        child: Container(
                          child: RichText(
                              textAlign: TextAlign.justify,
                              text: TextSpan(
                                  style: TextStyle(
                                      color: Colors.black,
                                      fontFamily: DB_fontFamily.FontFamily,
                                      fontWeight: FontWeight.w500,
                                      fontSize: db6.main_contant),
                                  text:
                                      """ روزه یکی از احکام اسلام است که با تطبیق آن تحولاتی زیادی پدید می‌آید و برای تمامی مسلمانان و مؤمنین فرصت تقرب بیشتر به الله سبحانه و تعالی را مساعد می‌سازد. طوری‌که در این ماه، مسلمانان نفس و اموال خود را در راه الله سبحانه و تعالی اختصاص می‌دهند. چنان‌چه می‌دانیم با تطبیق این حکم، مسلمانان مال خود را انفاق می‌کنند و به مساکین و فقراء رسیده‌گی می‌کنند. همچنین با تطبیق این حکم محبت و اخوت میان مسلمانان افزایش یافته که جهت ادای نماز تراویح و رفتن به بهترین شهرهای دنیا، مدینه منوره و مکه مکرمه جهت ادای عمره می‌باشد. با تطبیق این حکم، کسانی‌که در طول یک سال نماز‌های خود را قصداً یا سهواً ترک کرده‌اند، به الله سبحانه و تعالی رجوع می‌کنند و طلب مغفرت می‌کنند. روزه به صحت و سلامتی انسان مؤثر است، بدن انسان را از وجود مکروب‌ها تصفیه نموده و مقاومت بدن را بالا می‌برد. همچنین با تطبیق این حکم، انسان‌های عاقل به فکر مرگ و سرای حقیقی خود، که همانا آخرت است، می‌افتند. با تطبیق این حکم، میزان فحشاء و تمایل به ارتکاب منکرات و گناه‌ها نیز بطور فاحش در میان مسلمانان کاهش پیدا می‌کند. این درحالی‌ست که این همه دست‌آوردهای عظیم و نایاب ناشی از تطبیق، تنها یکی از احکام اسلام است.
اما حرف اصلی اینجاست که اگر اسلام با پیام سلامتی خود حاکمیت سیاسی داشته باشد و تمام احکام آن کامل و شامل بالای مسلمانان تطبیق شود، چه تحولاتی بالای مسلمانان و سرزمین مسلمانان رونما خواهد شد؟""")),
                        ),
                      )
                    ],
                  ),
                ),
              ),
            ),
          )
        ],
      )),
    );
  }
}
