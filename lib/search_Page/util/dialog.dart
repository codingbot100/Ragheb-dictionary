// ignore_for_file: must_be_immutable

import 'package:flutter/material.dart';

class RemoveDilog extends StatefulWidget {
  final List<TextEditingController> controllers;
  VoidCallback onSave;
  VoidCallback onCancel;

  RemoveDilog({
    Key? key,
    required this.onSave,
    required this.onCancel,
    required this.controllers,
  }) : super(key: key);

  @override
  State<RemoveDilog> createState() => _RemoveDilogState();
}

class _RemoveDilogState extends State<RemoveDilog> {
  final List<String> name = [
    "نام کارمند",
    "نام پدر ",
    "محل سکونت",
    "تاریخ استخدام",
    "وظیفه کارمند",
    " معاش",
  ];

  @override
  Widget build(BuildContext context) {
    DateTime selecedtDate = DateTime.now();

    return AlertDialog(
      content: Container(
        height: 500,
        width: 200,
        child: Directionality(
          textDirection: TextDirection.rtl,
          child: Column(
            children: [
              Text(
                'مشخصات کارمند جدید را وارد کنید.',
                style: TextStyle(
                  fontFamily: 'Yekan',
                  color: Colors.black,
                  fontSize: 16,
                  fontWeight: FontWeight.bold,
                ),
              ),
              SizedBox(height: 40),
              // ...

              for (int i = 0; i < widget.controllers.length; i++)
                Padding(
                  padding: const EdgeInsets.only(bottom: 30),
                  child: Container(
                    height: 40,
                    child: i == 3
                        ? buildDateTextField(context, selecedtDate)
                        : TextField(
                            cursorOpacityAnimates: true,
                            controller: widget.controllers[i],
                            decoration: InputDecoration(
                              labelText: i < name.length
                                  ? name[i]
                                  : '', // Check index range
                              labelStyle: TextStyle(
                                fontSize: 13,
                                fontWeight: FontWeight.w500,
                                color: Colors.black,
                                fontFamily: "Yekan",
                              ),
                              border: OutlineInputBorder(
                                borderRadius: BorderRadius.circular(8.0),
                              ),
                            ),
                          ),
                  ),
                ),

// ...
            ],
          ),
        ),
      ),
      actions: [
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceAround,
          children: [
            TextButton(
              onPressed: widget.onCancel,
              child: Text('انصراف',
                  style: TextStyle(
                    fontFamily: 'Yekan',
                    color: Colors.black,
                    fontSize: 16,
                    fontWeight: FontWeight.bold,
                  )),
            ),
            TextButton(
              onPressed: () {
                bool allFieldsFilled = widget.controllers.every(
                  (controller) => controller.text.isNotEmpty,
                );

                if (allFieldsFilled) {
                  widget.onSave();
                  _showSnackBar(context, 'اطلاعات با موفقیت ذخیره شد.');
                } else {
                  _showSnackBar(
                      context, 'لطفاً تمامی فیلدها را پر کنید.', Colors.red);
                }
              },
              child: Text(
                'ثبت',
                style: TextStyle(
                  fontFamily: 'Yekan',
                  color: Colors.black,
                  fontSize: 16,
                  fontWeight: FontWeight.bold,
                ),
              ),
            ),
          ],
        )
      ],
    );
  }

  void _showSnackBar(BuildContext context, String message,
      [Color color = Colors.green]) {
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: Center(
          child: Directionality(
              textDirection: TextDirection.rtl, child: Text(message)),
        ),
        backgroundColor: color,
      ),
    );
  }

  Widget buildDateTextField(BuildContext context, DateTime selecedtDate) {
    return Container(
      height: 60,
      child: TextField(
        cursorOpacityAnimates: true,
        controller: widget.controllers[3],
        decoration: InputDecoration(
          labelText: name[3],
          labelStyle: TextStyle(
              fontSize: 13,
              fontWeight: FontWeight.w500,
              color: Colors.black,
              fontFamily:
                  "Yekan"), // Use the corresponding label from the name list
          border: OutlineInputBorder(
            borderRadius: BorderRadius.circular(8.0),
          ),
        ),
        onTap: () async {
          final DateTime? dateTime = await showDatePicker(
              context: context,
              firstDate: DateTime(2000),
              lastDate: DateTime(3000),
              initialDate: selecedtDate);
          if (dateTime != null) {
            selecedtDate = dateTime;
            widget.controllers[3].text =
                "${selecedtDate.year} - ${selecedtDate.month} - ${selecedtDate.day}";
          }
        },
      ),
    );
  }
}
