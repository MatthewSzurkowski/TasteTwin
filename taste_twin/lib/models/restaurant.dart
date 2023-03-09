class Restaurant {
  final String name;
  final int
      location; //TODO: add proper location and use that value to find distance from user (this is temporary)
  final String type;
  final Map<String, String> menu;
  final String description;
  final String
      pictureURL; // link to a sample picture for the restaurant that can be displayed in the match card
  final String price; // estimated on a 5 point scale

  Restaurant(this.name, this.location, this.type, this.menu, this.description,
      this.pictureURL, this.price);
}

final List<Restaurant> tempRestaurantList = [
  Restaurant(
    "The WORKS",
    10,
    "Hamburger",
    {
      "Big Burger": "It is a pretty large burger - \$18",
      "Best Burger": "This is our best burger - \$22",
    },
    "Burger place serving craft beer & burgers.",
    "https://images.unsplash.com/photo-1568901346375-23c9450c58cd?ixlib=rb-4.0.3&ixid=MnwxMjA3fDB8MHxzZWFyY2h8Mnx8YnVyZ2VyfGVufDB8fDB8fA%3D%3D&w=1000&q=80",
    "\$\$\$",
  ),
  Restaurant(
    "Fairly Italian",
    24,
    "Italian",
    {
      "Perfect Pasta": "This is good, you should eat it - \$15",
      "Passable Pasta": "This is more of a risk, but economical - \$8",
      "Pretentious Pasta": "Wow, we are impressed you ordered it - \$36",
    },
    "Local restauarant specializing in mid-tier Italian cuisine.",
    "https://assets.bonappetit.com/photos/5b9a901947aaaf7cd9ea90f2/1:1/w_2240,c_limit/ba-recipe-pasta-al-limone.jpg",
    "\$\$",
  ),
  Restaurant(
    "Blanc Menu",
    12,
    "French",
    {},
    "Hip and upscale restauarant specializing in French cuisine.",
    "https://media.istockphoto.com/id/157421404/photo/french-baguettes-and-wine.jpg?s=612x612&w=0&k=20&c=Dct0A4GFRloResX5hZUGKvK-DX1Pzik1mm6AIlgjse0=",
    "\$\$\$\$\$",
  ),
  Restaurant(
    "Terrific Tacos",
    18,
    "Mexican",
    {
      "Two Tacos": "Two of our finest tacos - \$6",
      "Twenty Tacos": "Twenty of our finest tacos - \$10",
      "Twenty-Two Tacos": "Twenty-two of our finest tacos - \$22",
    },
    "The absolute best Tacos in town!",
    "https://media.discordapp.net/attachments/1018880809140228277/1044723085359722567/RenderedImage.jpeg?width=1051&height=1402",
    "\$",
  ),
  Restaurant(
    "Steak & Shake",
    19,
    "American",
    {
      "Steak": " - \$4",
      "Milkshake": " - \$44",
    },
    "We serve perfectly cooked steak alongside our world renowned milkshakes.",
    "https://4sonrus.com/wp-content/uploads/2018/11/Set-5-Vertical-Milkshake-Candy--683x1024.jpg",
    "\$\$\$",
  ),
  Restaurant(
    "The WORKS",
    10,
    "Hamburger",
    {
      "Big Burger": "It is a pretty large burger - \$18",
      "Best Burger": "This is our best burger - \$22",
    },
    "Burger place serving craft beer & burgers.",
    "https://unsplash.com/photos/poI7DelFiVA",
    "\$\$\$",
  ),
  Restaurant(
    "Fairly Italian",
    24,
    "Italian",
    {
      "Perfect Pasta": "This is good, you should eat it - \$15",
      "Passable Pasta": "This is more of a risk, but economical - \$8",
      "Pretentious Pasta": "Wow, we are impressed you ordered it - \$36",
    },
    "Local restauarant specializing in mid-tier Italian cuisine.",
    "https://unsplash.com/photos/N_Y88TWmGwA",
    "\$\$",
  ),
  Restaurant(
    "Blanc Menu",
    12,
    "French",
    {},
    "Hip and upscale restauarant specializing in French cuisine.",
    "https://unsplash.com/photos/nmpW_WwwVSc",
    "\$\$\$\$\$",
  ),
  Restaurant(
    "Terrific Tacos",
    18,
    "Mexican",
    {
      "Two Tacos": "Two of our finest tacos - \$6",
      "Twenty Tacos": "Twenty of our finest tacos - \$10",
      "Twenty-Two Tacos": "Twenty-two of our finest tacos - \$22",
    },
    "The absolute best Tacos in town!",
    "https://unsplash.com/photos/oCsaxvGCehM",
    "\$",
  ),
  Restaurant(
    "Steak & Shake",
    19,
    "American",
    {
      "Steak": " - \$4",
      "Milkshake": " - \$44",
    },
    "We serve perfectly cooked steak alongside our world renowned milkshakes.",
    "https://unsplash.com/photos/Ciqxn7FE4vE",
    "\$\$\$",
  ),
];
