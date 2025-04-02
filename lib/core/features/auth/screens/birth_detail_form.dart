import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

class BirthDetailsScreen extends StatefulWidget {
  @override
  _BirthDetailsScreenState createState() => _BirthDetailsScreenState();
}

class _BirthDetailsScreenState extends State<BirthDetailsScreen> {
  final _formKey = GlobalKey<FormState>();
  final TextEditingController _nameController = TextEditingController();
  final TextEditingController _dateController = TextEditingController();
  final TextEditingController _timeController = TextEditingController();
  String? _gender;
  String? _maritalStatus;
  String? _occupation;
  String? _placeOfBirth;

  Future<void> _selectDate(BuildContext context) async {
    DateTime? picked = await showDatePicker(
      context: context,
      initialDate: DateTime.now(),
      firstDate: DateTime(1900),
      lastDate: DateTime.now(),
    );
    if (picked != null) {
      setState(() {
        _dateController.text = DateFormat('dd/MM/yyyy').format(picked);
      });
    }
  }

  Future<void> _selectTime(BuildContext context) async {
    TimeOfDay? picked = await showTimePicker(
      context: context,
      initialTime: TimeOfDay.now(),
    );
    if (picked != null) {
      setState(() {
        _timeController.text = picked.format(context);
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text("Profile")),
      body: SingleChildScrollView(
        padding: const EdgeInsets.symmetric(horizontal: 30, vertical: 0),
        //EdgeInsets.all(16.0),
        child: Form(
          key: _formKey,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              // Image.asset(
              //   'assets/welcome.png',
              //   height: 50,
              // ),
              SizedBox(height: 25),
              Center(
                child: Text(
                  'Share Birth Details',
                  style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
                ),
              ),
              SizedBox(height: 10),
              TextFormField(
                controller: _nameController,
                decoration: InputDecoration(
                    labelText: "Name",
                    border: OutlineInputBorder(borderRadius: BorderRadius.circular(10))
                ),
                validator: (value) => value!.isEmpty ? "Enter your name" : null,
              ),
              SizedBox(height: 10),
              DropdownButtonFormField<String>(
                value: _gender,
                decoration: InputDecoration(
                    labelText: "Gender",
                    border: OutlineInputBorder(borderRadius: BorderRadius.circular(10)),
                ),
                icon: Icon(Icons.arrow_drop_down, color: Colors.orange),
                items: ["Male", "Female", "Other"].map((e) => DropdownMenuItem(value: e, child: Text(e))).toList(),
                onChanged: (value) => setState(() => _gender = value),
                validator: (value) => value == null ? "Select gender" : null,
              ),
              SizedBox(height: 10),
              TextFormField(
                decoration: InputDecoration(
                    labelText: "Place of Birth",
                    border: OutlineInputBorder(borderRadius: BorderRadius.circular(10))),
                onChanged: (value) => _placeOfBirth = value,
                validator: (value) => value!.isEmpty ? "Enter place of birth" : null,
              ),
              SizedBox(height: 10),
              TextFormField(
                controller: _dateController,
                decoration: InputDecoration(
                  labelText: "Date of Birth",
                  border: OutlineInputBorder(borderRadius: BorderRadius.circular(10)),
                  suffixIcon: Icon(Icons.calendar_today, color: Colors.orangeAccent),
                ),
                readOnly: true,
                onTap: () => _selectDate(context),
                validator: (value) => value!.isEmpty ? "Select date of birth" : null,
              ),
              SizedBox(height: 10),
              TextFormField(
                controller: _timeController,
                decoration: InputDecoration(
                  labelText: "Time of Birth",
                  border: OutlineInputBorder(borderRadius: BorderRadius.circular(10)),
                  suffixIcon: Icon(Icons.access_time , color: Colors.orangeAccent),
                ),
                readOnly: true,
                onTap: () => _selectTime(context),
                validator: (value) => value!.isEmpty ? "Select time of birth" : null,
              ),
              SizedBox(height: 10),
              DropdownButtonFormField<String>(
                value: _maritalStatus,
                decoration: InputDecoration(
                    labelText: "Marital Status",
                    border: OutlineInputBorder(borderRadius: BorderRadius.circular(10)),
                ),
                icon: Icon(Icons.arrow_drop_down, color: Colors.orange),
                items: ["Single", "Married","Divorced","Widowed"].map((e) => DropdownMenuItem(value: e, child: Text(e))).toList(),
                onChanged: (value) => setState(() => _maritalStatus = value),
                validator: (value) => value == null ? "Select marital status" : null,
              ),
              SizedBox(height: 10),
              DropdownButtonFormField<String>(
                value: _occupation,
                decoration: InputDecoration(
                    labelText: "Occupation",
                    border: OutlineInputBorder(borderRadius: BorderRadius.circular(10)),
                ),
                icon: Icon(Icons.arrow_drop_down, color: Colors.orange),
                items: ["Student", "Employed", "Un-Employed", "Other"].map((e) => DropdownMenuItem(value: e, child: Text(e))).toList(),
                onChanged: (value) => setState(() => _occupation = value),
                validator: (value) => value == null ? "Select occupation" : null,
              ),
              SizedBox(height: 20),
              SizedBox(
                width: double.infinity,
                child: ElevatedButton(
                  style: ElevatedButton.styleFrom(
                    padding: EdgeInsets.symmetric(vertical: 15),
                    backgroundColor: Colors.orange,
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(10),
                    ),
                  ),
                  onPressed: () {
                    if (_formKey.currentState!.validate()) {
                      ScaffoldMessenger.of(context).showSnackBar(SnackBar(content: Text("Profile saved successfully!")));
                    }
                  },
                  child: Text('NEXT',
                    style: TextStyle(
                      fontSize: 16,
                      fontWeight: FontWeight.bold,
                      color: Colors.white,
                    ),
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}












// import 'package:flutter/material.dart';
// //import 'package:intl_phone_field/intl_phone_field.dart';
// import 'package:intl/intl.dart';
//
// void main() {
//   runApp(MyApp());
// }
//
// class MyApp extends StatelessWidget {
//   @override
//   Widget build(BuildContext context) {
//     return MaterialApp(
//       debugShowCheckedModeBanner: false,
//       home: BirthDetailsScreen(),
//     );
//   }
// }
//
// class BirthDetailsScreen extends StatefulWidget {
//   @override
//   _BirthDetailsScreenState createState() => _BirthDetailsScreenState();
// }
//
// class _BirthDetailsScreenState extends State<BirthDetailsScreen> {
//   final _formKey = GlobalKey<FormState>();
//   String phoneNumber = '';
//   String name = '';
//   String gender = 'Not specified';
//   String dateOfBirth = '';
//   String timeOfBirth = '';
//   String placeOfBirth = '';
//   String maritalStatus = 'Not specified';
//   String occupation = 'Not specified';
//
//   Future<void> _selectDate(BuildContext context) async {
//     DateTime? picked = await showDatePicker(
//       context: context,
//       initialDate: DateTime.now(),
//       firstDate: DateTime(1900),
//       lastDate: DateTime.now(),
//     );
//     if (picked != null) {
//       setState(() {
//         dateOfBirth = DateFormat('dd/MM/yyyy').format(picked);
//       });
//     }
//   }
//
//   Future<void> _selectTime(BuildContext context) async {
//     TimeOfDay? picked = await showTimePicker(
//       context: context,
//       initialTime: TimeOfDay.now(),
//     );
//     if (picked != null) {
//       setState(() {
//         timeOfBirth = picked.format(context);
//       });
//     }
//   }
//
//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       backgroundColor: Colors.white,
//       body: SingleChildScrollView(
//         child: Padding(
//           padding: const EdgeInsets.symmetric(horizontal: 40, vertical: 50),
//           child: Form(
//             key: _formKey,
//             child: Column(
//               crossAxisAlignment: CrossAxisAlignment.start,
//               children: [
//                 Center(
//                   child: Image.asset(
//                     'assets/welcome.png',
//                     height: 150,
//                   ),
//                 ),
//                 SizedBox(height: 20),
//                 Center(
//                   child: Text(
//                     'Share Birth Details',
//                     style: TextStyle(
//                       fontSize: 24,
//                       fontWeight: FontWeight.bold,
//                     ),
//                   ),
//                 ),
//                 SizedBox(height: 10),
//                 TextFormField(
//                   decoration: InputDecoration(labelText: 'Name'),
//                   validator: (value) {
//                     if (value == null || value.isEmpty) {
//                       return 'Please enter your name';
//                     }
//                     return null;
//                   },
//                   onChanged: (value) => name = value,
//                 ),
//                 SizedBox(height: 10),
//                 DropdownButtonFormField(
//                   value: gender,
//                   decoration: InputDecoration(labelText: 'Gender'),
//                   items: ['Not specified', 'Male', 'Female', 'Other']
//                       .map((e) => DropdownMenuItem(value: e, child: Text(e)))
//                       .toList(),
//                   onChanged: (value) => setState(() => gender = value!),
//                 ),
//                 SizedBox(height: 10),
//                 TextFormField(
//                   readOnly: false,
//                   decoration: InputDecoration(
//                     labelText: 'Date of Birth',
//                     suffixIcon: Icon(Icons.calendar_today),
//                   ),
//                   controller: TextEditingController(text: dateOfBirth),
//                   onTap: () => _selectDate(context),
//                   validator: (value) {
//                     if (value == null || value.isEmpty) {
//                       return 'Please enter date of birth';
//                     }
//                     return null;
//                   },
//                 ),
//                 SizedBox(height: 10),
//                 TextFormField(
//                   readOnly: true,
//                   decoration: InputDecoration(
//                     labelText: 'Time of Birth',
//                     suffixIcon: Icon(Icons.access_time),
//                   ),
//                   controller: TextEditingController(text: timeOfBirth),
//                   onTap: () => _selectTime(context),
//                 ),
//                 SizedBox(height: 10),
//                 TextFormField(
//                   decoration: InputDecoration(labelText: 'Place of Birth'),
//                   onChanged: (value) => placeOfBirth = value,
//                 ),
//                 SizedBox(height: 10),
//                 DropdownButtonFormField(
//                   value: maritalStatus,
//                   decoration: InputDecoration(labelText: 'Marital Status'),
//                   items: ['Not specified', 'Single', 'Married', 'Divorced', 'Widowed']
//                       .map((e) => DropdownMenuItem(value: e, child: Text(e)))
//                       .toList(),
//                   onChanged: (value) => setState(() => maritalStatus = value!),
//                 ),
//                 SizedBox(height: 10),
//                 DropdownButtonFormField(
//                   value: occupation,
//                   decoration: InputDecoration(labelText: 'Occupation'),
//                   items: ['Not specified', 'Student', 'Employed', 'Self-employed', 'Unemployed']
//                       .map((e) => DropdownMenuItem(value: e, child: Text(e)))
//                       .toList(),
//                   onChanged: (value) => setState(() => occupation = value!),
//                 ),
//                 // SizedBox(height: 20),
//                 // IntlPhoneField(
//                 //   decoration: InputDecoration(labelText: 'Phone Number'),
//                 //   initialCountryCode: 'IN',
//                 //   onChanged: (phone) {
//                 //     setState(() {
//                 //       phoneNumber = phone.completeNumber;
//                 //     });
//                 //   },
//                 //   validator: (phone) {
//                 //     if (phone == null || phone.number.isEmpty) {
//                 //       return 'Please enter a valid phone number';
//                 //     }
//                 //     return null;
//                 //   },
//                 // ),
//                 SizedBox(height: 30),
//                 SizedBox(
//                   width: double.infinity,
//                   child: ElevatedButton(
//                     style: ElevatedButton.styleFrom(
//                       padding: EdgeInsets.symmetric(vertical: 15),
//                       backgroundColor: Colors.orange,
//                       shape: RoundedRectangleBorder(
//                         borderRadius: BorderRadius.circular(10),
//                       ),
//                     ),
//                     onPressed: () {
//                       if (_formKey.currentState!.validate()) {
//                         print('Form submitted');
//                       }
//                     },
//                     child: Text(
//                       'NEXT',
//                       style: TextStyle(
//                         fontSize: 16,
//                         fontWeight: FontWeight.bold,
//                         color: Colors.white,
//                       ),
//                     ),
//                   ),
//                 ),
//               ],
//             ),
//           ),
//         ),
//       ),
//     );
//   }
// }