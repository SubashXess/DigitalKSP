import 'package:digitalksp/constants/styles.dart';
import 'package:digitalksp/models/blog_post_model.dart';
import 'package:digitalksp/utilities/utilities.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:flutter_widget_from_html_core/flutter_widget_from_html_core.dart';

class BlogPostPage extends StatefulWidget {
  const BlogPostPage({super.key});

  @override
  State<BlogPostPage> createState() => _BlogPostPageState();
}

class _BlogPostPageState extends State<BlogPostPage> {
  late final ScrollController _scrollController;
  late final List<SocialMediaModel> _socialMedia;

  final String htmlContent = """
  <p><strong>नवग्रह</strong></p>
  <p>वैदिक ज्योतिष में सूर्य, चंद्र, मंगल, बुध , बृहस्&zwj;पति, शुक्र,&nbsp; शनि और राहु&nbsp; केतु &nbsp; को नवग्रह के रूप में मान्यता प्राप्त है। सभी ग्रह अपने गोचर मे भ्रमण करते हुए राशिचक्र में कुछ समय के लिए ठहरते हैं और अपना अपना राशिफल&nbsp; प्रदान करते हैं। राहु और केतु आभाषीय ग्रह है, नक्षत्र मंडल में इनका वास्तविक अस्तित्व नहीं है। ये दोनों राशीमंडल में गणीतीय बिन्दु के रूप में स्थित होते हैं।&nbsp; </p>
  <p><strong>लग्न और जन्म राशि</strong></p>
  <p>पृथ्वी अपने अक्ष पर 24 घंटे में एक बार पश्चिम से पूरब घूमती है। इस कारण से सभी ग्रह नक्षत्र व राशियां 24 घंटे में एक बार पूरब से पश्चिम दिशा में घूमती हुई प्रतीत होती हैं। इस प्रक्रिया में सभी राशियां और तारे 24 घंटे में एक बार पूर्वी क्षितिज पर उदित और पश्चिमी क्षितिज पर अस्त होते हुए नज़र आते हैं। यही कारण है कि एक निश्चित बिन्दु और काल में&nbsp; राशिचक्र&nbsp; में एक विशेष राशि पूर्वी क्षितिज पर उदित होती है। जब कोई व्यक्ति जन्म लेता है उस समय उस अक्षांश और देशांतर में जो राशि पूर्व दिशा में उदित होती है वह राशि व्यक्ति का&nbsp;<strong>जन्म लग्न&nbsp;</strong>कहलाता है। जन्म के समय चन्द्रमा जिस राशि में बैठा होता है उस राशि को&nbsp;<strong>जन्म राशि या चन्द्र लग्न</strong>&nbsp; के नाम से जाना जाता है।</p>
  """;

  @override
  void initState() {
    super.initState();
    _scrollController = ScrollController();
    _socialMedia = SocialMediaModel.generatedItem;
  }

  @override
  void dispose() {
    _scrollController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final Size size = MediaQuery.of(context).size;
    return Scaffold(
      appBar: AppBar(
        actions: [
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 16.0),
            child: IconButton(
              onPressed: () => Utilities.shareIt(
                  url: 'https://www.digitalksp.com/blog_details.php?id=158',
                  text: 'Sharing files, text, and images between apps'),
              icon: SvgPicture.asset(
                'assets/icons/share-outlined.svg',
                width: 20.0,
                height: 20.0,
              ),
            ),
          ),
        ],
      ),
      body: SafeArea(
        child: SingleChildScrollView(
          controller: _scrollController,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const SizedBox(height: 16.0),
              Container(
                width: size.width,
                padding: const EdgeInsets.symmetric(horizontal: 16.0),
                child: Row(
                  children: [
                    const CircleAvatar(
                      radius: 20.0,
                      backgroundColor: Colors.grey,
                      backgroundImage: NetworkImage(
                          'https://images.pexels.com/photos/28368876/pexels-photo-28368876/free-photo-of-a-man-in-black-sitting-on-a-red-couch.jpeg?auto=compress&cs=tinysrgb&w=1260&h=750&dpr=1'),
                    ),
                    const SizedBox(width: 10.0),
                    Expanded(
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Row(
                            crossAxisAlignment: CrossAxisAlignment.center,
                            children: [
                              Text(
                                'Seth Godin',
                                style: Theme.of(context)
                                    .textTheme
                                    .labelLarge
                                    ?.copyWith(fontWeight: FontWeight.w600),
                              ),
                              const SizedBox(width: 8.0),
                              Tooltip(
                                message: 'Digital KSP Verified',
                                padding:
                                    const EdgeInsets.symmetric(horizontal: 8.0),
                                margin: EdgeInsets.zero,
                                child: Icon(Icons.check_circle_rounded,
                                    color: Theme.of(context).primaryColor,
                                    size: 14.0),
                              ),
                            ],
                          ),
                          const SizedBox(height: 2.0),
                          Row(
                            crossAxisAlignment: CrossAxisAlignment.center,
                            mainAxisAlignment: MainAxisAlignment.start,
                            children: [
                              Text(
                                '4h ago',
                                style: Theme.of(context)
                                    .textTheme
                                    .bodySmall
                                    ?.copyWith(color: Colors.grey),
                              ),
                              const SizedBox(width: 6.0),
                              const CircleAvatar(
                                  radius: 2.0, backgroundColor: Colors.grey),
                              const SizedBox(width: 6.0),
                              Text(
                                '5 min read',
                                style: Theme.of(context)
                                    .textTheme
                                    .bodySmall
                                    ?.copyWith(color: Colors.grey),
                              ),
                            ],
                          )
                        ],
                      ),
                    ),
                  ],
                ),
              ),
              const SizedBox(height: 20.0),
              Container(
                width: size.width,
                padding: const EdgeInsets.symmetric(horizontal: 16.0),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      'The freelancer and the Entrepreneur',
                      style: Theme.of(context)
                          .textTheme
                          .headlineSmall
                          ?.copyWith(fontWeight: FontWeight.w700),
                    ),
                    const SizedBox(height: 20.0),
                    const Divider(height: 0.0),
                    const SizedBox(height: 20.0),
                    Row(
                      children: [
                        Text('244',
                            style: Theme.of(context)
                                .textTheme
                                .bodyMedium
                                ?.copyWith(fontWeight: FontWeight.w500)),
                        const SizedBox(width: 4.0),
                        Icon(
                          Icons.visibility,
                          size: 18.0,
                          color: Colors.amber.shade600,
                        ),
                      ],
                    ),
                    const SizedBox(height: 20.0),
                    Container(
                      width: size.width,
                      height: 200.0,
                      decoration: BoxDecoration(
                          borderRadius:
                              BorderRadius.circular(AppDimensions.borderRadius),
                          image: const DecorationImage(
                              image: NetworkImage(
                                  'https://images.pexels.com/photos/6829538/pexels-photo-6829538.jpeg?auto=compress&cs=tinysrgb&w=1260&h=750&dpr=1'),
                              fit: BoxFit.cover)),
                    ),
                  ],
                ),
              ),
              const SizedBox(height: 24.0),
              Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 16.0),
                  child: HtmlWidget(htmlContent)),
              const SizedBox(height: 24.0),
              Container(
                width: size.width,
                padding: const EdgeInsets.symmetric(horizontal: 16.0),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Row(
                      children: [
                        Container(
                          width: 80.0,
                          height: 110.0,
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(
                                AppDimensions.borderRadius),
                            color: Colors.grey.shade200,
                          ),
                        ),
                        const SizedBox(width: 10.0),
                        Expanded(
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Row(
                                children: [
                                  Text(
                                    'Seth Godin',
                                    style: Theme.of(context)
                                        .textTheme
                                        .bodyLarge
                                        ?.copyWith(fontWeight: FontWeight.w700),
                                  ),
                                  const SizedBox(width: 8.0),
                                  Tooltip(
                                    message: 'Digital KSP Verified',
                                    padding: const EdgeInsets.symmetric(
                                        horizontal: 8.0),
                                    margin: EdgeInsets.zero,
                                    child: Icon(Icons.check_circle_rounded,
                                        color: Theme.of(context).primaryColor,
                                        size: 14.0),
                                  ),
                                ],
                              ),
                              const SizedBox(height: 4.0),
                              Text(
                                'Try to enlighten the core knowledge with everyone. The vision is right information in right time time to all categories of people.',
                                maxLines: 2,
                                overflow: TextOverflow.ellipsis,
                                style: Theme.of(context)
                                    .textTheme
                                    .bodySmall
                                    ?.copyWith(color: Colors.grey),
                              ),
                              const SizedBox(height: 14.0),
                              SizedBox(
                                width: size.width,
                                child: Wrap(
                                  runSpacing: 8.0,
                                  spacing: 8.0,
                                  alignment: WrapAlignment.start,
                                  children: List.generate(
                                    _socialMedia.length,
                                    (index) => CircleAvatar(
                                      radius: 16.0,
                                      backgroundColor: Colors.grey.shade200,
                                      child: SvgPicture.asset(
                                        _socialMedia[index].icon,
                                        width: 16.0,
                                      ),
                                    ),
                                  ),
                                ),
                              ),
                            ],
                          ),
                        ),
                      ],
                    ),
                  ],
                ),
              ),
              const SizedBox(height: 24.0),
              Container(
                width: size.width,
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 16.0),
                      child: Text('Recent Posts',
                          style: Theme.of(context)
                              .textTheme
                              .titleMedium
                              ?.copyWith(fontWeight: FontWeight.w700)),
                    ),
                    const SizedBox(height: 10.0),
                    SizedBox(
                      height: 186.0,
                      child: ListView.builder(
                        itemCount: 10,
                        shrinkWrap: true,
                        padding: const EdgeInsets.symmetric(horizontal: 16.0),
                        scrollDirection: Axis.horizontal,
                        clipBehavior: Clip.antiAliasWithSaveLayer,
                        itemBuilder: (context, index) {
                          return Container(
                            width: size.width * 0.5,
                            margin: EdgeInsets.only(
                                right: index == 10 - 1 ? 0.0 : 10.0),
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Container(
                                  height: 100.0,
                                  alignment: Alignment.bottomLeft,
                                  padding: const EdgeInsets.all(6.0),
                                  decoration: BoxDecoration(
                                    borderRadius: BorderRadius.circular(
                                        AppDimensions.borderRadius),
                                    color: Colors.grey.shade200,
                                  ),
                                  child: Container(
                                    padding: const EdgeInsets.symmetric(
                                        vertical: 4.0, horizontal: 10.0),
                                    decoration: BoxDecoration(
                                      borderRadius: BorderRadius.circular(
                                          AppDimensions.borderRadius),
                                      color: Colors.white,
                                    ),
                                    child: Text('Heath',
                                        maxLines: 1,
                                        overflow: TextOverflow.ellipsis,
                                        style: Theme.of(context)
                                            .textTheme
                                            .bodySmall
                                            ?.copyWith(
                                                fontWeight: FontWeight.w500)),
                                  ),
                                ),
                                const SizedBox(height: 14.0),
                                Text('Like Screenshots. Tap Caption For Gists.',
                                    maxLines: 2,
                                    overflow: TextOverflow.ellipsis,
                                    style: Theme.of(context)
                                        .textTheme
                                        .titleSmall
                                        ?.copyWith(
                                            fontWeight: FontWeight.w500)),
                                const SizedBox(height: 8.0),
                                Text('Umakanta Swain',
                                    maxLines: 1,
                                    overflow: TextOverflow.ellipsis,
                                    style: Theme.of(context)
                                        .textTheme
                                        .bodySmall
                                        ?.copyWith(color: Colors.grey)),
                              ],
                            ),
                          );
                        },
                      ),
                    ),
                  ],
                ),
              ),
              const SizedBox(height: 20.0),
            ],
          ),
        ),
      ),
    );
  }
}
