import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import 'package:event_manager/core/colors.dart';
import 'package:event_manager/event_details/models/user_model.dart';

import '../../event_details/view_models/event_view_model.dart';

class ProfileWidget extends StatefulWidget {
  const ProfileWidget({
    super.key,
    required this.userModel,
    required this.createrID,
    required this.isFollowed,
  });
  final UserModel userModel;
  final String createrID;
  final bool isFollowed;

  @override
  State<ProfileWidget> createState() => _ProfileWidgetState();
}

class _ProfileWidgetState extends State<ProfileWidget> {
  final FirebaseAuth auth = FirebaseAuth.instance;
  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.only(left: 20, right: 20, top: 10, bottom: 10),
      padding: const EdgeInsets.all(20),
      decoration: BoxDecoration(
          color: AppColor.secondaryColor(context),
          borderRadius: BorderRadius.circular(15)),
      child: Row(
        // mainAxisAlignment: MainAxisAlignment.spaceAround,
        children: [
          CircleAvatar(
            radius: 30,
            backgroundImage:
                NetworkImage(widget.userModel.profilePhoto),
          ),
          const SizedBox(width: 10),
          Column(
            mainAxisAlignment: MainAxisAlignment.start,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                widget.userModel.name,
                style:
                    const TextStyle(fontWeight: FontWeight.w700, fontSize: 19),
              ),
              Text(
                  "Followers ${widget.userModel.followers.length.toString()}"),
            ],
          ),
          const Expanded(child: SizedBox()),
          if (auth.currentUser != null && widget.userModel.uid != auth.currentUser!.uid)
          MaterialButton(
              shape:
                  OutlineInputBorder(borderRadius: BorderRadius.circular(10)),
              onPressed: () {
                if (widget.isFollowed) {
                  context.read<EventViewModel>().unfollow(widget.createrID);
                  return;
                }
                context.read<EventViewModel>().follow(widget.createrID);
              },
              color: widget.isFollowed
                  ? AppColor.tertiaryColor(context)
                  : AppColor.primaryColor,
              padding: const EdgeInsets.all(20),
              child: Text(widget.isFollowed ? "Unfollow" : "Follow"),
            )
        ],
      ),
    );
  }
}
