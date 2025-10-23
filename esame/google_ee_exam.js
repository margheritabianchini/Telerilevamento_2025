// ================================================================================================================================================================
// 🛰️ CODICE PYTHON - GOOGLE ENGINE 🛰️
// ================================================================================================================================================================
// 1. ESPORTAZIONE DELL'IMMAGINE PRE-EVENTO 
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
