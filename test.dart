ListTile(
          title: Text("elon"),
          leading: CircleAvatar(
            radius: 33,
            backgroundImage: NetworkImage("https://dvyvvujm9h0uq.cloudfront.net/com/articles/1515135672-shutterstock_284581649.jpg")),
        ),
    )




    widget.data["postId"]
    userData!.profileImg
    userData.username
    commentController.text
    userData.uid




    Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Row(
                children: [
                  Container(
                    margin: EdgeInsets.only(right: 12),
                    padding: const EdgeInsets.all(3),
                    decoration: const BoxDecoration(
                        shape: BoxShape.circle,
                        color: Color.fromARGB(125, 78, 91, 110)),
                    child: CircleAvatar(
                      backgroundImage: NetworkImage(
                          "https://childdevelopment.com.au/wp-content/uploads/what-is-child-development.jpg"),
                      radius: 26,
                    ),
                  ),
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Row(
                        children: [
                          Text(
                            "USERNAME",
                            style: const TextStyle(
                                fontWeight: FontWeight.bold, fontSize: 17),
                          ),
                          SizedBox(
                            width: 11,
                          ),
                          Text(
                            "nice pic",
                            style: TextStyle(fontSize: 16),
                          )
                        ],
                      ),
                      SizedBox(
                        height: 8,
                      ),
                      Text(
                        "12/12/2012",
                        style: TextStyle(
                            fontSize: 12, fontWeight: FontWeight.w400),
                      )
                    ],
                  ),
                ],
              ),
              IconButton(onPressed: () {}, icon: Icon(Icons.favorite))
            ],
          ),