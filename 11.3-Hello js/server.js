const http = require("http");
const port = 8080;

const requestHandler = (request, response) => {
  console.log(request.url);
  response.end(
    "Hello Node.js Server! I´m configured with:" + process.env.configvalue
  );
};

const server = http.createServer(requestHandler);

server.listen(port, err => {
  if (err) {
    return console.log("something bad happened", err);
  }

  console.log(`server is listening on ${port}`);
});
