'use strict';
const CACHE_NAME = 'flutter-app-cache';
const RESOURCES = {
  "/assets\AssetManifest.json": "47ea47501e0319341b0e5c829517acc5",
"/assets\assets\img\creationDevis.jpg": "fd90aab727c7be0c295e4663f4a39073",
"/assets\assets\img\echeancier.PNG": "7a7a231ea631441642659786821b89ab",
"/assets\assets\img\icons\off.png": "a2079956fec29d93955c27205b0040d9",
"/assets\assets\img\logo-madera.png": "7c131e087d495f781c644a5c82677549",
"/assets\assets\img\madera.JPG": "2e097e80c74503a0f755657aec25885e",
"/assets\assets\img\suiviDevis.jpg": "b0edd81135a80f9ddd28042efab83591",
"/assets\FontManifest.json": "580ff1a5d08679ded8fcf5c6848cece7",
"/assets\fonts\MaterialIcons-Regular.ttf": "56d3ffdef7a25659eab6a68a3fbfaf16",
"/assets\LICENSE": "e5c991351f6273db012653704c3f7073",
"/index.html": "6e2f7e56ade7db26569dd94033a92625",
"/main.dart.js": "334721ce27d7ff718f9ad1eb5e68b8f6",
"/sql-wasm.js": "38afbefcc29a055208149c373c93f6f9",
"/sql-wasm.wasm": "b01552bc79c0b957d4228839bb9b74bf"
};

self.addEventListener('activate', function (event) {
  event.waitUntil(
    caches.keys().then(function (cacheName) {
      return caches.delete(cacheName);
    }).then(function (_) {
      return caches.open(CACHE_NAME);
    }).then(function (cache) {
      return cache.addAll(Object.keys(RESOURCES));
    })
  );
});

self.addEventListener('fetch', function (event) {
  event.respondWith(
    caches.match(event.request)
      .then(function (response) {
        if (response) {
          return response;
        }
        return fetch(event.request, {
          credentials: 'include'
        });
      })
  );
});
