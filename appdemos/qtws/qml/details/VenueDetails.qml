import QtQuick

QtObject {
  readonly property string city: "Berlin"
  readonly property string name: "bcc Berlin Congress Center"
  readonly property string addressLine1: "Alexanderstraße 11"
  readonly property string addressLine2: "10178 Berlin, Germany"

  readonly property string fullName: "bcc Berlin Congress Center, Alexanderstraße 11, Berlin, Germany"
  readonly property var geo: QtObject {
    readonly property real latitude: 52.52081013304152
    readonly property real longitude: 13.416399893673203
  }

  readonly property string description: `The former Kongresshalle, now known as the bcc, attracts the eye with its transparent, clear design and many interesting architectural details. Its glistening aluminium dome can be seen from far, and the building's foyer provides visitors with an unobstructed view of the Berlin cityscape. The combination of the present-day bcc and the adjacent Haus des Lehrers forms an intense architectural ensemble on Alexanderplatz.<br/><br/>
  The bcc is right in the center of Berlin. The location's excellent public transport connections ensure an easy arrival and minimized commuting times. The following information will make your journey to and from the bcc quick and comfortable.`

  readonly property string travelByCar: 'From Berlin Brandenburg Airport (BER)<br/>
  Distance: approx. 23 km<br/>
  Driving time: approx. 35-60 min<br/>
  Price: approx. 45.00 EUR<br/>'

  readonly property string travelByPublicTransport: 'Regional Train: RE 1, RE 2, RE 7, RB 14<br/>
  U-Bahn: U2, U5, U8<br/>
  S-Bahn: S3, S5, S7, S9<br/>
  Bus: 100, 200, 245, N2, N40, N42, N5, N60, N65, N8<br/>
  Tram: M2, M4, M5, M6'

  readonly property string cloakrooms: 'Cloakrooms are located at Level A. There is staff at the cloakroom during the opening hours. Please note that Qt and bcc are not responsible for items left in the cloakroom. Kindly note that you cannot bring large items to bcc. A laptop bag or small bag pack is ok. If you need to store your luggage during the summit, you find a container just outside bcc.<br/>'

  readonly property string infoDesk: 'All Qt employees are more than happy to help you. If you have any questions, please feel free to reach out any of the Qt employees on site. Info desk is found at Level A.<br/>'

  readonly property string swagPickUp: 'Pick up your Qt World Summit swag anytime at the pickup point which is found at Level C.<br/>'

  readonly property string demoArea: 'Visit the demo area at Level B and see the latest demos, built with Qt showcases, and meet all QtWS amazing sponsors.<br/>'

  readonly property string wifi: 'Qt World Summit venue has free Wi-Fi for everyone to use. Password for the Wi-Fi is: QtWorldSummit2023<br/>'

  readonly property string afterwork: 'Stay with us for a night of entertainment! What to expect at QtWS afterwork and evening party? Networking, games, coding in the dark, demos, music, food and drinks, entertainment, and much more!<br/>'
}
