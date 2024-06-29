import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:slrapp/custom/custom_login_button.dart';
import 'package:slrapp/custom/flush_bar_custom.dart';
import 'package:slrapp/custom/fonts.dart';
import 'package:slrapp/custom/pop_up_spinkits.dart';
import 'package:slrapp/custom/text_form_decoration.dart';
import 'package:slrapp/custom/themes.dart';
import 'package:slrapp/features/auth/model/register_response_model.dart';
import 'package:slrapp/features/auth/view/widgets/pop_up_items.dart';
import 'package:slrapp/features/auth/viewmodel/auth_view_model.dart';

class AddInformationScreen extends StatefulWidget {
  final String name;
  final String mobile;
  const AddInformationScreen({Key? key, required this.name, required this.mobile}) : super(key: key);

  @override
  State<AddInformationScreen> createState() => _AddInformationScreenState();
}

class _AddInformationScreenState extends State<AddInformationScreen> {
  int? id;
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();
  TextEditingController gatePassNoController = TextEditingController();
  TextEditingController companyController = TextEditingController();

  @override
  void initState() {
    super.initState();
    getId();
    initializeDropdowns();
  }

  void initializeDropdowns() {
    final addInformationViewModel =
        Provider.of<Authviewmodel>(context, listen: false);
    addInformationViewModel.crewController.clear();
    addInformationViewModel.designationController.clear();
    addInformationViewModel.rigController.clear();
    gatePassNoController.clear();
    addInformationViewModel.projectController.clear();
    companyController.clear();
    addInformationViewModel.getProject();
    addInformationViewModel.getAllcrews();
  }

  Future<void> getId() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    setState(() {
      id = prefs.getInt('userId');
    });
  }

  @override
  Widget build(BuildContext context) {
    final addInformationViewModel = Provider.of<Authviewmodel>(context);

    return Scaffold(
      backgroundColor: themeColor,
      body: SafeArea(
        child: Container(
          color: Colors.white,
          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 12.0),
            child: ListView(
              children: [
                addInformationViewModel.isLoading?
                Padding(
                  padding: const EdgeInsets.only(top: 350),
                  child: Center(child: spinKits(colors: themeColor)),
                ):
                Form(
                  key: _formKey,
                  child: Column(
                    children: [
                      const SizedBox(height: 20),
                      Center(
                        child: Text(
                          "Add Information",
                          style: normalFonts(20, Colors.black, FontWeight.w600),
                        ),
                      ),
                      const SizedBox(height: 30),
                      TextFormField(
                        keyboardType: TextInputType.number,
                        controller: gatePassNoController,
                        validator: (value) {
                          if (value == null || value.isEmpty) {
                            return "This field is required";
                          }
                          return null;
                        },
                        decoration: emailField(
                            hintText: "Gate Pass No.",
                            labelText: "Gate Pass No.",
                            data: null),
                      ),
                      const SizedBox(height: 12),
                      TextFormField(
                        readOnly: true,
                        controller: addInformationViewModel.crewController,
                        onTap: () {
                          showPopUpCustom(
                              context: context,
                              crew: addInformationViewModel.crewlist);
                        },
                        decoration: emailField(
                            hintText: "Select Company",
                            labelText: "Select Company",
                            data: Icons.keyboard_arrow_down_sharp),
                        validator: (value) {
                          if (value == null || value.isEmpty) {
                            return "This field is required";
                          }
                          return null;
                        },
                      ),
                        SizedBox(
                          height: 16,
                        ),
                        TextFormField(
                          controller:
                              addInformationViewModel.designationController,
                          decoration: emailField(
                              hintText: "Designation",
                              labelText: "Designation",
                              data: null),
                          validator: (value) {
                            if (value == null || value.isEmpty) {
                              return "This field is required";
                            }
                            return null;
                          },
                        ),
                      const SizedBox(height: 12),
                      TextFormField(
                        readOnly: true,
                        controller: addInformationViewModel.rigController,
                        onTap: () {
                          showPopUpRig(
                              context: context,
                              rig: addInformationViewModel.rig);
                        },
                        decoration: emailField(
                            hintText: "Select Rig",
                            labelText: "Select Rig",
                            data: Icons.keyboard_arrow_down_sharp),
                        validator: (value) {
                          if (value == null || value.isEmpty) {
                            return "This field is required";
                          }
                          return null;
                        },
                      ),
                      const SizedBox(height: 12),
                      TextFormField(
                        onTap: () {
                          selectProject(context: context, projects: addInformationViewModel.getAllProjects);
                        },
                        readOnly: true,
                        controller: addInformationViewModel.projectController,
                        validator: (value) {
                          if (value == null || value.isEmpty) {
                            return "This field is required";
                          }
                          return null;
                        },
                        decoration: emailField(
                            hintText: "Project Name",
                            labelText: "Project",
                            data: Icons.keyboard_arrow_down_rounded),
                      ),
                      const SizedBox(height: 20),
                      customButton(
                        text: "Submit",
                        onTap: () {
                          if (_formKey.currentState!.validate()) {
                            addInformationViewModel.registerUser(
                                registerresponseModel: RegisterresponseModel(
                                    gatePassNo: gatePassNoController.text,
                                    rigOrRigless: addInformationViewModel.rigController.text,
                                    projectName: addInformationViewModel.projectController.text,
                                    companyName: addInformationViewModel.crewController.text,
                                    designationName: addInformationViewModel.designationController.text,
                                    mobileNumber: widget.mobile,
                                    fullName: widget.name,
                                     projectId: addInformationViewModel.ProjectId,
                                     companyId: addInformationViewModel.companyId),
                                context: context);
                          } else {
                            customFlushBar(
                              context: context,
                              message: "Please Fill All Fields",
                              color: Colors.red,
                            );
                          }
                        },
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
