import Felgo


App {
  NavigationStack {
    ListPage {
      title: "ListPage"

      onItemSelected: {
        console.log("Clicked Item #" + index + ": " + JSON.stringify(item))
      }

      model: [
        {
          text: "Apple",
          detailText: "A delicious fruit with round shape",
          iconType: IconType.apple
        },
        {
          text: "Beer",
          detailText: "A delicious drink",
          iconType: IconType.beer
        },
        {
          text: "Camera",
          detailText: "Your digital eye",
          iconType: IconType.camera
        },
        {
          text: "Gamepad",
          detailText: "Device for having fun",
          iconType: IconType.gamepad
        },
        {
          text: "Gift",
          detailText: "Something you always ready to get",
          iconType: IconType.gift
        },
        {
          text: "Music",
          detailText: "Do you mind if I put some music on?",
          iconType: IconType.music
        },
        {
          text: "Umbrella",
          detailText: "You can stand under my umbrella",
          iconType: IconType.umbrella
        }
      ]
    }
  }
}
