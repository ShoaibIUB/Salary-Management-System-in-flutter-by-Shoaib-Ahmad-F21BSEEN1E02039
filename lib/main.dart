import 'package:flutter/material.dart';

void main() {
  runApp(const SalaryManagementApp());
}

class SalaryManagementApp extends StatelessWidget {
  const SalaryManagementApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return const MaterialApp(
      title: 'Salary Management System',
      home: SalaryManagementScreen(),
      debugShowCheckedModeBanner: false,
    );
  }
}

class SalaryManagementScreen extends StatefulWidget {
  const SalaryManagementScreen({Key? key}) : super(key: key);

  @override
  // ignore: library_private_types_in_public_api
  _SalaryManagementScreenState createState() => _SalaryManagementScreenState();
}

class _SalaryManagementScreenState extends State<SalaryManagementScreen> {
  final List<Map<String, dynamic>> _employeeData = [];
  final TextEditingController _nameController = TextEditingController();
  final TextEditingController _hoursWorkedController = TextEditingController();
  final TextEditingController _billTypeController = TextEditingController();
  final TextEditingController _billAmountController = TextEditingController();
  String _position = "Software Developer";

  @override
  void dispose() {
    _nameController.dispose();
    _hoursWorkedController.dispose();
    _billTypeController.dispose();
    _billAmountController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Salary Management System'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const Text('Employee Name:'),
            TextFormField(controller: _nameController),
            const SizedBox(height: 20),
            const Text('Position:'),
            DropdownButtonFormField(
              value: "Software Developer",
              items: ["Software Developer", "Manager", "Intern"]
                  .map((String position) {
                return DropdownMenuItem(
                  value: position,
                  child: Text(position),
                );
              }).toList(),
              onChanged: (value) {
                setState(() {
                  _position = value.toString();
                });
              },
            ),
            const SizedBox(height: 20),
            const Text('Hours Worked:'),
            TextFormField(controller: _hoursWorkedController),
            const SizedBox(height: 20),
            const Text('Bills:'),
            const SizedBox(height: 10),
            const Text('Bill Type:'),
            TextFormField(controller: _billTypeController),
            const SizedBox(height: 10),
            const Text('Bill Amount:'),
            TextFormField(controller: _billAmountController),
            const SizedBox(height: 20),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                ElevatedButton(
                  onPressed: () {
                    final name = _nameController.text;
                    final hoursWorked = _hoursWorkedController.text;
                    final billType = _billTypeController.text;
                    final billAmount = _billAmountController.text;

                    if (name.isEmpty ||
                        hoursWorked.isEmpty ||
                        billType.isEmpty ||
                        billAmount.isEmpty) {
                      ScaffoldMessenger.of(context).showSnackBar(
                        const SnackBar(
                          content: Text('Please fill in all required fields.'),
                        ),
                      );
                      return;
                    }

                    setState(() {
                      _employeeData.add({
                        "name": name,
                        "position": _position,
                        "hoursWorked": hoursWorked,
                        "billType": billType,
                        "billAmount": billAmount,
                      });

                      _nameController.clear();
                      _hoursWorkedController.clear();
                      _billTypeController.clear();
                      _billAmountController.clear();
                    });
                  },
                  child: const Text('Add Employee Data'),
                ),
                const SizedBox(width: 20),
                ElevatedButton(
                  onPressed: () {},
                  child: const Text('Calculate Salary'),
                ),
                const SizedBox(width: 20),
                ElevatedButton(
                  onPressed: () {},
                  child: const Text('Generate Report'),
                ),
              ],
            ),
            const SizedBox(height: 20),
            Expanded(
              child: ListView.builder(
                itemCount: _employeeData.length,
                itemBuilder: (context, index) {
                  final employee = _employeeData[index];
                  return Card(
                    child: ListTile(
                      title: Text('Employee: ${employee["name"]}'),
                      subtitle: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text('Position: ${employee["position"]}'),
                          Text('Hours Worked: ${employee["hoursWorked"]}'),
                          Text('Bill Type: ${employee["billType"]}'),
                          Text('Bill Amount: ${employee["billAmount"]}'),
                        ],
                      ),
                    ),
                  );
                },
              ),
            ),
          ],
        ),
      ),
    );
  }
}
