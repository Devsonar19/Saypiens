import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:url_launcher/url_launcher.dart';
import '../../../../theme/app_color.dart';

class FooterSection extends StatelessWidget {
  const FooterSection({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.infinity,
      decoration: const BoxDecoration(
        color: AppColors.tertiaryFixed,
        image: DecorationImage(
          image: AssetImage('assets/images/footer_logo.png'),
          fit: BoxFit.cover,
          opacity: 0.07, // Very light and subtle
        ),
      ),
      padding: const EdgeInsets.symmetric(vertical: 80),
      child: Center(
        child: ConstrainedBox(
          constraints: const BoxConstraints(maxWidth: 1200),
          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 24),
            child: LayoutBuilder(
              builder: (context, constraints) {
                final isMobile = constraints.maxWidth < 700;

                final leftContent = Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      'Saypiens',
                      style: GoogleFonts.cormorantGaramond(
                        fontSize: 56,
                        fontWeight: FontWeight.bold,
                        color: AppColors.onTertiaryFixed,
                        letterSpacing: 1.5,
                      ),
                    ),
                    const SizedBox(height: 16),
                    Text(
                      '"We were bestowed upon the past,\nbut we are accountable for the future"',
                      style: GoogleFonts.plusJakartaSans(
                        fontSize: 16,
                        color: AppColors.onTertiaryFixedVariant,
                        fontStyle: FontStyle.italic,
                        height: 1.6,
                      ),
                    ),
                  ],
                );

                final rightContent = Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      'Contact us:',
                      style: GoogleFonts.syne(
                        fontSize: 20,
                        fontWeight: FontWeight.bold,
                        color: AppColors.onTertiaryFixed,
                        letterSpacing: 1.2,
                      ),
                    ),
                    const SizedBox(height: 24),
                    const _ContactEmailItem(email: 'saypiens1@gmail.com'),
                    const SizedBox(height: 16),
                    _buildContactItem(context, Icons.phone_outlined, '8734852905, 6355737425'),
                    const SizedBox(height: 32),
                    Row(
                      children: [
                        _buildFooterLink('Brochure', 'https://drive.google.com/file/d/1HIsjJavpzoMxfmt5Di9cmwkoZpr5FWxT/view?usp=sharing'),
                        const SizedBox(width: 32),
                        _buildFooterLink('Chat Guidelines', 'https://drive.google.com/file/d/1_T_jTU9KQqHF7VArLZsaSaOxZrUv0ltc/view?usp=sharing'),
                      ],
                    ),
                  ],
                );

                Widget topSection;
                if (isMobile) {
                  topSection = Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      leftContent,
                      const SizedBox(height: 64),
                      rightContent,
                    ],
                  );
                } else {
                  topSection = Row(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Expanded(child: leftContent),
                      rightContent,
                    ],
                  );
                }

                return Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    topSection,
                    const SizedBox(height: 80),
                    Divider(color: AppColors.onTertiaryFixed.withOpacity(0.15)),
                    const SizedBox(height: 24),
                    if (isMobile)
                      Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text('EST 2026', style: GoogleFonts.plusJakartaSans(fontSize: 12, color: AppColors.onTertiaryFixedVariant, fontWeight: FontWeight.bold)),
                          const SizedBox(height: 8),
                          Text('crafted for thinkers & builders', style: GoogleFonts.plusJakartaSans(fontSize: 12, color: AppColors.onTertiaryFixedVariant)),
                        ],
                      )
                    else
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Text('EST 2026', style: GoogleFonts.plusJakartaSans(fontSize: 12, color: AppColors.onTertiaryFixedVariant, fontWeight: FontWeight.bold)),
                          Text('crafted for thinkers & builders', style: GoogleFonts.plusJakartaSans(fontSize: 12, color: AppColors.onTertiaryFixedVariant)),
                        ],
                      ),
                  ],
                );
              },
            ),
          ),
        ),
      ),
    );
  }

  Widget _buildContactItem(BuildContext context, IconData icon, String text) {
    return Row(
      mainAxisSize: MainAxisSize.min,
      children: [
        Icon(icon, color: AppColors.onTertiaryFixed, size: 20),
        const SizedBox(width: 12),
        Text(
          text,
          style: GoogleFonts.plusJakartaSans(
            fontSize: 15,
            color: AppColors.onTertiaryFixedVariant,
            fontWeight: FontWeight.w600,
          ),
        ),
      ],
    );
  }

  Widget _buildFooterLink(String text, String url) {
    return _HoverFooterLink(text: text, url: url);
  }
}

class _ContactEmailItem extends StatefulWidget {
  final String email;
  const _ContactEmailItem({required this.email});

  @override
  State<_ContactEmailItem> createState() => _ContactEmailItemState();
}

class _ContactEmailItemState extends State<_ContactEmailItem> {
  bool _isHovered = false;
  bool _showCopied = false;

  void _copyToClipboard() async {
    await Clipboard.setData(ClipboardData(text: widget.email));
    setState(() {
      _showCopied = true;
    });
    Future.delayed(const Duration(seconds: 2), () {
      if (mounted) {
        setState(() {
          _showCopied = false;
        });
      }
    });
  }

  void _launchMailto() async {
    final uri = Uri.parse('mailto:${widget.email}');
    if (await canLaunchUrl(uri)) {
      await launchUrl(uri);
    }
  }

  @override
  Widget build(BuildContext context) {
    return MouseRegion(
      onEnter: (_) => setState(() => _isHovered = true),
      onExit: (_) => setState(() => _isHovered = false),
      cursor: SystemMouseCursors.click,
      child: GestureDetector(
        onTap: _launchMailto,
        child: Row(
          mainAxisSize: MainAxisSize.min,
          children: [
            Icon(Icons.email_outlined, color: AppColors.onTertiaryFixed, size: 20),
            const SizedBox(width: 12),
            AnimatedDefaultTextStyle(
              duration: const Duration(milliseconds: 200),
              style: GoogleFonts.plusJakartaSans(
                fontSize: 15,
                color: _isHovered ? AppColors.onTertiaryFixed : AppColors.onTertiaryFixedVariant,
                fontWeight: FontWeight.w600,
              ),
              child: Text(widget.email),
            ),
            const SizedBox(width: 8),
            GestureDetector(
              onTap: _copyToClipboard,
              child: Container(
                padding: const EdgeInsets.all(4),
                decoration: BoxDecoration(
                  color: _isHovered ? AppColors.onTertiaryFixed.withOpacity(0.05) : Colors.transparent,
                  borderRadius: BorderRadius.circular(4),
                ),
                child: Icon(Icons.copy, size: 16, color: AppColors.onTertiaryFixedVariant),
              ),
            ),
            if (_showCopied) ...[
              const SizedBox(width: 8),
              AnimatedOpacity(
                duration: const Duration(milliseconds: 200),
                opacity: _showCopied ? 1.0 : 0.0,
                child: Text(
                  'Copied!',
                  style: GoogleFonts.plusJakartaSans(
                    fontSize: 12,
                    color: AppColors.onTertiaryFixedVariant, 
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ),
            ],
          ],
        ),
      ),
    );
  }
}

class _HoverFooterLink extends StatefulWidget {
  final String text;
  final String url;
  
  const _HoverFooterLink({required this.text, required this.url});

  @override
  State<_HoverFooterLink> createState() => _HoverFooterLinkState();
}

class _HoverFooterLinkState extends State<_HoverFooterLink> {
  bool _isHovered = false;

  void _launchUrl() async {
    final uri = Uri.parse(widget.url);
    if (await canLaunchUrl(uri)) {
      await launchUrl(uri);
    }
  }

  @override
  Widget build(BuildContext context) {
    return MouseRegion(
      onEnter: (_) => setState(() => _isHovered = true),
      onExit: (_) => setState(() => _isHovered = false),
      cursor: SystemMouseCursors.click,
      child: GestureDetector(
        onTap: _launchUrl,
        child: AnimatedContainer(
          duration: const Duration(milliseconds: 200),
          decoration: BoxDecoration(
            border: Border(
              bottom: BorderSide(
                color: _isHovered ? AppColors.onTertiaryFixed : Colors.transparent,
                width: 1.5,
              ),
            ),
          ),
          padding: const EdgeInsets.only(bottom: 2),
          child: Text(
            widget.text,
            style: GoogleFonts.plusJakartaSans(
              fontSize: 15,
              color: _isHovered ? AppColors.onTertiaryFixed : AppColors.onTertiaryFixedVariant,
              fontWeight: FontWeight.bold,
            ),
          ),
        ),
      ),
    );
  }
}
