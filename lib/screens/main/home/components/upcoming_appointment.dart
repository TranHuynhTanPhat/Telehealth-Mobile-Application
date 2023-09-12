import 'package:carousel_slider/carousel_slider.dart';
import 'package:flutter/material.dart';
import 'package:healthline/res/style.dart';

class UpcomingApointment extends StatelessWidget {
  const UpcomingApointment({super.key, required this.appointments});
  final List<Map<String, dynamic>> appointments;

  @override
  Widget build(BuildContext context) {
    return CarouselSlider(
        items: appointments
            .map(
              (e) => Container(
                padding: EdgeInsets.all(dimensWidth() * 2),
                decoration: BoxDecoration(
                    color: colorCDDEFF,
                    borderRadius: BorderRadius.circular(dimensWidth() * 2.5)),
                child: Row(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Expanded(
                          flex: 3,
                          child: Container(
                            decoration: BoxDecoration(
                              color: white.withOpacity(.5),
                              borderRadius: BorderRadius.circular(
                                dimensWidth() * 1.5,
                              ),
                            ),
                            child: Column(
                              children: [
                                Expanded(
                                  child: Text(
                                    e['date'].month.toString(),
                                    style: Theme.of(context)
                                        .textTheme
                                        .displayLarge
                                        ?.copyWith(
                                            color: secondary,
                                            fontWeight: FontWeight.w600),
                                  ),
                                ),
                                Expanded(
                                  child: Text(
                                    e['date'].day.toString(),
                                    style: Theme.of(context)
                                        .textTheme
                                        .displaySmall
                                        ?.copyWith(
                                            color: secondary,
                                            fontWeight: FontWeight.w400),
                                  ),
                                )
                              ],
                            ),
                          )),
                      Expanded(
                          flex: 7,
                          child: Padding(
                            padding: EdgeInsets.only(
                                left: dimensWidth() * 2,
                                top: dimensWidth(),
                                bottom: dimensWidth() * 2),
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              mainAxisAlignment: MainAxisAlignment.start,
                              children: [
                                Expanded(
                                  child: Text(
                                    e['time'].format(context).toString(),
                                    style: Theme.of(context)
                                        .textTheme
                                        .bodyLarge
                                        ?.copyWith(color: secondary),
                                  ),
                                ),
                                Expanded(
                                  child: Text(
                                    e['dr'],
                                    overflow: TextOverflow.ellipsis,
                                    style: Theme.of(context)
                                        .textTheme
                                        .titleLarge
                                        ?.copyWith(
                                            color: secondary,
                                            fontWeight: FontWeight.w600),
                                  ),
                                ),
                                Expanded(
                                  child: Text(
                                    e['description'],
                                    overflow: TextOverflow.ellipsis,
                                    style: Theme.of(context)
                                        .textTheme
                                        .bodyLarge
                                        ?.copyWith(color: secondary),
                                  ),
                                )
                              ],
                            ),
                          ))
                    ]),
              ),
            )
            .toList(),
        options: CarouselOptions(
            autoPlay: false,
            aspectRatio: 3,
            enlargeCenterPage: true,
            viewportFraction: 0.8,
            reverse: false,
            enlargeStrategy: CenterPageEnlargeStrategy.scale));
  }
}
