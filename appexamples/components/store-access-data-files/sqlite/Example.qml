import Felgo 4.0
import QtQuick 2.10
import QtQuick.LocalStorage 2.0


App {
  NavigationStack {
    AppPage {
      title: "SQLite"

      Column {
        padding: dp(20)
        AppButton {
          text: "Do DB transaction and get results"
          onClicked: {
            findGreetings()
          }
        }

        AppText {
          id: resultsLabel
          text: result
        }
      }
    }
  }

  property string result: ""

  function findGreetings() {
    var db = LocalStorage.openDatabaseSync("QMLSQLiteExampleDB", "1.0", "The Example QML SQL!", 1000000);
    db.transaction(
          function(tx) {
            // Create the database if it doesn't already exist
            tx.executeSql('CREATE TABLE IF NOT EXISTS Greeting(salutation TEXT, salutee TEXT, number INTEGER)')
            // Add (another) greeting row
            const randomIntNumber = Math.floor(100*Math.random())
            tx.executeSql('INSERT INTO Greeting VALUES(?, ?, ?)', [ 'hello', 'world', randomIntNumber])
            // Show all added greetings
            var rs = tx.executeSql('SELECT * FROM Greeting')
            var r = ""
            for (var i = 0; i < rs.rows.length; i++) {
              r += rs.rows.item(i).salutation + ", " + rs.rows.item(i).salutee + ", " + rs.rows.item(i).number + "\n"
            }
            result = r
          } )
  }
}
