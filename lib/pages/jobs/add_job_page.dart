import 'package:flutter/material.dart';
import 'package:time_tracker_flutter_course/common_widgets/platform_toolbar.dart';
import 'package:time_tracker_flutter_course/common_widgets/platform_toolbar_action.dart';

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

  final _formKey = GlobalKey<FormState>();
  String name;
  int ratePerHour;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: PlatformToolbar(
        title: Text("New Job"),
        actions: <Widget>[
          PlatformFlatButton(
            title: Text("Save"),
            onPressed: _submit,
          )
        ],
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
      key: _formKey,
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
        onSaved: (value) => name = value,
        validator: (value) => value.isNotEmpty ? null : "Name cant be empty",
      ),
      TextFormField(
        decoration: InputDecoration(labelText: "Rate per hour"),
        keyboardType: TextInputType.numberWithOptions(
          signed: false,
          decimal: false,
        ),onSaved: (rate) => ratePerHour = int.parse(rate) ?? 0,
      ),
    ];
  }

  void _submit() {
    if(_validateAndSaveForm()){
      print("Form validated and saved: name: $name, ratePerHour: $ratePerHour");
      //TODO: Submit value to firestore
    }

  }

  bool _validateAndSaveForm(){
    final form = _formKey.currentState;
    if(form.validate()){
      form.save();
      return true;
    }
    return false;
  }
}
