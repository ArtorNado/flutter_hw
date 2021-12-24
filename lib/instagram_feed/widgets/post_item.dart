import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter_hw/instagram_feed/storage/post.dart';
import 'package:flutter_svg/svg.dart';
import 'package:line_icons/line_icons.dart';

import '../theme/colors.dart';

class PostItem extends StatelessWidget {
  final Post post;

  const PostItem({
    required this.post
  });

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 8),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: <Widget>[
          Padding(
            padding: const EdgeInsets.symmetric(vertical: 16, horizontal: 16),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: <Widget>[
                Row(
                  children: <Widget>[
                    Container(
                      width: 32,
                      height: 32,
                      decoration: const BoxDecoration(
                          shape: BoxShape.circle,
                          image: DecorationImage(
                              image: AssetImage("assets/images/profile_img.jpeg"),
                              fit: BoxFit.cover)),
                    ),
                    const SizedBox(width: 8),
                    Text(
                      post.user.name,
                      style: const TextStyle(
                          color: white,
                          fontSize: 14,
                          fontWeight: FontWeight.w700),
                    )
                  ],
                ),
                const Icon(LineIcons.horizontalEllipsis, color: white)
              ],
            ),
          ),
          Container(
            height: 400,
            decoration: BoxDecoration(
                image: DecorationImage(
                    image: FileImage(File(post.postImg)), fit: BoxFit.cover)),
          ),
          Padding(
            padding: const EdgeInsets.only(left: 16, top: 12, right: 16),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: <Widget>[
                Row(
                  children: <Widget>[
                    post.isLoved
                        ? SvgPicture.asset("assets/images/loved_icon.svg",
                            width: 20)
                        : SvgPicture.asset("assets/images/love_icon.svg",
                            width: 20),
                    const SizedBox(width: 16),
                    SvgPicture.asset("assets/images/comment_icon.svg",
                        width: 20),
                    const SizedBox(width: 16),
                    SvgPicture.asset("assets/images/message_icon.svg",
                        width: 20),
                  ],
                ),
                SvgPicture.asset("assets/images/save_icon.svg", width: 20),
              ],
            ),
          ),
          Padding(
            padding: const EdgeInsets.only(top: 12, left: 16, right: 16),
            child: RichText(
                text: TextSpan(children: [
              const TextSpan(
                  text: "Liked by ",
                  style: TextStyle(fontSize: 14, fontWeight: FontWeight.w400)),
              TextSpan(
                  text: "${post.likedBy} ",
                  style: const TextStyle(
                      fontSize: 14, fontWeight: FontWeight.w700)),
              const TextSpan(
                  text: "and ",
                  style: TextStyle(fontSize: 14, fontWeight: FontWeight.w400)),
              const TextSpan(
                  text: "Other",
                  style: TextStyle(fontSize: 14, fontWeight: FontWeight.w700)),
            ])),
          ),
          Padding(
              padding: const EdgeInsets.only(left: 16, top: 12, right: 16),
              child: RichText(
                  text: TextSpan(children: [
                TextSpan(
                    text: "${post.user.name} ",
                    style: const TextStyle(
                        fontSize: 14, fontWeight: FontWeight.w700)),
                TextSpan(
                    text: post.caption,
                    style: const TextStyle(
                        fontSize: 14, fontWeight: FontWeight.w400)),
              ]))),
          Padding(
            padding: const EdgeInsets.only(left: 16, top: 12, right: 16),
            child: Text(
              "View ${post.viewCount} comments",
              style: TextStyle(
                  color: white.withOpacity(0.5),
                  fontSize: 12,
                  fontWeight: FontWeight.w500),
            ),
          ),
          Padding(
              padding: const EdgeInsets.only(left: 16, top: 12, right: 16),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: <Widget>[
                  Row(
                    children: <Widget>[
                      Container(
                        width: 24,
                        height: 24,
                        decoration: BoxDecoration(
                            shape: BoxShape.circle,
                            image: DecorationImage(
                                image: AssetImage(post.user.profileImg),
                                fit: BoxFit.cover)),
                      ),
                      const SizedBox(
                        width: 8,
                      ),
                      Text(
                        "Add a comment...",
                        style: TextStyle(
                            color: white.withOpacity(0.5),
                            fontSize: 14,
                            fontWeight: FontWeight.w400),
                      ),
                    ],
                  ),
                  Row(
                    children: <Widget>[
                      const Text(
                        "😂",
                        style: TextStyle(fontSize: 14),
                      ),
                      const SizedBox(width: 8),
                      const Text(
                        "😍",
                        style: TextStyle(fontSize: 14),
                      ),
                      const SizedBox(width: 8),
                      Icon(Icons.add_circle,
                          color: white.withOpacity(0.5), size: 18)
                    ],
                  )
                ],
              )),
          Padding(
            padding: const EdgeInsets.only(left: 16, top: 12, right: 16),
            child: Text(
              "${post.dayAgo} day ago",
              style: TextStyle(
                  color: white.withOpacity(0.5),
                  fontSize: 14,
                  fontWeight: FontWeight.w400),
            ),
          )
        ],
      ),
    );
  }
}
