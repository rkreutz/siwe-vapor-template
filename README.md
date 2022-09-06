# siwe-vapor-template
A simple template for Sign-In with Ethereum on Vapor.

## Trying it out
You can spin up the Vapor app with:
```shell
vapor run migrate -y
vapor run serve --hostname 0.0.0.0 --port 3000
```

And then the example front-end with:
```shell
cd Frontend
npm install
npm run dev
```

Access [localhost:8080](http://localhost:8080) with a browser with MetaMask installed, connect the wallet and sign the message, you should see some logs on the browser.