const { response } = require('express');
const express = require('express')
const app = express()
const port = portFromEnv()
var os = require("os");
var uuid = require('uuid');

var jsresponse = {
    "language": "javascript",
    "hostname": os.hostname(),
    "timestamp": new Date(),
    "uuid": uuid.v4()
}

function portFromEnv() {
    if (process.env.PORT) {
        return process.env.PORT
    } else {
        return 8080
    }
}

app.get('/', (req, res) => {
  res.send(jsresponse)
})

app.get('/health', (req, res) => {
  res.send({"status": "ok"})
})

app.listen(port, () => {
  console.log(`js app listening at 0.0.0.0:${port}`)
})
