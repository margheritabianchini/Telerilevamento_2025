// Coordinate di Blatten (metti più precise se le hai)
var blatten = ee.Geometry.Polygon([7.835, 46.419]);

// Periodo di analisi
var startDate = '2016-01-01';
var endDate   = '2023-12-31';

// Collezione Sentinel-2 SR (corretta a livello di superficie)
var s2 = ee.ImageCollection('COPERNICUS/S2_SR')
            .filterBounds(blatten)
            .filterDate(startDate, endDate)
            .filter(ee.Filter.lt('CLOUDY_PIXEL_PERCENTAGE', 20));

// Funzione per aggiungere NDVI (può aiutare a vedere vegetazione disturbata dalla frana)
function addNDVI(img) {
  var ndvi = img.normalizedDifference(['B8','B4']).rename('NDVI');
  return img.addBands(ndvi);
}
var s2_ndvi = s2.map(addNDVI);

// Mediana annuale per ridurre nuvole/rumore
var yearly = ee.ImageCollection(
  ee.List.sequence(2016, 2023).map(function(year) {
    var annual = s2_ndvi.filter(ee.Filter.calendarRange(year, year, 'year'));
    return annual.median().set('year', year);
  })
);

// Visualizza un anno (es. 2020)
var img2020 = yearly.filter(ee.Filter.eq('year', 2020)).first();
Map.centerObject(blatten, 13);
Map.addLayer(img2020, {bands:['B4','B3','B2'], min:0, max:3000}, 'RGB 2020');
Map.addLayer(img2020.select('NDVI'), {min:0, max:1, palette:['brown','green']}, 'NDVI 2020');

// Esporta un’immagine
Export.image.toDrive({
  image: img2020.select(['B4','B3','B2','NDVI']),
  description: 'Blatten_S2_2020',
  region: blatten.buffer(2000), // 2 km attorno al punto
  scale: 10,
  maxPixels: 1e13
});











-----------------------------------------------------------





// ==============================================
// Sentinel-2 Surface Reflectance - Cloud Masking and Visualization
// https://developers.google.com/earth-engine/datasets/catalog/COPERNICUS_S2_SR_HARMONIZED
// ==============================================

// ==============================================
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
                   .filterBounds(blatten)
                   .filterDate('2025-05-20', '2025-06-20')              // Filter by date                                   // Filter by AOI
                   .filter(ee.Filter.lt('CLOUDY_PIXEL_PERCENTAGE', 20)) // Only images with <20% cloud cover
                   .map(maskS2clouds);                                  // Apply cloud masking

// Print number of images available after filtering
print('Number of images in collection:', collection.size());

// ==============================================
// Create a median composite from the collection
// Useful when the AOI overlaps multiple scenes or frequent cloud cover
// ==============================================
var composite = collection.median().clip(blatten);

// ==============================================
// Visualization on the Map
// ==============================================

Map.centerObject(blatten, 10); // Zoom to the AOI

// Display the first image of the collection (GEE does this by default)
Map.addLayer(collection, {
  bands: ['B4', 'B3', 'B2'],  // True color: Red, Green, Blue
  min: 0,
  max: 0.3
}, 'First image of collection');

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
  region: blatten,
  scale: 10,                                    // Sentinel-2 resolution
  crs: 'EPSG:4326',
  maxPixels: 1e13
});

