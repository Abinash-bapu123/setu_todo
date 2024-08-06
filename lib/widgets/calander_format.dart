import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:setu_todo/utils/app_colors.dart';
import 'package:setu_todo/utils/extensions.dart';

class CalanderFormat extends StatefulWidget {
  const CalanderFormat({super.key});

  @override
  State<CalanderFormat> createState() => _CalanderFormatState();
}

class _CalanderFormatState extends State<CalanderFormat> {
  final DateTime now = DateTime.now();
  final List<int> numbers = List.generate(35, (index) => index + 1);
  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Text(
              "${now.monthName} ${now.year}",
              style: GoogleFonts.manrope(
                color: AppColors.appText,
                fontSize: 17,
                fontWeight: FontWeight.w500,
                height: 1.3,
              ),
            ),
            Row(
              children: [
                IconButton(
                  onPressed: () {},
                  icon: const Icon(
                    Icons.arrow_back_ios_sharp,
                    size: 12,
                  ),
                ),
                IconButton(
                  onPressed: () {},
                  icon: const Icon(
                    Icons.arrow_forward_ios_sharp,
                    size: 12,
                  ),
                ),
              ],
            )
          ],
        ),
        Expanded(
          child: Column(
            children: [
              Table(
                children: [
                  TableRow(
                    children: [
                      _buildHeaderCell('Mo'),
                      _buildHeaderCell('Tu'),
                      _buildHeaderCell('We'),
                      _buildHeaderCell('Th'),
                      _buildHeaderCell('Fr'),
                      _buildHeaderCell('Sa'),
                      _buildHeaderCell('Su'),
                    ],
                  )
                ],
              ),
              Table(
                border: TableBorder.all(
                  color: AppColors.buttonColor,
                  width: 0.5,
                ),
                children: _buildTableRows(),
              ),
            ],
          ),
        ),
      ],
    );
  }

  List<TableRow> _buildTableRows() {
    List<TableRow> rows = [];
    int index = 0;

    for (int i = 0; i < 5; i++) {
      List<Widget> cells = [];
      for (int j = 0; j < 7; j++) {
        cells.add(
          Container(
            height: 43,
            alignment: Alignment.center,
            child: Text(
              numbers[index].toString(),
              style: GoogleFonts.manrope(
                color: AppColors.buttonColor,
                fontSize: 10,
                fontWeight: FontWeight.w500,
              ),
            ),
          ),
        );
        index++;
      }
      rows.add(TableRow(children: cells));
    }
    return rows;
  }

  Widget _buildHeaderCell(String text) {
    return Container(
      height: 45,
      alignment: Alignment.center,
      child: Text(
        text,
        style: const TextStyle(
          fontSize: 10,
          fontWeight: FontWeight.bold,
        ),
      ),
    );
  }
}
