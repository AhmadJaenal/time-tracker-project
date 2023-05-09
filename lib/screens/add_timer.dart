import 'package:flutter/material.dart';

import '../shared/theme.dart';

class AddTimer extends StatelessWidget {
  const AddTimer({super.key});

  @override
  Widget build(BuildContext context) {
    TextEditingController titleController = TextEditingController();
    TextEditingController dscController = TextEditingController();
    TextEditingController typeController = TextEditingController();
    return Scaffold(
      body: Padding(
        padding: EdgeInsets.symmetric(horizontal: margin, vertical: 42),
        child: Column(
          children: [
            Center(
              child: Text(
                'Add Task',
                style: Theme.of(context).textTheme.titleLarge,
              ),
            ),
            Container(
              margin: const EdgeInsets.only(top: 32),
              width: double.infinity,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    'Title Task',
                    style: Theme.of(context).textTheme.bodyMedium,
                  ),
                  const SizedBox(height: 16),
                  inputTextField(controller: titleController)
                ],
              ),
            ),
            const SizedBox(),
            Container(
              margin: const EdgeInsets.only(top: 16),
              width: double.infinity,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    'Description Task',
                    style: Theme.of(context).textTheme.bodyMedium,
                  ),
                  const SizedBox(height: 16),
                  inputTextField(controller: dscController)
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class inputTextField extends StatelessWidget {
  TextEditingController controller = TextEditingController();
  inputTextField({
    super.key,
    required this.controller,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 48,
      child: TextField(
        cursorColor: blueColor,
        decoration: InputDecoration(
          enabledBorder: OutlineInputBorder(
            borderRadius: BorderRadius.circular(10),
            borderSide: BorderSide(
              color: grayColor.withOpacity(.5),
              width: 2,
            ),
          ),
          focusedBorder: OutlineInputBorder(
            borderRadius: BorderRadius.circular(10),
            borderSide: BorderSide(
              color: blueColor,
              width: 2,
            ),
          ),
        ),
      ),
    );
  }
}
