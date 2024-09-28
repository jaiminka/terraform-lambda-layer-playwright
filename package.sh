npm --prefix ./src/nodejs ci --omit=dev
mkdir -p dist
cd src
zip -r ../dist/chromium.zip ./nodejs
cd ..
