_[Demo and API docs](https://adelarosab.github.io/cordova-accelerometer)_

### &lt;cordova-accelerometer&gt;
`<cordova-accelerometer>` provides access to the device's accelerometer.

### Installation
In your `www` project:
```bash
bower install --save cordova-accelerometer
```

In your `cordova` project:
```bash
cordova plugin add cordova-plugin-device-motion
```

### Usage
```html
<cordova-accelerometer
  auto
  loop
  period="3000"
  ready
  timestamp="1471173266"
  x="3"
  y="1.4"
  z="0"
></cordova-accelerometer>
```

`<cordova-accelerometer>` allow to read the state of the device's accelerometer
 in the current moment. `ready` means cordova is fully operative and 
 `acceleration`  shows the speed of the device.

---

###### Note
Due to restrictions `ready` attribute is not shown into attributes table.
