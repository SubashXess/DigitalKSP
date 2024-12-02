import 'package:flutter/material.dart';

class AboutUsPage extends StatelessWidget {
  const AboutUsPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('About us')),
      body: SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Container(
              width: double.infinity,
              height: 240.0,
              decoration: const BoxDecoration(
                image: DecorationImage(
                    image: AssetImage('assets/images/about-us-banner.jpg'),
                    fit: BoxFit.cover),
              ),
            ),
            Padding(
              padding: const EdgeInsets.all(16.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text('Let\'s know us better',
                      style: Theme.of(context)
                          .textTheme
                          .headlineMedium
                          ?.copyWith(fontWeight: FontWeight.w500)),
                  const SizedBox(height: 10.0),
                  Text(
                      'Welcome to DigitalKSP, your go-to platform for sharing and discovering valuable insights, stories, and ideas from across the digital world. Founded in 2022, DigitalKSP was built to provide a community space where passionate bloggers, writers, and professionals can showcase their knowledge and experiences.',
                      style: Theme.of(context)
                          .textTheme
                          .bodyMedium
                          ?.copyWith(color: Colors.black54)),
                  const SizedBox(height: 20.0),
                  Text(
                      'At DigitalKSP, we believe in the power of expression. Whether you’re an expert in your field or a curious learner with a fresh perspective, our platform is designed to let you share your thoughts and expertise with a global audience. Register, create your blog posts, and once approved by our dedicated admin team, your voice will be shared with the world!',
                      style: Theme.of(context)
                          .textTheme
                          .bodyMedium
                          ?.copyWith(color: Colors.black54)),
                  const SizedBox(height: 40.0),
                  Text('Why DigitalKSP?',
                      style: Theme.of(context)
                          .textTheme
                          .headlineMedium
                          ?.copyWith(fontWeight: FontWeight.w500)),
                  const SizedBox(height: 10.0),
                  Text(
                      'A welcoming community for both new and experienced bloggers. A space for diverse topics ranging from tech and business to lifestyle and personal stories. A simple and user-friendly platform to submit your posts and reach a wider audience. Let your ideas thrive with DigitalKSP. Register today and start sharing!',
                      style: Theme.of(context)
                          .textTheme
                          .bodyMedium
                          ?.copyWith(color: Colors.black54)),
                  const SizedBox(height: 20.0),
                  Text('Contact us: info@digitalksp.com',
                      style: Theme.of(context)
                          .textTheme
                          .bodyMedium
                          ?.copyWith(color: Colors.black54)),
                  const SizedBox(height: 6.0),
                  Text('Website us: www.digitalksp.com',
                      style: Theme.of(context)
                          .textTheme
                          .bodyMedium
                          ?.copyWith(color: Colors.black54)),
                ],
              ),
            )
          ],
        ),
      ),
    );
  }
}
