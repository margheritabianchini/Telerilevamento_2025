// ================================================================================================================================================================
// CODICE PYTHON - GOOGLE EARTH ENGINE 
// ================================================================================================================================================================
// 🛰️ SENTINEL-2 🛰️
// ================================================================================================================================================================
// 1. ESPORTAZIONE DELLE IMMAGINI PRE-EVENTO 
// ================================================================================================================================================================
// 1a. Primavera 2017
// ================================================================================================================================================================
// Function to mask clouds using the QA60 band
// Bits 10 and 11 correspond to opaque clouds and cirrus
// ==============================================
function maskS2clouds(image) {
  var qa = image.select('QA60');
  var cloudBitMask = 1 << 10;
  var cirrusBitMask = 1 << 11;

  // Keep only pixels where both cloud and cirrus bits are 0
  var mask = qa.bitwiseAnd(cloudBitMask).eq(0)
               .and(qa.bitwiseAnd(cirrusBitMask).eq(0));

  // Apply the cloud mask and scale reflectance values (0–10000 ➝ 0–1)
  return image.updateMask(mask).divide(10000);
}

// ==============================================
// Load and Prepare the Image Collection
// ==============================================

// Load Sentinel-2 SR Harmonized collection (atmospherical correction already done)
var collection = ee.ImageCollection('COPERNICUS/S2_SR_HARMONIZED')
                   .filterBounds(pizzo_cengalo)
                   .filterDate('2017-03-23', '2017-05-23')     // Filter by date                                   // Filter by AOI
                   .filter(ee.Filter.lt('CLOUDY_PIXEL_PERCENTAGE', 20)) // Only images with <20% cloud cover
                   .map(maskS2clouds) //Apply cloud masking 
                   .select(['B2', 'B3', 'B4', 'B8']);                                  // Apply cloud masking

// Print number of images available after filtering
print('Number of images in collection:', collection.size());

// ==============================================
// Create a median composite from the collection
// Useful when the AOI overlaps multiple scenes or frequent cloud cover
// ==============================================
var composite = collection.median().clip(pizzo_cengalo);

// ==============================================
// Visualization on the Map
// ==============================================

Map.centerObject(pizzo_cengalo, 10); // Zoom to the AOI

// Display the image of the collection (GEE does this by default)
Map.addLayer(collection, {
  bands: ['B4', 'B3', 'B2'],  // True color: Red, Green, Blue
  min: 0,
  max: 0.3
}, 'Image');

// Display the median composite image
Map.addLayer(composite, {
  bands: ['B8', 'B3', 'B2'],
  min: 0,
  max: 0.3
}, 'Median composite');
//B8 è NIR quindi ponendolo per prima verrà tutto rosso 


// ==============================================
// Export to Google Drive
// ==============================================

// Export the median composite
Export.image.toDrive({
  image: composite.select(['B4', 'B3', 'B2', 'B8']),  // Select RGB bands
  description: 'Sentinel2_Median_Composite',
  folder: 'GEE_exports',                        // Folder in Google Drive
  fileNamePrefix: 'sentinel2_median_2025_month',
  region: pizzo_cengalo,
  scale: 10,                                    // Sentinel-2 resolution
  crs: 'EPSG:4326',
  maxPixels: 1e13
});


// ================================================================================================================================================================
// 1b. Primavera - estate 2017
// ================================================================================================================================================================
// Function to mask clouds using the QA60 band
// Bits 10 and 11 correspond to opaque clouds and cirrus
// ==============================================
function maskS2clouds(image) {
  var qa = image.select('QA60');
  var cloudBitMask = 1 << 10;
  var cirrusBitMask = 1 << 11;

  // Keep only pixels where both cloud and cirrus bits are 0
  var mask = qa.bitwiseAnd(cloudBitMask).eq(0)
               .and(qa.bitwiseAnd(cirrusBitMask).eq(0));

  // Apply the cloud mask and scale reflectance values (0–10000 ➝ 0–1)
  return image.updateMask(mask).divide(10000);
}

// ==============================================
// Load and Prepare the Image Collection
// ==============================================

// Load Sentinel-2 SR Harmonized collection (atmospherical correction already done)
var collection = ee.ImageCollection('COPERNICUS/S2_SR_HARMONIZED')
                   .filterBounds(pizzo_cengalo)
                   .filterDate('2017-03-28', '2017-07-23')     // Filter by date                                   // Filter by AOI
                   .filter(ee.Filter.lt('CLOUDY_PIXEL_PERCENTAGE', 20)) // Only images with <20% cloud cover
                   .map(maskS2clouds) //Apply cloud masking 
                   .select(['B2', 'B3', 'B4', 'B8']);                                  // Apply cloud masking

// Print number of images available after filtering
print('Number of images in collection:', collection.size());

// ==============================================
// Create a median composite from the collection
// Useful when the AOI overlaps multiple scenes or frequent cloud cover
// ==============================================
var composite = collection.median().clip(pizzo_cengalo);

// ==============================================
// Visualization on the Map
// ==============================================

Map.centerObject(pizzo_cengalo, 10); // Zoom to the AOI

// Display the image of the collection (GEE does this by default)
Map.addLayer(collection, {
  bands: ['B4', 'B3', 'B2'],  // True color: Red, Green, Blue
  min: 0,
  max: 0.3
}, 'Image');

// Display the median composite image
Map.addLayer(composite, {
  bands: ['B8', 'B3', 'B2'],
  min: 0,
  max: 0.3
}, 'Median composite');
//B8 è NIR quindi ponendolo per prima verrà tutto rosso 


// ==============================================
// Export to Google Drive
// ==============================================

// Export the median composite
Export.image.toDrive({
  image: composite.select(['B4', 'B3', 'B2', 'B8']),  // Select RGB bands
  description: 'Sentinel2_Median_Composite',
  folder: 'GEE_exports',                        // Folder in Google Drive
  fileNamePrefix: 'sentinel2_median_2025_month',
  region: pizzo_cengalo,
  scale: 10,                                    // Sentinel-2 resolution
  crs: 'EPSG:4326',
  maxPixels: 1e13
});


// ================================================================================================================================================================
// 1c. Estate 2017
// ================================================================================================================================================================
// Function to mask clouds using the QA60 band
// Bits 10 and 11 correspond to opaque clouds and cirrus
// ==============================================
function maskS2clouds(image) {
  var qa = image.select('QA60');
  var cloudBitMask = 1 << 10;
  var cirrusBitMask = 1 << 11;

  // Keep only pixels where both cloud and cirrus bits are 0
  var mask = qa.bitwiseAnd(cloudBitMask).eq(0)
               .and(qa.bitwiseAnd(cirrusBitMask).eq(0));

  // Apply the cloud mask and scale reflectance values (0–10000 ➝ 0–1)
  return image.updateMask(mask).divide(10000);
}


// ==============================================
// Load and Prepare the Image Collection
// ==============================================
// Load Sentinel-2 SR Harmonized collection (atmospherical correction already done)
var collection = ee.ImageCollection('COPERNICUS/S2_SR_HARMONIZED')
                   .filterBounds(pizzo_cengalo)
                   .filterDate('2013-06-23', '2013-08-23')     // Filter by date                                   // Filter by AOI
                   .filter(ee.Filter.lt('CLOUDY_PIXEL_PERCENTAGE', 20)) // Only images with <20% cloud cover
                   .map(maskS2clouds) //Apply cloud masking 
                   .select(['B2', 'B3', 'B4', 'B8']);                                  // Apply cloud masking

// Print number of images available after filtering
print('Number of images in collection:', collection.size());


// ==============================================
// Create a median composite from the collection
// Useful when the AOI overlaps multiple scenes or frequent cloud cover
// ==============================================
var composite = collection.median().clip(pizzo_cengalo);


// ==============================================
// Visualization on the Map
// ==============================================
Map.centerObject(pizzo_cengalo, 10); // Zoom to the AOI

// Display the image of the collection (GEE does this by default)
Map.addLayer(collection, {
  bands: ['B4', 'B3', 'B2'],  // True color: Red, Green, Blue
  min: 0,
  max: 0.3
}, 'Image');

// Display the median composite image
Map.addLayer(composite, {
  bands: ['B8', 'B3', 'B2'],
  min: 0,
  max: 0.3
}, 'Median composite');
//B8 è NIR quindi ponendolo per prima verrà tutto rosso 


// ==============================================
// Export to Google Drive
// ==============================================
// Export the median composite
Export.image.toDrive({
  image: composite.select(['B4', 'B3', 'B2', 'B8']),  // Select RGB bands
  description: 'Sentinel2_Median_Composite',
  folder: 'GEE_exports',                        // Folder in Google Drive
  fileNamePrefix: 'sentinel2_median_2025_month',
  region: pizzo_cengalo,
  scale: 10,                                    // Sentinel-2 resolution
  crs: 'EPSG:4326',
  maxPixels: 1e13
});


// ================================================================================================================================================================
// 2. ESPORTAZIONE DELL'IMMAGINE POST-EVENTO 
// ================================================================================================================================================================
// Function to mask clouds using the QA60 band
// Bits 10 and 11 correspond to opaque clouds and cirrus
// ==============================================
function maskS2clouds(image) {
  var qa = image.select('QA60');
  var cloudBitMask = 1 << 10;
  var cirrusBitMask = 1 << 11;

  // Keep only pixels where both cloud and cirrus bits are 0
  var mask = qa.bitwiseAnd(cloudBitMask).eq(0)
               .and(qa.bitwiseAnd(cirrusBitMask).eq(0));

  // Apply the cloud mask and scale reflectance values (0–10000 ➝ 0–1)
  return image.updateMask(mask).divide(10000);
}


// ==============================================
// Load and Prepare the Image Collection
// ==============================================
// Load Sentinel-2 SR Harmonized collection (atmospherical correction already done)
var collection = ee.ImageCollection('COPERNICUS/S2_SR_HARMONIZED')
                   .filterBounds(pizzo_cengalo)
                   .filterDate('2018-06-23', '2018-08-23')     // Filter by date                                   // Filter by AOI
                   .filter(ee.Filter.lt('CLOUDY_PIXEL_PERCENTAGE', 20)) // Only images with <20% cloud cover
                   .map(maskS2clouds) //Apply cloud masking 
                   .select(['B2', 'B3', 'B4', 'B8']);                                  // Apply cloud masking

// Print number of images available after filtering
print('Number of images in collection:', collection.size());


// ==============================================
// Create a median composite from the collection
// Useful when the AOI overlaps multiple scenes or frequent cloud cover
// ==============================================
var composite = collection.median().clip(pizzo_cengalo);


// ==============================================
// Visualization on the Map
// ==============================================
Map.centerObject(pizzo_cengalo, 10); // Zoom to the AOI

// Display the image of the collection (GEE does this by default)
Map.addLayer(collection, {
  bands: ['B4', 'B3', 'B2'],  // True color: Red, Green, Blue
  min: 0,
  max: 0.3
}, 'Image');

// Display the median composite image
Map.addLayer(composite, {
  bands: ['B8', 'B3', 'B2'],
  min: 0,
  max: 0.3
}, 'Median composite');
//B8 è NIR quindi ponendolo per prima verrà tutto rosso 


// ==============================================
// Export to Google Drive
// ==============================================
// Export the median composite
Export.image.toDrive({
  image: composite.select(['B4', 'B3', 'B2', 'B8']),  // Select RGB bands
  description: 'Sentinel2_Median_Composite',
  folder: 'GEE_exports',                        // Folder in Google Drive
  fileNamePrefix: 'sentinel2_median_2025_month',
  region: pizzo_cengalo,
  scale: 10,                                    // Sentinel-2 resolution
  crs: 'EPSG:4326',
  maxPixels: 1e13
});


// ================================================================================================================================================================
// CODICE PYTHON - GOOGLE EARTH ENGINE
// ================================================================================================================================================================
// 🛰️ LANDSAT 5 🛰️
// ================================================================================================================================================================
// 1. ESPORTAZIONE DELL'IMMAGINE PRE-EVENTO 
//    (estate 2011)
// ================================================================================================================================================================
// Function to mask clouds using the QA_PIXEL band
// Bits 10 and 11 correspond to opaque clouds and cirrus
// ==============================================
function maskS2clouds(image) {
  var qa = image.select('QA_PIXEL');
  var cloudBitMask = 1 << 10;
  var cirrusBitMask = 1 << 11;

  // Keep only pixels where both cloud and cirrus bits are 0
  var mask = qa.bitwiseAnd(cloudBitMask).eq(0)
               .and(qa.bitwiseAnd(cirrusBitMask).eq(0));

  // Apply the cloud mask and scale reflectance values (0–10000 ➝ 0–1)
  return image.updateMask(mask).divide(10000);
}


// ==============================================
// Load and Prepare the Image Collection
// ==============================================
// Load Landsat 5 collection (atmospherical correction already done)
var collection = ee.ImageCollection('LANDSAT/LT05/C02/T1_L2')
                   .filterBounds(pizzo_cengalo)
                   .filterDate('2011-05-01', '2011-09-01')     // Filter by date                                   // Filter by AOI
                   .filter(ee.Filter.lt('CLOUD_COVER', 20)) // Only images with <20% cloud cover
                   .map(maskS2clouds) //Apply cloud masking 
                   .select(['SR_B1', 'SR_B2', 'SR_B3', 'SR_B4']);                                  // Apply cloud masking

// Print number of images available after filtering
print('Number of images in collection:', collection.size());


// ==============================================
// Create a median composite from the collection
// Useful when the AOI overlaps multiple scenes or frequent cloud cover
// ==============================================
var composite = collection.median().clip(pizzo_cengalo);


// ==============================================
// Visualization on the Map
// ==============================================
Map.centerObject(pizzo_cengalo, 10); // Zoom to the AOI

// Display the image of the collection (GEE does this by default)
Map.addLayer(collection, {
  bands: ['SR_B3', 'SR_B2', 'SR_B1'],  // True color: Red, Green, Blue
  min: 0,
  max: 0.3
}, 'Image');

// Display the median composite image
Map.addLayer(composite, {
  bands: ['SR_B4', 'SR_B2', 'SR_B1'], //False 
  min: 0,
  max: 0.3
}, 'Median composite');
//B8 è NIR quindi ponendolo per prima verrà tutto rosso 


// ==============================================
// Export to Google Drive
// ==============================================
// Export the median composite
Export.image.toDrive({
  image: composite.select(['SR_B3', 'SR_B2', 'SR_B1', 'SR_B4']),  // Select RGB bands
  description: 'Landsat5_median_composite ',
  folder: 'GEE_exports',                        // Folder in Google Drive
  fileNamePrefix: 'Landsat5_2011',
  region: pizzo_cengalo,
  scale: 30,                                    // Landsat 5 resolution
  crs: 'EPSG:4326',
  maxPixels: 1e13
});


// ================================================================================================================================================================
// 🛰️ LANDSAT 8 🛰️
// ================================================================================================================================================================
// 2. ESPORTAZIONE DELL'IMMAGINE POST-EVENTO
//    (estate 2013)
// ================================================================================================================================================================
// Function to mask clouds using the QA_PIXEL band
// Bits 10 and 11 correspond to opaque clouds and cirrus
// ================================================================================================================================================================
function maskL8sr(image) {
  var qa = image.select('QA_PIXEL');

  var cloudBitMask = 1 << 5;        // cloud

  var mask = qa.bitwiseAnd(cloudBitMask).eq(0)

  // Scale reflectance to 0-1
  var scaled = image.select(['SR_B2','SR_B3','SR_B4','SR_B5','SR_B6','SR_B7'])
                    .multiply(0.0000275).add(-0.2);

  return scaled.updateMask(mask);
}

// ======================
// Load and Prepare the Image Collection
// ======================
var collection = ee.ImageCollection('LANDSAT/LC08/C02/T1_L2')
                  .filterBounds(pizzo_cengalo)
                  .filterDate('2013-05-01', '2013-10-01')
                  .filter(ee.Filter.lt('CLOUD_COVER', 20))
                  .map(maskL8sr)
                  .select(['SR_B2','SR_B3','SR_B4','SR_B5','SR_B6','SR_B7']); 

print('Images:', collection.size());

// ======================
// Create a median composite from the collection
// Useful when the AOI overlaps multiple scenes or frequent cloud cover
// ======================
var composite = collection.median().clip(pizzo_cengalo);

// ======================
// Visualization on the Map
// ======================
Map.centerObject(pizzo_cengalo, 10);

// Display the image of the collection (GEE does this by default)
Map.addLayer(composite, {
  bands: ['SR_B4', 'SR_B3', 'SR_B2'],  // R,G,B
  min: 0,
  max: 0.3
}, 'L8 RGB');

// Display the median composite image
Map.addLayer(composite, {
  bands: ['SR_B5', 'SR_B3', 'SR_B2'],  // NIR,G,B
  min: 0,
  max: 0.4
}, 'L8 NIR');

// ======================
// Export to Google Drive
// ======================
Export.image.toDrive({
  image: composite,
  description: 'Landsat8_Composite_2017',
  folder: 'GEE_exports',
  fileNamePrefix: 'Landsat8_2017',
  region: pizzo_cengalo,
  scale: 30,
  crs: 'EPSG:4326',
  maxPixels: 1e13
});
