import {GoogleMapLoader, GoogleMap, Marker, SearchBox } from "react-google-maps";

const SimpleMap = props => (
    <GoogleMapLoader
      containerElement={
        <div
          {...props.containerElementProps}
          style={{
            height: `600`, width: `1000`
          }}
        />
      }
      googleMapElement={
        <GoogleMap
          ref={(map) => console.log(map)}
          defaultZoom={10}
          defaultCenter={{ lng: 37.363882, lat: 55.044922 }}
          onClick={props.onMapClick}
        >
          {props.markers.map((marker, index) => (
            <Marker
              {...marker}
              onRightclick={() => props.onMarkerRightclick(index)}
            />
          ))}
        </GoogleMap>
      }
    />
);


class MainComponent extends React.Component {
  state = {
    markers: []
  }

  mapClick(arg) {
    let { markers } = this.state;
    markers = update(markers, {
      $push: [
        {
          position: event.latLng,
          defaultAnimation: 2,
          key: Date.now(), // Add a key property for: http://fb.me/react-warning-keys
        },
      ],
    });
    this.setState({ markers });
  }

  render() {
    return (
      <div>
       <h1>Карта</h1>
       <SimpleMap
            markers={[]}
            onMapClick={ this.mapClick}
            onMarkerRightclick={function(){}}
        />
      </div>
    );
  }
}

export default MainComponent
