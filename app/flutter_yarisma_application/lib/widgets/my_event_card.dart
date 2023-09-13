import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_yarisma_application/util/constants.dart';
import 'package:flutter_yarisma_application/screens/screen.dart';

class MyEventCard extends StatelessWidget {
  const MyEventCard({
    Key? key,
    required this.event,
    required this.owner,
    required this.isActive,
    required this.eventFinishDate,
    required this.eventName,
    required this.award,
    required this.awardCount,
    required this.contestants,
  }) : super(key: key);

  final String owner;
  final bool isActive;
  final String eventFinishDate;
  final String eventName;
  final String award;
  final String awardCount;
  final String contestants;
  final event;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(top: 3),
      child: InkWell(
        onTap: () {
          Navigator.of(context).push(CupertinoPageRoute(
            builder: (context) => EventDetailPage(event: event, owner: owner),
          ));
        },
        child: Card(
          color: cardColor,
          child: Column(
            mainAxisSize: MainAxisSize.min,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              ListTile(
                title: Text(
                  eventName,
                  style: ortaBoyBaslik.copyWith(color: Colors.black),
                ),
                subtitle: Text(
                  owner,
                  style: buyukBoyBody.copyWith(color: Colors.black38),
                ),
              ),
              Padding(
                padding: const EdgeInsets.fromLTRB(15, 0, 15, 15),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      "Yarışma Bitiş Tarihi: ${DateTime.parse(eventFinishDate).day}/${DateTime.parse(eventFinishDate).month}/${DateTime.parse(eventFinishDate).year}",
                      style: ortaBoyBody.copyWith(color: Colors.black),
                    ),
                    Text(
                      "Ödül: $award",
                      style: ortaBoyBody.copyWith(color: Colors.black),
                    ),
                    Text(
                      "Verilecek Ödül Sayısı: $awardCount",
                      style: ortaBoyBody.copyWith(color: Colors.black),
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
