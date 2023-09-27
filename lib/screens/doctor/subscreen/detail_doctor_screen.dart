import 'package:cloudinary_flutter/cloudinary_context.dart';
import 'package:flutter/material.dart';
import 'package:flutter_rating_bar/flutter_rating_bar.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:healthline/res/style.dart';
import 'package:healthline/screens/widgets/elevated_button_widget.dart';

class DetailDoctorScreen extends StatefulWidget {
  const DetailDoctorScreen({super.key});

  @override
  State<DetailDoctorScreen> createState() => _DetailDoctorScreenState();
}

class _DetailDoctorScreenState extends State<DetailDoctorScreen> {
  // ignore: prefer_typing_uninitialized_variables
  var imgVariable;
  @override
  void initState() {
    imgVariable = null;
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    imgVariable = imgVariable ??
        NetworkImage(
          CloudinaryContext.cloudinary
              .image('healthline/avatar/oxgzmmewx1udo3un2udo')
              .toString(),
        );
    return Scaffold(
      resizeToAvoidBottomInset: true,
      backgroundColor: white,
      extendBody: true,
      bottomNavigationBar: Container(
          padding: EdgeInsets.fromLTRB(
              dimensWidth() * 3, 0, dimensWidth() * 3, dimensHeight() * 3),
          decoration: BoxDecoration(
            gradient: LinearGradient(
              colors: [Colors.white.withOpacity(0.0), white],
              begin: Alignment.topCenter,
              end: Alignment.bottomCenter,
            ),
          ),
          width: double.infinity,
          child: const ElevatedButtonWidget(
              text: 'Book appointment', onPressed: null)),
      body: NestedScrollView(
        headerSliverBuilder: (context, innerBoxIsScrolled) {
          return [
            SliverAppBar(
              centerTitle: true,
              snap: false,
              pinned: true,
              floating: true,
              expandedHeight: dimensHeight() * 35,
              flexibleSpace: FlexibleSpaceBar(
                background: Container(
                  width: double.infinity,
                  decoration: BoxDecoration(
                    image: DecorationImage(
                      image: imgVariable,
                      onError: (exception, stackTrace) => setState(() {
                        imgVariable = AssetImage(DImages.placeholder);
                      }),
                      fit: BoxFit.cover,
                    ),
                  ),
                ),
              ),
              bottom: PreferredSize(
                preferredSize: Size.fromHeight(dimensHeight() * 7),
                child: Container(
                  padding: EdgeInsets.fromLTRB(
                    dimensWidth() * 3,
                    dimensHeight(),
                    dimensWidth() * 3,
                    dimensHeight(),
                  ),
                  alignment: Alignment.center,
                  width: double.infinity,
                  decoration: BoxDecoration(
                    gradient: LinearGradient(
                      colors: [Colors.white.withOpacity(0.0), white],
                      begin: Alignment.topCenter,
                      end: Alignment.bottomCenter,
                    ),
                  ),
                  child: Row(
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      Expanded(
                        child: Text(
                          "Doctor Name",
                          maxLines: 2,
                          overflow: TextOverflow.fade,
                          style: Theme.of(context)
                              .textTheme
                              .headlineMedium
                              ?.copyWith(fontWeight: FontWeight.bold),
                        ),
                      ),
                      Text(
                        "\$100",
                        maxLines: 2,
                        overflow: TextOverflow.fade,
                        style: Theme.of(context)
                            .textTheme
                            .bodyLarge
                            ?.copyWith(color: secondary),
                      ),
                    ],
                  ),
                ),
              ),
            ),
          ];
        },
        body: ListView(
          shrinkWrap: true,
          scrollDirection: Axis.vertical,
          padding: EdgeInsets.only(
              bottom: dimensHeight() * 2,
              left: dimensWidth() * 3,
              right: dimensWidth() * 3),
          children: [
            Padding(
              padding:
                  EdgeInsets.only(bottom: dimensHeight(), top: dimensHeight()),
              child: Text(
                'Tim mạch',
                style: Theme.of(context).textTheme.labelLarge,
              ),
            ),
            Row(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                RatingBar.builder(
                  ignoreGestures: true,
                  initialRating: 3.5,
                  minRating: 1,
                  direction: Axis.horizontal,
                  allowHalfRating: true,
                  itemCount: 5,
                  itemSize: dimensWidth() * 2,
                  itemBuilder: (context, _) => const FaIcon(
                    FontAwesomeIcons.solidStar,
                    color: Colors.amber,
                  ),
                  onRatingUpdate: (double value) {},
                ),
                Padding(
                  padding: EdgeInsets.only(left: dimensWidth()),
                  child: Text(
                    '3.5 (+800 feedbacks)',
                    style: Theme.of(context).textTheme.bodyMedium,
                  ),
                )
              ],
            ),
            Padding(
              padding: EdgeInsets.only(top: dimensHeight() * 3),
              child: Text(
                'Biography',
                style: Theme.of(context).textTheme.titleLarge,
              ),
            ),
            Text(
              'sndlcklkndslncvladsnvjadsnfldncljfkjaslkfjlskdjflakdsjflksjlfsdjfslkfjlskadflkdsjflksdjflksdjflsdjlkfsdlkfjslkdfjlsakjflksdajfjaewkjclksjdlcjsdlkjlfkdsfkawfjklsdjflkslkvlskdvnlskdjfklsdjflksdclksdnflsjkdflskdlkcasdmclknadslkvjsflkjejfoaisclksndlcklkndslncvladsnvjadsnfldncljfkjaslkfjlskdjflakdsjflksjlfsdjfslkfjlskadflkdsjflksdjflksdjflsdjlkfsdlkfjslkdfjlsakjflksdajfjaewkjclksjdlcjsdlkjlfkdsfkawfjklsdjflkslkvlskdvnlskdjfklsdjflksdclksdnflsjkdflskdlkcasdmclknadslkvjsflkjejfoaisclksndlcklkndslncvladsnvjadsnfldncljfkjaslkfjlskdjflakdsjflksjlfsdjfslkfjlskadflkdsjflksdjflksdjflsdjlkfsdlkfjslkdfjlsakjflksdajfjaewkjclksjdlcjsdlkjlfkdsfkawfjklsdjflkslkvlskdvnlskdjfklsdjflksdclksdnflsjkdflskdlkcasdmclknadslkvjsflkjejfoaisclksndlcklkndslncvladsnvjadsnfldncl',
              style: Theme.of(context).textTheme.bodyLarge,
            ),
            Padding(
              padding: EdgeInsets.only(top: dimensHeight() * 3),
              child: Text(
                'Working time',
                style: Theme.of(context).textTheme.titleLarge,
              ),
            ),
            Text(
              'Mon - Sat, 10:00 am - 07:00 pm',
              style: Theme.of(context).textTheme.bodyLarge,
            ),
            Padding(
              padding: EdgeInsets.only(top: dimensHeight() * 3),
              child: Text(
                'Feedbacks',
                style: Theme.of(context).textTheme.titleLarge,
              ),
            ),
            Text(
              'Mon - Sat, 10:00 am - 07:00 pm',
              style: Theme.of(context).textTheme.bodyLarge,
            ),
            SizedBox(
              height: dimensHeight() * 10,
            )
          ],
        ),
      ),
    );
  }
}
