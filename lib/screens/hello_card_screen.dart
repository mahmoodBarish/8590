import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:go_router/go_router.dart'; // Import go_router

class HelloCardScreen extends StatefulWidget {
  const HelloCardScreen({Key? key}) : super(key: key);

  @override
  State<HelloCardScreen> createState() => _HelloCardScreenState();
}

class _HelloCardScreenState extends State<HelloCardScreen> {
  // Assuming the blue dot (id 167:35) is for the second page (index 1) based on the JSON
  // Its absoluteBoundingBox x is 158, while the first dot is 118, third 198, fourth 238.
  int _currentPageIndex = 1;

  @override
  Widget build(BuildContext context) {
    final screenWidth = MediaQuery.of(context).size.width;
    final screenHeight = MediaQuery.of(context).size.height;

    // Responsive dimensions based on original Figma screen size 375x812
    final double cardWidth = 326 / 375 * screenWidth;
    final double cardHeight = 614 / 812 * screenHeight;
    final double cardTop = 81 / 812 * screenHeight;
    final double cardLeft = 25 / 375 * screenWidth;

    final double imageHeaderHeight = 338 / 812 * screenHeight;
    // Spacing calculations based on Figma absolute bounding box values
    // Image bottom = 81 (card top) + 338 (image height) = 419
    // Headline "Hello" top = 465
    final double spaceImageToHeadline = (465 - 419) / 812 * screenHeight;
    // Headline "Hello" render height = 20.72
    // Headline "Hello" bottom = 465 + 20.72 = 485.72
    // Description "Lorem ipsum..." top = 513
    final double spaceHeadlineToDescription = (513 - 485.72) / 812 * screenHeight;
    final double descriptionHorizontalPadding = (66 / 375) * screenWidth; // Based on text x=66 for 375 width

    // Dots position: y=725, height=20. Bottom of dots is 725+20=745.
    // Home indicator: y=798, height=5. Bottom of indicator is 798+5=803.
    // So, dots are above the home indicator.
    final double dotsBottomOffset = (812 - 745) / 812 * screenHeight;
    final double homeIndicatorBottomOffset = (812 - 803) / 812 * screenHeight;

    return Scaffold(
      backgroundColor: Colors.white,
      body: Stack(
        children: [
          // Background Bubbles
          // Bubble 01 (blue) - absoluteRenderBounds: x=0, y=0, width=255.435, height=319.326
          Positioned(
            left: 0,
            top: 0,
            width: screenWidth * (255.435 / 375),
            height: screenHeight * (319.326 / 812),
            child: CustomPaint(
              painter: Bubble01Painter(),
            ),
          ),
          // Bubble 02 (light blue/white) - absoluteRenderBounds: x=0, y=282.695, width=325.835, height=389.995
          Positioned(
            left: 0,
            top: screenHeight * (282.695 / 812),
            width: screenWidth * (325.835 / 375),
            height: screenHeight * (389.995 / 812),
            child: CustomPaint(
              painter: Bubble02Painter(),
            ),
          ),

          // Status Bar
          Positioned(
            top: 0,
            left: 0,
            right: 0,
            child: Container(
              height: screenHeight * (44 / 812), // Standard status bar height
              alignment: Alignment.bottomCenter,
              padding: EdgeInsets.symmetric(horizontal: screenWidth * (21 / 375), vertical: 8),
              child: SafeArea(
                bottom: false,
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text(
                      '9:41',
                      style: GoogleFonts.nunitoSans(
                        fontWeight: FontWeight.w600, // SemiBold
                        fontSize: 14,
                        color: Colors.black,
                      ),
                    ),
                    Row(
                      children: const [
                        Icon(Icons.signal_cellular_alt, size: 18, color: Colors.black),
                        SizedBox(width: 5),
                        Icon(Icons.wifi, size: 18, color: Colors.black),
                        SizedBox(width: 5),
                        Icon(Icons.battery_full, size: 18, color: Colors.black),
                      ],
                    ),
                  ],
                ),
              ),
            ),
          ),

          // Main Card Content
          Positioned(
            top: cardTop,
            left: cardLeft,
            width: cardWidth,
            height: cardHeight,
            child: GestureDetector(
              // The entire card is made tappable for navigation
              onTap: () {
                // Navigates to the '/home' route using go_router.
                context.go('/home');
              },
              child: Container(
                decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.circular(30),
                  boxShadow: [
                    BoxShadow(
                      color: const Color.fromRGBO(0, 0, 0, 0.16),
                      offset: const Offset(0, 10),
                      blurRadius: 37,
                    ),
                  ],
                ),
                child: Column(
                  children: [
                    // Image Header
                    ClipRRect(
                      borderRadius: const BorderRadius.vertical(top: Radius.circular(30)),
                      child: Image.asset(
                        'assets/images/167_42.png', // Local asset path
                        width: double.infinity,
                        height: imageHeaderHeight,
                        fit: BoxFit.cover,
                      ),
                    ),
                    SizedBox(height: spaceImageToHeadline), // Responsive space calculation
                    // Headline Text
                    Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 20), // General horizontal padding for text
                      child: Text(
                        'Hello',
                        textAlign: TextAlign.center,
                        style: GoogleFonts.raleway(
                          fontWeight: FontWeight.bold,
                          fontSize: 28,
                          letterSpacing: -0.28,
                          color: const Color(0xFF202020),
                        ),
                      ),
                    ),
                    SizedBox(height: spaceHeadlineToDescription), // Responsive space calculation
                    // Description Text
                    Padding(
                      padding: EdgeInsets.symmetric(horizontal: descriptionHorizontalPadding),
                      child: Text(
                        'Lorem ipsum dolor sit amet, consectetur adipiscing elit. Sed non consectetur turpis. Morbi eu eleifend lacus.',
                        textAlign: TextAlign.center,
                        style: GoogleFonts.nunitoSans(
                          fontWeight: FontWeight.w300, // Light
                          fontSize: 19,
                          height: 27 / 19, // Line height calculation
                          color: Colors.black,
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ),

          // Dots (Page Indicator)
          Positioned(
            bottom: dotsBottomOffset,
            left: 0,
            right: 0,
            child: Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: List.generate(4, (index) {
                // Spacing between dots is 20px (40px center to center, minus 20px dot width)
                final double horizontalMargin = (20 / 375) * screenWidth / 2;
                return GestureDetector(
                  onTap: () {
                    setState(() {
                      _currentPageIndex = index;
                    });
                  },
                  child: Container(
                    margin: EdgeInsets.symmetric(horizontal: horizontalMargin),
                    width: 20, // Figma width
                    height: 20, // Figma height
                    decoration: BoxDecoration(
                      shape: BoxShape.circle,
                      color: _currentPageIndex == index
                          ? const Color(0xFF004BFF) // Active dot color (from 167:35)
                          : const Color(0xFFC7D6FC), // Inactive dot color (from 167:32)
                      boxShadow: [
                        BoxShadow(
                          color: const Color.fromRGBO(0, 0, 0, 0.16),
                          offset: const Offset(0, 0),
                          blurRadius: 30,
                        ),
                      ],
                    ),
                  ),
                );
              }),
            ),
          ),

          // Bottom Home Indicator Bar
          Positioned(
            bottom: homeIndicatorBottomOffset,
            left: 0,
            right: 0,
            child: Center(
              child: Container(
                width: 134, // Figma width
                height: 5, // Figma height
                decoration: BoxDecoration(
                  color: Colors.black,
                  borderRadius: BorderRadius.circular(34),
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}

// CustomPainter for Bubble 01 (Blue bubble)
class Bubble01Painter extends CustomPainter {
  @override
  void paint(Canvas canvas, Size size) {
    final paint = Paint()
      ..color = const Color(0xFF004BEF) // Figma fill color: r=0, g=0.294, b=0.996, a=1
      ..style = PaintingStyle.fill;

    // Approximated as an oval covering its render bounds.
    final path = Path();
    path.addOval(Rect.fromLTWH(0, 0, size.width, size.height));
    canvas.drawPath(path, paint);
  }

  @override
  bool shouldRepaint(covariant CustomPainter oldDelegate) => false;
}

// CustomPainter for Bubble 02 (Light blue/white bubble)
class Bubble02Painter extends CustomPainter {
  @override
  void paint(Canvas canvas, Size size) {
    final paint = Paint()
      ..color = const Color(0xFFF2F5FF) // Figma fill color: r=0.949, g=0.960, b=0.996, a=1
      ..style = PaintingStyle.fill;

    // Approximated as an oval covering its render bounds.
    final path = Path();
    path.addOval(Rect.fromLTWH(0, 0, size.width, size.height));
    canvas.drawPath(path, paint);
  }

  @override
  bool shouldRepaint(covariant CustomPainter oldDelegate) => false;
}