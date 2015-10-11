Polymer
  is: "cordova-accelerometer"

  properties:
    auto:
      type: Boolean
      value: false
    loop:
      type: Boolean
      value: false
    period:
      type: Number
      value: 3
    x:
      notify: yes
      readOnly: yes
      reflectToAttribute: yes
    y:
      notify: yes
      readOnly: yes
      reflectToAttribute: yes
    z:
      notify: yes
      readOnly: yes
      reflectToAttribute: yes

  _setAcceleration: (acceleration) ->
    @_setX acceleration.x
    @_setY acceleration.y
    @_setZ acceleration.z

  attached: ->
    @watch() if @auto

  watch: ->
    this.$.enabler.promise.then =>
      fn = if @loop then "watchAcceleration" else "getCurrentAcceleration"
      navigator.accelerometer[fn] @_setAcceleration,
        (@fire.bind this, "cordova-accelerometer"),
        {period: @period}
