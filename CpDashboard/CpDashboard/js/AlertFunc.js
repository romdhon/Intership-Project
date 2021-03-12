function getSensorAlert(_value, _alertval) {
    var sensor_name = $(_value).find("SensorName").text();
    var thresh_val = $(_value).find("Value").text();

    if (parseFloat(_alertval) > parseFloat(thresh_val)) {
        $.ajax({
            url: 'SensorService.asmx/PostAlert',
            data: {
                sensorname: sensor_name,
                threshval: thresh_val,
                alertval: _alertval,
            },
            method: 'POST',
            type: 'xml',
            success: function (succ) {
                //alert("getSensorAlert success")
            },
            error: function (err) {
                //alert("getSensorAlert error");
            }
        });
    } else {
        //alert("Not in conditions");
    }

}

//get the alert setting value
function getAlertValue(_id, _alertval) {
    $.ajax({
        url: 'SensorService.asmx/GetAlertValue',
        data: { id: _id },
        type: 'xml',
        method: 'POST',
        success: function (value) {
            getSensorAlert(value, _alertval);
            //alert("getAlertValue Success");
        },
        error: function (err) {
            //alert("getAlertValue Error");
        }
    })
}