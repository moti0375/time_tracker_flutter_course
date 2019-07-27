import 'package:flutter/material.dart';
import 'package:time_tracker_flutter_course/common_widgets/platform_toolbar.dart';

class AddJobPage extends StatefulWidget {
  static Future<void> show(BuildContext context) async {
    await Navigator.of(context).push(new MaterialPageRoute(
      builder: (context) => AddJobPage(),
      fullscreenDialog: true,
    ));
  }

  @override
  State<StatefulWidget> createState() {
    return AddJobPageState();
  }
}

class AddJobPageState extends State<AddJobPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: PlatformToolbar(
        title: Text("New Job"),
        actions: <Widget>[],
      ).build(context),
      body: _buildContent(context),
      backgroundColor: Colors.grey[200],
    );
  }

  Widget _buildContent(BuildContext context) {
    return SingleChildScrollView(
      child: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Card(
          child: Padding(
            padding: const EdgeInsets.all(16.0),
            child: _buildForm(context),
          ),
        ),
      ),
    );
  }

  Widget _buildForm(BuildContext context) {
    return Form(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: _buildFormChildren(),
      ),
    );
  }

  List<Widget> _buildFormChildren() {
    return [
      TextFormField(
        decoration: InputDecoration(labelText: "Job name"),
      ),
      TextFormField(
        decoration: InputDecoration(labelText: "Rate per hour"),
        keyboardType: TextInputType.numberWithOptions(
          signed: false,
          decimal: false,
        ),
      ),
    ];
  }
}
