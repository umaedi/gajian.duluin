import 'package:cached_network_image/cached_network_image.dart';
import 'package:carousel_slider/carousel_slider.dart';
import 'package:duluin_app/contants/assets.dart';
import 'package:duluin_app/contants/color.dart';
import 'package:duluin_app/contants/routes.dart';
import 'package:duluin_app/controllers/account-controller.dart';
import 'package:duluin_app/controllers/user-controller.dart';
import 'package:duluin_app/models/user-model.dart';
import 'package:duluin_app/views/errors/empty-list-widget.dart';
import 'package:duluin_app/views/partials/header-navigation.dart';
import 'package:duluin_app/views/shimmer/dashboard-shimmer.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';

import '../contants/attribute.dart';
import '../controllers/banner-controller.dart';
import '../controllers/loan-controller.dart';
import '../data/loan-status.dart';
import '../data/register-status.dart';
import '../models/account-model.dart';
import '../models/banner-model.dart';
import '../models/loan-model.dart';
import '../services/currency-formatter.dart';
import '../services/date-formatter.dart';

class DashboardPage extends StatefulWidget {
  const DashboardPage({super.key});

  @override
  State<DashboardPage> createState() => _DashboardPageState();
}

class _DashboardPageState extends State<DashboardPage> {
  AccountController accountController = AccountController();
  UserController userController = UserController();
  LoanController loanController = LoanController();
  BannerController bannerController = BannerController();

  AccountModel? _accountData;
  UserModel? _userData;
  List<BannerModel>? _bannerData;
  List<LoanModel>? _loanTransaction;
  List<LoanModel>? _loanPayment;

  bool isLoading = false;
  String loanBarLevel = '';
  int _selectedIndex = 0;

  @override
  void initState() {
    super.initState();
    loadData();
  }

  Future<void> _getAccountData() async {
    AccountModel? accountData =
        await accountController.accountDataService(context);

    double calculateLevel = (1.0 -
            double.parse(accountData!.loanDebitAmount) /
                double.parse(accountData.loanMaxAmount))
        .clamp(0.0, 1.0);

    setState(() {
      _accountData = accountData;
      loanBarLevel = calculateLevel.toString();
    });
  }

  Future<void> _getUserData() async {
    UserModel? userData = await userController.currentUserDataService(context);
    setState(() {
      _userData = userData;
    });
  }

  Future<void> _getLoanData() async {
    List<LoanModel>? loanTransactionData =
        await loanController.loanDataService(context, '');
    List<LoanModel>? loanPaymentData =
        await loanController.loanDataService(context, 'repayment');
    setState(() {
      _loanTransaction = loanTransactionData;
      _loanPayment = loanPaymentData;
    });
  }

  Future<void> _getBannerData() async {
    List<BannerModel>? bannerData =
        await bannerController.bannerDataService(context);

    setState(() {
      _bannerData = bannerData;
    });
  }

  Future<void> loadData() async {
    setState(() => isLoading = true);

    await Future.wait([
      _getAccountData(),
      _getUserData(),
      _getLoanData(),
      _getBannerData(),
    ]);

    setState(() => isLoading = false);
  }

  @override
  void dispose() {
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;

    bool isShowAlertStatus =
        (_accountData?.isApproved == "borrower") ? false : true;

    return Scaffold(
      appBar: HeaderNavigationAppbar(
        isShowBackButton: false,
        titleText: ASSET_DULUIN_GAJIAN,
        isTitleText: false,
        isShowNotificationButton: true,
        isCenterTitle: true,
        sizeImage: size.width * 0.070,
      ),
      body: isLoading
          ? DashboardShimmer()
          : RefreshIndicator(
              onRefresh: () async {
                loadData();
              },
              color: COLOR_PRIMARY_GREEN,
              child: SingleChildScrollView(
                padding: EdgeInsets.symmetric(
                  horizontal: SCROLL_PADDING_HORIZONTAL,
                  vertical: SCROLL_PADDING_VERTICAL,
                ),
                scrollDirection: Axis.vertical,
                child: Column(
                  children: [
                    Visibility(
                      visible: isShowAlertStatus,
                      child: Container(
                        padding: EdgeInsets.all(16.0),
                        margin: EdgeInsets.only(bottom: 14, left: 5, right: 5),
                        decoration: BoxDecoration(
                          // color: Colors.redAccent,
                          color:
                              getRegisterStatusColor(_accountData!.isApproved),
                          borderRadius: BorderRadius.circular(8.0),
                          boxShadow: [
                            BoxShadow(
                              color: Colors.black12,
                              offset: Offset(0, 3),
                              blurRadius: 6.0,
                            ),
                          ],
                        ),
                        child: Row(
                          mainAxisSize: MainAxisSize.max,
                          children: <Widget>[
                            setIconStatus(_accountData!.isApproved),
                            SizedBox(width: 8.0),
                            Expanded(
                              child: Text(
                                getRegisterStatusText(_accountData!.isApproved),
                                style: TextStyle(
                                  color: setTextStatusColor(
                                      _accountData!.isApproved),
                                  fontSize: 13.0,
                                ),
                              ),
                            ),
                          ],
                        ),
                      ),
                    ),
                    Container(
                      margin: EdgeInsets.only(bottom: 10),
                      child: Card(
                        elevation: 5,
                        margin: EdgeInsets.symmetric(
                          horizontal: 5,
                        ),
                        color: Colors.white,
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(10.0),
                        ),
                        child: Column(
                          children: [
                            Padding(
                              padding: const EdgeInsets.all(12.5),
                              child: Row(
                                children: [
                                  Expanded(
                                    child: Row(
                                      children: [
                                        ClipRRect(
                                          borderRadius:
                                              BorderRadius.circular(8.0),
                                          child: CachedNetworkImage(
                                            imageUrl: ASSET_DEFAULT_PROFILE,
                                            height: 35.0,
                                            width: 35.0,
                                          ),
                                        ),
                                        SizedBox(width: 10),
                                        Expanded(
                                          child: Column(
                                            crossAxisAlignment:
                                                CrossAxisAlignment.start,
                                            children: [
                                              Text(
                                                _userData!.name,
                                                maxLines: 1,
                                                overflow: TextOverflow.ellipsis,
                                                style: TextStyle(
                                                  color: COLOR_PRIMARY_GREEN,
                                                  fontWeight: FontWeight.bold,
                                                  fontSize: 14,
                                                ),
                                              ),
                                              Padding(
                                                padding: const EdgeInsets.only(
                                                  right: 10,
                                                ),
                                                child: Text(
                                                  _accountData!.companyName,
                                                  maxLines: 1,
                                                  overflow:
                                                      TextOverflow.ellipsis,
                                                  textAlign: TextAlign.justify,
                                                  style: TextStyle(
                                                    fontWeight:
                                                        FontWeight.normal,
                                                    color: Colors.black54,
                                                    fontSize: 12,
                                                  ),
                                                ),
                                              ),
                                            ],
                                          ),
                                        ),
                                      ],
                                    ),
                                  ),
                                  ElevatedButton(
                                    onPressed: () {
                                      Navigator.pushNamed(
                                          context, withdrawPageRoute);
                                    },
                                    style: ButtonStyle(
                                      padding:
                                          WidgetStateProperty.all<EdgeInsets>(
                                        EdgeInsets.symmetric(
                                          vertical: 10,
                                          horizontal: 15,
                                        ),
                                      ),
                                      backgroundColor:
                                          const WidgetStatePropertyAll<Color>(
                                        COLOR_PRIMARY_GREEN,
                                      ),
                                      shape: WidgetStateProperty.all<
                                          OutlinedBorder>(
                                        RoundedRectangleBorder(
                                          borderRadius:
                                              BorderRadius.circular(10),
                                        ),
                                      ),
                                    ),
                                    child: Row(
                                      mainAxisSize: MainAxisSize.min,
                                      children: [
                                        Text(
                                          "TARIK",
                                          style: TextStyle(
                                            color: Colors.white,
                                            fontSize: size.width * 0.035,
                                          ),
                                        ),
                                        SizedBox(width: 5),
                                        Icon(
                                          FontAwesomeIcons.arrowCircleDown,
                                          color: Colors.white,
                                          size: 14,
                                        ),
                                      ],
                                    ),
                                  ),
                                ],
                              ),
                            ),
                            Container(
                              width: size.width,
                              child: Card(
                                margin: EdgeInsets.zero,
                                color: COLOR_PRIMARY_GREEN,
                                shape: RoundedRectangleBorder(
                                  borderRadius: BorderRadius.circular(10.0),
                                ),
                                child: Padding(
                                  padding: const EdgeInsets.all(10),
                                  child: Column(
                                    crossAxisAlignment:
                                        CrossAxisAlignment.start,
                                    children: [
                                      Text(
                                        "Saldo Tersedia",
                                        style: TextStyle(
                                          color: Colors.grey.shade200,
                                          fontSize: 14,
                                          fontWeight: FontWeight.normal,
                                        ),
                                      ),
                                      SizedBox(height: 10),
                                      Row(
                                        crossAxisAlignment:
                                            CrossAxisAlignment.end,
                                        mainAxisAlignment:
                                            MainAxisAlignment.spaceBetween,
                                        children: [
                                          Expanded(
                                            child: Text(
                                              convertStringToCurrency(
                                                  _accountData!
                                                      .loanCreditAmount,
                                                  'id_ID',
                                                  'Rp '),
                                              maxLines: 1,
                                              overflow: TextOverflow.ellipsis,
                                              style: TextStyle(
                                                color: Colors.white,
                                                fontSize: size.width * 0.065,
                                                fontWeight: FontWeight.bold,
                                              ),
                                            ),
                                          ),
                                          Padding(
                                            padding: const EdgeInsets.only(
                                              bottom: 7.5,
                                            ),
                                            child: Text(
                                              "Cut off ${formatDateMonthThreeWord(_accountData!.companyCutoffDate)}",
                                              style: TextStyle(
                                                color: Colors.white60,
                                                fontSize: size.width * 0.025,
                                                fontWeight: FontWeight.bold,
                                              ),
                                            ),
                                          ),
                                        ],
                                      ),
                                      SizedBox(height: 10),
                                      Container(
                                        height: 7.5,
                                        child: ClipRRect(
                                          borderRadius:
                                              BorderRadius.circular(10.0),
                                          child: LinearProgressIndicator(
                                            minHeight: 7.5,
                                            value: double.parse(loanBarLevel),
                                            valueColor:
                                                AlwaysStoppedAnimation<Color>(
                                                    Colors.orange),
                                            backgroundColor: Color(0xffD6D6D6),
                                          ),
                                        ),
                                      ),
                                      SizedBox(height: 20),
                                      Row(
                                        mainAxisAlignment:
                                            MainAxisAlignment.spaceBetween,
                                        children: [
                                          Row(
                                            children: [
                                              Icon(
                                                FontAwesomeIcons.checkCircle,
                                                color: Colors.grey.shade200,
                                                size: 10,
                                              ),
                                              SizedBox(width: 2.5),
                                              Text(
                                                "Tarik Kapanpun",
                                                style: TextStyle(
                                                  color: Colors.grey.shade200,
                                                  fontSize: 10,
                                                  fontWeight: FontWeight.normal,
                                                ),
                                              ),
                                            ],
                                          ),
                                          Row(
                                            children: [
                                              Icon(
                                                FontAwesomeIcons.moneyBill1,
                                                color: Colors.grey.shade200,
                                                size: 10,
                                              ),
                                              SizedBox(width: 5),
                                              Text(
                                                "Biaya Rendah",
                                                style: TextStyle(
                                                  color: Colors.grey.shade200,
                                                  fontSize: 10,
                                                  fontWeight: FontWeight.normal,
                                                ),
                                              ),
                                            ],
                                          ),
                                          Row(
                                            children: [
                                              Icon(
                                                FontAwesomeIcons.shieldHalved,
                                                color: Colors.grey.shade200,
                                                size: 10,
                                              ),
                                              SizedBox(width: 5),
                                              Text(
                                                "Pasti Aman",
                                                style: TextStyle(
                                                  color: Colors.grey.shade200,
                                                  fontSize: 10,
                                                  fontWeight: FontWeight.normal,
                                                ),
                                              ),
                                            ],
                                          ),
                                        ],
                                      ),
                                    ],
                                  ),
                                ),
                              ),
                            ),
                          ],
                        ),
                      ),
                    ),
                    SizedBox(height: 10),
                    CarouselSlider(
                      items: _bannerData?.map((banner) {
                            return GestureDetector(
                              onTap: () {
                                Navigator.pushNamed(
                                  context,
                                  detailBannerPageRoute,
                                  arguments: {
                                    "slug": banner.slug,
                                  },
                                );
                              },
                              child: Container(
                                margin: EdgeInsets.symmetric(horizontal: 5),
                                child: ClipRRect(
                                  borderRadius:
                                      BorderRadius.all(Radius.circular(10.0)),
                                  child: CachedNetworkImage(
                                    imageUrl: banner.imgUrl,
                                    width: double.infinity,
                                    fit: BoxFit.cover,
                                  ),
                                ),
                              ),
                            );
                          }).toList() ??
                          [],
                      options: CarouselOptions(
                        autoPlayAnimationDuration: Duration(seconds: 1),
                        autoPlayInterval: Duration(seconds: 3),
                        height: size.width * 0.30,
                        initialPage: 0,
                        autoPlay: true,
                        disableCenter: false,
                        enableInfiniteScroll: false,
                        aspectRatio: 16 / 9,
                        padEnds: false,
                        viewportFraction: 1.0,
                      ),
                    ),
                    SizedBox(height: 15),
                    Row(
                      children: [
                        Expanded(
                          child: Card(
                            elevation: 2.5,
                            color: Colors.white,
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(5.0),
                            ),
                            child: Padding(
                              padding:
                                  const EdgeInsets.symmetric(vertical: 7.5),
                              child: Row(
                                children: [
                                  Container(
                                    padding: EdgeInsets.all(5),
                                    decoration: BoxDecoration(
                                      color: COLOR_PRIMARY_GREEN,
                                      borderRadius: BorderRadius.only(
                                        topRight: Radius.circular(2.5),
                                        bottomRight: Radius.circular(2.5),
                                      ),
                                    ),
                                    child: Icon(
                                      FontAwesomeIcons.star,
                                      size: size.width * 0.040,
                                      color: Colors.white,
                                    ),
                                  ),
                                  SizedBox(width: 5),
                                  Expanded(
                                    child: Column(
                                      crossAxisAlignment:
                                          CrossAxisAlignment.start,
                                      children: [
                                        Text(
                                          "Bonus Poin",
                                          style: TextStyle(
                                            color: Colors.black87,
                                            fontSize: size.width * 0.035,
                                          ),
                                        ),
                                        Text(
                                          convertIntegerToCurrency(
                                              _accountData!.pointValue,
                                              'id_ID',
                                              ''),
                                          maxLines: 1,
                                          overflow: TextOverflow.ellipsis,
                                          style: TextStyle(
                                            color: Colors.black87,
                                            fontSize: size.width * 0.030,
                                          ),
                                        ),
                                      ],
                                    ),
                                  ),
                                ],
                              ),
                            ),
                          ),
                        ),
                        Expanded(
                          child: Card(
                            elevation: 2.5,
                            color: Colors.white,
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(5.0),
                            ),
                            child: Padding(
                              padding:
                                  const EdgeInsets.symmetric(vertical: 7.5),
                              child: Row(
                                children: [
                                  Container(
                                    padding: EdgeInsets.all(5),
                                    decoration: BoxDecoration(
                                      color: COLOR_PRIMARY_ORANGE,
                                      borderRadius: BorderRadius.only(
                                        topRight: Radius.circular(2.5),
                                        bottomRight: Radius.circular(2.5),
                                      ),
                                    ),
                                    child: Icon(
                                      FontAwesomeIcons.moneyBill,
                                      size: size.width * 0.040,
                                      color: Colors.white,
                                    ),
                                  ),
                                  SizedBox(width: 5),
                                  Expanded(
                                    child: GestureDetector(
                                      onTap: () {
                                        Navigator.pushReplacementNamed(
                                          context,
                                          bottomNavRoute,
                                          arguments: {'initialPage': 1},
                                        );
                                      },
                                      child: Column(
                                        crossAxisAlignment:
                                            CrossAxisAlignment.start,
                                        children: [
                                          Text(
                                            "Total Penarikan",
                                            style: TextStyle(
                                              color: Colors.black87,
                                              fontSize: size.width * 0.035,
                                            ),
                                          ),
                                          Text(
                                            convertStringToCurrency(
                                                _accountData!.loanDebitAmount,
                                                'id_ID',
                                                'Rp '),
                                            maxLines: 1,
                                            overflow: TextOverflow.ellipsis,
                                            style: TextStyle(
                                              color: Colors.black87,
                                              fontSize: size.width * 0.030,
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
                      ],
                    ),
                    SizedBox(height: 15),
                    DefaultTabController(
                      length: 2,
                      initialIndex: 0,
                      child: Column(
                        children: [
                          Card(
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(12),
                            ),
                            elevation: 1.5,
                            child: Container(
                              decoration: BoxDecoration(
                                color: COLOR_PRIMARY_GREEN.withOpacity(0.15),
                                borderRadius: BorderRadius.circular(12),
                              ),
                              child: TabBar(
                                indicator: BoxDecoration(
                                  borderRadius: BorderRadius.circular(12),
                                  color: COLOR_PRIMARY_GREEN,
                                ),
                                dividerHeight: 0,
                                labelStyle: TextStyle(
                                  fontSize: size.width * 0.035,
                                ),
                                labelColor: Colors.white,
                                indicatorSize: TabBarIndicatorSize.tab,
                                unselectedLabelColor: COLOR_PRIMARY_GREEN,
                                isScrollable: false,
                                labelPadding:
                                    EdgeInsets.symmetric(horizontal: 25),
                                tabs: [
                                  Tab(
                                    child: Text(
                                      "DULUIN GAJIAN",
                                      textAlign: TextAlign.center,
                                      overflow: TextOverflow.ellipsis,
                                      maxLines: 1,
                                    ),
                                  ),
                                  Tab(
                                    child: Text(
                                      "PEMBAYARAN",
                                      textAlign: TextAlign.center,
                                      overflow: TextOverflow.ellipsis,
                                      maxLines: 1,
                                    ),
                                  ),
                                ],
                                onTap: (index) {
                                  setState(() {
                                    _selectedIndex = index;
                                  });
                                },
                              ),
                            ),
                          ),
                          Container(
                            margin: EdgeInsets.symmetric(vertical: 15),
                            height: calculateTotalHeight(
                              _selectedIndex,
                              size,
                            ),
                            child: TabBarView(
                              children: [
                                DuluinGajianWidget(
                                  size: size,
                                  loanTransactions: _loanTransaction,
                                ),
                                PembayaranWidget(
                                  size: size,
                                  loanPayments: _loanPayment,
                                ),
                              ],
                            ),
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
              ),
            ),
    );
  }

  double calculateTotalHeight(int currentIndex, Size size) {
    double totalHeight = 0.0;

    print("anbmvshjavshb: $currentIndex");

    if (currentIndex == 0 && _loanTransaction!.isNotEmpty) {
      for (LoanModel loan in _loanTransaction!) {
        double itemHeight = 65.0;
        totalHeight += itemHeight;
      }

      totalHeight += (_loanTransaction!.length * 10.0);
    } else if (currentIndex == 1 && _loanPayment!.isNotEmpty) {
      for (LoanModel loan in _loanPayment!) {
        double itemHeight = 65.0;
        totalHeight += itemHeight;
      }

      totalHeight += (_loanPayment!.length * 10.0);
    } else {
      totalHeight = size.height * 0.25;
    }

    return totalHeight;
  }
}

class DuluinGajianWidget extends StatelessWidget {
  const DuluinGajianWidget({
    Key? key,
    required this.size,
    required this.loanTransactions,
  }) : super(key: key);

  final Size size;
  final List<LoanModel>? loanTransactions;

  @override
  Widget build(BuildContext context) {
    if (loanTransactions == null || loanTransactions!.isEmpty) {
      return const Center(
        child: EmptyListWidget(),
      );
    }

    return ListView.builder(
      itemCount: loanTransactions!.length,
      shrinkWrap: true,
      physics: NeverScrollableScrollPhysics(),
      itemBuilder: (context, index) {
        LoanModel _loan = loanTransactions![index];
        return GestureDetector(
          onTap: () {
            Navigator.pushNamed(
              context,
              detailLoanPageRoute,
              arguments: {
                'loanId': _loan.id,
              },
            );
          },
          child: Container(
            width: size.width,
            margin: EdgeInsets.only(bottom: 10),
            child: Card(
              margin: EdgeInsets.zero,
              color: Colors.transparent,
              elevation: 0,
              child: Padding(
                padding: const EdgeInsets.all(12.5),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Text(
                          'Penarikan Gaji',
                          style: TextStyle(
                            fontWeight: FontWeight.bold,
                            fontSize: 14,
                            color: COLOR_PRIMARY_GREEN,
                          ),
                        ),
                        Text(
                          convertStringToCurrency(
                              _loan.loanAmount, 'id_ID', 'Rp '),
                          style: TextStyle(
                            fontWeight: FontWeight.normal,
                            fontSize: 14,
                            color: Colors.black,
                          ),
                        ),
                      ],
                    ),
                    SizedBox(height: 5),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Text(
                          _loan.loanPurpose,
                          style: TextStyle(
                            fontWeight: FontWeight.normal,
                            fontSize: 14,
                            color: Colors.black54,
                          ),
                        ),
                        Container(
                          padding: EdgeInsets.symmetric(
                            horizontal: 5,
                            vertical: 1.5,
                          ),
                          decoration: BoxDecoration(
                            color: getStatusColor(_loan.loanStatus),
                            borderRadius: BorderRadius.circular(25),
                          ),
                          child: Text(
                            getStatusText(_loan.loanStatus),
                            style: TextStyle(
                              color: Colors.white,
                              fontSize: 10,
                            ),
                          ),
                        ),
                      ],
                    ),
                  ],
                ),
              ),
            ),
          ),
        );
      },
    );
  }
}

class PembayaranWidget extends StatelessWidget {
  const PembayaranWidget({
    Key? key,
    required this.size,
    required this.loanPayments,
  }) : super(key: key);

  final Size size;
  final List<LoanModel>? loanPayments;

  @override
  Widget build(BuildContext context) {
    if (loanPayments == null || loanPayments!.isEmpty) {
      return const Center(
        child: EmptyListWidget(),
      );
    }

    return ListView.builder(
      itemCount: loanPayments?.length,
      shrinkWrap: true,
      physics: NeverScrollableScrollPhysics(),
      itemBuilder: (context, index) {
        LoanModel _loan = loanPayments![index];
        if (loanPayments!.isNotEmpty) {
          return GestureDetector(
            onTap: () {
              Navigator.pushNamed(
                context,
                detailLoanPageRoute,
                arguments: {
                  'loanId': _loan.id,
                },
              );
            },
            child: Container(
              width: size.width,
              margin: EdgeInsets.only(bottom: 10),
              child: Card(
                margin: EdgeInsets.zero,
                color: Colors.transparent,
                elevation: 0,
                child: Padding(
                  padding: const EdgeInsets.all(12.5),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Text(
                            'Penarikan Gaji',
                            style: TextStyle(
                              fontWeight: FontWeight.bold,
                              fontSize: 14,
                              color: COLOR_PRIMARY_GREEN,
                            ),
                          ),
                          Text(
                            convertStringToCurrency(
                                _loan.loanAmount, 'id_ID', 'Rp '),
                            style: TextStyle(
                              fontWeight: FontWeight.normal,
                              fontSize: 14,
                              color: Colors.black,
                            ),
                          ),
                        ],
                      ),
                      SizedBox(height: 5),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Text(
                            _loan.loanPurpose,
                            style: TextStyle(
                              fontWeight: FontWeight.normal,
                              fontSize: 14,
                              color: Colors.black54,
                            ),
                          ),
                          Container(
                            padding: EdgeInsets.symmetric(
                              horizontal: 5,
                              vertical: 1.5,
                            ),
                            decoration: BoxDecoration(
                              color: getStatusColor(_loan.loanStatus),
                              borderRadius: BorderRadius.circular(25),
                            ),
                            child: Text(
                              getStatusText(_loan.loanStatus),
                              style: TextStyle(
                                color: Colors.white,
                                fontSize: 10,
                              ),
                            ),
                          ),
                        ],
                      ),
                    ],
                  ),
                ),
              ),
            ),
          );
        }
      },
    );
  }
}
