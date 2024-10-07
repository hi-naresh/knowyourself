'use strict';
const MANIFEST = 'flutter-app-manifest';
const TEMP = 'flutter-temp-cache';
const CACHE_NAME = 'flutter-app-cache';

const RESOURCES = {"version.json": "49c978aa6565d43fe3ac8a8bc534aca0",
"index.html": "65fe0b5af54c2cae51f39dc62d992634",
"/": "65fe0b5af54c2cae51f39dc62d992634",
"main.dart.js": "f4f322bb139e34043d63e1b579617643",
"flutter.js": "c71a09214cb6f5f8996a531350400a9a",
"favicon.png": "5dcef449791fa27946b3d35ad8803796",
"icons/Icon-192.png": "ac9a721a12bbc803b44f645561ecb1e1",
"icons/Icon-maskable-192.png": "c457ef57daa1d16f64b27b786ec2ea3c",
"icons/Icon-maskable-512.png": "301a7604d45b3e739efc881eb04896ea",
"icons/Icon-512.png": "96e752610906ba2a93c65f8abe1645f1",
"manifest.json": "251b719669474869228b2210ef0091ed",
"assets/AssetManifest.json": "5624ab3ed2f0a02eba5f77fc732a12f0",
"assets/NOTICES": "822e7e87ba18a8bf438437fa16ab2f76",
"assets/FontManifest.json": "dc3d03800ccca4601324923c0b1d6d57",
"assets/AssetManifest.bin.json": "c85d334096cad3ebce9a14a1520aeb5a",
"assets/packages/awesome_notifications/test/assets/images/test_image.png": "c27a71ab4008c83eba9b554775aa12ca",
"assets/packages/cupertino_icons/assets/CupertinoIcons.ttf": "6cff16d8c73a47d94596df53e7b1f0dd",
"assets/packages/animated_emoji/lottie/anxiousWithSweat.json": "897f0ff7718180789096bb251863f893",
"assets/packages/animated_emoji/lottie/scared.json": "d13e16416a0160110c68e71b1fbc5413",
"assets/packages/animated_emoji/lottie/sweat.json": "c557d4a250b3917a00c91d28a47cc70c",
"assets/packages/animated_emoji/lottie/rage.json": "0afa6756f1171d9dba82b7d94813133e",
"assets/packages/animated_emoji/lottie/sad.json": "2b20861bc811ea67fdacb6b5fdcbfc1a",
"assets/packages/animated_emoji/lottie/grinning.json": "4771c0deb24da9adb31aae3b41fa3795",
"assets/packages/animated_emoji/lottie/surprised.json": "074b90d24eb74fdb2da352c4fc1c42b3",
"assets/packages/animated_emoji/lottie/distraught.json": "ecacc2788dd6d6a8620b48565df45e8a",
"assets/packages/animated_emoji/lottie/cry.json": "8f498e2afe2fd8a538501189ad420710",
"assets/packages/animated_emoji/lottie/grin.json": "56d4712120eb3590c5a39569feae6b23",
"assets/packages/animated_emoji/lottie/pleading.json": "42f95be8fb684053cd6746170d650b3d",
"assets/shaders/ink_sparkle.frag": "ecc85a2e95f5e9f53123dcaf8cb9b6ce",
"assets/AssetManifest.bin": "722b0f7df141ad7b6fa44ad5c411464d",
"assets/fonts/MaterialIcons-Regular.otf": "2f7865e2c0d4fbf09501c703b40d1819",
"assets/assets/materials/sa.jpg": "ed63f72082c64831f8e9497aee30c3e2",
"assets/assets/materials/data.json": "739bf56cebdf03439f8995723e97d270",
"assets/assets/mood_shifter/mood_shift.tflite": "501adf4317cd714261798492645e24d6",
"assets/assets/mood_shifter/sentiments.json": "a322305ce2ba72f560ac4c03072c5da0",
"assets/assets/mood_shifter/updated_activities.json": "1427a77b5c74138f63e6142a914f3cfe",
"assets/assets/mood_shifter/emotions.json": "e268ca2e881cf4b2a111fa4c59b2185a",
"assets/assets/chapters/chapters.json": "69d359af1d71e7f8e9484bddfbda5a56",
"assets/assets/illustrations/health5.svg": "540c09c56b5be032bb9c661cd41f1642",
"assets/assets/illustrations/health4.svg": "281d7d8bea18f9a25b5507a1c2bb912e",
"assets/assets/illustrations/emotional.svg": "272d89584216eac69ee2c8eaed849696",
"assets/assets/illustrations/health6.svg": "30dfc110ed26a60746b94c700ca9d680",
"assets/assets/illustrations/spiritual.svg": "515021af728db7c50f45293ae5c9feac",
"assets/assets/illustrations/health7.svg": "ff736f4bb8862419330db2a156c71036",
"assets/assets/illustrations/health3.svg": "3fd5134e651174fc5094379a6b5c90e1",
"assets/assets/illustrations/health2.svg": "b15b2746634f568bf4835543a033d9c1",
"assets/assets/illustrations/health1.svg": "c189cd57f6b8ee7010434a7a13a23ab9",
"assets/assets/illustrations/jupiter.png": "1c34fb5ebd77d309daf93a780cd236c3",
"assets/assets/illustrations/health15.svg": "cb27a7980b88ce90df3dfa88b011b7ee",
"assets/assets/illustrations/mental.svg": "0b0186a673dad63448216c2aadd5c356",
"assets/assets/illustrations/abstract.svg": "c418ebfd5b46f16293b77d8580b8c689",
"assets/assets/illustrations/milestones.svg": "3470a712136b3466935333506f7b6e57",
"assets/assets/illustrations/health14.svg": "896c39268ecc2272616aed7d070a2385",
"assets/assets/illustrations/health16.svg": "64adead602c5bcb00a2c2cc3c6b497ed",
"assets/assets/illustrations/health17.svg": "a39d50213e08b6776307c3e9191a7b38",
"assets/assets/illustrations/health13.svg": "f99c00cb82bb715e5fb8585355085e4f",
"assets/assets/illustrations/health12.svg": "c077555928b79d19c8ef183f71e4cd3e",
"assets/assets/illustrations/fit.png": "6757cdf408552d9b962f7b046fad0842",
"assets/assets/illustrations/health10.svg": "918abdc3eac546f8b3c77c44555273eb",
"assets/assets/illustrations/physical.svg": "753421a941eece7fe14a58461f344fba",
"assets/assets/illustrations/health11.svg": "a57b8383b7676d4523f4664206d77289",
"assets/assets/illustrations/health20.svg": "20f69d613d66ca9066df00915ffc51d5",
"assets/assets/illustrations/health21.svg": "fe8211e37f96d9ef74f0b91c86f3f085",
"assets/assets/illustrations/activity.png": "720c69b05c63becf586ea2760b03b10f",
"assets/assets/illustrations/health19.svg": "025b12ba1df60afa41378f4b61a9451c",
"assets/assets/illustrations/tour/why.svg": "fb6a284a480bcf26d3b31d075b19cda0",
"assets/assets/illustrations/tour/auro.png": "80d5db06d14ee9ad459d81db10bd448e",
"assets/assets/illustrations/tour/what.svg": "1a40f4ec32bc07295de305c4f53e9eca",
"assets/assets/illustrations/tour/how.svg": "2c7b9eb9ac128fd055c278aa01f29268",
"assets/assets/illustrations/health18.svg": "319f7e1e49cf1d351f67564fb36149f1",
"assets/assets/illustrations/onboard1.svg": "0bfe526b6fbdeebb6441d5fdb6a5c3df",
"assets/assets/illustrations/onboard2.svg": "8612196d2fade941c314f5b457f5685a",
"assets/assets/illustrations/onboard3.svg": "2abde708e96e89977be25d624cf355ca",
"assets/assets/illustrations/health9.svg": "c6bcd502a7cf0c39ad0cfba3ac455759",
"assets/assets/illustrations/health8.svg": "78de83ba5c42bcf372a7bd822449219c",
"assets/assets/brand/kyb.svg": "8138c0de2b4e8c8339034ae98e2f67f0",
"assets/assets/brand/sailcc.png": "d1018d46d1f959719bc40eb5fd7055ef",
"assets/assets/brand/google.svg": "324c3c17d42e117359efc915417a3c65",
"assets/assets/audio/audio.mp3": "6f80ca943f40e6384f4a09f06bf869a9",
"assets/assets/logo/kyb.svg": "8138c0de2b4e8c8339034ae98e2f67f0",
"assets/assets/logo/circle.svg": "87efbd39fa55b376bf25868d472b0ddf",
"assets/assets/logo/sailcc.png": "d1018d46d1f959719bc40eb5fd7055ef",
"assets/assets/logo/google.svg": "324c3c17d42e117359efc915417a3c65",
"assets/assets/team/sneha.jpg": "24d3287c36c8260ed68294fd78cb7aa7",
"assets/assets/team/mugh.jpg": "e38ce899589e282a2346a3b70605b29e",
"assets/assets/team/naresh.jpg": "7935fcdf36707ca8343aecb23b1467cd",
"assets/assets/team/kiran-singh.jpg": "f4515060253e92782c670b5d75b35cb3",
"assets/assets/icons/home.svg": "2d457883a9ba86ce93323e318c8078f5",
"assets/assets/icons/myspace.svg": "57e5a494d88b290d8fc787a7774c9ac2",
"assets/assets/icons/journall.svg": "3dbaf9d1fe11fbe6c77ad0bcdfb863c2",
"assets/assets/icons/bell.svg": "1562fcfb9d4562d0e5181e3c4615a675",
"assets/assets/icons/entries.svg": "b3ef5f26d7ee26cbfc857df626c56ca4",
"assets/assets/icons/add.svg": "03414017acdaa6730c629b2b4f76c237",
"assets/assets/icons/close.svg": "c139ada97eb06dfa02331f8519b35ddc",
"assets/assets/icons/more.svg": "63e798c0c20f3c794e6af7b8d227c7da",
"assets/assets/icons/analysis.svg": "f4bc77e8f38b9ede853c534a52a4efd5",
"assets/assets/icons/learn.svg": "eb6946f4edba4430709289f1e8c36ee3",
"assets/assets/icons/points.svg": "966a12c0b7d132f3e847d16942ff7b66",
"assets/assets/icons/assess.svg": "3f7f223930b6de61144de53f81f9446e",
"assets/assets/emojis/amazed.svg": "6d685ab222bf7d699c154b80cd110b37",
"assets/assets/emojis/loving.svg": "ad50a4187a39fcf56e511818738c7412",
"assets/assets/emojis/party.svg": "84f337a70631a8a2a422b1b29a07b89e",
"assets/assets/emojis/sad.svg": "b85db91a8d69ed751a6f672d27a49c7d",
"assets/assets/emojis/joyful.svg": "51665178ecf64ba27b514d5e96bdf3e0",
"assets/assets/emojis/neutral.svg": "fd0224c536011749100f60b19403c7ea",
"assets/assets/emojis/happy.svg": "a73ac1872824fe8cf25b2623b1e7c3bc",
"assets/assets/emojis/angry.svg": "89e816f3c74fb636875fef6640ef5ffb",
"assets/assets/avatars/avatar8.svg": "3b1b82010f40b86c608936cec33cd50e",
"assets/assets/avatars/avatar9.svg": "1a202191e6919eabfa47d09231becb23",
"assets/assets/avatars/avatar11.svg": "0f48f1a8567247a630a701777fc05be3",
"assets/assets/avatars/avatar1.svg": "0bd306fadea7edfcc901d8a3dffeb937",
"assets/assets/avatars/avatar10.svg": "d92d178047c197bbca12095cba654825",
"assets/assets/avatars/avatar2.svg": "d3fccc48dc1800952841c66e9e46f658",
"assets/assets/avatars/avatar3.svg": "1a02777f2a771bd902fe67a1a501fd3a",
"assets/assets/avatars/avatar7.svg": "1fae7f71e10cfd30c0cdb78f6d18ef28",
"assets/assets/avatars/avatar6.svg": "c126cee073ffdfcfd14c6c703f8436d2",
"assets/assets/avatars/avatar4.svg": "ca6e8c99b3cf9adfae9e15df9b5ae5d6",
"assets/assets/avatars/avatar5.svg": "c08f622094050460743591375e6169b8",
"assets/assets/animations/breathe.json": "9c44870bac0552a90cc8d4744305e666",
"assets/assets/animations/space.json": "00d27e4d0033581510d495a70059f99e",
"assets/assets/animations/meditate.json": "39572e75c59b7a14d384e10b1a7e5413",
"assets/assets/animations/KYB.json": "26439a7300e7fdf3fc80026dab836b5f",
"assets/assets/animations/seeking-development.json": "0a0f6ef78aecbccfde29a898a1f0bfe5",
"canvaskit/skwasm.js": "445e9e400085faead4493be2224d95aa",
"canvaskit/skwasm.js.symbols": "741d50ffba71f89345996b0aa8426af8",
"canvaskit/canvaskit.js.symbols": "38cba9233b92472a36ff011dc21c2c9f",
"canvaskit/skwasm.wasm": "e42815763c5d05bba43f9d0337fa7d84",
"canvaskit/chromium/canvaskit.js.symbols": "4525682ef039faeb11f24f37436dca06",
"canvaskit/chromium/canvaskit.js": "43787ac5098c648979c27c13c6f804c3",
"canvaskit/chromium/canvaskit.wasm": "f5934e694f12929ed56a671617acd254",
"canvaskit/canvaskit.js": "c86fbd9e7b17accae76e5ad116583dc4",
"canvaskit/canvaskit.wasm": "3d2a2d663e8c5111ac61a46367f751ac",
"canvaskit/skwasm.worker.js": "bfb704a6c714a75da9ef320991e88b03"};
// The application shell files that are downloaded before a service worker can
// start.
const CORE = ["main.dart.js",
"index.html",
"assets/AssetManifest.bin.json",
"assets/FontManifest.json"];

// During install, the TEMP cache is populated with the application shell files.
self.addEventListener("install", (event) => {
  self.skipWaiting();
  return event.waitUntil(
    caches.open(TEMP).then((cache) => {
      return cache.addAll(
        CORE.map((value) => new Request(value, {'cache': 'reload'})));
    })
  );
});
// During activate, the cache is populated with the temp files downloaded in
// install. If this service worker is upgrading from one with a saved
// MANIFEST, then use this to retain unchanged resource files.
self.addEventListener("activate", function(event) {
  return event.waitUntil(async function() {
    try {
      var contentCache = await caches.open(CACHE_NAME);
      var tempCache = await caches.open(TEMP);
      var manifestCache = await caches.open(MANIFEST);
      var manifest = await manifestCache.match('manifest');
      // When there is no prior manifest, clear the entire cache.
      if (!manifest) {
        await caches.delete(CACHE_NAME);
        contentCache = await caches.open(CACHE_NAME);
        for (var request of await tempCache.keys()) {
          var response = await tempCache.match(request);
          await contentCache.put(request, response);
        }
        await caches.delete(TEMP);
        // Save the manifest to make future upgrades efficient.
        await manifestCache.put('manifest', new Response(JSON.stringify(RESOURCES)));
        // Claim client to enable caching on first launch
        self.clients.claim();
        return;
      }
      var oldManifest = await manifest.json();
      var origin = self.location.origin;
      for (var request of await contentCache.keys()) {
        var key = request.url.substring(origin.length + 1);
        if (key == "") {
          key = "/";
        }
        // If a resource from the old manifest is not in the new cache, or if
        // the MD5 sum has changed, delete it. Otherwise the resource is left
        // in the cache and can be reused by the new service worker.
        if (!RESOURCES[key] || RESOURCES[key] != oldManifest[key]) {
          await contentCache.delete(request);
        }
      }
      // Populate the cache with the app shell TEMP files, potentially overwriting
      // cache files preserved above.
      for (var request of await tempCache.keys()) {
        var response = await tempCache.match(request);
        await contentCache.put(request, response);
      }
      await caches.delete(TEMP);
      // Save the manifest to make future upgrades efficient.
      await manifestCache.put('manifest', new Response(JSON.stringify(RESOURCES)));
      // Claim client to enable caching on first launch
      self.clients.claim();
      return;
    } catch (err) {
      // On an unhandled exception the state of the cache cannot be guaranteed.
      console.error('Failed to upgrade service worker: ' + err);
      await caches.delete(CACHE_NAME);
      await caches.delete(TEMP);
      await caches.delete(MANIFEST);
    }
  }());
});
// The fetch handler redirects requests for RESOURCE files to the service
// worker cache.
self.addEventListener("fetch", (event) => {
  if (event.request.method !== 'GET') {
    return;
  }
  var origin = self.location.origin;
  var key = event.request.url.substring(origin.length + 1);
  // Redirect URLs to the index.html
  if (key.indexOf('?v=') != -1) {
    key = key.split('?v=')[0];
  }
  if (event.request.url == origin || event.request.url.startsWith(origin + '/#') || key == '') {
    key = '/';
  }
  // If the URL is not the RESOURCE list then return to signal that the
  // browser should take over.
  if (!RESOURCES[key]) {
    return;
  }
  // If the URL is the index.html, perform an online-first request.
  if (key == '/') {
    return onlineFirst(event);
  }
  event.respondWith(caches.open(CACHE_NAME)
    .then((cache) =>  {
      return cache.match(event.request).then((response) => {
        // Either respond with the cached resource, or perform a fetch and
        // lazily populate the cache only if the resource was successfully fetched.
        return response || fetch(event.request).then((response) => {
          if (response && Boolean(response.ok)) {
            cache.put(event.request, response.clone());
          }
          return response;
        });
      })
    })
  );
});
self.addEventListener('message', (event) => {
  // SkipWaiting can be used to immediately activate a waiting service worker.
  // This will also require a page refresh triggered by the main worker.
  if (event.data === 'skipWaiting') {
    self.skipWaiting();
    return;
  }
  if (event.data === 'downloadOffline') {
    downloadOffline();
    return;
  }
});
// Download offline will check the RESOURCES for all files not in the cache
// and populate them.
async function downloadOffline() {
  var resources = [];
  var contentCache = await caches.open(CACHE_NAME);
  var currentContent = {};
  for (var request of await contentCache.keys()) {
    var key = request.url.substring(origin.length + 1);
    if (key == "") {
      key = "/";
    }
    currentContent[key] = true;
  }
  for (var resourceKey of Object.keys(RESOURCES)) {
    if (!currentContent[resourceKey]) {
      resources.push(resourceKey);
    }
  }
  return contentCache.addAll(resources);
}
// Attempt to download the resource online before falling back to
// the offline cache.
function onlineFirst(event) {
  return event.respondWith(
    fetch(event.request).then((response) => {
      return caches.open(CACHE_NAME).then((cache) => {
        cache.put(event.request, response.clone());
        return response;
      });
    }).catch((error) => {
      return caches.open(CACHE_NAME).then((cache) => {
        return cache.match(event.request).then((response) => {
          if (response != null) {
            return response;
          }
          throw error;
        });
      });
    })
  );
}
