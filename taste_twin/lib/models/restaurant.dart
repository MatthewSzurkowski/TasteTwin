class Restaurant {
  late final String name;
  final double
      location; //Location is set to distanceGuelph which is stored in the database
  final String type;
  final Map<String, String>? menu;
  final String? description;
  final String
      pictureURL; // link to a sample picture for the restaurant that can be displayed in the match card
  final String price; // estimated on a 5 point scale
  final bool isFastFood;

  Restaurant({
    required this.name,
    required this.location,
    required this.type,
    required this.menu,
    required this.description,
    required this.pictureURL,
    required this.price,
    required this.isFastFood,
  });

  factory Restaurant.fromJson(Map<String, dynamic> json) {
    return Restaurant(
      name: json['name'],
      location: json['distanceGuelph'],
      type: json['type'],
      menu: null, // Map<String, String>.from(json['menu']),
      description: json['description'],
      pictureURL: json['photo_url'],
      price: json['price_level'].toString(),
      isFastFood: json['isFastFood'],
    );
  }

  Map<String, dynamic> toJSON() => {
        'name': name,
        'description': description,
        'location': location,
        'isFastFood': isFastFood,
        'photoURL': pictureURL,
        'price_level': price,
        'type': type,
        'distanceGuelph': location,
      };
}

final List<Restaurant> tempRestaurantList = [
  Restaurant(
    name: "The WORKS",
    location: 10,
    type: "Hamburger",
    menu: {
      "Big Burger": "It is a pretty large burger - \$18",
      "Best Burger": "This is our best burger - \$22",
    },
    description: "Burger place serving craft beer & burgers.",
    pictureURL:
        "https://images.unsplash.com/photo-1568901346375-23c9450c58cd?ixlib=rb-4.0.3&ixid=MnwxMjA3fDB8MHxzZWFyY2h8Mnx8YnVyZ2VyfGVufDB8fDB8fA%3D%3D&w=1000&q=80",
    price: "\$\$\$",
    isFastFood: false,
  ),
  Restaurant(
    name: "Fairly Italian",
    location: 24,
    type: "Italian",
    menu: {
      "Perfect Pasta": "This is good, you should eat it - \$15",
      "Passable Pasta": "This is more of a risk, but economical - \$8",
      "Pretentious Pasta": "Wow, we are impressed you ordered it - \$36",
    },
    description: "Local restauarant specializing in mid-tier Italian cuisine.",
    pictureURL:
        "https://assets.bonappetit.com/photos/5b9a901947aaaf7cd9ea90f2/1:1/w_2240,c_limit/ba-recipe-pasta-al-limone.jpg",
    price: "\$\$",
    isFastFood: false,
  ),
  Restaurant(
    name: "Blanc Menu",
    location: 12,
    type: "French",
    menu: {},
    description: "Hip and upscale restauarant specializing in French cuisine.",
    pictureURL:
        "https://media.istockphoto.com/id/157421404/photo/french-baguettes-and-wine.jpg?s=612x612&w=0&k=20&c=Dct0A4GFRloResX5hZUGKvK-DX1Pzik1mm6AIlgjse0=",
    price: "\$\$\$\$\$",
    isFastFood: false,
  ),
  Restaurant(
    name: "Terrific Tacos",
    location: 18,
    type: "Mexican",
    menu: {
      "Two Tacos": "Two of our finest tacos - \$6",
      "Twenty Tacos": "Twenty of our finest tacos - \$10",
      "Twenty-Two Tacos": "Twenty-two of our finest tacos - \$22",
    },
    description: "The absolute best Tacos in town!",
    pictureURL:
        "https://media.discordapp.net/attachments/1018880809140228277/1044723085359722567/RenderedImage.jpeg?width=1051&height=1402",
    price: "\$",
    isFastFood: false,
  ),
  Restaurant(
    name: "Steak & Shake",
    location: 19,
    type: "American",
    menu: {
      "Steak": " - \$4",
      "Milkshake": " - \$44",
    },
    description:
        "We serve perfectly cooked steak alongside our world renowned milkshakes.",
    pictureURL:
        "https://4sonrus.com/wp-content/uploads/2018/11/Set-5-Vertical-Milkshake-Candy--683x1024.jpg",
    price: "\$\$\$",
    isFastFood: false,
  ),
  Restaurant(
    name: "The WORKS",
    location: 10,
    type: "Hamburger",
    menu: {
      "Big Burger": "It is a pretty large burger - \$18",
      "Best Burger": "This is our best burger - \$22",
    },
    description: "Burger place serving craft beer & burgers.",
    pictureURL:
        "https://media.discordapp.net/attachments/1064228781469999114/1080679126760951859/image.png?width=1078&height=1204",
    price: "\$\$\$",
    isFastFood: false,
  ),
  Restaurant(
    name: "Fairly Italian",
    location: 24,
    type: "Italian",
    menu: {
      "Perfect Pasta": "This is good, you should eat it - \$15",
      "Passable Pasta": "This is more of a risk, but economical - \$8",
      "Pretentious Pasta": "Wow, we are impressed you ordered it - \$36",
    },
    description: "Local restauarant specializing in mid-tier Italian cuisine.",
    pictureURL:
        "https://media.discordapp.net/attachments/1064228781469999114/1083237084812279888/maxresdefault.png?width=2232&height=1256",
    price: "\$\$",
    isFastFood: false,
  ),
  Restaurant(
    name: "Blanc Menu",
    location: 12,
    type: "French",
    menu: {},
    description: "Hip and upscale restauarant specializing in French cuisine.",
    pictureURL: "https://unsplash.com/photos/nmpW_WwwVSc",
    price: "\$\$\$\$\$",
    isFastFood: false,
  ),
  Restaurant(
    name: "Terrific Tacos",
    location: 18,
    type: "Mexican",
    menu: {
      "Two Tacos": "Two of our finest tacos - \$6",
      "Twenty Tacos": "Twenty of our finest tacos - \$10",
      "Twenty-Two Tacos": "Twenty-two of our finest tacos - \$22",
    },
    description: "The absolute best Tacos in town!",
    pictureURL: "https://unsplash.com/photos/oCsaxvGCehM",
    price: "\$",
    isFastFood: false,
  ),
  Restaurant(
    name: "Steak & Shake",
    location: 19,
    type: "American",
    menu: {
      "Steak": " - \$4",
      "Milkshake": " - \$44",
    },
    description:
        "We serve perfectly cooked steak alongside our world renowned milkshakes.",
    pictureURL: "https://unsplash.com/photos/Ciqxn7FE4vE",
    price: "\$\$\$",
    isFastFood: false,
  ),
];
