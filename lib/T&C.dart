import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:google_fonts/google_fonts.dart';
class Termsofuse extends StatefulWidget {
  const Termsofuse({Key? key}) : super(key: key);

  @override
  State<Termsofuse> createState() => _TermsofuseState();
}

class _TermsofuseState extends State<Termsofuse> {
  bool isDark=false;
  final FirebaseAuth _auth = FirebaseAuth.instance;
  final FirebaseFirestore _firestore = FirebaseFirestore.instance;
  String terms='';
  @override
  void initState() {
    // TODO: implement initState
    super.initState();

  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: isDark?Colors.white:Colors.black,
      appBar: AppBar(
        backgroundColor: Colors.black,
        centerTitle: true,
        actions: [
          IconButton(onPressed: (){
            setState(() {
              isDark=!isDark;
            });
          },
              icon: Icon(isDark?Icons.sunny:Icons.nights_stay_rounded,
                color: Colors.white,))
        ],
        title: Text(
          'NetFly',
          style: GoogleFonts.amaranth(
            color: Colors.red,
            fontWeight: FontWeight.bold,
            fontSize: 20,
          ),
        ),
      ),
      body: Container(
        child: SingleChildScrollView(
          child: Column(
            children: [
              SizedBox(
                height: 30,
              ),
              Center(
                child: Text('Terms Of Use',style: TextStyle(fontSize: 20,
                    fontWeight: FontWeight.bold,
                    color: isDark?Colors.black:Colors.white),),
              ),
              SizedBox(
                height: 20,
              ),
              Text('''NetFly provides a personalized subscription service that allows our members to access entertainment content (“NetFly content”) over the Internet on certain Internet-connected TVs, computers and other devices ("NetFly ready devices").

These Terms of Use govern your use of our service. As used in these Terms of Use, "NetFly service", "our service" or "the service" means the personalized service provided by NetFly for discovering and accessing NetFly content, including all features and functionalities, recommendations and reviews, our websites, and user interfaces, as well as all content and software associated with our service. References to ‘you’ in these Terms of Use indicate the member who created the NetFly account and whose payment method is charged.

Membership

1.1. Your NetFly membership will continue until terminated. To use the NetFly service you must have Internet access and a NetFly ready device, and provide us with one or more Payment Methods. “Payment Method” means a current, valid, accepted method of payment, as may be updated from time to time, and which may include payment through your account with a third party. Unless you cancel your membership before your billing date, you authorize us to charge the membership fee for the next billing cycle to your Payment Method (see "Cancellation" below).

1.2. We may offer a number of membership plans, including memberships offered by third parties in conjunction with the provision of their own products and services. We are not responsible for the products and services provided by such third parties. Some membership plans may have differing conditions and limitations, which will be disclosed at your sign-up or in other communications made available to you. You can find specific details regarding your NetFly membership by visiting the NetFly.com website and clicking on the "Account" link available at the top of the pages under your profile name.
Promotional Offers. We may from time to time offer special promotional offers, plans or memberships (“Offers”). Offer eligibility is determined by NetFly at its sole discretion and we reserve the right to revoke an Offer and put your account on hold in the event that we determine you are not eligible. Members of households with an existing or recent NetFly membership may not be eligible for certain introductory Offers. We may use information such as device ID, method of payment or an account email address used with an existing or recent NetFly membership to determine Offer eligibility. The eligibility requirements and other limitations and conditions will be disclosed when you sign-up for the Offer or in other communications made available to you.
Billing and Cancellation

3.1. Billing Cycle. The membership fee for the NetFly service and any other charges you may incur in connection with your use of the service, such as taxes and possible transaction fees, will be charged to your Payment Method on the specific payment date indicated on the "Account" page. The length of your billing cycle will depend on the type of subscription that you choose when you signed up for the service. In some cases your payment date may change, for example if your Payment Method has not successfully settled, when you change your subscription plan or if your paid membership began on a day not contained in a given month. Visit the NetFly.com website and click on the "Billing details" link on the "Account" page to see your next payment date. We may authorize your Payment Method in anticipation of membership or service-related charges through various methods, including authorizing it for up to approximately one month of service as soon as you register. If you signed up for NetFly using your account with a third party as a Payment Method, you can find the billing information about your NetFly membership by visiting your account with the applicable third party.

3.2. Payment Methods. To use the NetFly service you must provide one or more Payment Methods. You authorize us to charge any Payment Method associated to your account in case your primary Payment Method is declined or no longer available to us for payment of your subscription fee. You remain responsible for any uncollected amounts. If a payment is not successfully settled, due to expiration, insufficient funds, or otherwise, and you do not cancel your account, we may suspend your access to the service until we have successfully charged a valid Payment Method. For some Payment Methods, the issuer may charge you certain fees, such as foreign transaction fees or other fees relating to the processing of your Payment Method. Local tax charges may vary depending on the Payment Method used. Check with your Payment Method service provider for details.

3.3. Updating your Payment Methods. You can update your Payment Methods by going to the "Account" page. We may also update your Payment Methods using information provided by the payment service providers. Following any update, you authorize us to continue to charge the applicable Payment Method(s).

3.4. Cancellation. You can cancel your NetFly membership at any time, and you will continue to have access to the NetFly service through the end of your billing period. To the extent permitted by the applicable law, payments are non-refundable and we do not provide refunds or credits for any partial membership periods or unused NetFly content. To cancel, go to the "Account" page and follow the instructions for cancellation. If you cancel your membership, your account will automatically close at the end of your current billing period. To see when your account will close, click "Billing details" on the "Account" page. If you signed up for NetFly using your account with a third party as a Payment Method and wish to cancel your NetFly membership, you may need to do so through such third party, for example by visiting your account with the applicable third party and turning off auto-renew, or unsubscribing from the NetFly service through that third party.

3.5. Changes to the Price and Subscription Plans. We may change our subscription plans and the price of our service from time to time; however, any price changes or changes to your subscription plans will apply no earlier than 30 days following notice to you.
NetFly Service

4.1. You must be at least 18 years of age  to become a member of the NetFly service. Minors may only use the service under the supervision of an adult.

4.2. The NetFly service and any content accessed through the service are for your personal and non-commercial use only and may not be shared with individuals beyond your household unless otherwise allowed by your subscription plan. During your NetFly membership we grant you a limited, non-exclusive, non-transferable right to access the NetFly service and NetFly content. Except for the foregoing, no right, title or interest shall be transferred to you. You agree not to use the service for public performances.

4.3. You may access the NetFly content primarily within the country in which you have established your account and only in geographic locations where we offer our service and have licensed such content. For the purpose of determining the taxes that will be charged over your subscription fee, we will use the IP address that is used when you sign up to the NetFly service. The content that may be available will vary by geographic location and will change from time to time. The number of devices on which you may simultaneously watch depends on your chosen subscription plan and is specified on the "Account" page.

4.4. The NetFly service, including the content library, is regularly updated. In addition, we continually test various aspects of our service, including our websites, user interfaces and promotional features. You can turn off test participation at any time by visiting the "Account" page and changing the "Test participation" settings.

4.5. Some NetFly content is available for temporary download and offline viewing on certain supported devices (“Offline Titles”). Limitations apply, including restrictions on the number of Offline Titles per account, the maximum number of devices that can contain Offline Titles, the time period within which you will need to begin viewing Offline Titles and how long the Offline Titles will remain accessible. Some Offline Titles may not be playable in certain countries and if you go online in a country where you would not be able to stream that Offline Title, the Offline Title will not be playable while you are in that country.

4.6. You agree to use the NetFly service, including all features and functionalities associated therewith, in accordance with all applicable laws, rules and regulations, or other restrictions on use of the service or content therein. Except as explicitly authorized by us, you agree not to:
(i) archive, reproduce, distribute, modify, display, perform, publish, license, create derivative works from, offer for sale, or use content and information contained on or obtained from or through the NetFly service;

(ii) circumvent, remove, alter, deactivate, degrade, block, obscure or thwart any of the content protections or other elements of the NetFly service, including the graphical user interface, copyright notices, and trademarks; 

(iii) use any robot, spider, scraper or other automated means to access the NetFly service; 

(iv) decompile, reverse engineer or disassemble any software or other products or processes accessible through the NetFly service; 

(v) insert any code or product or manipulate the content of the NetFly service in any way; 

(vi) use any data mining, data gathering or extraction method; 

(vii) upload, post, e-mail or otherwise send or transmit any material designed to interrupt, destroy or limit the functionality of any computer software or hardware or telecommunications equipment associated with the NetFly service, including any software viruses or any other computer code, files or programs. 

We may terminate or restrict your use of our service if you violate these Terms of Use or are engaged in illegal or fraudulent use of the service.

4.7. The quality of the display of the NetFly content may vary from device to device, and may be affected by a variety of factors, such as your location, the bandwidth available through and/or speed of your Internet connection. HD, Ultra HD and HDR availability is subject to your Internet service and device capabilities. Not all content is available in all formats, such as HD, Ultra HD or HDR and not all subscription plans allow you to receive content in all formats. The minimum connection speed for HD video quality (defined as a resolution of 720p or higher) is 3.0 Mbps per stream; however, we recommend a faster connection for improved video quality. A connection speed of at least 5.0 Mbps per stream is recommended to receive Full HD video quality (defined as a resolution of 1080p or higher). A connection speed of at least 15.0 Mbps per stream is recommended to receive Ultra HD video quality (defined as a resolution of 4K or higher). You are responsible for all Internet access charges. Please check with your Internet provider for information on possible Internet data usage charges. The time it takes to begin watching NetFly content will vary based on a number of factors, including your location, available bandwidth at the time, the content you have selected and the configuration of your NetFly ready device.

4.8. NetFly software is developed by, or for, NetFly and may solely be used for authorized streaming and to access NetFly content through NetFly ready devices. This software may vary by device and medium, and functionalities and features may also differ between devices. You acknowledge that the use of the service may require third party software that is subject to third party licenses. You agree that you may automatically receive updated versions of the NetFly software and related third-party software.

Passwords and Account Access. You are responsible for any activity that occurs through the NetFly account. By allowing others to access the account (which includes access to information on viewing activity for the account), you agree that such individuals are acting on your behalf and that you are bound by any changes that they may make to the account, including but not limited to changes to the subscription plan. To help maintain control over the account and to prevent any unauthorized users  from accessing the account, you should maintain control over the devices that are used to access the service and not reveal the password or details of the Payment Method associated with the account to anyone. You agree to provide and maintain accurate information relating to your account, including a valid email address so we can send you account related notices. We can terminate your account or place your account on hold in order to protect you, NetFly or our partners from identity theft or other fraudulent activity.
Warranties and Limitations on Liability. The NetFly service is provided "as is" and without warranty or condition. In particular, our service may not be uninterrupted or error-free. You waive all special, indirect and consequential damages against us. These terms will not limit any non-waivable warranties or mandatory consumer protection rights that apply to you.
Class Action Waiver. WHERE PERMITTED UNDER THE APPLICABLE LAW, YOU AND NetFly AGREE THAT EACH MAY BRING CLAIMS AGAINST THE OTHER ONLY IN YOUR OR ITS INDIVIDUAL CAPACITY, AND NOT AS A PLAINTIFF OR CLASS MEMBER IN ANY PURPORTED CLASS OR REPRESENTATIVE PROCEEDING. Further, where permitted under the applicable law, unless both you and NetFly agree otherwise, the court may not consolidate more than one person's claims with your claims, and may not otherwise preside over any form of a representative or class proceeding.
Miscellaneous

8.1. Governing Law. These Terms of Use shall be governed by and construed in accordance with the laws of India.

8.2. Unsolicited Materials. NetFly does not accept unsolicited materials or ideas for NetFly content and is not responsible for the similarity of any of its content or programming in any media to materials or ideas transmitted to NetFly.

8.3. Customer Support. To find more information about our service and its features or if you need assistance with your account, please visit the NetFly Help Center, which is accessible through the NetFly.com website. In certain instances, Customer Service may best be able to assist you by using a remote access support tool through which we have full access to your computer. If you do not want us to have this access, you should not consent to support through the remote access tool, and we will assist you through other means. In the event of any conflict between these Terms of Use and information provided by Customer Support or other portions of our websites, these Terms of Use will control.

8.4. Survival. If any provision or provisions of these Terms of Use shall be held to be invalid, illegal, or unenforceable, the validity, legality and enforceability of the remaining provisions shall remain in full force and effect.

8.5. Changes to Terms of Use and Assignment. NetFly may, from time to time, change these Terms of Use. We will notify you at least 30 days before such changes apply to you. We may assign or transfer our agreement with you including our associated rights and obligations at any time and you agree to cooperate with us in connection with such an assignment or transfer.

8.6. Electronic Communications. We will send you information relating to your account (e.g. payment authorizations, invoices, changes in password or Payment Method, confirmation messages, notices) in electronic form only, for example via emails to your email address provided during registration.
Last Updated: January 5, 2023''',style: TextStyle(color: isDark?Colors.black:Colors.white,fontWeight: FontWeight.w400),),
              SizedBox(
                height:50 ,
              ),
            ],
          ),
        ),
      ),
    );
  }
}
