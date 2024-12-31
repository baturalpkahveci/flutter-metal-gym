import 'package:flutter/material.dart';
import 'package:metal_gym_mobile_application/core/app_colors.dart';
import 'package:smooth_page_indicator/smooth_page_indicator.dart';

class ImagePanel extends StatefulWidget {
  final List<String> imageUrls;
  final double height;
  final double dotHeight;
  final double dotWidth;
  final Color activeDotColor;
  final Color dotColor;

  const ImagePanel({
    Key? key,
    required this.imageUrls,
    this.height = 300.0,
    this.dotHeight = 8.0,
    this.dotWidth = 8.0,
    this.activeDotColor = Colors.blue,
    this.dotColor = Colors.grey,
  }) : super(key: key);

  @override
  _ImagePanelState createState() => _ImagePanelState();
}

class _ImagePanelState extends State<ImagePanel> {
  final PageController _pageController = PageController();
  int _currentPage = 0;

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        GestureDetector(
          onTap: () => _showFullScreenImage(context, _currentPage),
          child: SizedBox(
            height: widget.height,
            child: PageView.builder(
              controller: _pageController,
              itemCount: widget.imageUrls.length,
              onPageChanged: (index) {
                setState(() {
                  _currentPage = index;
                });
              },
              itemBuilder: (context, index) {
                return Image.network(
                  widget.imageUrls[index],
                  fit: BoxFit.cover,
                  width: double.infinity,
                );
              },
            ),
          ),
        ),
        const SizedBox(height: 16),
        SmoothPageIndicator(
          controller: _pageController,
          count: widget.imageUrls.length,
          effect: WormEffect(
            dotHeight: widget.dotHeight,
            dotWidth: widget.dotWidth,
            activeDotColor: widget.activeDotColor,
            dotColor: widget.dotColor,
          ),
        ),
        const SizedBox(height: 16),
      ],
    );
  }

  void _showFullScreenImage(BuildContext context, int index) {
    showDialog(
      context: context,
      builder: (context) {
        return Stack(
          children: [
            GestureDetector(
              onTap: () => Navigator.of(context).pop(),
              child: Container(
                color: Colors.black.withOpacity(0.9),
                child: Center(
                  child: Image.network(
                    widget.imageUrls[index],
                    fit: BoxFit.contain, // Ensures the full image is visible.
                  ),
                ),
              ),
            ),
            Positioned(
              top: 40,
              right: 20,
              child: ElevatedButton(
                onPressed: () => Navigator.of(context).pop(),
                style: ElevatedButton.styleFrom(
                  shape: const CircleBorder(),
                  padding: const EdgeInsets.all(12),
                  backgroundColor: AppColors.highlighted.withOpacity(0.8),
                ),
                child: const Icon(Icons.close, color: AppColors.background),
              ),
            ),
          ],
        );
      },
    );
  }

  @override
  void dispose() {
    _pageController.dispose();
    super.dispose();
  }
}
