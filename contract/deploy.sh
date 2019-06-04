rm -rf build
truffle migrate --reset --network ropsten --compile-all
cd ../web/
npm install
npm run build
cd /var/www
rm -rf dist
cd ~/contract/web
move dist /var/www
nginx -s reload