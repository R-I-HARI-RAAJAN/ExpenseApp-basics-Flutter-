import 'package:flutter/material.dart';

class EmployeePage extends StatefulWidget {
  const EmployeePage({super.key});

  @override
  State<EmployeePage> createState() => _EmployeePageState();
}

class _EmployeePageState extends State<EmployeePage> {
  List<Map<String, String>> employees = [
    {
      "name": "John Doe",
      "position": "Software Engineer",
      "imageUrl": "https://picsum.photos/200",
    },
    {
      "name": "David",
      "position": "Manager",
      "imageUrl": "https://picsum.photos/201",
    },
  ];

  void addEmployee() {
    TextEditingController nameController = TextEditingController();
    TextEditingController positionController = TextEditingController();
    TextEditingController imageController = TextEditingController();

    showDialog(
      context: context,
      builder: (context) {
        return AlertDialog(
          title: const Text("Add Employee"),

          content: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              TextField(
                controller: nameController,
                decoration: const InputDecoration(labelText: "Name"),
              ),

              TextField(
                controller: positionController,
                decoration: const InputDecoration(labelText: "Position"),
              ),

              TextField(
                controller: imageController,
                decoration: const InputDecoration(labelText: "Image URL"),
              ),
            ],
          ),

          actions: [
            ElevatedButton(
              onPressed: () {
                setState(() {
                  employees.add({
                    "name": nameController.text,
                    "position": positionController.text,
                    "imageUrl": imageController.text,
                  });
                });

                Navigator.pop(context);
              },
              child: const Text("Add"),
            ),
          ],
        );
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Employees"),
        backgroundColor: const Color.fromARGB(226, 224, 123, 219),
      ),

      body: ListView.builder(
        itemCount: employees.length,

        itemBuilder: (context, index) {
          String url = employees[index]["imageUrl"] ?? "";

          return Card(
            margin: const EdgeInsets.all(10),

            child: ListTile(
              leading: CircleAvatar(
                radius: 30,
                backgroundColor: Colors.grey[300],

                child: ClipOval(
                  child: Image.network(
                    url,
                    width: 60,
                    height: 60,
                    fit: BoxFit.cover,

                    errorBuilder: (context, error, stackTrace) {
                      return const Icon(Icons.person, size: 30);
                    },
                  ),
                ),
              ),

              title: Text(
                employees[index]["name"]!,
                style: const TextStyle(
                  fontSize: 18,
                  fontWeight: FontWeight.bold,
                ),
              ),

              subtitle: Text(employees[index]["position"]!),
            ),
          );
        },
      ),

      floatingActionButton: FloatingActionButton(
        onPressed: addEmployee,
        child: const Icon(Icons.add),
      ),
    );
  }
}
