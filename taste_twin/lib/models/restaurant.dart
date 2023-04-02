import 'dart:ffi';

class Restaurant {
  final String name;
  final double
      location; //TODO: add proper location and use that value to find distance from user (this is temporary)
  final String type;
  final bool isFastFood;
  final Map<String, String> menu;
  final String description;
  final String
      pictureURL; // link to a sample picture for the restaurant that can be displayed in the match card
  final String price; // estimated on a 5 point scale
  final List<String> tags;

  Restaurant(this.name, this.location, this.type, this.isFastFood, this.menu,
      this.description, this.pictureURL, this.price, this.tags);
}

final List<Restaurant> tempRestaurantList = [
  Restaurant(
      "The WORKS",
      1.14,
      "Hamburger",
      false,
      {
        "Big Burger": "It is a pretty large burger - \$18",
        "Best Burger": "This is our best burger - \$22",
      },
      "Burger place serving craft beer & burgers.",
      "https://images.unsplash.com/photo-1568901346375-23c9450c58cd?ixlib=rb-4.0.3&ixid=MnwxMjA3fDB8MHxzZWFyY2h8Mnx8YnVyZ2VyfGVufDB8fDB8fA%3D%3D&w=1000&q=80",
      "\$\$\$",
      ['American']),
  Restaurant(
      "Fairly Italian",
      10.9,
      "Italian",
      false,
      {
        "Perfect Pasta": "This is good, you should eat it - \$15",
        "Passable Pasta": "This is more of a risk, but economical - \$8",
        "Pretentious Pasta": "Wow, we are impressed you ordered it - \$36",
      },
      "Local restauarant specializing in mid-tier Italian cuisine.",
      "https://assets.bonappetit.com/photos/5b9a901947aaaf7cd9ea90f2/1:1/w_2240,c_limit/ba-recipe-pasta-al-limone.jpg",
      "\$\$",
      ['Italian', 'French']),
  Restaurant(
      "Blanc Menu",
      6.90,
      "French",
      false,
      {},
      "Hip and upscale restauarant specializing in French cuisine.",
      "https://media.istockphoto.com/id/157421404/photo/french-baguettes-and-wine.jpg?s=612x612&w=0&k=20&c=Dct0A4GFRloResX5hZUGKvK-DX1Pzik1mm6AIlgjse0=",
      "\$\$\$\$\$",
      ['French', 'Italian']),
  Restaurant(
    "Terrific Tacos",
    9.0,
    "Mexican",
    true,
    {
      "Two Tacos": "Two of our finest tacos - \$6",
      "Twenty Tacos": "Twenty of our finest tacos - \$10",
      "Twenty-Two Tacos": "Twenty-two of our finest tacos - \$22",
    },
    "The absolute best Tacos in town!",
    "https://media.discordapp.net/attachments/1018880809140228277/1044723085359722567/RenderedImage.jpeg?width=1051&height=1402",
    "\$",
    ['Mexican', 'American'],
  ),
  Restaurant(
    "Steak & Shake",
    5.5,
    "American",
    true,
    {
      "Steak": " - \$4",
      "Milkshake": " - \$44",
    },
    "We serve perfectly cooked steak alongside our world renowned milkshakes.",
    "https://4sonrus.com/wp-content/uploads/2018/11/Set-5-Vertical-Milkshake-Candy--683x1024.jpg",
    "\$\$\$",
    ['American', 'Fast Food'],
  ),
];
