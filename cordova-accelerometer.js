Polymer({
  is: 'cordova-accelerometer',

  hostAttributes: {
    hidden: true
  },

  properties: {
    /**
     * If true, automatically performs watch when device is ready.
     */
    auto: Boolean,

    /**
     * If true, will watch over again, every period is finished.
     */
    loop: {
      observer: '_observeLoop',
      type: Boolean
    },

    /**
     * Time between updates of heading data in Milliseconds.
     */
    period: {
      type: Number,
      value: 3000
    },

    /**
     * Return if cordova deviceready event has been fired.
     */
    ready: {
      computed: '_computeReady(_ready_, _paused_)',
      notify: true,
      type: Boolean,
      value: false
    },

    /**
     * Creation timestamp for heading.
     */
    timestamp: {
      notify: true,
      readOnly: true,
      type: Number
    },

    /**
     * Amount of acceleration on the x-axis. (in m/s^2)
     */
    x: {
      notify: yes,
      readOnly: true,
      type: Number,
      value: 0
    }

    /**
     * Amount of acceleration on the y-axis. (in m/s^2)
     */
    y: {
      notify: yes,
      readOnly: true,
      type: Number,
      value: 0
    }

    /**
     * Amount of acceleration on the z-axis. (in m/s^2)
     */
    z: {
      notify: yes,
      readOnly: true,
      type: Number,
      value: 0
    }
  },

  observers: ['_observeReady(auto, ready)'],

  _computeReady(ready, paused) {
    return ready && !paused;
  },

  _observeLoop(loop) {
    (loop) ? this.watch() : this.clearWatch();
  },

  _observeReady(auto, ready) {
    if (auto && ready) {
      this.watch();
    }
  },

  _onError() {
    this.fire('error', ...arguments);
    this.fire('cordova-accelerometer-error', ...arguments);
  },

  _onWatch(acceleration) {
    this._setTimestamp(acceleration.timestamp);
    this._setX(acceleration.x);
    this._setY(acceleration.y);
    this._setZ(acceleration.z);
  },

  /**
   * Stop watching the Heading
   */
  clearWatch() {
    if (this.ready && this.watchId) {
      navigtor.compass.clearWatch(this.watchId);

      this.loop = false;
      this.watchId = null;
    }
  },

  /**
   * Get the current acceleration along the x, y, and z axes. If loop is
   * set, it gets acceleration at regular interval.
   */
  watch() {
    if (this.ready) {
      const errorCb = this._onError.bind(this);
      const fn = (this.loop) ? 'watchAcceleration' : 'getCurrentAcceleration';
      const optionsFn = {
        frequency: this.period
      };
      const successCb = this._onWatch.bind(this);

      this.watchId = navigator.accelerometer[fn](successCb, errorCb, optionsFn);
    }
  }
})
