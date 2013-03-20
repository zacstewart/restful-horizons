# RESTful Horizons

This is a (sloppy) little Sinatra app to demonstrate the usage of [Tengai][1].

## Body data

`/bodies/:body_id`

Displays the datasheet for a body. Try 399 or 499.

[Example](http://horizons.herokuapp.com/bodies/499)

## Ephemeris tables

`/bodies/:body_id/ephemeris`

Exposes JSON-format ephemerides for a body, begining and ending on the speified
dates and times and with a resolution of `interval` minutes.

[Example](http://horizons.herokuapp.com/bodies/499/ephemeris?start_time=2013-3-1%2000:00:00&stop_time=2013-3-1%2023:59:00&interval=720)

### Parameters

*  **start_time** _string_
The beginning of the ephemeris table (parsed by `DateTime.parse`)

* **stop_time** _string_
The end of the ephemeris table (parsed by `DateTime.parse`)

* **interval** _integer_
The resolution of the table in minutes

### Response

Refer to the [HORIZONS documentation][2] for the meaning of the pehemeris table entries

```json
{
  "center_body_id": 0,
  "data": null,
  "ephemeris_table": [
    {
      "jdct": "2013-02-28T12:00:00+00:00",
      "lt": 0.008026114720758357,
      "rg": 1.389678685210623,
      "rr": 0.0004782688859427937,
      "vx": 0.0008866942664097094,
      "vy": 0.01381173089611027,
      "vz": 0.00631113629012057,
      "x": 1.388757252269638,
      "y": -0.01974843966995092,
      "z": -0.04658477785514784
    },
    {
      "jdct": "2013-03-01T00:00:00+00:00",
      "lt": 0.008027505435162865,
      "rg": 1.389919479945361,
      "rr": 0.0004849072346230474,
      "vx": 0.0008102297497016642,
      "vy": 0.01381250618491775,
      "vz": 0.006313556750527259,
      "x": 1.389181482507043,
      "y": -0.01284236455301021,
      "z": -0.04342859730413272
    }
  ],
  "start_time": "2013-03-01T00:00:00+00:00",
  "step_size": "720 minutes",
  "stop_time": "2013-03-01T23:59:00+00:00",
  "target_body_id": 499
}
```

  [1]: https://github.com/zacstewart/tengai
  [2]: http://ssd.jpl.nasa.gov/?horizons_doc
