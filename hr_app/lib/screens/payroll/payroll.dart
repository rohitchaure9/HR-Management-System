import 'package:flutter/material.dart';

bool money = false;
bool money2 = false;
bool money3 = false;
bool money4 = false;

class Payroll extends StatefulWidget {
  @override
  _PayrollState createState() => _PayrollState();
}

class _PayrollState extends State<Payroll> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Payroll'),
        centerTitle: true,
      ),
      body: ListView(
        children: [
          Padding(
            padding: const EdgeInsets.all(6.0),
            child: Card(
              child: ListTile(
                title: Text('50,000 INR'),
                subtitle: Text('Akshay | Dev Team'),
                trailing: money == false
                    ? ElevatedButton(
                        child: Text('Send'),
                        onPressed: () {
                          setState(() {
                            money = true;
                          });
                        },
                      )
                    : Text('Payment Done'),
              ),
            ),
          ),
          Padding(
            padding: const EdgeInsets.all(6.0),
            child: Card(
              child: ListTile(
                title: Text('75,000 INR'),
                subtitle: Text('Aditi | Manager'),
                trailing: money2 == false
                    ? ElevatedButton(
                        child: Text('Send'),
                        onPressed: () {
                          setState(() {
                            money2 = true;
                          });
                        },
                      )
                    : Text('Payment Done'),
              ),
            ),
          ),
          Padding(
            padding: const EdgeInsets.all(6.0),
            child: Card(
              child: ListTile(
                title: Text('40,000 INR'),
                subtitle: Text('Arvind | Sales Team'),
                trailing: money3 == false
                    ? ElevatedButton(
                        child: Text('Send'),
                        onPressed: () {
                          setState(() {
                            money3 = true;
                          });
                        },
                      )
                    : Text('Payment Done'),
              ),
            ),
          ),
          Padding(
            padding: const EdgeInsets.all(6.0),
            child: Card(
              child: ListTile(
                title: Text('60,000 INR'),
                subtitle: Text('Vinay | Design Team'),
                trailing: money4 == false
                    ? ElevatedButton(
                        child: Text('Send'),
                        onPressed: () {
                          setState(() {
                            money4 = true;
                          });
                        },
                      )
                    : Text('Payment Done'),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
