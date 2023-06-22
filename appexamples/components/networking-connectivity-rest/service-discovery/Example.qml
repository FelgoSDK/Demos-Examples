import QtQuick
import Felgo 4.0

App {
  id: app

  readonly property string serviceTypeAllServices: "_services._dns-sd._udp."

  readonly property bool searching: ZeroConf.networkServiceDiscoveryActive

  property var foundServices: ({})

  Component.onCompleted: ZeroConf.startNetworkServiceDiscovery(serviceTypeAllServices)

  NavigationStack {
    id: stack

    ListPage {
      title: "Service types"

      emptyText.text: "Searching for service types..."

      model: Object.values(foundServices).filter(service => !service.resolved)

      delegate: AppListItem {
        text: modelData.name
        detailText: modelData.type

        onSelected: showServiceType(modelData)
      }
    }
  }

  Component {
    id: servicesPage

    ListPage {
      title: "Services for: " + serviceType

      required property string serviceType

      emptyText.text: "Searching for services..."

      onPushed: {
        console.log("Start search for type:", serviceType)

        ZeroConf.stopNetworkServiceDiscovery()
        ZeroConf.startNetworkServiceDiscovery(serviceType)
      }

      onPopped: {
        ZeroConf.stopNetworkServiceDiscovery()
        ZeroConf.startNetworkServiceDiscovery(serviceTypeAllServices)
      }

      model: Object.values(foundServices).filter(service => service.type === serviceType)

      delegate: AppListItem {
        text: modelData.name

        detailText: "Type: %1\nDomain: %2\nHost: %3\nPort: %4\nAddresses: %5\nAttributes: %6"
        .arg(modelData.type)
        .arg(modelData.domain)
        .arg(modelData.hostName)
        .arg(modelData.port)
        .arg(JSON.stringify(modelData.addresses, null, "  "))
        .arg(JSON.stringify(modelData.attributes, null, "  "))
      }
    }
  }

  Connections {
    target: ZeroConf

    function onNetworkServiceDiscovered(serviceData) {
      console.log("Network service discovered:", JSON.stringify(serviceData, null, "  "))

      foundServices[serviceData.name] = serviceData
      foundServicesChanged()
    }

    function onNetworkServiceRemoved(serviceData) {
      console.log("Network service removed:", JSON.stringify(serviceData, null, "  "))

      delete foundServices[serviceData.name]
      foundServicesChanged()
    }

    function onNetworkServiceDiscoveryFailed(errorData) {
      console.log("Network service search failed:", JSON.stringify(errorData, null, "  "))
    }
  }

  function showServiceType(serviceModel) {
    // the service search returns the type property like "_udp.local.", containing protocol and domain
    // split it to get the protocol, and add it to the service name
    var elems = serviceModel.type.split(".")
    var serviceType = "%1.%2.".arg(serviceModel.name).arg(elems[0])

    stack.push(servicesPage, { serviceType: serviceType })
  }
}
