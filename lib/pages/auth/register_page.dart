import 'package:flutter/material.dart';
import 'donatur_form_page.dart';
// import 'pages/penerima_form_page.dart'; // kalau sudah ada form penerima

class RegisterPage extends StatefulWidget {
  const RegisterPage({super.key});

  @override
  State<RegisterPage> createState() => _RegisterPageState();
}

class _RegisterPageState extends State<RegisterPage> {
  final Color primaryColor = const Color(0xFF3E54C5);
  final Color borderColor = Colors.purple;

  bool isHoveringDonatur = false;
  bool isHoveringPenerima = false;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: Stack(
        children: [
          // Background oval
          ClipPath(
            clipper: OvalClipper(),
            child: Container(
              height: 280,
              color: primaryColor,
              alignment: Alignment.center,
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: const [
                  Icon(Icons.medical_services, color: Colors.white, size: 64),
                  SizedBox(height: 10),
                  Text(
                    "OBATIN",
                    style: TextStyle(
                      color: Colors.white,
                      fontSize: 28,
                      fontWeight: FontWeight.bold,
                      letterSpacing: 2,
                    ),
                  ),
                ],
              ),
            ),
          ),

          // Tombol Daftar
          Align(
            alignment: Alignment.center,
            child: Padding(
              padding: const EdgeInsets.symmetric(horizontal: 32.0),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.end,
                children: [
                  const Spacer(),
                  _buildHoverButton(
                    text: "Daftar sebagai Donatur",
                    isHovering: isHoveringDonatur,
                    onHover: (hover) =>
                        setState(() => isHoveringDonatur = hover),
                    onPressed: () {
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (context) => const DonaturFormPage(),
                        ),
                      );
                    },
                  ),
                  const SizedBox(height: 20),
                  _buildHoverButton(
                    text: "Daftar sebagai Penerima",
                    isHovering: isHoveringPenerima,
                    onHover: (hover) =>
                        setState(() => isHoveringPenerima = hover),
                    onPressed: () {
                      // TODO: Navigasi ke form penerima
                      ScaffoldMessenger.of(context).showSnackBar(
                        const SnackBar(content: Text("Fitur belum tersedia")),
                      );
                    },
                  ),
                  const SizedBox(height: 60),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildHoverButton({
    required String text,
    required bool isHovering,
    required void Function(bool) onHover,
    required void Function() onPressed,
  }) {
    return MouseRegion(
      onEnter: (_) => onHover(true),
      onExit: (_) => onHover(false),
      child: AnimatedContainer(
        duration: const Duration(milliseconds: 200),
        decoration: BoxDecoration(
          border: Border.all(color: borderColor, width: 2),
          color: isHovering ? borderColor.withOpacity(0.1) : Colors.transparent,
          borderRadius: BorderRadius.circular(12),
        ),
        child: MaterialButton(
          onPressed: onPressed,
          padding: const EdgeInsets.symmetric(vertical: 16, horizontal: 24),
          minWidth: double.infinity,
          child: Text(
            text,
            style: TextStyle(
              color: borderColor,
              fontSize: 16,
              fontWeight: FontWeight.w600,
            ),
          ),
        ),
      ),
    );
  }
}

class OvalClipper extends CustomClipper<Path> {
  @override
  Path getClip(Size size) {
    Path path = Path();
    path.lineTo(0, size.height * 0.6);
    path.quadraticBezierTo(
      size.width / 2,
      size.height,
      size.width,
      size.height * 0.6,
    );
    path.lineTo(size.width, 0);
    path.close();
    return path;
  }

  @override
  bool shouldReclip(OvalClipper oldClipper) => false;
}
