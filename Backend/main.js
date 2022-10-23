var express = require('express');
var app = express();
var fs = require("fs");

app.get('/test', function (req, res) {
   res.send('Hello World');
})

app.get('/medicineNames', function (req, res) {
    fs.readFile( __dirname + "/" + "medicineNames.json", 'utf8', function (err, data) {
       console.log( data );
       res.end( data );
    });
 })

//  app.post('/addMedicine', function (req, res) {
//     // First read existing users.
//     fs.readFile( __dirname + "/" + "medicines.json", 'utf8', function (err, data) {
//        data = JSON.parse( data );
//        data["user6"] = user["user6"];
//        console.log( data );
//        res.end( JSON.stringify(data));
//     });
//  })

var server = app.listen(8081, function () {
   var host = server.address().address
   var port = server.address().port
   console.log("Example app listening at http://%s:%s", host, port)
})