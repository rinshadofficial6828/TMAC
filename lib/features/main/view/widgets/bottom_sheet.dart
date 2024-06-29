import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:slrapp/custom/fonts.dart';
import 'package:slrapp/custom/pop_up_spinkits.dart';
import 'package:slrapp/custom/themes.dart';
import 'package:slrapp/features/main/viewmodel/user_view_model.dart';

class SubTrainingDetails extends StatefulWidget {
  final String maintext;
  const SubTrainingDetails({super.key, required this.maintext});

  @override
  State<SubTrainingDetails> createState() => _SubTrainingDetailsState();
}

class _SubTrainingDetailsState extends State<SubTrainingDetails> {
  @override
  void initState() {
    super.initState();
    final subTrainingviewModel = Provider.of<UserViewModel>(context, listen: false);
    subTrainingviewModel.getSubTraining(itemId: subTrainingviewModel.percentageId ?? 0);
  }

  @override
  Widget build(BuildContext context) {
    final subTrainingviewModel = Provider.of<UserViewModel>(context);

    return Scaffold(
      appBar: AppBar(),
      body: SafeArea(
        child: ListView(
          children:[ Padding(
            padding: const EdgeInsets.only(left: 20, right: 20, bottom: 10,),
            child: Column(
              children: [
                SizedBox(height: 20),
                customSubtraining(
                  mainColor: themeColor,
                  text: widget.maintext,
                  text2: subTrainingviewModel.SubdataPercentage ?? "0",
                  textColor: Colors.white,
                  percentageColor:subTrainingviewModel.submainperscentage > 90 ?  Colors.yellow : Colors.red,
                  context: context,
                ),
                SizedBox(height: 12),
                subTrainingviewModel.isLoading ? Padding(
                  padding: const EdgeInsets.only(top: 100),
                  child: Center(child: spinKits(colors: themeColor),),
                ):SizedBox(),
                subTrainingviewModel.subTrainings.isNotEmpty ?
                ListView.separated(
                  physics: NeverScrollableScrollPhysics(),
                  separatorBuilder: (context, index) => SizedBox(height: 12),
                  shrinkWrap: true,
                  itemCount: subTrainingviewModel.subTrainings.length,
                  itemBuilder: (context, index) {
                    final trainings = subTrainingviewModel.subTrainings[index];
                    dynamic completionPercentage = trainings.completionPercentage ?? 0;
                    dynamic percentagesShow(){
                      if(completionPercentage < 1 || completionPercentage < 1.0){
                      return "0 %";
                      }else{
                        return "100 %";
                      }
                    }
                    return customSubtraining(
                      mainColor: trainings.warning == true ? const Color.fromARGB(255, 244, 16, 0):  Colors.white,
                      text: trainings.subTrainingName ?? "",
                      text2:trainings.startDate ==null ? "Not started": percentagesShow(),
                      textColor: Colors.black,
                      percentageColor: completionPercentage != 0  ? Colors.green : trainings.warning == true ? Colors.black : Colors.red,
                      context: context,
                    );
                  },
                ): !subTrainingviewModel.isLoading ? Padding(
                  padding: const EdgeInsets.only(top: 80),
                  child: Center(
                    child: Text("No Sub trainings Found",style: normalFonts(15, Colors.black, FontWeight.bold),),
                  ),
                ):SizedBox()
              ],
            ),
          ),
          ]
        ),
      ),
    );
  }
}

Widget customSubtraining({
  required Color mainColor,
  required String text,
  required String text2,
  required Color textColor,
  required Color percentageColor,
  required BuildContext context,
  required
}) {
  return Container(
    decoration: BoxDecoration(
      color: mainColor,
      boxShadow: [
        BoxShadow(
          color: Colors.grey,
          spreadRadius: 1,
          blurRadius: 3,
        ),
      ],
      borderRadius: BorderRadius.circular(5),
    ),
    child: Padding(
      padding: EdgeInsets.only(left: 16, right: 16, top: 20, bottom: 20),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          SizedBox(
            width: MediaQuery.of(context).size.width * .6,
            child: Text(
              text,
              style: normalFonts(12, textColor, FontWeight.w500),
            ),
          ),
          SizedBox(
            width: MediaQuery.of(context).size.width *.2,
            child: Text(
              text2,
              textAlign: TextAlign.end,
              style: normalFonts(16, percentageColor, FontWeight.w500,),
            ),
          ),
        ],
      ),
    ),
  );
}
