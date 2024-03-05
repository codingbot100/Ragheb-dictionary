import 'package:flutter/material.dart';

class message extends StatefulWidget {
  const message({super.key});

  @override
  State<message> createState() => _messageState();
}

class _messageState extends State<message> {
  var fontFamile2 = 'YekanBakh';
  final fontSizeTitle = 20.0;
  double fontSizeSubTitle = 10.0;
  final colorPrimary = Color(0xFF009688);
  final colorBackground = Color.fromRGBO(245, 245, 220, 1);
  final colorPrimary2 = Color(0xFFB0BEC5);
  final colorBackground2 = Color.fromARGB(255, 224, 224, 224);
  var listColor = Color.fromRGBO(0, 150, 136, 1);
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Color(0xFFF5F5DC),
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.all(25.0),
          child: Column(
            children: [
              Container(
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.end,
                  children: [
                    Text(
                      'وبلاگ راغب',
                      style: TextStyle(
                          fontSize: 20,
                          fontFamily: 'Yekan',
                          fontWeight: FontWeight.w700,
                          color: Color.fromRGBO(0, 150, 136, 1)),
                    ),
                  ],
                ),
              ),
              SizedBox(height: 30),
              Padding(
                padding: const EdgeInsets.only(
                  left: 20,
                  right: 20,
                ),
                child: SafeArea(
                  child: SingleChildScrollView(
                    child: Expanded(
                      child: Column(
                        children: [
                          Container(
                            width: double.infinity,
                            height: 600,
                            child: ListView.builder(
                                itemCount: 3,
                                itemBuilder: (context, index) {
                                  return articals();
                                }),
                          )
                        ],
                      ),
                    ),
                  ),
                ),
              )
            ],
          ),
        ),
      ),
    );
  }

  Widget articals() {
    return Padding(
      padding: const EdgeInsets.only(bottom: 30),
      child: GestureDetector(
        child: Container(
          width: 200,
          decoration: BoxDecoration(
              color: Color.fromRGBO(245, 245, 220, 1),
              borderRadius: BorderRadius.circular(12.0),
              boxShadow: [
                BoxShadow(
                    color: Color.fromRGBO(0, 0, 0, 0.08), offset: Offset(2, 2))
              ]),
          height: 350,
          child: Padding(
            padding: const EdgeInsets.only(bottom: 10),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Container(
                    decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(25.0)),
                    width: double.infinity,
                    child: Image.asset('images2/2.jpg')),
                Container(
                  width: 300,
                  child: RichText(
                      textDirection: TextDirection.rtl,
                      textAlign: TextAlign.right,
                      text: TextSpan(
                        text: 'اسلام دین صلح و آرامش ',
                        style: TextStyle(
                          fontFamily: fontFamile2,
                          fontSize: 18,
                          fontWeight: FontWeight.w900,
                          color: Color.fromRGBO(82, 82, 82, 1),
                        ),
                      )),
                ),
                Container(
                  width: 300,
                  child: RichText(
                      textDirection: TextDirection.rtl,
                      textAlign: TextAlign.justify,
                      text: TextSpan(
                        text:
                            'لورم ایپسوم متن ساختگی با تولید سادگی نامفهوم از صنعت چاپ، و با استفاده از طراحان گرافیک است، چاپگرها و متون بلکه روزنامه و مجله در ستون و سطرآنچنان که لازم است، و برای شرایط فعلی تکنولوژی مورد نیاز، و کاربردهای متنوع با هدف بهبود ابزارهای کاربردی می باشد.\n\n'
                            'کتابهای زیادی در شصت و سه درصد گذشته حال .',
                        style: TextStyle(
                          fontFamily: fontFamile2,
                          fontSize: 8,
                          fontWeight: FontWeight.w300,
                          color: Color.fromRGBO(111, 111, 111, 1),
                        ),
                      )),
                )
              ],
            ),
          ),
        ),
      ),
    );
  }
}
