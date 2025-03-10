import 'package:project_bc_tuto/features/Applications/screens/chat2/models/user_model.dart';
import 'package:project_bc_tuto/utils/constants/image_strings.dart';

class Messages {
  final User sender;
  final String time;
  final String text;
  final bool isLiked;
  final bool unread;


  Messages({
    required this.sender,
    required this.time,
    required this.text,
    required this.isLiked,
    required this.unread,
  });
}

final User currentUser = User(
  id: 0,
  name: 'Franck',
  imageUrl: JImages.google,
);

final User rin = User(
  id: 1,
  name: 'Rin',
  imageUrl: JImages.user3,
);

final User ben = User(
  id: 2,
  name: 'Ben',
  imageUrl: JImages.user2,
);

final User biggie = User(
  id: 3,
  name: 'Biggie',
  imageUrl: JImages.user1,
);

final User ferrey = User(
  id: 4,
  name: 'Ferrey',
  imageUrl: JImages.nvidia,
);

final User festy = User(
  id: 5,
  name: 'Festy',
  imageUrl: JImages.user2,
);


List<User> favorite = [ferrey, ben, festy, biggie, rin];

List<Messages> chats = [

  Messages(
      sender: ben,
      time: '7:08 PM',
      text: "Hy boy how are you",
      isLiked: true,
      unread: true
  ),

  Messages(
      sender: festy,
      time: '7:08 PM',
      text: "Hy boy how are you",
      isLiked: true,
      unread: true
  ),

  Messages(sender: ben,
      time: '7:08 PM',
      text: "yo boy",
      isLiked: true,
      unread: true
  ),

  Messages(sender: ferrey,
      time: '7:08 PM',
      text: "Hy boy how are you",
      isLiked: false,
      unread: false
  ),

  Messages(sender: currentUser,
      time: '7:08 PM',
      text: "Hy boy how are you",
      isLiked: true,
      unread: false
  ),
  Messages(sender: currentUser,
      time: '7:08 PM',
      text: "Hy boy how are you",
      isLiked: true,
      unread: false
  ),
];