import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:project_cdm/features/feedback/ui/feedback_editing_page.dart';
import 'package:readmore/readmore.dart';

class FeedbackPage extends StatefulWidget {
  const FeedbackPage({super.key});

  @override
  State<FeedbackPage> createState() => _FeedbackPageState();
}

class _FeedbackPageState extends State<FeedbackPage> {
  bool isLike = false;
  @override
  Widget build(BuildContext context) {
    final width = MediaQuery.of(context).size.width;
    return Scaffold(
      floatingActionButton: MaterialButton(
        shape: const CircleBorder(),
        color: Colors.blue,
        padding: const EdgeInsets.all(15),
        onPressed: () {
          Navigator.of(context).push(
              MaterialPageRoute(builder: (context) => const FeedbackEditor()));
        },
        child: const Icon(Icons.add),
      ),
      appBar: AppBar(
        leading: const Card(
          clipBehavior: Clip.antiAliasWithSaveLayer,
          shape: CircleBorder(),
          child: Image(
              image: NetworkImage(
                  'https://images.rawpixel.com/image_800/czNmcy1wcml2YXRlL3Jhd3BpeGVsX2ltYWdlcy93ZWJzaXRlX2NvbnRlbnQvbHIvdjkzNy1hZXctMTM5LWtsaGRkM2FuLmpwZw.jpg')),
        ),
        title: Text(
          'Hari Prasath',
          style: GoogleFonts.poppins(fontWeight: FontWeight.normal),
        ),
      ),
      body: Padding(
        padding: const EdgeInsets.only(
          right: 10.0,
          left: 10.0,
          top: 10.0,
        ),
        child: SingleChildScrollView(
          child: Column(
            children: [
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceAround,
                children: [
                  const Flexible(
                    child: Row(
                      children: [
                        CircleAvatar(
                            backgroundColor: Colors.transparent,
                            radius: 25,
                            child: Icon(
                              Icons.account_circle_outlined,
                              size: 50,
                            )),
                        SizedBox(width: 10),
                        Flexible(
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text(
                                'NutriCare',
                                style: TextStyle(
                                    fontSize: 18, fontWeight: FontWeight.w600),
                              ),
                              Text(
                                'Chronic Disease Management Application',
                                style:
                                    TextStyle(overflow: TextOverflow.ellipsis),
                              ),
                            ],
                          ),
                        ),
                      ],
                    ),
                  ),
                  TextButton(
                    onPressed: () {},
                    child: const Row(
                      children: [
                        Icon(Icons.add),
                        Text(
                          "Follow",
                          style: TextStyle(fontSize: 15),
                        ),
                      ],
                    ),
                  ),
                ],
              ),
              const SizedBox(height: 6),
              const ReadMoreText(
                'Community support and feedback system for the chornic disease management app users exclusively. Users can share their own expirence to other user and other informations',
                trimLines: 2,
                trimMode: TrimMode.Line,
                colorClickableText: Colors.pink,
                style: TextStyle(color: Colors.black),
                trimCollapsedText: 'more',
                trimExpandedText: ' show less',
              ),
              Container(
                width: width,
                height: width,
                decoration: const BoxDecoration(
                    image: DecorationImage(
                        image: NetworkImage(
                            'https://meteoreducation.com/wp-content/uploads/community-support.png'))),
              ),
              Padding(
                padding:
                    const EdgeInsets.symmetric(vertical: 10.0, horizontal: 10),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Row(
                      children: [
                        IconButton(
                            onPressed: () {
                              setState(() {
                                isLike = !isLike;
                              });
                            },
                            icon: isLike
                                ? const Icon(
                                    CupertinoIcons.heart_fill,
                                    color: Colors.red,
                                    size: 27,
                                  )
                                : const Icon(
                                    CupertinoIcons.heart,
                                    size: 27,
                                  )),
                        const Text(
                          '66',
                          style: TextStyle(fontSize: 14),
                        ),
                        const SizedBox(width: 5),
                        IconButton(
                            onPressed: () {},
                            icon: const Icon(Icons.report_problem_outlined))
                      ],
                    ),
                    Row(
                      children: [
                        IconButton(
                            onPressed: () {},
                            icon: const Icon(Icons.messenger_outline_sharp)),
                        const Text("30")
                      ],
                    ),
                  ],
                ),
              )
            ],
          ),
        ),
      ),
    );
  }
}
