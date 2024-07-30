import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:http/http.dart' as http;
import 'dart:io';
import 'dart:convert';
import 'package:dio/dio.dart';

class RegisterCarForm extends StatefulWidget {
  const RegisterCarForm({super.key});

  @override
  _RegisterCarFormState createState() => _RegisterCarFormState();
}

class _RegisterCarFormState extends State<RegisterCarForm> {
  final _formKey = GlobalKey<FormState>();
  final _carModelController = TextEditingController();
  final _carMakeController = TextEditingController();
  final _yearController = TextEditingController();
  final _licensePlateController = TextEditingController();
  List<String> filenames = ['','','','',''];

  final List<File?> _images = [null, null, null, null];

  @override
  void dispose() {
    _carModelController.dispose();
    _carMakeController.dispose();
    _yearController.dispose();
    _licensePlateController.dispose();
    super.dispose();
  }
  void registerCar() async {
    if (_formKey.currentState!.validate() ) {



      var response = await http.post(
        Uri.parse('http://10.254.110.221:5001/registercar'),
        headers: {"Content-Type": "application/json"},
        body: jsonEncode(
            {
              "Reg_Number": _licensePlateController.text,
              "Manufacturer": _carMakeController.text,
              "Model": _carModelController.text,
              "Year": int.parse(_yearController.text),
              "Pic1": filenames[0],
              "Pic2": filenames[1],
              "Pic3": filenames[2],
              "Pic4": filenames[3],
            }
        ),
      );
      var data = json.decode(response.body);
      print(data);

      if (response.statusCode == 200) {
        // Navigate to login screen on successful registration

        Navigator.pushReplacementNamed(context, '/login');
      } else {
        // Show error message if registration failed
        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(content: Text('Registration failed. Please try again.')),
        );
      }
    }
  }
  Future<void> _pickImage(int index) async {
    var dio = Dio();
    final pickedFile =
    await ImagePicker().pickImage(source: ImageSource.gallery);
    print('file array: $filenames  current index: $index');
    if (pickedFile != null) {

      setState(() {
        _images[index] = File(pickedFile.path);
        filenames[index] =pickedFile.path.split('/').last;
        print('file array: $filenames  current index: $index');
        print(pickedFile.path.split('/').last);
      });

      FormData data = FormData.fromMap({
        'key': 'b0ac0292fdb6fe4eca6e63ca1f7dc479', //key needs to be entered
        'image':  await MultipartFile.fromFile(pickedFile.path,filename:pickedFile.path.split('/').last)

      });
      var response = await dio.post("https://api.imgbb.com/1/upload",data: data,
          onSendProgress:(int sent, int total){
            print('$sent,$total');

          });
      print(response.data);
    }else{
      print("result is null");
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Register Car'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Form(
          key: _formKey,
          child: ListView(
            children: [
              TextFormField(
                controller: _licensePlateController,
                decoration: InputDecoration(
                    labelText: 'License Plate',
                    border: OutlineInputBorder(
                      borderSide: const BorderSide(
                        color: Colors.white,
                      ),
                      borderRadius: BorderRadius.circular(16.0),
                    )),
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return 'Please enter the license plate';
                  }
                  return null;
                },
              ),
              const SizedBox(
                height: 10.0,
              ),
              TextFormField(
                controller: _carMakeController,
                decoration: InputDecoration(
                    labelText: 'Vehicle Manufacturer',
                    border: OutlineInputBorder(
                      borderSide: const BorderSide(
                        color: Colors.white,
                      ),
                      borderRadius: BorderRadius.circular(16.0),
                    )),
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return 'Please enter the car manufacturer';
                  }
                  return null;
                },
              ),
              const SizedBox(
                height: 10.0,
              ),
              TextFormField(
                controller:  _carModelController,
                decoration: InputDecoration(
                    labelText: 'Vehicle Model',
                    border: OutlineInputBorder(
                      borderSide: const BorderSide(
                        color: Colors.white,
                      ),
                      borderRadius: BorderRadius.circular(16.0),
                    )),

                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return 'Please enter the vehicle model';
                  }
                  return null;
                },
              ),
              const SizedBox(
                height: 10.0,
              ),
              TextFormField(
                controller:_yearController ,
                decoration: InputDecoration(
                    labelText: 'Vehicle Year',
                    border: OutlineInputBorder(
                      borderSide: const BorderSide(
                        color: Colors.white,
                      ),
                      borderRadius: BorderRadius.circular(16.0),
                    )),
                keyboardType: TextInputType.number,
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return 'Please enter the license vehicle year';
                  }
                  return null;
                },
              ),
              const SizedBox(height: 16.0),
              const Text(
                'Upload 4 pictures of your vehicle:',
                style: TextStyle(fontSize: 16),
              ),
              GridView.builder(
                shrinkWrap: true,
                itemCount: 4,
                gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                    crossAxisCount: 2),
                itemBuilder: (BuildContext context, int index) {
                  return GestureDetector(
                    onTap: () => _pickImage(index),
                    child: Container(
                      margin: const EdgeInsets.all(8.0),
                      decoration: BoxDecoration(
                        border: Border.all(color: Colors.grey),
                      ),
                      child: _images[index] != null
                          ? Image.file(_images[index]!, fit: BoxFit.cover)
                          : const Center(child: Text('Select Image')),
                    ),
                  );
                },
              ),
              const SizedBox(height: 16.0),
              Row(
                children: [
                  Expanded(
                    child: ElevatedButton(
                      style: ElevatedButton.styleFrom(
                          backgroundColor: Colors.blue),
                      onPressed: () {
                        registerCar();
                        Navigator.pushReplacementNamed(context, '/login');
                      },
                      child: const Text(
                        'Register Car',
                        style: TextStyle(
                          color: Colors.white,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    ),
                  )
                ],
              )
            ],
          ),
        ),
      ),
    );
  }
}
