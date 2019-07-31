import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:time_tracker_flutter_course/common_widgets/platform_alert_dialog.dart';
import 'package:time_tracker_flutter_course/common_widgets/platform_exception_alert_dialog.dart';
import 'package:time_tracker_flutter_course/common_widgets/platform_toolbar.dart';
import 'package:time_tracker_flutter_course/common_widgets/platform_toolbar_action.dart';
import 'package:time_tracker_flutter_course/pages/jobs/models/job.dart';
import 'package:time_tracker_flutter_course/services/database.dart';
import 'package:flutter/services.dart';


class EditJobPage extends StatefulWidget {
  const EditJobPage({Key key, @required this.database, this.job}) : super(key: key);
  final Job job;
  final Database database;

  static Future<void> show(BuildContext context, {Job job}) async {
    Database database = Provider.of<Database>(context);
    await
    Navigator.of(context).push(new MaterialPageRoute(
      builder: (context) => EditJobPage(database: database, job: job,),
      fullscreenDialog: true,
    ));
  }

  @override
  State<StatefulWidget> createState() {
    return EditJobPageState();
  }
}

class EditJobPageState extends State<EditJobPage> {

  final _formKey = GlobalKey<FormState>();
  String _name;
  int _ratePerHour;
  @override
  void initState() {
    super.initState();
    if(widget.job != null){
      _name = widget.job.name;
      _ratePerHour = widget.job.ratePerHour;
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: PlatformToolbar(
        title: Text(widget.job == null ? "New Job" : "Edit Job"),
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
        initialValue: _name,
        decoration: InputDecoration(labelText: "Job name"),
        onSaved: (value) => _name = value,
        validator: (value) => value.isNotEmpty ? null : "Name cant be empty",
      ),
      TextFormField(
        initialValue: _ratePerHour != null ? "$_ratePerHour" : null,
        decoration: InputDecoration(labelText: "Rate per hour"),
        keyboardType: TextInputType.numberWithOptions(
          signed: false,
          decimal: false,
        ), onSaved: (rate) => _ratePerHour = int.tryParse(rate),
      ),
    ];
  }

  Future<void> _submit() async {
    if (_validateAndSaveForm()) {
      try {
        final jobs = await widget.database
            .jobsStream()
            .first;

        final allNames = jobs.map((job) => job.name).toList();
        if(widget.job != null){
          allNames.remove(widget.job.name);
        }
        if(allNames.contains(_name)){
          PlatformAlertDialog(
            title: "Name already used",
            content: "Please choose a different name",
            defaultActionText: "OK",
            actions: _buildActions(),
          ).show(context);
        } else {
          final id = widget.job?.id ?? _docIdFromDateTime();
          Job job = Job(name: _name, ratePerHour: _ratePerHour, id: id);
          await widget.database.setJob(job);
          Navigator.of(context).pop();
          print("Form validated and saved: name: $_name, ratePerHour: $_ratePerHour");
        }
      } on PlatformException catch (e) {
        PlatformExceptionAlertDialog platformAlertDialog = PlatformExceptionAlertDialog(
            title: "Oparation failed",
            exception: e,
            actions: _buildActions());
        platformAlertDialog.show(context).then((selection) {});
      }
    }
  }

  String _docIdFromDateTime() => DateTime.now().toIso8601String();

  List<Widget> _buildActions() {
    return [
      PlatformAlertDialogAction(
          child: Text("OK"),
          onPressed: () {
            Navigator.of(context).pop();
          })
    ];
  }

  bool _validateAndSaveForm() {
    final form = _formKey.currentState;
    if (form.validate()) {
      form.save();
      return true;
    }
    return false;
  }
}
