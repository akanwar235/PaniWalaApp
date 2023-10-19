import 'package:flutter/material.dart';
import 'package:water_order/utils/colors.dart';
import 'package:water_order/widget/appbar.dart';

class About extends StatefulWidget {
  const About({super.key});

  @override
  State<About> createState() => _AboutState();
}

class _AboutState extends State<About> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: appbar("About"),
      body: SingleChildScrollView(
        child: Container(
          margin: EdgeInsets.all(8),
          padding: EdgeInsets.all(8),
          decoration: BoxDecoration(
              color: Colors.grey.shade400,
              borderRadius: BorderRadius.circular(8)),
          child: Text(
            """ 
            iet massa tincidunt nunc pulvinar. Nulla aliquet porttitor lacus luctus. Orci porta non pulvinar neque. Lobortis scelerisque fermentum dui faucibus in ornare quam viverra. Nunc eget lorem dolor sed viverra ipsum. Nunc consequat interdum varius sit amet mattis vulputate enim nulla. Natoque penatibus et magnis dis parturient montes nascetur ridiculus. Ultrices in iaculis nunc sed augue lacus viverra. Eu turpis egestas pretium aenean. Felis eget velit aliquet sagittis. At tellus at urna condimentum mattis pellentesque id nibh tortor. Amet commodo nulla facilisi nullam vehicula. Magna fringilla urna porttitor rhoncus dolor purus. Faucibus vitae aliquet nec ullamcorper. Faucibus interdum posuere lorem ipsum. Ac ut consequat semper viverra nam libero. Donec ac odio tempor orci dapibus ultrices in. Purus ut faucibus pulvinar elementum integer enim. Orci sagittis eu volutpat odio facilisis mauris.
            iet massa tincidunt nunc pulvinar. Nulla aliquet porttitor lacus luctus. Orci porta non pulvinar neque. Lobortis scelerisque fermentum dui faucibus in ornare quam viverra. Nunc eget lorem dolor sed viverra ipsum. Nunc consequat interdum varius sit amet mattis vulputate enim nulla. Natoque penatibus et magnis dis parturient montes nascetur ridiculus. Ultrices in iaculis nunc sed augue lacus viverra. Eu turpis egestas pretium aenean. Felis eget velit aliquet sagittis. At tellus at urna condimentum mattis pellentesque id nibh tortor. Amet commodo nulla facilisi nullam vehicula. Magna fringilla urna porttitor rhoncus dolor purus. Faucibus vitae aliquet nec ullamcorper. Faucibus interdum posuere lorem ipsum. Ac ut consequat semper viverra nam libero. Donec ac odio tempor orci dapibus ultrices in. Purus ut faucibus pulvinar elementum integer enim. Orci sagittis eu volutpat odio facilisis mauris.
            iet massa tincidunt nunc pulvinar. Nulla aliquet porttitor lacus luctus. Orci porta non pulvinar neque. Lobortis scelerisque fermentum dui faucibus in ornare quam viverra. Nunc eget lorem dolor sed viverra ipsum. Nunc consequat interdum varius sit amet mattis vulputate enim nulla. Natoque penatibus et magnis dis parturient montes nascetur ridiculus. Ultrices in iaculis nunc sed augue lacus viverra. Eu turpis egestas pretium aenean. Felis eget velit aliquet sagittis. At tellus at urna condimentum mattis pellentesque id nibh tortor. Amet commodo nulla facilisi nullam vehicula. Magna fringilla urna porttitor rhoncus dolor purus. Faucibus vitae aliquet nec ullamcorper. Faucibus interdum posuere lorem ipsum. Ac ut consequat semper viverra nam libero. Donec ac odio tempor orci dapibus ultrices in. Purus ut faucibus pulvinar elementum integer enim. Orci sagittis eu volutpat odio facilisis mauris.
            iet massa tincidunt nunc pulvinar. Nulla aliquet porttitor lacus luctus. Orci porta non pulvinar neque. Lobortis scelerisque fermentum dui faucibus in ornare quam viverra. Nunc eget lorem dolor sed viverra ipsum. Nunc consequat interdum varius sit amet mattis vulputate enim nulla. Natoque penatibus et magnis dis parturient montes nascetur ridiculus. Ultrices in iaculis nunc sed augue lacus viverra. Eu turpis egestas pretium aenean. Felis eget velit aliquet sagittis. At tellus at urna condimentum mattis pellentesque id nibh tortor. Amet commodo nulla facilisi nullam vehicula. Magna fringilla urna porttitor rhoncus dolor purus. Faucibus vitae aliquet nec ullamcorper. Faucibus interdum posuere lorem ipsum. Ac ut consequat semper viverra nam libero. Donec ac odio tempor orci dapibus ultrices in. Purus ut faucibus pulvinar elementum integer enim. Orci sagittis eu volutpat odio facilisis mauris.
            iet massa tincidunt nunc pulvinar. Nulla aliquet porttitor lacus luctus. Orci porta non pulvinar neque. Lobortis scelerisque fermentum dui faucibus in ornare quam viverra. Nunc eget lorem dolor sed viverra ipsum. Nunc consequat interdum varius sit amet mattis vulputate enim nulla. Natoque penatibus et magnis dis parturient montes nascetur ridiculus. Ultrices in iaculis nunc sed augue lacus viverra. Eu turpis egestas pretium aenean. Felis eget velit aliquet sagittis. At tellus at urna condimentum mattis pellentesque id nibh tortor. Amet commodo nulla facilisi nullam vehicula. Magna fringilla urna porttitor rhoncus dolor purus. Faucibus vitae aliquet nec ullamcorper. Faucibus interdum posuere lorem ipsum. Ac ut consequat semper viverra nam libero. Donec ac odio tempor orci dapibus ultrices in. Purus ut faucibus pulvinar elementum integer enim. Orci sagittis eu volutpat odio facilisis mauris.
      
       """,
            style: getstyle(fontsize: 16),
          ),
        ),
      ),
    );
  }
}
