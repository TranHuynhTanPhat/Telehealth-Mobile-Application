import 'package:flutter/material.dart';
import 'package:healthline/res/style.dart';
import 'package:healthline/utils/translate.dart';

class VaccinationScreen extends StatelessWidget {
  const VaccinationScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final List<Map<String, dynamic>> vaccinationForAdult = [
      {
        "vaccine": "influenza",
        "age": "over_nine_years_old",
        "categories": [
          {
            "dose": 1,
            "notice": "a_booster_dose_every_year",
            "required": false,
            "method": "injection",
            "schedule": [
              {
                "dose": 1,
                "timeDose": "from_nine_years_old",
                "daysFromLastDose": ""
              }
            ]
          }
        ],
      },
      {
        "vaccine": "pneumococcal_disease",
        "age": "over_nine_years_old",
        "categories": [
          {
            "dose": 1,
            "notice": "",
            "required": false,
            "method": "injection",
            "schedule": [
              {
                "dose": 1,
                "timeDose": "from_nine_years_old",
                "daysFromLastDose": ""
              }
            ]
          }
        ]
      },
      {
        "vaccine": "measles_mumps_rubella",
        "age": "over_nine_years_old",
        "categories": [
          {
            "dose": 2,
            "notice":
                "women_should_receive_the_vaccine_at_least_three_month_before_getting_pregnant",
            "required": false,
            "method": "injection",
            "schedule": [
              {
                "dose": 1,
                "timeDose": "from_nine_years_old",
                "daysFromLastDose": ""
              },
              {
                "dose": 2,
                "timeDose": "from_nine_years_old",
                "daysFromLastDose": "minimum_interval_one_month"
              }
            ]
          }
        ],
      },
      {
        "vaccine": "varicella",
        "age": "over_nine_years_old",
        "categories": [
          {
            "dose": 2,
            "notice":
                "women_should_receive_the_vaccine_at_least_three_month_before_getting_pregnant",
            "required": false,
            "method": "injection",
            "schedule": [
              {
                "dose": 1,
                "timeDose": "from_nine_years_old",
                "daysFromLastDose": ""
              },
              {
                "dose": 2,
                "timeDose": "from_nine_years_old",
                "daysFromLastDose": "minimum_interval_one_month"
              }
            ]
          }
        ],
      },
      {
        "vaccine": "tetanus",
        "age": "over_nine_years_old",
        "categories": [
          {
            "dose": 3,
            "notice": "women_in_fertility_age",
            "required": false,
            "method": "injection",
            "schedule": [
              {
                "dose": 1,
                "timeDose": "asap_when_being_pregnant",
                "daysFromLastDose": ""
              },
              {"dose": 2, "timeDose": "", "daysFromLastDose": "one_month"},
              {
                "dose": 3,
                "timeDose": "",
                "daysFromLastDose":
                    "at_least_six_months_or_can_be_received_in_the_next_pregnancy"
              }
            ]
          },
          {
            "dose": 3,
            "notice": "",
            "required": false,
            "method": "injection",
            "schedule": [
              {"dose": 1, "timeDose": "when_in_need", "daysFromLastDose": ""},
              {
                "dose": 2,
                "timeDose": "",
                "daysFromLastDose": "minimum_interval_one_month"
              },
              {
                "dose": 3,
                "timeDose": "",
                "daysFromLastDose": "six_to_twelve_months"
              }
            ]
          }
        ],
      },
      {
        "vaccine": "diphtheria_tetanus_pertussis",
        "age": "over_nine_years_old",
        "categories": [
          {
            "dose": 1,
            "notice": "a_booster_every_10_years",
            "required": false,
            "method": "injection",
            "schedule": [
              {
                "dose": 1,
                "timeDose": "from_nine_years_old",
                "daysFromLastDose": ""
              }
            ]
          }
        ]
      },
      {
        "vaccine": "japanese_encephalitis",
        "age": "over_nine_years_old",
        "categories": [
          {
            "dose": 2,
            "notice": "never_injected_yet",
            "required": false,
            "method": "injection",
            "schedule": [
              {
                "dose": 1,
                "timeDose": "from_nine_years_old",
                "daysFromLastDose": ""
              },
              {
                "dose": 2,
                "timeDose": "from_nine_years_old",
                "daysFromLastDose": "one_year"
              }
            ]
          },
          {
            "dose": 1,
            "notice": "already_injected",
            "required": false,
            "method": "injection",
            "schedule": [
              {
                "dose": 1,
                "timeDose": "from_nine_years_old",
                "daysFromLastDose": ""
              }
            ]
          }
        ]
      },
      {
        "vaccine": "meningococcal_acwy",
        "age": "over_nine_years_old",
        "categories": [
          {
            "dose": 1,
            "notice": "",
            "required": false,
            "method": "injection",
            "schedule": [
              {
                "dose": 1,
                "timeDose": "from_nine_to_fifty_five_years_old",
                "daysFromLastDose": ""
              }
            ]
          }
        ]
      },
      {
        "vaccine": "meningococcal_disease_caused_by_serogroups_b_and_c",
        "age": "over_nine_years_old",
        "categories": [
          {
            "dose": 2,
            "notice": "",
            "required": false,
            "method": "injection",
            "schedule": [
              {
                "dose": 1,
                "timeDose": "from_nine_to_fourty_five_years_old",
                "daysFromLastDose": ""
              },
              {
                "dose": 2,
                "timeDose": "from_nine_to_fourty_five_years_old",
                "daysFromLastDose": "minimum_interval_two_months"
              }
            ]
          }
        ]
      },
      {
        "vaccine": "hepatitis_a",
        "age": "over_nine_years_old",
        "categories": [
          {
            "dose": 2,
            "notice": "",
            "required": false,
            "method": "injection",
            "schedule": [
              {
                "dose": 1,
                "timeDose": "from_nine_years_old",
                "daysFromLastDose": ""
              },
              {
                "dose": 2,
                "timeDose": "from_nine_years_old",
                "daysFromLastDose": "minimum_interval_six_to_twelve_months"
              }
            ]
          }
        ]
      },
      {
        "vaccine": "hepatitis_b",
        "age": "over_nine_years_old",
        "categories": [
          {
            "dose": 3,
            "notice": "a_booster_dose_every_five_years",
            "required": false,
            "method": "injection",
            "schedule": [
              {
                "dose": 1,
                "timeDose": "from_nine_years_old",
                "daysFromLastDose": ""
              },
              {
                "dose": 2,
                "timeDose": "from_nine_years_old",
                "daysFromLastDose": "one_month_after_1st_dose"
              },
              {
                "dose": 3,
                "timeDose": "from_nine_years_old",
                "daysFromLastDose": "six_months_after_1st_dose"
              }
            ]
          }
        ]
      },
      {
        "vaccine": "hepatitis_a_and_b",
        "age": "over_nine_years_old",
        "categories": [
          {
            "dose": 2,
            "notice": "",
            "required": false,
            "method": "injection",
            "schedule": [
              {
                "dose": 1,
                "timeDose": "from_nine_to_fifteen_years_old",
                "daysFromLastDose": ""
              },
              {
                "dose": 2,
                "timeDose": "from_nine_to_fifteen_years_old",
                "daysFromLastDose": "minimum_interval_six_to_twelve_months"
              }
            ]
          },
          {
            "dose": 3,
            "notice": "",
            "required": false,
            "method": "injection",
            "schedule": [
              {
                "dose": 1,
                "timeDose": "from_sixteen_years_old",
                "daysFromLastDose": ""
              },
              {
                "dose": 2,
                "timeDose": "from_sixteen_years_old",
                "daysFromLastDose": "minimum_interval_one_month"
              },
              {
                "dose": 3,
                "timeDose": "from_sixteen_years_old",
                "daysFromLastDose": "minimum_interval_five_month"
              }
            ]
          }
        ]
      },
      {
        "vaccine": "hpv",
        "age": "over_nine_years_old",
        "categories": [
          {
            "dose": 3,
            "notice": "",
            "required": false,
            "method": "injection",
            "schedule": [
              {
                "dose": 1,
                "timeDose": "from_nine_to_fourty_five_years_old",
                "daysFromLastDose": ""
              },
              {
                "dose": 1,
                "timeDose": "from_nine_to_fourty_five_years_old",
                "daysFromLastDose":
                    "minimum_interval_one_to_two_months_after_1st_dose"
              },
              {
                "dose": 1,
                "timeDose": "from_nine_to_fourty_five_years_old",
                "daysFromLastDose": "minimum_interval_six_months_after_1st_dose"
              }
            ]
          }
        ]
      },
      {
        "vaccine": "cholera",
        "age": "over_nine_years_old",
        "categories": [
          {
            "dose": 2,
            "notice": "a_booster_when_needed",
            "required": false,
            "method": "drink",
            "schedule": [
              {
                "dose": 1,
                "timeDose": "from_nine_years_old",
                "daysFromLastDose": ""
              },
              {
                "dose": 2,
                "timeDose": "from_nine_years_old",
                "daysFromLastDose": "minimum_interval_two_weeks"
              }
            ]
          }
        ]
      },
      {
        "vaccine": "typhoid",
        "age": "over_nine_years_old",
        "categories": [
          {
            "dose": 1,
            "notice": "a_booster_every_three_years",
            "required": false,
            "method": "injection",
            "schedule": [
              {
                "dose": 1,
                "timeDose": "from_nine_years_old",
                "daysFromLastDose": ""
              }
            ]
          }
        ]
      },
      {
        "vaccine": "rabies",
        "age": "over_nine_years_old",
        "categories": [
          {
            "dose": 3,
            "notice": "three_dose_series_depending_on_indication",
            "required": false,
            "method": "injection",
            "schedule": []
          }
        ]
      },
      {
        "vaccine": "yellow_fever",
        "age": "over_nine_years_old",
        "categories": [
          {
            "dose": 1,
            "notice":
                "single_dose_recommended_to_person_traveling_to_or_living_in_areas_at_risk_for_yellow_fever_virus",
            "required": false,
            "method": "injection",
            "schedule": []
          }
        ]
      }
    ];
    final List<Map<String, dynamic>> vaccinationForChild = [
      {
        "vaccine": "tuberculosis",
        "age": "under_nine_years_old",
        "categories": [
          {
            "dose": 1,
            "notice": "",
            "required": true,
            "method": "injection",
            "schedule": [
              {"dose": 1, "timeDose": "new_born", "daysFromLastDose": ""}
            ]
          }
        ],
      },
      {
        "vaccine": "hepatitis_b",
        "age": "under_nine_years_old",
        "categories": [
          {
            "dose": 5,
            "notice": "",
            "required": true,
            "method": "injection",
            "schedule": [
              {"dose": 1, "timeDose": "new_born", "daysFromLastDose": ""},
              {
                "dose": 2,
                "timeDose": "two_months_old",
                "daysFromLastDose": "two_months"
              },
              {
                "dose": 3,
                "timeDose": "three_months_old",
                "daysFromLastDose": "one_month"
              },
              {
                "dose": 4,
                "timeDose": "four_months_old",
                "daysFromLastDose": "one_month"
              },
              {
                "dose": 5,
                "timeDose": "eighteen_months_old",
                "daysFromLastDose": "fourteen_month"
              }
            ]
          }
        ]
      },
      {
        "vaccine": "diphtheria_tetanus_pertussis",
        "age": "under_nine_years_old",
        "categories": [
          {
            "dose": 5,
            "notice": "",
            "required": true,
            "method": "injection",
            "schedule": [
              {"dose": 1, "timeDose": "two_months_old", "daysFromLastDose": ""},
              {
                "dose": 2,
                "timeDose": "three_months_old",
                "daysFromLastDose": "one_month"
              },
              {
                "dose": 3,
                "timeDose": "four_months_old",
                "daysFromLastDose": "one_month"
              },
              {
                "dose": 4,
                "timeDose": "eighteen_months_old",
                "daysFromLastDose": "fourteen_month"
              },
              {
                "dose": 5,
                "timeDose": "five_to_six_years_old",
                "daysFromLastDose": ""
              }
            ]
          }
        ]
      },
      {
        "vaccine": "poliomyelitis",
        "age": "under_nine_years_old",
        "categories": [
          {
            "dose": 5,
            "notice": "",
            "required": true,
            "method": "injection",
            "schedule": [
              {"dose": 1, "timeDose": "two_months_old", "daysFromLastDose": ""},
              {
                "dose": 2,
                "timeDose": "three_months_old",
                "daysFromLastDose": "one_month"
              },
              {
                "dose": 3,
                "timeDose": "four_months_old",
                "daysFromLastDose": "one_month"
              },
              {
                "dose": 4,
                "timeDose": "eighteen_months_old",
                "daysFromLastDose": "fourteen_month"
              },
              {
                "dose": 5,
                "timeDose": "five_to_six_years_old",
                "daysFromLastDose": ""
              }
            ]
          }
        ],
      },
      {
        "vaccine": "hib_diseases",
        "age": "under_nine_years_old",
        "categories": [
          {
            "dose": 4,
            "notice": "",
            "required": true,
            "method": "injection",
            "schedule": [
              {"dose": 1, "timeDose": "two_months_old", "daysFromLastDose": ""},
              {
                "dose": 2,
                "timeDose": "three_months_old",
                "daysFromLastDose": "one_month"
              },
              {
                "dose": 3,
                "timeDose": "four_months_old",
                "daysFromLastDose": "one_month"
              },
              {
                "dose": 4,
                "timeDose": "eighteen_months_old",
                "daysFromLastDose": "fourteen_month"
              }
            ]
          }
        ]
      },
      {
        "vaccine": "rotavirus",
        "age": "under_nine_years_old",
        "categories": [
          {
            "dose": 2,
            "notice": "",
            "required": false,
            "method": "injection",
            "schedule": [
              {
                "dose": 1,
                "timeDose": "two_to_six_months_old",
                "daysFromLastDose": ""
              },
              {
                "dose": 2,
                "timeDose": "two_to_six_months_old",
                "daysFromLastDose": "minimum_interval_one_month"
              }
            ]
          },
          {
            "dose": 3,
            "notice": "",
            "required": false,
            "method": "injection",
            "schedule": [
              {
                "dose": 1,
                "timeDose": "two_to_six_months_old",
                "daysFromLastDose": ""
              },
              {
                "dose": 2,
                "timeDose": "two_to_six_months_old",
                "daysFromLastDose": "minimum_interval_one_month"
              },
              {
                "dose": 3,
                "timeDose": "two_to_six_months_old",
                "daysFromLastDose": "minimum_interval_one_month"
              }
            ]
          }
        ]
      },
      {
        "vaccine": "pneumococcal_disease",
        "age": "under_nine_years_old",
        "categories": [
          {
            "dose": 4,
            "notice": "",
            "required": false,
            "method": "injection",
            "schedule": [
              {"dose": 1, "timeDose": "two_months_old", "daysFromLastDose": ""},
              {
                "dose": 2,
                "timeDose": "three_months_old",
                "daysFromLastDose": "one_month"
              },
              {
                "dose": 3,
                "timeDose": "four_months_old",
                "daysFromLastDose": "one_month"
              },
              {
                "dose": 4,
                "timeDose": "ten_to_elevent_months_old",
                "daysFromLastDose": "six_to_seven_months"
              }
            ]
          }
        ]
      },
      {
        "vaccine": "meningococcal_disease_caused_by_serogroups_b_and_c",
        "age": "under_nine_years_old",
        "categories": [
          {
            "dose": 2,
            "notice": "",
            "required": false,
            "method": "injection",
            "schedule": [
              {"dose": 1, "timeDose": "six_months_old", "daysFromLastDose": ""},
              {
                "dose": 2,
                "timeDose": "eight_months_old",
                "daysFromLastDose": "two_months"
              }
            ]
          }
        ]
      },
      {
        "vaccine": "influenza",
        "age": "under_nine_years_old",
        "categories": [
          {
            "dose": 2,
            "notice": "a_booster_dose_every_year",
            "required": false,
            "method": "injection",
            "schedule": [
              {
                "dose": 1,
                "timeDose": "six_months_to_nine_years_old",
                "daysFromLastDose": ""
              },
              {
                "dose": 2,
                "timeDose": "six_months_to_nine_years_old",
                "daysFromLastDose": "minimum_interval_one_month"
              }
            ]
          }
        ]
      },
      {
        "vaccine": "measles",
        "age": "under_nine_years_old",
        "categories": [
          {
            "dose": 2,
            "notice": "",
            "required": true,
            "method": "injection",
            "schedule": [
              {
                "dose": 1,
                "timeDose": "nine_months_old",
                "daysFromLastDose": ""
              },
              {
                "dose": 2,
                "timeDose": "eighteen_months_old",
                "daysFromLastDose": "nine_months_old"
              }
            ]
          }
        ]
      },
      {
        "vaccine": "meningococcal_acwy",
        "age": "under_nine_years_old",
        "categories": [
          {
            "dose": 2,
            "notice": "",
            "required": false,
            "method": "injection",
            "schedule": [
              {
                "dose": 1,
                "timeDose": "nine_months_old",
                "daysFromLastDose": ""
              },
              {
                "dose": 2,
                "timeDose": "twelve_months_old",
                "daysFromLastDose": "three_months"
              }
            ]
          }
        ]
      },
      {
        "vaccine": "japanese_encephalitis",
        "age": "under_nine_years_old",
        "categories": [
          {
            "dose": 2,
            "notice": "",
            "required": true,
            "method": "injection",
            "schedule": [
              {
                "dose": 1,
                "timeDose": "nine_months_to_two_months_old",
                "daysFromLastDose": ""
              },
              {
                "dose": 2,
                "timeDose": "nine_months_to_two_months_old",
                "daysFromLastDose": "minimum_interval_one_year"
              }
            ]
          }
        ]
      },
      {
        "vaccine": "measles_mumps_rubella",
        "age": "under_nine_years_old",
        "categories": [
          {
            "dose": 2,
            "notice": "",
            "required": true,
            "method": "injection",
            "schedule": [
              {
                "dose": 2,
                "timeDose": "twelve_months_old",
                "daysFromLastDose": ""
              },
              {
                "dose": 3,
                "timeDose": "three_to_six_years_old",
                "daysFromLastDose": "two_to_five_years_old"
              }
            ]
          }
        ]
      },
      {
        "vaccine": "varicella",
        "age": "under_nine_years_old",
        "categories": [
          {
            "dose": 2,
            "notice": "",
            "required": false,
            "method": "injection",
            "schedule": [
              {
                "dose": 1,
                "timeDose": "nine_months_to_nine_years_old",
                "daysFromLastDose": ""
              },
              {
                "dose": 2,
                "timeDose": "nine_months_to_nine_years_old",
                "daysFromLastDose": "minimum_interval_three_months"
              }
            ]
          }
        ]
      },
      {
        "vaccine": "hepatitis_a",
        "age": "under_nine_years_old",
        "categories": [
          {
            "dose": 2,
            "notice": "",
            "required": false,
            "method": "injection",
            "schedule": [
              {
                "dose": 1,
                "timeDose": "twelve_to_eighteen_months_old",
                "daysFromLastDose": ""
              },
              {
                "dose": 2,
                "timeDose": "twelve_to_eighteen_months_old",
                "daysFromLastDose": "minimum_interval_six_months"
              }
            ]
          }
        ]
      },
      {
        "vaccine": "hepatitis_a_and_b",
        "age": "under_nine_years_old",
        "categories": [
          {
            "dose": 2,
            "notice": "",
            "required": false,
            "method": "injection",
            "schedule": [
              {
                "dose": 1,
                "timeDose": "twelve_to_eighteen_months_old",
                "daysFromLastDose": ""
              },
              {
                "dose": 2,
                "timeDose": "twelve_to_eighteen_months_old",
                "daysFromLastDose": "minimum_interval_six_to_twelve_months"
              }
            ]
          }
        ]
      },
      {
        "vaccine": "typhoid",
        "age": "under_nine_years_old",
        "categories": [
          {
            "dose": 1,
            "notice": " a_booster_dose_every_three_years",
            "required": false,
            "method": "injection",
            "schedule": [
              {
                "dose": 1,
                "timeDose": " two_to_nine_years_old",
                "daysFromLastDose": ""
              }
            ]
          }
        ]
      },
      {
        "vaccine": "cholera",
        "age": "under_nine_years_old",
        "categories": [
          {
            "dose": 2,
            "notice": "",
            "required": false,
            "method": "injection",
            "schedule": [
              {
                "dose": 1,
                "timeDose": " two_to_nine_years_old",
                "daysFromLastDose": ""
              },
              {
                "dose": 2,
                "timeDose": " two_to_nine_years_old",
                "daysFromLastDose": "minimum_interval_two_weeks"
              }
            ]
          }
        ],
      }
    ];
    return Scaffold(
      appBar: AppBar(
        elevation: 10,
        title: Text(
          translate(context, 'vaccination'),
        ),
      ),
      body: SingleChildScrollView(
        padding: EdgeInsets.only(bottom: dimensHeight() * 10),
        child: ExpansionPanelList.radio(
          elevation: 0,
          animationDuration: const Duration(milliseconds: 200),
          children: [
            ExpansionPanelRadio(
                headerBuilder: (BuildContext context, bool isExpanded) {
                  return ListTile(
                    title: Text(
                      translate(context, 'over_fine_ages'),
                      style: Theme.of(context).textTheme.titleLarge,
                    ),
                  );
                },
                body: ExpansionPanelList.radio(
                  animationDuration: const Duration(milliseconds: 200),
                  children: [
                    ...vaccinationForAdult.map(
                      (e) => ExpansionPanelRadio(
                        value: e,
                        headerBuilder: ((context, isExpanded) => ListTile(
                              title: Text(
                                translate(
                                  context,
                                  e['vaccine'],
                                ),
                              ),
                            )),
                        body: Column(
                          children: [
                            ...e['categories'].map(
                              (item) => ListTile(
                                title: Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    Text(
                                      "${translate(context, 'notice')}: ${translate(context, item['notice'])}",
                                    ),
                                    Text(
                                        "${translate(context, 'doses')}: ${item['dose'].toString()}"),
                                    Padding(
                                      padding:
                                          EdgeInsets.only(top: dimensHeight()),
                                      child: Text(
                                        '${translate(context, 'schedule')}:',
                                        style: Theme.of(context)
                                            .textTheme
                                            .labelLarge,
                                      ),
                                    ),
                                    ...item['schedule'].map(
                                      (schedule) => Column(
                                        crossAxisAlignment:
                                            CrossAxisAlignment.start,
                                        children: [
                                          Text(
                                              '${translate(context, 'dose')}: ${schedule['dose']}'),
                                          Padding(
                                            padding: EdgeInsets.only(
                                                left: dimensWidth()),
                                            child: Text(
                                                '${translate(context, 'time_dose')}: ${translate(context, schedule['timeDose'])}'),
                                          ),
                                          Padding(
                                            padding: EdgeInsets.only(
                                                left: dimensWidth()),
                                            child: Text(
                                                '${translate(context, 'days_from_last_dose')}: ${translate(context, schedule['daysFromLastDose'])}'),
                                          ),
                                        ],
                                      ),
                                    ),
                                    const Divider(
                                      color: black26,
                                    )
                                  ],
                                ),
                              ),
                            ),
                          ],
                        ),
                      ),
                    ),
                  ],
                ),
                value: 1),
            ExpansionPanelRadio(
                headerBuilder: (BuildContext context, bool isExpanded) {
                  return ListTile(
                    title: Text(
                      translate(context, 'under_fine_ages'),
                      style: Theme.of(context).textTheme.titleLarge,
                    ),
                  );
                },
                body: ExpansionPanelList.radio(
                  animationDuration: const Duration(milliseconds: 200),
                  children: [
                    ...vaccinationForChild.map(
                      (e) => ExpansionPanelRadio(
                        value: e,
                        headerBuilder: ((context, isExpanded) => ListTile(
                              title: Text(
                                translate(
                                  context,
                                  e['vaccine'],
                                ),
                              ),
                            )),
                        body: Column(
                          children: [
                            ...e['categories'].map(
                              (item) => ListTile(
                                title: Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    Text(
                                      "${translate(context, 'notice')}: ${translate(context, item['notice'])}",
                                    ),
                                    Text(
                                        "${translate(context, 'doses')}: ${item['dose'].toString()}"),
                                    Padding(
                                      padding:
                                          EdgeInsets.only(top: dimensHeight()),
                                      child: Text(
                                        '${translate(context, 'schedule')}:',
                                        style: Theme.of(context)
                                            .textTheme
                                            .labelLarge,
                                      ),
                                    ),
                                    ...item['schedule'].map(
                                      (schedule) => Column(
                                        crossAxisAlignment:
                                            CrossAxisAlignment.start,
                                        children: [
                                          Text(
                                              '${translate(context, 'dose')}: ${schedule['dose']}'),
                                          Padding(
                                            padding: EdgeInsets.only(
                                                left: dimensWidth()),
                                            child: Text(
                                                '${translate(context, 'time_dose')}: ${translate(context, schedule['timeDose'])}'),
                                          ),
                                          Padding(
                                            padding: EdgeInsets.only(
                                                left: dimensWidth()),
                                            child: Text(
                                                '${translate(context, 'days_from_last_dose')}: ${translate(context, schedule['daysFromLastDose'])}'),
                                          ),
                                        ],
                                      ),
                                    ),
                                    const Divider(
                                      color: black26,
                                    )
                                  ],
                                ),
                              ),
                            ),
                          ],
                        ),
                      ),
                    ),
                  ],
                ),
                value: 2),
          ],
        ),
      ),
    );
  }
}
