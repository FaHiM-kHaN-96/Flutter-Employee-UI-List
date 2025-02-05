import 'package:flutter/material.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Add Employee',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: AddEmployeeScreen(),
    );
  }
}

class AddEmployeeScreen extends StatefulWidget {
  @override
  _AddEmployeeScreenState createState() => _AddEmployeeScreenState();
}

class _AddEmployeeScreenState extends State<AddEmployeeScreen> {
  final _formKey = GlobalKey<FormState>();
  final _nameController = TextEditingController();
  final _ageController = TextEditingController();
  final _salaryController = TextEditingController();
  List<Map<String, dynamic>> _employees = [];

  @override
  void dispose() {
    _nameController.dispose();
    _ageController.dispose();
    _salaryController.dispose();
    super.dispose();
  }

  void _addEmployee() {
    if (_formKey.currentState!.validate()) {
      String name = _nameController.text;
      int age = int.tryParse(_ageController.text) ?? 0;
      double salary = double.tryParse(_salaryController.text) ?? 0.0;

      setState(() {
        _employees.add({'name': name, 'age': age, 'salary': salary});
      });

      _nameController.clear();
      _ageController.clear();
      _salaryController.clear();
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Add Employee'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Form(
          key: _formKey,
          child: Column(
            children: <Widget>[
              TextFormField(
                controller: _nameController,
                decoration: InputDecoration(labelText: 'Name'),
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return 'Please enter a name';
                  }
                  return null;
                },
              ),
              TextFormField(
                controller: _ageController,
                decoration: InputDecoration(labelText: 'Age'),
                keyboardType: TextInputType.number,
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return 'Please enter an age';
                  }
                  if (int.tryParse(value) == null) {
                    return 'Please enter a valid age';
                  }
                  return null;
                },
              ),
              TextFormField(
                controller: _salaryController,
                decoration: InputDecoration(labelText: 'Salary'),
                keyboardType: TextInputType.number,
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return 'Please enter a salary';
                  }
                  if (double.tryParse(value) == null) {
                    return 'Please enter a valid salary';
                  }
                  return null;
                },
              ),
              SizedBox(height: 20),
              ElevatedButton(
                onPressed: _addEmployee,
                child: Text('Add Employee'),
              ),
              SizedBox(height: 20),
              Expanded(
                child: ListView.builder(
                  itemCount: _employees.length,
                  itemBuilder: (context, index) {
                    return ListTile(
                      title: Text(_employees[index]['name']),
                      subtitle: Text(
                          'Age: ${_employees[index]['age']}, Salary: \$${_employees[index]['salary'].toStringAsFixed(2)}'),
                    );
                  },
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}