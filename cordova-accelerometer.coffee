Polymer
  is: "cordova-accelerometer"

  properties:
    ### If true, automatically performs watch when device is ready.  ###
    auto:
      reflectToAttribute: yes
      type: Boolean
      value: false
    ### If true, will watch over again, every time it is finished. ###
    loop:
      reflectToAttribute: yes
      observer: "_observeLoop"
      type: Boolean
      value: false
    ### Period of updates with acceleration data in Milliseconds. ###
    period:
      reflectToAttribute: yes
      type: Number
      value: 3000
    ### Return if cordova deviceready event has been fired. ###
    ready:
      notify: yes
      observer: "_observeReady"
      readOnly: yes
      reflectToAttribute: yes
    ### Amount of acceleration on the x-axis. (in m/s^2) ###
    x:
      notify: yes
      readOnly: yes
    ### Amount of acceleration on the y-axis. (in m/s^2) ###
    y:
      notify: yes
      readOnly: yes
    ### Amount of acceleration on the z-axis. (in m/s^2) ###
    z:
      notify: yes
      readOnly: yes

  _observeLoop: ->
    if @loop then @watch() else @clearWatch()

  _setAcceleration: (acceleration) ->
    @_setX acceleration.x
    @_setY acceleration.y
    @_setZ acceleration.z

  attached: ->
    @watch() if @auto

  ### Stop watching the Acceleration ###
  clearWatch: ->
    if @ready and @watchId?
      navigator.accelerometer.clearWatch @watchId
      @loop = false
      @watchId = null

  ### Get the current acceleration along the x, y, and z axes. If loop is set, it
   gets acceleration at regular interval. ###
  watch: ->
    if @ready
      fn = if @loop then "watchAcceleration" else "getCurrentAcceleration"
      @watchId = navigator.accelerometer[fn] @_setAcceleration,
        (@fire.bind this, "cordova-accelerometer"),
        {period: @period}
