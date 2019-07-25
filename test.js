const oasis = require('@oasislabs/client');
const convertHex = require('convert-hex');

let gateway = new oasis.gateways.Web3Gateway(
  'ws://localhost:8546',
  oasis.Wallet.fromMnemonic(
    'range drive remove bleak mule satisfy mandate east lion minimum unfold ready',
  ),
);

oasis.setGateway(gateway);

let service = oasis
  .deploy({
    arguments: [],
    bytecode: require('fs').readFileSync('build/hello_service.wasm'),
    header: {confidential: false},
    options: {gasLimit: 1000000},
  })
  .then(service => {
    console.log('deployed');
    return service.hello();
  })
  .then((response, asdf) => {
    console.log(response);
    gateway.disconnect();
  })
  .catch(err => {
    console.error(err);
    gateway.disconnect();
  });
