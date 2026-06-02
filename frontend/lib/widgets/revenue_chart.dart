import 'package:fl_chart/fl_chart.dart';
import 'package:flutter/material.dart';

class RevenueChart extends StatelessWidget {

  const RevenueChart({
    super.key,
  });

  @override
  Widget build(BuildContext context) {

    return Container(

      width: double.infinity,

      padding:
          const EdgeInsets.all(24),

      decoration: BoxDecoration(

        color: Colors.white,

        borderRadius:
            BorderRadius.circular(24),

        boxShadow: [

          BoxShadow(

            color:
                Colors.black.withOpacity(
              0.05,
            ),

            blurRadius: 10,
          ),
        ],
      ),

      child: Column(

        crossAxisAlignment:
            CrossAxisAlignment.start,

        children: [

          const Text(

            'Faturamento Semanal',

            style: TextStyle(

              fontSize: 20,

              fontWeight:
                  FontWeight.bold,
            ),
          ),

          const SizedBox(
            height: 24,
          ),

          SizedBox(

            height: 220,

            child: LineChart(

              LineChartData(

                minX: 0,
                maxX: 6,

                minY: 0,
                maxY: 600,

                gridData:
                    const FlGridData(
                  show: true,
                ),

                borderData:
                    FlBorderData(
                  show: false,
                ),

                titlesData:
                    const FlTitlesData(
                  topTitles:
                      AxisTitles(
                    sideTitles:
                        SideTitles(
                      showTitles: false,
                    ),
                  ),

                  rightTitles:
                      AxisTitles(
                    sideTitles:
                        SideTitles(
                      showTitles: false,
                    ),
                  ),
                ),

                lineBarsData: [

                  LineChartBarData(

                    isCurved: true,

                    barWidth: 5,

                    dotData:
                        const FlDotData(
                      show: true,
                    ),

                    spots: const [

                      FlSpot(0, 120),

                      FlSpot(1, 180),

                      FlSpot(2, 150),

                      FlSpot(3, 300),

                      FlSpot(4, 280),

                      FlSpot(5, 500),

                      FlSpot(6, 450),
                    ],
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}