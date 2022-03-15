// This file contains the boilerplate to execute your React app.
// If you want to modify your application's content, start in "index.js"

import {ReactInstance} from 'react-360-web';
import SimpleRaycaster from 'simple-raycaster';
import WebVRPolyfill from "webvr-polyfill";
const polyfill = new WebVRPolyfill();

function init(bundle, parent, options = {}) {
  const r360 = new ReactInstance(bundle, parent, {
    // Add custom options here
    fullScreen: true,
    ...options,
  });

  console.log(r360._cameraPosition)

  console.log(r360._cameraPosition)
  // r360.scene.rotateY(210)
  r360.scene.rotateY(-1.5)


  var surf = r360.getDefaultSurface();

  // Render your app content to the default cylinder surface
  r360.renderToSurface(
    r360.createRoot('fliqxify_vr', { /* initial props */ }),
    surf
  );

  // Load the initial environment
  r360.compositor.setBackground(r360.getAssetURL('dark_theatre.jpg'));
  r360.controls.clearRaycasters();
  r360.controls.addRaycaster(SimpleRaycaster);
}

window.React360 = {init};