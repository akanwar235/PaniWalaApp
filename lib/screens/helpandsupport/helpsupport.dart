import 'package:flutter/material.dart';
import 'package:water_order/utils/colors.dart';
import 'package:water_order/widget/appbar.dart';

class HelpSupport extends StatefulWidget {
  const HelpSupport({super.key});

  @override
  State<HelpSupport> createState() => _HelpSupportState();
}

class _HelpSupportState extends State<HelpSupport> {
  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;

    return Scaffold(
      appBar: appbar("Help & Support"),
      body: Padding(
        padding: const EdgeInsets.all(10),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Container(
              height: size.height * .3,
              decoration: const BoxDecoration(
                  image: DecorationImage(
                      image: AssetImage("assets/images/register.png"),
                      fit: BoxFit.contain)),
            ),
            Text(
              "Get in touch",
              style: getstyle(fontsize: 22, fontweight: FontWeight.w700),
            ),
            const Spacer(),
            ListTile(
              onTap: () {},
              leading: const Icon(
                Icons.message_sharp,
                color: Colors.black,
                size: 25,
              ),
              title: Text(
                "Send us an email",
                style: getstyle(fontsize: 16),
              ),
              trailing: const Icon(
                Icons.arrow_forward_ios,
                color: Colors.black,
                size: 25,
              ),
            ),
            ListTile(
              onTap: () {},
              leading: const Icon(
                Icons.phone,
                size: 25,
                color: Colors.black,
              ),
              title: Text(
                "Contact Us",
                style: getstyle(fontsize: 16),
              ),
              trailing: const Icon(
                Icons.arrow_forward_ios,
                size: 25,
                color: Colors.black,
              ),
            ),
            const Spacer(
              flex: 10,
            )
          ],
        ),
      ),
    );
  }
}
