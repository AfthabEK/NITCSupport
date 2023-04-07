import 'package:flutter/material.dart';
import 'my_filter_chip.dart';
import 'filter_chip_data.dart';
import 'admin_dashboard.dart';

class add_mentors extends StatefulWidget {
  const add_mentors({Key? key}) : super(key: key);

  @override
  State<add_mentors> createState() => _add_mentorsState();
}

class _add_mentorsState extends State<add_mentors> {
  final double spacing = 8;

  final _productController = TextEditingController();
  final _productDesController = TextEditingController();
  bool? _listTileCheckBox = false;
  List<FilterChipData> filterChips = FilterChips.all;

  final _formKey = GlobalKey<FormState>();

  @override
  void dispose() {
    _productController.dispose();
    _productDesController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          backgroundColor: Colors.white,
          title: Text(
            "Add mentor",
            style: TextStyle(
              color: Colors.black,
              fontSize: 22,
              fontWeight: FontWeight.w600,
              letterSpacing: 1,
            ),
          ),
          leading: IconButton(
            onPressed: () {
              Navigator.of(context).push(
                MaterialPageRoute(
                  builder: (context) => AdminDashboard(),
                ),
              );
            },
            icon: Icon(
              Icons.arrow_back_ios,
              color: Colors.black,
              size: 30,
            ),
          ),
          centerTitle: true,
          elevation: 0,
        ),
        body: Container(
          padding: EdgeInsets.all(20.0),
          child: ListView(
            children: [
              const Text(
                "Add Mentor",
                style: TextStyle(fontWeight: FontWeight.bold, fontSize: 36),
              ),
              const SizedBox(height: 10.0),
              const Text("No field should be left empty."),
              const SizedBox(height: 30.0),
              Form(
                key: _formKey,
                child: Column(
                  children: [
                    MyTextField(
                        myController: _productController,
                        fieldName: "Username",
                        prefixIconColor: Color.fromARGB(255, 76, 116, 175)),
                    const SizedBox(height: 10.0),
                    MyTextField(
                        myController: _productDesController,
                        fieldName: "Password",
                        prefixIconColor: Color.fromARGB(255, 76, 116, 175)),
                    const SizedBox(height: 10.0),
                    const Text(
                      "Select appropriate tags: ",
                      style: TextStyle(
                          color: Color.fromARGB(255, 76, 116, 175),
                          fontSize: 24),
                    ),
                    Wrap(
                      runSpacing: spacing,
                      spacing: spacing,
                      children: filterChips
                          .map(
                            (filterChip) => FilterChip(
                              label: Text(filterChip.label),
                              labelStyle: TextStyle(
                                fontWeight: FontWeight.bold,
                                color: filterChip.color,
                              ),
                              backgroundColor:
                                  filterChip.color.withOpacity(0.1),
                              onSelected: (isSelected) => setState(() {
                                filterChips = filterChips.map((otherChip) {
                                  return filterChip == otherChip
                                      ? otherChip.copy(isSelected: isSelected)
                                      : otherChip;
                                }).toList();
                              }),
                              selected: filterChip.isSelected,
                              checkmarkColor: filterChip.color,
                              selectedColor: filterChip.color.withOpacity(0.25),
                            ),
                          )
                          .toList(),
                    ),
                    const SizedBox(height: 20.0),
                    myBtn(context),
                  ],
                ),
              ),
            ],
          ),
        ));
  }

  Widget buildFilterChips() => Wrap(
        runSpacing: spacing,
        spacing: spacing,
        children: filterChips
            .map((filterChip) => FilterChip(
                  label: Text(filterChip.label),
                  labelStyle: TextStyle(
                    fontWeight: FontWeight.bold,
                    color: filterChip.color,
                  ),
                  backgroundColor: filterChip.color.withOpacity(0.1),
                  onSelected: (isSelected) => setState(() {
                    filterChips = filterChips.map((otherChip) {
                      return filterChip == otherChip
                          ? otherChip.copy(isSelected: isSelected)
                          : otherChip;
                    }).toList();
                  }),
                  selected: filterChip.isSelected,
                  checkmarkColor: filterChip.color,
                  selectedColor: filterChip.color.withOpacity(0.25),
                ))
            .toList(),
      );

  OutlinedButton myBtn(BuildContext context) {
    return OutlinedButton(
      style: OutlinedButton.styleFrom(minimumSize: const Size(200, 50)),
      onPressed: () {
        Navigator.of(context).pushReplacement(
          MaterialPageRoute(
            builder: (context) => AdminDashboard(),
          ),
        );
      },
      child: Text(
        "Submit".toUpperCase(),
        style: const TextStyle(fontWeight: FontWeight.bold),
      ),
    );
  }
}

class MyTextField extends StatelessWidget {
  const MyTextField({
    Key? key,
    required this.fieldName,
    required this.myController,
    this.myIcon = Icons.verified_user_outlined,
    this.prefixIconColor = Colors.blueAccent,
  }) : super(key: key);

  final TextEditingController myController;
  final String fieldName;
  final IconData myIcon;
  final Color prefixIconColor;

  @override
  Widget build(BuildContext context) {
    return TextFormField(
      validator: (value) {
        if (value == null || value.isEmpty) {
          return 'Please enter some text';
        } else
          null;
      },
      controller: myController,
      decoration: InputDecoration(
          labelText: fieldName,
          prefixIcon: Icon(myIcon, color: prefixIconColor),
          border: const OutlineInputBorder(),
          focusedBorder: OutlineInputBorder(
            borderSide: BorderSide(color: Color.fromARGB(255, 76, 116, 175)),
          ),
          labelStyle:
              const TextStyle(color: Color.fromARGB(255, 76, 116, 175))),
    );
  }
}
