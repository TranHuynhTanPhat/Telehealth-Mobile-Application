import 'package:carousel_slider/carousel_slider.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:healthline/res/style.dart';
import 'package:healthline/screen/ui_doctor/main/overview/components/export.dart';
import 'package:healthline/utils/translate.dart';

class OverviewScreen extends StatelessWidget {
  const OverviewScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomInset: false,
      extendBody: true,
      backgroundColor: white,
      body: ListView(
        shrinkWrap: false,
        scrollDirection: Axis.vertical,
        padding: EdgeInsets.only(bottom: dimensHeight() * 10),
        children: [
          Padding(
            padding: EdgeInsets.symmetric(
                horizontal: dimensWidth() * 3, vertical: dimensHeight() * 2),
            child: Text(
              translate(context, 'statistics'),
              style: Theme.of(context).textTheme.titleLarge,
            ),
          ),
          Padding(
            padding: EdgeInsets.only(
              bottom: dimensHeight() * 2,
            ),
            child: CarouselSlider(
              items: const [
                RevenueCard(),
                AppointmentCard(),
                ReportCard(),
              ],
              options: CarouselOptions(
                  autoPlay: true,
                  aspectRatio: 2.2,
                  enlargeCenterPage: true,
                  viewportFraction: 0.8,
                  reverse: false,
                  enlargeStrategy: CenterPageEnlargeStrategy.scale),
            ),
          ),
          Padding(
            padding: EdgeInsets.symmetric(
                horizontal: dimensWidth() * 3, vertical: dimensHeight() * 2),
            child: Text(
              translate(context, 'upcoming_appointments'),
              style: Theme.of(context).textTheme.titleLarge,
            ),
          ),
          Padding(
            padding: EdgeInsets.only(
                left: dimensWidth() * 3, right: dimensWidth() * 3),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                ListTile(
                  onTap: () {},
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(
                      dimensWidth(),
                    ),
                  ),
                  dense: true,
                  visualDensity: const VisualDensity(vertical: 0),
                  leading: CircleAvatar(
                    backgroundImage: AssetImage(DImages.placeholder),
                    radius: dimensWidth() * 3,
                  ),
                  title: Text(
                    'Cảm',
                    style: Theme.of(context).textTheme.titleSmall,
                  ),
                  subtitle: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        'Trần Huỳnh Tấn Phát',
                        style: Theme.of(context).textTheme.labelLarge,
                      ),
                    ],
                  ),
                  trailing: Text(
                    TimeOfDay.now().format(context).toString(),
                    style: Theme.of(context).textTheme.titleLarge,
                  ),
                ),
                Divider(
                  color: color1F1F1F.withOpacity(.3),
                ),
                ListTile(
                  onTap: () {},
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(
                      dimensWidth(),
                    ),
                  ),
                  dense: true,
                  visualDensity: const VisualDensity(vertical: 0),
                  leading: CircleAvatar(
                    backgroundImage: AssetImage(DImages.placeholder),
                    radius: dimensWidth() * 3,
                  ),
                  title: Text(
                    'Đau bụng',
                    style: Theme.of(context).textTheme.titleSmall,
                  ),
                  subtitle: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        'Trần Huỳnh Tấn Phát',
                        style: Theme.of(context).textTheme.labelLarge,
                      ),
                    ],
                  ),
                  trailing: Text(
                    TimeOfDay.now().format(context).toString(),
                    style: Theme.of(context).textTheme.titleLarge,
                  ),
                ),
                Divider(
                  color: color1F1F1F.withOpacity(.3),
                ),
                ListTile(
                  onTap: () {},
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(
                      dimensWidth(),
                    ),
                  ),
                  dense: true,
                  visualDensity: const VisualDensity(vertical: 0),
                  leading: CircleAvatar(
                    backgroundImage: AssetImage(DImages.placeholder),
                    radius: dimensWidth() * 3,
                  ),
                  title: Text(
                    'Đau đầu',
                    style: Theme.of(context).textTheme.titleSmall,
                  ),
                  subtitle: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        'Trần Huỳnh Tấn Phát',
                        style: Theme.of(context).textTheme.labelLarge,
                      ),
                    ],
                  ),
                  trailing: Text(
                    TimeOfDay.now().format(context).toString(),
                    style: Theme.of(context).textTheme.titleLarge,
                  ),
                ),
              ],
            ),
          ),
          Padding(
            padding: EdgeInsets.symmetric(
                horizontal: dimensWidth() * 3, vertical: dimensHeight() * 2),
            child: Text(
              translate(context, 'next_patient_profile'),
              style: Theme.of(context).textTheme.titleLarge,
            ),
          ),
          Padding(
            padding: EdgeInsets.symmetric(horizontal: dimensWidth() * 3),
            child: Text(
              translate(context, 'images'),
              style: Theme.of(context).textTheme.titleMedium,
            ),
          ),
          Padding(
            padding: EdgeInsets.only(
              bottom: dimensHeight() * 2,
            ),
            child: CarouselSlider(
              items: [
                Container(
                  margin: EdgeInsets.only(top: dimensHeight()),
                  height: dimensHeight() * 35,
                  width: double.maxFinite,
                  decoration: BoxDecoration(
                    color: color1F1F1F,
                    borderRadius: BorderRadius.circular(dimensWidth() * 2),
                    image: DecorationImage(
                        alignment: Alignment.topCenter,
                        image: AssetImage(DImages.placeholder),
                        fit: BoxFit.fitWidth),
                  ),
                )
              ],
              options: CarouselOptions(
                  autoPlay: false,
                  aspectRatio: 2,
                  enlargeCenterPage: true,
                  viewportFraction: 0.8,
                  reverse: false,
                  enlargeStrategy: CenterPageEnlargeStrategy.scale),
            ),
          ),
          Padding(
            padding: EdgeInsets.symmetric(horizontal: dimensWidth() * 3),
            child: Text(
              translate(context, 'file'),
              style: Theme.of(context).textTheme.titleMedium,
            ),
          ),
          Padding(
            padding: EdgeInsets.only(
                left: dimensWidth() * 3, right: dimensWidth() * 3),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                ListTile(
                  onTap: () {},
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(
                      dimensWidth(),
                    ),
                  ),
                  dense: true,
                  visualDensity: const VisualDensity(vertical: 0),
                  leading: FaIcon(
                    FontAwesomeIcons.fileWord,
                    size: dimensIcon(),
                    color: const Color.fromARGB(255, 13, 105, 181),
                  ),
                  title: Text(
                    'Cảm',
                    style: Theme.of(context).textTheme.labelLarge,
                  ),
                  trailing: FaIcon(FontAwesomeIcons.chevronRight,
                      size: dimensIcon() * .5),
                ),
                const Divider(),
                ListTile(
                  onTap: () {},
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(
                      dimensWidth(),
                    ),
                  ),
                  dense: true,
                  visualDensity: const VisualDensity(vertical: 0),
                  leading: FaIcon(
                    FontAwesomeIcons.fileExcel,
                    size: dimensIcon(),
                    color: Colors.green,
                  ),
                  title: Text(
                    'Cảm',
                    style: Theme.of(context).textTheme.labelLarge,
                  ),
                  trailing: FaIcon(FontAwesomeIcons.chevronRight,
                      size: dimensIcon() * .5),
                ),
                const Divider(),
                ListTile(
                  onTap: () {},
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(
                      dimensWidth(),
                    ),
                  ),
                  leading: FaIcon(
                    FontAwesomeIcons.filePdf,
                    size: dimensIcon(),
                    color: Colors.redAccent,
                  ),
                  dense: true,
                  visualDensity: const VisualDensity(vertical: 0),
                  title: Text(
                    'Cảm',
                    style: Theme.of(context).textTheme.labelLarge,
                  ),
                  trailing: FaIcon(FontAwesomeIcons.chevronRight,
                      size: dimensIcon() * .5),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
