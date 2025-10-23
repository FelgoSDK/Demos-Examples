import QtQuick
import Qt5Compat.GraphicalEffects

Item {
  id: heartScene
  width: parent.width < dp(300) ? parent.width : dp(300)
  height: width
  anchors.horizontalCenter: parent.horizontalCenter
  clip: false

  property int bpm: -1
  property int lower: 50
  property int upper: 190
  readonly property double normalized: 1 - (upper - bpm) / (upper - lower)

  RadialGradient {
    id: radialGradient
    width: parent.width*2
    height: width
    anchors.centerIn: heart3D
    horizontalRadius: 300
    verticalRadius: 300
    clip: false

    property color targetColor: bpm < 0 ? Qt.rgba(1,1,1,0.25) : Qt.rgba(normalized*0.85, 0.35*(1-normalized), 1*(1-normalized*0.7+0.3), 0.85)

    ColorAnimation on targetColor {
      duration: 350
    }

    gradient: Gradient {
        GradientStop {
          id: gradientStart
          position: 0.0; color: radialGradient.targetColor
        }
        GradientStop {
         position: 0.3; color: Qt.hsla(radialGradient.targetColor.hslHue, radialGradient.targetColor.hslSaturation, radialGradient.targetColor.hslLightness, 0.3)
        }
        GradientStop {
          position: 0.8; color: "transparent"
        }
    }

    SequentialAnimation{
      running: bpm > 0.90*upper

      loops: Animation.Infinite
      alwaysRunToEnd: true

      NumberAnimation {
        target: radialGradient
        property: "scale"
        duration: 300
        easing.type: Easing.InOutCubic
        from: 1
        to: 1.1
      }
      NumberAnimation {
        target: radialGradient
        property: "scale"
        duration: 400
        easing.type: Easing.InOutCubic
        from: 1.1
        to: 1

      }
      onFinished: {
        heartGlow.scale = 1
      }
    }
  }

  Image {
    id: heart3D
    width: parent.width*0.9
    anchors.centerIn: parent
    fillMode: Image.PreserveAspectFit
    source: "../../assets/heart.png"
    transform: Scale {
      id: heartScale
      origin.x: width/2; origin.y: height/2;
      xScale: 1; yScale: 1
    }

    SequentialAnimation {
      id: beatAnimation
      running: heartScene.bpm > 0
      alwaysRunToEnd: true

      property double scaler: 1.8 - 1.3 * heartScene.normalized

      onFinished: {
        beatAnimation.scaler = 1.8 - 1.3 * heartScene.normalized
        running = Qt.binding(function () {
          return heartScene.bpm > 0
        })
      }

      ParallelAnimation {
        NumberAnimation {
          target: heartScale
          property: "xScale"
          duration: 120 * beatAnimation.scaler
          easing.type: Easing.InQuart
          from: 1
          to: 0.95
        }
        NumberAnimation {
          target: heartScale
          property: "yScale"
          duration: 120 * beatAnimation.scaler
          easing.type: Easing.InQuart
          from: 1
          to: 0.98
        }
      }

      ParallelAnimation {
        NumberAnimation {
          target: heartScale
          property: "xScale"
          duration: 280 * beatAnimation.scaler
          easing.type: Easing.InOutQuad
          from: 0.95
          to: 1
        }
        NumberAnimation {
          target: heartScale
          property: "yScale"
          duration: 120 * beatAnimation.scaler
          easing.type: Easing.InOutQuad
          from: 0.98
          to: 1
        }
      }
    }
  }
}
