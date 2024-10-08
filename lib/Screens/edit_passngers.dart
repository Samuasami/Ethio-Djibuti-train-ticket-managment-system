import 'package:book_train_ticket/Screens/passenger_conirm.dart';
import 'package:book_train_ticket/utils/app_style.dart';
import 'package:flutter/material.dart';
import 'package:gap/gap.dart';

class EditPassngers extends StatefulWidget {
  final List<Map<String, dynamic>> useredit;
  final String departureplace;
  final String arrivalplace;
  final DateTime dateTime;
  final String travelClass;

  final int price;
  final List<int> seat;
  final String Cargo;

  const EditPassngers(
      {super.key,
      required this.useredit,
      required this.price,
      required this.departureplace,
      required this.arrivalplace,
      required this.dateTime,
      required this.travelClass,
      required this.Cargo,
        required this.seat
      });

  @override
  State<EditPassngers> createState() => _EditPassngersState();
}

int calculateAge(String birthDate) {
  DateTime today = DateTime.now();
  List<String> birthDateParts = birthDate.split('-');
  int birthYear = int.parse(birthDateParts[0]);
  int birthMonth = int.parse(birthDateParts[1]);
  int birthDay = int.parse(birthDateParts[2]);

  int age = today.year - birthYear;

  // Check if the birthday hasn't occurred yet this year
  if (birthMonth > today.month ||
      (birthMonth == today.month && birthDay > today.day)) {
    age--;
  }

  return age;
}

class _EditPassngersState extends State<EditPassngers> {
  int selectdeIndx = 0;
  final _formKey = GlobalKey<FormState>();
  late String? SlectedItem;
  final TextEditingController _textEditingController = TextEditingController();
  final TextEditingController _textEditingController2 = TextEditingController();
  final TextEditingController _textEditingControlleremail =
      TextEditingController();
  final TextEditingController _textEditingControllerphonenumber =
      TextEditingController();
  final TextEditingController _textEditingController3 = TextEditingController();
  final TextEditingController _dateController = TextEditingController();
  bool isvisible = true;
  final _emailRgex =
      r"^[a-zA-z0-9.a-zA-Z0-9.!#$%&'*+-/=?^_`{|}~]+@[a-zA-Z0-9]+\.[a-zA-z]+";

  @override
  void initState() {
    super.initState();
    // Set the initial text value
    _textEditingController.text = widget.useredit[selectdeIndx]['Firstname'];
    _textEditingController2.text = widget.useredit[selectdeIndx]['middlename'];
    _textEditingController3.text = widget.useredit[selectdeIndx]['Lastname'];
    if (widget.useredit[selectdeIndx]['Datetime'] != null) {
      _dateController.text =
          widget.useredit[selectdeIndx]['Datetime'].toString().split(" ")[0];
    }
    _textEditingControllerphonenumber.text =
        widget.useredit[selectdeIndx]['phone'];
    _textEditingControlleremail.text = widget.useredit[selectdeIndx]['Email'];
    SlectedItem = widget.useredit[selectdeIndx]['Gender'];

    // print(widget.departureplace);
    // print(widget.arrivalplace);
    // print(widget.price);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: styles.bgColor,
      appBar: AppBar(
        title: const Center(child: Text("Passengers Edit")),
      ),
      body: Column(
        children: [
          SizedBox(
            height: 55,
            child: ListView.builder(
              itemCount: widget.useredit.length,
              scrollDirection: Axis.horizontal,
              itemBuilder: (context, index) {
                return Container(
                  margin: const EdgeInsets.only(left: 10, top: 10),
                  child: ElevatedButton(
                    onPressed: () {
                      setState(() {
                        selectdeIndx = index;
                        if (selectdeIndx == 0) {
                          isvisible = true;
                        }
                        if (selectdeIndx != 0) {
                          isvisible = false;
                        }
                        _textEditingController.text =
                            widget.useredit[selectdeIndx]['Firstname'];
                        _textEditingController2.text =
                            widget.useredit[selectdeIndx]['middlename'];
                        _textEditingController3.text =
                            widget.useredit[selectdeIndx]['Lastname'];
                        _dateController.text =
                            widget.useredit[selectdeIndx]['Datetime'];
                        SlectedItem = widget.useredit[selectdeIndx]['Gender'];
                      });
                    },
                    style: ElevatedButton.styleFrom(
                      backgroundColor:
                          selectdeIndx == index ? Colors.green : Colors.white,
                      shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(10)),
                    ),
                    child: Text(
                      widget.useredit[index]['Firstname'],
                      style: TextStyle(
                        color:
                            selectdeIndx == index ? Colors.white : Colors.black,
                        fontSize: 16,
                      ),
                    ),
                  ),
                );
              },
            ),
          ),
          Form(
            key: _formKey,
            child: Expanded(
              child: ListView(
                children: [
                  Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Container(
                      height: 500,
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(10),
                        color: Colors.white,
                      ),
                      child: Column(
                        children: [
                          Padding(
                            padding: const EdgeInsets.all(8.0),
                            child: Container(
                              width: 40.0,
                              height: 5.0,
                              decoration: BoxDecoration(
                                color: Colors.grey,
                                borderRadius: BorderRadius.circular(100),
                              ),
                            ),
                          ),
                          Padding(
                            padding: const EdgeInsets.only(left: 20, right: 20),
                            child: TextFormField(
                              keyboardType: TextInputType.text,
                              controller: _textEditingController,
                              decoration: const InputDecoration(
                                labelText: "First name*",
                                labelStyle: TextStyle(
                                  color: Colors.grey,
                                ),
                                fillColor: Colors.grey,
                              ),
                              validator: (value) {
                                if (value!.isNotEmpty && value.length > 2) {
                                  return null;
                                } else if (value.isEmpty) {
                                  return "First name required";
                                } else {
                                  return "First name to short";
                                }
                              },
                              cursorColor: Colors.grey,
                            ),
                          ),
                          Padding(
                            padding: const EdgeInsets.only(left: 20, right: 20),
                            child: TextFormField(
                              keyboardType: TextInputType.text,
                              controller: _textEditingController2,
                              decoration: const InputDecoration(
                                labelText: "Middle name",
                                labelStyle: TextStyle(
                                  color: Colors.grey,
                                ),
                              ),
                              validator: (value) {
                                if (value!.length < 3) {
                                  return "Middle name to short";
                                }
                                return null;
                              },
                            ),
                          ),
                          Padding(
                            padding: const EdgeInsets.only(left: 20, right: 20),
                            child: TextFormField(
                              keyboardType: TextInputType.text,
                              controller: _textEditingController3,
                              decoration: const InputDecoration(
                                  labelText: "Last name*",
                                  labelStyle: TextStyle(
                                    color: Colors.grey,
                                  )),
                              validator: (value) {
                                if (value!.isNotEmpty && value.length > 2) {
                                  return null;
                                } else if (value.isEmpty) {
                                  return "Last name required";
                                } else {
                                  return "Last name to short";
                                }
                              },
                            ),
                          ),
                          Padding(
                            padding: const EdgeInsets.only(left: 20, right: 20),
                            child: TextFormField(
                              keyboardType: TextInputType.datetime,
                              controller: _dateController,
                              decoration: const InputDecoration(
                                  suffixIcon: Icon(Icons.calendar_month),
                                  labelText: "Date Of Birth*",
                                  labelStyle: TextStyle(
                                    color: Colors.grey,
                                  )),
                              validator: (value) {
                                if (value!.isNotEmpty && value.length > 2) {
                                  return null;
                                } else if (value.isEmpty) {
                                  return "Date of birth required";
                                }
                                return null;
                              },
                              onTap: () {
                                _selectDate();
                              },
                            ),
                          ),
                          const Row(
                            children: [
                              Padding(
                                padding: EdgeInsets.only(
                                    left: 20, right: 20, top: 10),
                                child: Text(
                                  "Gender*",
                                  style: TextStyle(
                                    color: Colors.grey,
                                    fontSize: 18,
                                  ),
                                ),
                              ),
                            ],
                          ),
                          Padding(
                            padding: const EdgeInsets.only(
                                left: 20, right: 20, top: 10),
                            child: Row(
                              children: [
                                SizedBox(
                                  width: 150,
                                  child: RadioMenuButton(
                                    value: 'male',
                                    groupValue: SlectedItem,
                                    onChanged: (SlectedvalueItem) {
                                      setState(() {
                                        SlectedItem = SlectedvalueItem!;
                                      });
                                    },
                                    style: ButtonStyle(
                                      shape: MaterialStatePropertyAll(
                                        RoundedRectangleBorder(
                                          borderRadius:
                                              BorderRadius.circular(10),
                                        ),
                                      ),
                                      elevation:
                                          const MaterialStatePropertyAll(2),
                                      backgroundColor:
                                          const MaterialStatePropertyAll(
                                              Colors.white24),
                                    ),
                                    child: const Text("Male"),
                                  ),
                                ),
                                const Gap(20),
                                SizedBox(
                                  width: 150,
                                  child: RadioMenuButton(
                                    value: 'female',
                                    groupValue: SlectedItem,
                                    onChanged: (SlectedvalueItem) {
                                      setState(() {
                                        SlectedItem = SlectedvalueItem!;
                                      });
                                    },
                                    style: ButtonStyle(
                                      shape: MaterialStatePropertyAll(
                                        RoundedRectangleBorder(
                                          borderRadius:
                                              BorderRadius.circular(10),
                                        ),
                                      ),
                                      elevation:
                                          const MaterialStatePropertyAll(5),
                                      backgroundColor:
                                          const MaterialStatePropertyAll(
                                              Colors.white),
                                    ),
                                    child: const Text("Female"),
                                  ),
                                ),
                              ],
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                  Visibility(
                    visible: isvisible,
                    child: Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: Container(
                        height: 250,
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(10),
                          color: Colors.white,
                        ),
                        child: Column(
                          children: [
                            const Text(
                              "Contacts",
                              style: TextStyle(
                                fontSize: 25,
                              ),
                            ),
                            Padding(
                              padding:
                                  const EdgeInsets.only(left: 20, right: 20),
                              child: TextFormField(
                                keyboardType: TextInputType.emailAddress,
                                controller: _textEditingControlleremail,
                                decoration: const InputDecoration(
                                    labelText: "Email*",
                                    labelStyle: TextStyle(
                                      color: Colors.grey,
                                    )),
                                validator: (value) {
                                  if (value!.isEmpty) {
                                    return "Email is required";
                                  }
                                  if (!RegExp(_emailRgex).hasMatch(value)) {
                                    return "please enter correct email address";
                                  } else {
                                    return null;
                                  }
                                },
                              ),
                            ),
                            Padding(
                              padding:
                                  const EdgeInsets.only(left: 20, right: 20),
                              child: TextFormField(
                                controller: _textEditingControllerphonenumber,
                                keyboardType: TextInputType.phone,
                                maxLength: 10,
                                decoration: const InputDecoration(
                                    labelText: "Phone number*",
                                    labelStyle: TextStyle(
                                      color: Colors.grey,
                                    )),
                                validator: (value) {
                                  if (value!.isEmpty) {
                                    return "Phone Number is required";
                                  }
                                  if (value.length != 10) {
                                    return "Phone number must be 10 digit";
                                  } else {
                                    return null;
                                  }
                                },
                              ),
                            ),
                          ],
                        ),
                      ),
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.all(15.0),
                    child: ElevatedButton(
                      onPressed: () {
                        if (!_formKey.currentState!.validate()) {
                          return;
                        } else {
                          selectdeIndx = selectdeIndx;

                          String fname = _textEditingController.text;
                          String Mname = _textEditingController2.text;
                          String Lname = _textEditingController3.text;
                          String dateofbirth = _dateController.text;
                          int age = calculateAge(dateofbirth);
                          String email = _textEditingControlleremail.text;
                          String phone = _textEditingControllerphonenumber.text;
                          String? gender = SlectedItem;

                          widget.useredit[selectdeIndx]['Firstname'] = fname;
                          widget.useredit[selectdeIndx]['middlename'] = Mname;
                          widget.useredit[selectdeIndx]['Lastname'] = Lname;
                          widget.useredit[selectdeIndx]['Datetime'] =
                              dateofbirth;
                          widget.useredit[selectdeIndx]['Age'] = age;
                          widget.useredit[selectdeIndx]['Email'] = email;
                          widget.useredit[selectdeIndx]['phone'] = phone;
                          widget.useredit[selectdeIndx]['Gender'] = gender;

                          if (selectdeIndx < widget.useredit.length - 1) {
                            selectdeIndx++;
                            if (selectdeIndx == 0) {
                              isvisible = true;
                            }
                            if (selectdeIndx != 0) {
                              isvisible = false;
                            }
                            _textEditingController.text =
                                widget.useredit[selectdeIndx]['Firstname'];
                            _textEditingController2.text =
                                widget.useredit[selectdeIndx]['middlename'];
                            _textEditingController3.text =
                                widget.useredit[selectdeIndx]['Lastname'];
                            _dateController.text =
                                widget.useredit[selectdeIndx]['Datetime'];
                            _textEditingControllerphonenumber.text =
                                widget.useredit[selectdeIndx]['Email'];
                            _textEditingControlleremail.text =
                                widget.useredit[selectdeIndx]['phone'];
                          } else {
                            Navigator.push(
                              context,
                              MaterialPageRoute(
                                builder: (context) => PassengerConfrim(
                                  user: widget.useredit,
                                  arrivalplace: widget.arrivalplace,
                                  departureplace: widget.departureplace,
                                  dateTime: widget.dateTime,
                                  price: widget.price,
                                  travelClass: widget.travelClass,
                                  Cargo: widget.Cargo,
                                  seat: widget.seat,
                                ),
                              ),
                            );
                          }
                          setState(() {
                            selectdeIndx = selectdeIndx;
                          });
                        }
                      },
                      style: ElevatedButton.styleFrom(
                        backgroundColor: Colors.blue,
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(5),
                        ),
                      ),
                      child: const Center(
                        child: Text(
                          "Confirm",
                          style: TextStyle(
                            fontSize: 15,
                            letterSpacing: 2,
                            color: Colors.white,
                          ),
                        ),
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }

  Future<void> _selectDate() async {
    DateTime? picked = await showDatePicker(
      context: context,
      initialDate: DateTime.now(),
      firstDate: DateTime(2000),
      lastDate: DateTime(2100),
    );
    if (picked != null) {
      setState(() {
        _dateController.text = picked.toString().split(" ")[0];
      });
    }
  }
}
