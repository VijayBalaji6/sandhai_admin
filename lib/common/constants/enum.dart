import 'dart:ui';

enum DashboardBottomNavBarItem {
  home(name: 'Home', indexValue: 0),
  history(name: 'History', indexValue: 1),
  support(name: 'Support', indexValue: 2),
  products(name: 'Products', indexValue: 3);

  final String name;
  final int indexValue;

  const DashboardBottomNavBarItem({
    required this.name,
    required this.indexValue,
  });
}

enum Product {
  supplyChainFinancing(value: 'invoiceFinancing', title: "Invoice Financing"),
  termLoan(value: 'termLoan', title: "Term Loan");

  final String value;
  final String title;
  const Product({required this.value, required this.title});
}

enum ApplyProductFeature {
  flexibleRepayment(title: 'Flexible Repayment'),
  longerTenure(title: 'Longer Tenure'),
  lowestInterest(title: 'Lowest Interest');

  final String title;

  const ApplyProductFeature({required this.title});
}

enum ProductStatus {
  active(status: 'Active', statusColor: Color(0xFF00A86B)),
  inactive(status: 'In Active', statusColor: Color(0xFF00A86B)),
  pending(status: 'Pending', statusColor: Color(0xFF00A86B)),
  closed(status: 'Closed', statusColor: Color.fromARGB(255, 205, 240, 29));

  final String status;
  final Color statusColor;

  const ProductStatus({required this.status, required this.statusColor});
}

enum TermLoanPaymentStatus {
  partially(status: "PARTIALLY"),
  pending(status: "PENDING"),
  upcoming(status: "UPCOMING"),
  penalty(status: "PENALTY"),
  overDue(status: "OVERDUE"),
  unKnown(status: "UNKNOWN");

  final String status;

  const TermLoanPaymentStatus({required this.status});
}

enum RepaymentStatus {
  paid(status: "PAID"),
  penalty(status: "PENALTY"),
  partially(status: "PARTIALLY"),
  unKnown(status: "UNKNOWN");

  final String status;

  const RepaymentStatus({required this.status});
}
