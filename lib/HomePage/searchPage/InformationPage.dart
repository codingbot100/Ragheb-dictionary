import 'package:flutter/material.dart';

class InformationPage extends StatefulWidget {
  const InformationPage({super.key});

  @override
  State<InformationPage> createState() => _InformationPageState();
}

class _InformationPageState extends State<InformationPage> {
  var fontFamile2 = 'YekanBakh';
  final fontSizeTitle = 20.0;
  double fontSizeSubTitle = 10.0;
  final colorPrimary = Color(0xFF009688);
  final colorBackground = Color.fromRGBO(245, 245, 220, 1);
  final colorPrimary2 = Color(0xFFB0BEC5);
  final colorBackground2 = Color.fromARGB(255, 224, 224, 224);
  var listColor = Color.fromRGBO(0, 150, 136, 1);
  List favorites = [];
  bool isFavorite = false;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Color.fromRGBO(245, 245, 200, 1),
      body: Column(
        // mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Padding(
            padding: const EdgeInsets.only(top: 30),
            child: SafeArea(
              child: ListTile(
                leading: GestureDetector(
                  onTap: () {
                    setState(() {
                      isFavorite = !isFavorite;
                      if (isFavorite) {
                        //Add TO favorites
                      } else {}
                    });
                  },
                  child: isFavorite
                      ? Image.asset('images/new.png', color: Colors.green)
                      : Image.asset('images/open.png'),
                ),
                trailing: Text(
                  'لغت',
                  style: TextStyle(
                    fontFamily: fontFamile2,
                    fontSize: 30,
                    fontWeight: FontWeight.w900,
                    color: Color.fromRGBO(82, 82, 82, 1),
                  ),
                ),
              ),
            ),
          ),
          Container(
            decoration:
                BoxDecoration(borderRadius: BorderRadius.circular(16.0)),
            height: 700,
            child: SingleChildScrollView(
              child: Column(
                children: [
                  Padding(
                    padding:
                        const EdgeInsets.only(left: 20, right: 20, top: 40),
                    child: Container(
                      width: double.infinity,
                      child: RichText(
                        textDirection: TextDirection.rtl,
                        textAlign: TextAlign.justify,
                        text: TextSpan(
                          text:
                              'لورم ایپسوم متن ساختگی با تولید سادگی نامفهوم از صنعت چاپ، و با استفاده از طراحان گرافیک است، چاپگرها و متون بلکه روزنامه و مجله در ستون و سطرآنچنان که لازم است، و برای شرایط فعلی تکنولوژی مورد نیاز، و کاربردهای متنوع با هدف بهبود ابزارهای کاربردی می باشد.\n\n'
                              'کتابهای زیادی در شصت و سه درصد گذشته حال و آینده، شناخت فراوان جامعه و متخصصان را می طلبد.',
                          style: TextStyle(
                            fontFamily: fontFamile2,
                            fontSize: 14,
                            fontWeight: FontWeight.w900,
                            color: Color.fromRGBO(82, 82, 82, 1),
                          ),
                        ),
                      ),
                    ),
                  ),
                  Container(
                    width: double.infinity,
                    child: Padding(
                      padding: const EdgeInsets.only(left: 40, right: 40),
                      child: RichText(
                        textDirection: TextDirection.rtl,
                        textAlign: TextAlign.justify,
                        text: TextSpan(
                          text:
                              'لورم ایپسوم متن ساختگی با تولید سادگی نامفهوم از صنعت چاپ، و با استفاده از طراحان گرافیک است، چاپگرها و متون بلکه روزنامه و مجله در ستون و سطرآنچنان که لازم است، و برای شرایط فعلی تکنولوژی مورد نیاز، و کاربردهای متنوع با هدف بهبود ابزارهای کاربردی می باشد.\n\n'
                              'کتابهای زیادی در شصت و سه درصد گذشته حال و آینده، شناخت فراوان جامعه و متخصصان را می طلبد.'
                              'لورم ایپسوم متن ساختگی با تولید سادگی نامفهوم از صنعت چاپ، و با استفاده از طراحان گرافیک است، چاپگرها و متون بلکه روزنامه و مجله در ستون و سطرآنچنان که لازم است، و برای شرایط فعلی تکنولوژی مورد نیاز، و کاربردهای متنوع با هدف بهبود ابزارهای کاربردی می باشد.\n\n'
                              'کتابهای زیادی در شصت و سه درصد گذشته حال و آینده، شناخت فراوان جامعه و متخصصان را می طلبد.'
                              'لورم ایپسوم متن ساختگی با تولید سادگی نامفهوم از صنعت چاپ، و با استفاده از طراحان گرافیک است، چاپگرها و متون بلکه روزنامه و مجله در ستون و سطرآنچنان که لازم است، و برای شرایط فعلی تکنولوژی مورد نیاز، و کاربردهای متنوع با هدف بهبود ابزارهای کاربردی می باشد.\n\n'
                              'کتابهای زیادی در شصت و سه درصد گذشته حال و آینده، شناخت فراوان جامعه و متخصصان را می طلبد.'
                              'لورم ایپسوم متن ساختگی با تولید سادگی نامفهوم از صنعت چاپ، و با استفاده از طراحان گرافیک است، چاپگرها و متون بلکه روزنامه و مجله در ستون و سطرآنچنان که لازم است، و برای شرایط فعلی تکنولوژی مورد نیاز، و کاربردهای متنوع با هدف بهبود ابزارهای کاربردی می باشد.\n\n'
                              'کتابهای زیادی در شصت و سه درصد گذشته حال و آینده، شناخت فراوان جامعه و متخصصان را می طلبد.'
                              'لورم ایپسوم متن ساختگی با تولید سادگی نامفهوم از صنعت چاپ، و با استفاده از طراحان گرافیک است، چاپگرها و متون بلکه روزنامه و مجله در ستون و سطرآنچنان که لازم است، و برای شرایط فعلی تکنولوژی مورد نیاز، و کاربردهای متنوع با هدف بهبود ابزارهای کاربردی می باشد.\n\n'
                              'کتابهای زیادی در شصت و سه درصد گذشته حال و آینده، شناخت فراوان جامعه و متخصصان را می طلبد.'
                              'لورم ایپسوم متن ساختگی با تولید سادگی نامفهوم از صنعت چاپ، و با استفاده از طراحان گرافیک است، چاپگرها و متون بلکه روزنامه و مجله در ستون و سطرآنچنان که لازم است، و برای شرایط فعلی تکنولوژی مورد نیاز، و کاربردهای متنوع با هدف بهبود ابزارهای کاربردی می باشد.\n\n'
                              'کتابهای زیادی در شصت و سه درصد گذشته حال و آینده، شناخت فراوان جامعه و متخصصان را می طلبد.'
                              'لورم ایپسوم متن ساختگی با تولید سادگی نامفهوم از صنعت چاپ، و با استفاده از طراحان گرافیک است، چاپگرها و متون بلکه روزنامه و مجله در ستون و سطرآنچنان که لازم است، و برای شرایط فعلی تکنولوژی مورد نیاز، و کاربردهای متنوع با هدف بهبود ابزارهای کاربردی می باشد.\n\n'
                              'کتابهای زیادی در شصت و سه درصد گذشته حال و آینده، شناخت فراوان جامعه و متخصصان را می طلبد.',
                          style: TextStyle(
                            fontFamily: fontFamile2,
                            fontSize: 12,
                            fontWeight: FontWeight.w900,
                            color: Color.fromRGBO(82, 82, 82, 1),
                          ),
                        ),
                      ),
                    ),
                  ),
                ],
              ),
            ),
          )
        ],
      ),
    );
  }
}
