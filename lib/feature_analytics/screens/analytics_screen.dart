import 'package:flutter/material.dart';
import 'package:fl_chart/fl_chart.dart';
import 'package:intl/intl.dart';
import 'package:share_plus/share_plus.dart';

class AnalyticsScreen extends StatefulWidget {
  const AnalyticsScreen({super.key});

  @override
  State<AnalyticsScreen> createState() => _AnalyticsScreenState();
}

class _AnalyticsScreenState extends State<AnalyticsScreen>
    with SingleTickerProviderStateMixin {
  int _selectedPeriod = 0;
  final List<String> _periods = ['Week', 'Month', 'Year'];
  String _selectedChart = 'Spending';
  final List<String> _charts = ['Spending', 'Income', 'Balance'];
  late AnimationController _animationController;
  late Animation<double> _fadeAnimation;
  late Animation<Offset> _slideAnimation;

  @override
  void initState() {
    super.initState();
    _animationController = AnimationController(
      vsync: this,
      duration: const Duration(milliseconds: 500),
    );
    _fadeAnimation = Tween<double>(begin: 0.0, end: 1.0).animate(
      CurvedAnimation(
        parent: _animationController,
        curve: Curves.easeIn,
      ),
    );
    _slideAnimation = Tween<Offset>(
      begin: const Offset(0, 0.1),
      end: Offset.zero,
    ).animate(
      CurvedAnimation(
        parent: _animationController,
        curve: Curves.easeOut,
      ),
    );
    _animationController.forward();
  }

  @override
  void dispose() {
    _animationController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: CustomScrollView(
        slivers: [
          // Custom App Bar
          SliverAppBar(
            expandedHeight: 120,
            pinned: true,
            flexibleSpace: FlexibleSpaceBar(
              background: Container(
                decoration: BoxDecoration(
                  gradient: LinearGradient(
                    begin: Alignment.topCenter,
                    end: Alignment.bottomCenter,
                    colors: [
                      Theme.of(context).primaryColor,
                      Theme.of(context).primaryColor.withOpacity(0.8),
                    ],
                  ),
                ),
                child: SafeArea(
                  child: Padding(
                    padding: const EdgeInsets.all(16.0),
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        const Text(
                          'Analytics',
                          style: TextStyle(
                            color: Colors.white,
                            fontSize: 24,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
              ),
            ),
            actions: [
              IconButton(
                icon: const Icon(Icons.share, color: Colors.white),
                onPressed: _exportAnalytics,
              ),
            ],
          ),
          // Content
          SliverToBoxAdapter(
            child: Padding(
              padding: const EdgeInsets.all(16.0),
              child: Column(
                children: [
                  // Summary Cards
                  FadeTransition(
                    opacity: _fadeAnimation,
                    child: SlideTransition(
                      position: _slideAnimation,
                      child: Row(
                        children: [
                          Expanded(
                            child: _buildSummaryCard(
                              title: 'Total Income',
                              amount: 'MWK 45,000',
                              change: '+12.5%',
                              isPositive: true,
                              icon: Icons.arrow_upward,
                            ),
                          ),
                          const SizedBox(width: 16),
                          Expanded(
                            child: _buildSummaryCard(
                              title: 'Total Expenses',
                              amount: 'MWK 32,000',
                              change: '-8.3%',
                              isPositive: false,
                              icon: Icons.arrow_downward,
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                  const SizedBox(height: 24),

                  // Chart Section
                  FadeTransition(
                    opacity: _fadeAnimation,
                    child: SlideTransition(
                      position: _slideAnimation,
                      child: Card(
                        elevation: 2,
                        shadowColor: Colors.grey.withOpacity(0.1),
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(16),
                        ),
                        child: Padding(
                          padding: const EdgeInsets.all(16),
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Row(
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceBetween,
                                children: [
                                  const Text(
                                    'Overview',
                                    style: TextStyle(
                                      fontSize: 18,
                                      fontWeight: FontWeight.bold,
                                    ),
                                  ),
                                  Container(
                                    decoration: BoxDecoration(
                                      color: Colors.grey[100],
                                      borderRadius: BorderRadius.circular(8),
                                    ),
                                    child: Row(
                                      children: List.generate(
                                        _charts.length,
                                        (index) => GestureDetector(
                                          onTap: () {
                                            setState(() {
                                              _selectedChart = _charts[index];
                                            });
                                          },
                                          child: Container(
                                            padding: const EdgeInsets.symmetric(
                                              horizontal: 12,
                                              vertical: 6,
                                            ),
                                            decoration: BoxDecoration(
                                              color: _selectedChart ==
                                                      _charts[index]
                                                  ? Theme.of(context)
                                                      .primaryColor
                                                  : Colors.transparent,
                                              borderRadius:
                                                  BorderRadius.circular(8),
                                            ),
                                            child: Text(
                                              _charts[index],
                                              style: TextStyle(
                                                color: _selectedChart ==
                                                        _charts[index]
                                                    ? Colors.white
                                                    : Colors.grey[600],
                                                fontWeight: FontWeight.bold,
                                              ),
                                            ),
                                          ),
                                        ),
                                      ),
                                    ),
                                  ),
                                ],
                              ),
                              const SizedBox(height: 24),
                              // Period Selector
                              Container(
                                decoration: BoxDecoration(
                                  color: Colors.grey[100],
                                  borderRadius: BorderRadius.circular(8),
                                ),
                                child: Row(
                                  children: List.generate(
                                    _periods.length,
                                    (index) => Expanded(
                                      child: GestureDetector(
                                        onTap: () {
                                          setState(() {
                                            _selectedPeriod = index;
                                          });
                                        },
                                        child: Container(
                                          padding: const EdgeInsets.symmetric(
                                              vertical: 8),
                                          decoration: BoxDecoration(
                                            color: _selectedPeriod == index
                                                ? Theme.of(context).primaryColor
                                                : Colors.transparent,
                                            borderRadius:
                                                BorderRadius.circular(8),
                                          ),
                                          child: Text(
                                            _periods[index],
                                            textAlign: TextAlign.center,
                                            style: TextStyle(
                                              color: _selectedPeriod == index
                                                  ? Colors.white
                                                  : Colors.grey[600],
                                              fontWeight: FontWeight.bold,
                                            ),
                                          ),
                                        ),
                                      ),
                                    ),
                                  ),
                                ),
                              ),
                              const SizedBox(height: 24),
                              // Chart
                              SizedBox(
                                height: 300,
                                child: LineChart(
                                  LineChartData(
                                    gridData: FlGridData(
                                      show: true,
                                      drawVerticalLine: false,
                                      horizontalInterval: 1,
                                      getDrawingHorizontalLine: (value) {
                                        return FlLine(
                                          color: Colors.grey[300],
                                          strokeWidth: 1,
                                        );
                                      },
                                    ),
                                    titlesData: FlTitlesData(
                                      show: true,
                                      rightTitles: const AxisTitles(
                                        sideTitles:
                                            SideTitles(showTitles: false),
                                      ),
                                      topTitles: const AxisTitles(
                                        sideTitles:
                                            SideTitles(showTitles: false),
                                      ),
                                      bottomTitles: AxisTitles(
                                        sideTitles: SideTitles(
                                          showTitles: true,
                                          reservedSize: 30,
                                          interval: 1,
                                          getTitlesWidget: (value, meta) {
                                            const style = TextStyle(
                                              color: Colors.grey,
                                              fontSize: 12,
                                            );
                                            String text;
                                            switch (value.toInt()) {
                                              case 0:
                                                text = 'Mon';
                                                break;
                                              case 1:
                                                text = 'Tue';
                                                break;
                                              case 2:
                                                text = 'Wed';
                                                break;
                                              case 3:
                                                text = 'Thu';
                                                break;
                                              case 4:
                                                text = 'Fri';
                                                break;
                                              case 5:
                                                text = 'Sat';
                                                break;
                                              case 6:
                                                text = 'Sun';
                                                break;
                                              default:
                                                text = '';
                                            }
                                            return SideTitleWidget(
                                              axisSide: meta.axisSide,
                                              child: Text(text, style: style),
                                            );
                                          },
                                        ),
                                      ),
                                      leftTitles: AxisTitles(
                                        sideTitles: SideTitles(
                                          showTitles: true,
                                          interval: 1,
                                          getTitlesWidget: (value, meta) {
                                            const style = TextStyle(
                                              color: Colors.grey,
                                              fontSize: 12,
                                            );
                                            return SideTitleWidget(
                                              axisSide: meta.axisSide,
                                              child: Text(
                                                'MWK ${value.toInt()}K',
                                                style: style,
                                              ),
                                            );
                                          },
                                          reservedSize: 42,
                                        ),
                                      ),
                                    ),
                                    borderData: FlBorderData(show: false),
                                    minX: 0,
                                    maxX: 6,
                                    minY: 0,
                                    maxY: 6,
                                    lineBarsData: [
                                      LineChartBarData(
                                        spots: [
                                          const FlSpot(0, 3),
                                          const FlSpot(1, 1),
                                          const FlSpot(2, 4),
                                          const FlSpot(3, 2),
                                          const FlSpot(4, 5),
                                          const FlSpot(5, 3),
                                          const FlSpot(6, 4),
                                        ],
                                        isCurved: true,
                                        color: Theme.of(context).primaryColor,
                                        barWidth: 3,
                                        isStrokeCapRound: true,
                                        dotData: FlDotData(
                                          show: true,
                                          getDotPainter:
                                              (spot, percent, barData, index) {
                                            return FlDotCirclePainter(
                                              radius: 4,
                                              color: Theme.of(context)
                                                  .primaryColor,
                                              strokeWidth: 2,
                                              strokeColor: Colors.white,
                                            );
                                          },
                                        ),
                                        belowBarData: BarAreaData(
                                          show: true,
                                          color: Theme.of(context)
                                              .primaryColor
                                              .withOpacity(0.1),
                                        ),
                                      ),
                                    ],
                                  ),
                                ),
                              ),
                            ],
                          ),
                        ),
                      ),
                    ),
                  ),
                  const SizedBox(height: 24),

                  // Categories Section
                  FadeTransition(
                    opacity: _fadeAnimation,
                    child: SlideTransition(
                      position: _slideAnimation,
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          _buildSectionHeader(
                            context,
                            'Spending by Category',
                            Icons.category_outlined,
                          ),
                          Card(
                            elevation: 2,
                            shadowColor: Colors.grey.withOpacity(0.1),
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(16),
                            ),
                            child: Padding(
                              padding: const EdgeInsets.all(24),
                              child: Column(
                                children: [
                                  _buildCategoryItem(
                                    title: 'Food & Dining',
                                    amount: 'MWK 12,000',
                                    percentage: 35,
                                    color: Colors.blue,
                                  ),
                                  const SizedBox(height: 16),
                                  _buildCategoryItem(
                                    title: 'Transportation',
                                    amount: 'MWK 8,000',
                                    percentage: 25,
                                    color: Colors.orange,
                                  ),
                                  const SizedBox(height: 16),
                                  _buildCategoryItem(
                                    title: 'Shopping',
                                    amount: 'MWK 6,000',
                                    percentage: 18,
                                    color: Colors.purple,
                                  ),
                                  const SizedBox(height: 16),
                                  _buildCategoryItem(
                                    title: 'Bills & Utilities',
                                    amount: 'MWK 4,000',
                                    percentage: 12,
                                    color: Colors.red,
                                  ),
                                  const SizedBox(height: 16),
                                  _buildCategoryItem(
                                    title: 'Entertainment',
                                    amount: 'MWK 2,000',
                                    percentage: 10,
                                    color: Colors.green,
                                  ),
                                ],
                              ),
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                  const SizedBox(height: 24),

                  // Top Transactions Section
                  FadeTransition(
                    opacity: _fadeAnimation,
                    child: SlideTransition(
                      position: _slideAnimation,
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          _buildSectionHeader(
                            context,
                            'Top Transactions',
                            Icons.star_outline,
                          ),
                          Card(
                            elevation: 2,
                            shadowColor: Colors.grey.withOpacity(0.1),
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(16),
                            ),
                            child: ListView.separated(
                              shrinkWrap: true,
                              physics: const NeverScrollableScrollPhysics(),
                              itemCount: 5,
                              separatorBuilder: (context, index) =>
                                  const Divider(height: 1),
                              itemBuilder: (context, index) {
                                return ListTile(
                                  leading: Container(
                                    padding: const EdgeInsets.all(8),
                                    decoration: BoxDecoration(
                                      color: (index % 2 == 0
                                              ? Colors.green
                                              : Colors.red)
                                          .withOpacity(0.1),
                                      borderRadius: BorderRadius.circular(8),
                                    ),
                                    child: Icon(
                                      index % 2 == 0
                                          ? Icons.arrow_upward
                                          : Icons.arrow_downward,
                                      color: index % 2 == 0
                                          ? Colors.green
                                          : Colors.red,
                                    ),
                                  ),
                                  title: Text(
                                    index % 2 == 0 ? 'Salary' : 'Rent',
                                    style: const TextStyle(
                                      fontWeight: FontWeight.bold,
                                    ),
                                  ),
                                  subtitle: Text(
                                    '${index + 1} day${index == 0 ? '' : 's'} ago',
                                    style: TextStyle(
                                      color: Colors.grey[600],
                                    ),
                                  ),
                                  trailing: Text(
                                    'MWK ${(index + 1) * 5000}.00',
                                    style: TextStyle(
                                      color: index % 2 == 0
                                          ? Colors.green
                                          : Colors.red,
                                      fontWeight: FontWeight.bold,
                                    ),
                                  ),
                                );
                              },
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildSectionHeader(
      BuildContext context, String title, IconData icon) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 8),
      child: Row(
        children: [
          Icon(icon, color: Theme.of(context).primaryColor, size: 20),
          const SizedBox(width: 8),
          Text(
            title,
            style: Theme.of(context).textTheme.titleMedium?.copyWith(
                  color: Theme.of(context).primaryColor,
                  fontWeight: FontWeight.bold,
                ),
          ),
        ],
      ),
    );
  }

  Widget _buildSummaryCard({
    required String title,
    required String amount,
    required String change,
    required bool isPositive,
    required IconData icon,
  }) {
    return Card(
      elevation: 2,
      shadowColor: Colors.grey.withOpacity(0.1),
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(16),
      ),
      child: Padding(
        padding: const EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              title,
              style: TextStyle(
                color: Colors.grey[600],
                fontSize: 14,
              ),
            ),
            const SizedBox(height: 8),
            Text(
              amount,
              style: const TextStyle(
                fontSize: 24,
                fontWeight: FontWeight.bold,
              ),
            ),
            const SizedBox(height: 8),
            Row(
              children: [
                Icon(
                  icon,
                  color: isPositive ? Colors.green : Colors.red,
                  size: 16,
                ),
                const SizedBox(width: 4),
                Text(
                  change,
                  style: TextStyle(
                    color: isPositive ? Colors.green : Colors.red,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildCategoryItem({
    required String title,
    required String amount,
    required double percentage,
    required Color color,
  }) {
    return Column(
      children: [
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Row(
              children: [
                Container(
                  width: 12,
                  height: 12,
                  decoration: BoxDecoration(
                    color: color,
                    shape: BoxShape.circle,
                  ),
                ),
                const SizedBox(width: 8),
                Text(
                  title,
                  style: const TextStyle(
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ],
            ),
            Text(
              amount,
              style: TextStyle(
                color: Colors.grey[600],
                fontWeight: FontWeight.bold,
              ),
            ),
          ],
        ),
        const SizedBox(height: 8),
        ClipRRect(
          borderRadius: BorderRadius.circular(4),
          child: LinearProgressIndicator(
            value: percentage / 100,
            backgroundColor: color.withOpacity(0.1),
            valueColor: AlwaysStoppedAnimation<Color>(color),
            minHeight: 8,
          ),
        ),
      ],
    );
  }

  void _exportAnalytics() async {
    final now = DateTime.now();
    final formattedDate = DateFormat('yyyy-MM-dd').format(now);
    final message = '''
Analytics Report - $formattedDate

Period: ${_periods[_selectedPeriod]}

Summary:
- Total Income: MWK 45,000 (+12.5%)
- Total Expenses: MWK 32,000 (-8.3%)
- Net Balance: MWK 13,000

Spending by Category:
- Food & Dining: MWK 12,000 (35%)
- Transportation: MWK 8,000 (25%)
- Shopping: MWK 6,000 (18%)
- Bills & Utilities: MWK 4,000 (12%)
- Entertainment: MWK 2,000 (10%)

Top Transactions:
1. Salary - MWK 25,000 (Income)
2. Rent - MWK 15,000 (Expense)
3. Project Payment - MWK 10,000 (Income)
4. Groceries - MWK 8,000 (Expense)
5. Freelance Work - MWK 5,000 (Income)

Generated by Nyasa Send
''';

    await Share.share(message, subject: 'Nyasa Send Analytics Report');
  }
}
